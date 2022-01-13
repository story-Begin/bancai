package com.baosight.utils;

import com.alibaba.fastjson.JSONObject;
import com.baosight.dto.gismap.resp.DeviceLocationCameraRespDTO;
import com.baosight.service.gismap.DeviceLocationService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArraySet;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;

@ServerEndpoint(value = "/ws/asset/",encoders = {DataEncoder.class})
@Component
public class WebSocketServer {


    @Autowired
    DeviceLocationService locationService;

    private static Logger log = LoggerFactory.getLogger(WebSocketServer.class);
    private static final AtomicInteger OnlineCount = new AtomicInteger(0);
    // concurrent包的线程安全Map，用来存放每个地图的session对象组
    private static ConcurrentHashMap<String,CopyOnWriteArraySet<Session>> sessionMap = new ConcurrentHashMap<>();


    @PostConstruct
    public void init() {
        System.out.println("websocket 加载");

        new Thread(()->{
            log.info("Send Message Start！");
            while (true){
                for (String key:sessionMap.keySet()) {
                    if(!key.contains("areaId")){
                        continue;
                    }
                    Map<String, String> formatUrlParams = formatParams(key);
                    Integer areaId =Integer.parseInt(formatUrlParams.get("areaId"));
                    Integer mapId = Integer.parseInt(formatUrlParams.get("mapId"));
                    List<DeviceLocationCameraRespDTO> allDeviceLocation = locationService.findAllDeviceLocation(areaId, mapId);
                    Map<String, Integer> newStatusList = allDeviceLocation.stream().
                            collect(Collectors.toMap((item)->item.getDeviceId().toString(),
                                    DeviceLocationCameraRespDTO::getDeviceStatus));
                    broadCastInfo(key,newStatusList);
                    System.out.println(newStatusList);
                }
                try {
                    Thread.sleep(10000);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }).start();

    }
    /**
     * 连接建立成功调用的方法
     */
    @OnOpen
    public void onOpen(Session session) {
        String urlParams = session.getQueryString();
        addSession(urlParams,session);
        int cnt = OnlineCount.incrementAndGet();
        System.out.println(urlParams);
        log.info("有连接成功！，当前连接数为：{}", cnt);
        System.out.println(sessionMap);
    }

    /**
     * 连接关闭调用的方法
     */
    @OnClose
    public void onClose(Session session) {
        String urlParams = session.getQueryString();
        removeSession(urlParams,session);
        int cnt = OnlineCount.decrementAndGet();
        log.info("有连接关闭，当前连接数为：{}", cnt);
        System.out.println(sessionMap);
    }

    /**
     * 收到客户端消息后调用的方法
     * @param message
     * 客户端发送过来的消息
     */
    @OnMessage
    public void onMessage(String message, Session session) {

        log.info("来自客户端的消息：{}",message);

    }

    /**
     * 出现错误
     * @param session
     * @param error
     */
    @OnError
    public void onError(Session session, Throwable error) {
        log.error("发生错误：{}，Session ID： {}",error.getMessage(),session.getId());
        error.printStackTrace();
    }

    /**
     * 发送消息，实践表明，每次浏览器刷新，session会发生变化。
     * @param session
     * @param message
     */
    public static void sendMessage(Session session, Object message) {
        try {
//            session.getBasicRemote().sendText(String.format("%s (From Server，Session ID=%s)",message,session.getId()));
            session.getBasicRemote().sendText(JSONObject.toJSONString(message));
        } catch (IOException  e) {
            log.error("发送消息出错：{}", e.getMessage());
            e.printStackTrace();
        }
    }

    public static void sendObjMessage(Session session, Object data){
        try {
            session.getBasicRemote().sendObject(data);
        }catch (IOException | EncodeException e){
            log.error("发送消息出错：{}", e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * 群发消息
     * @param message
     * @throws IOException
     */
    public static void broadCastInfo(String key,Object message) {
            CopyOnWriteArraySet<Session> sessionSet = sessionMap.get(key);
            if(sessionSet!=null&& sessionSet.size()>0) {
                for (Session session : sessionSet) {
                    if (session.isOpen()) {
                        sendMessage(session,message);
                    }
                }
            }
    }

    /**
     * 格式化Url参数
     * @param urlParams
     * @return
     */
    public static Map<String,String> formatParams(String urlParams){

        Map<String,String> formatParams = new HashMap<>();
        String[] split = urlParams.split("&");
        for (String s : split) {
            String[] split1 = s.split("=");
            formatParams.put(split1[0],split1[1]);
        }
        return formatParams;
    }
    /**
     * 添加客户端Session到Map中
     * @param key
     * @param session
     */
    public static void addSession(String key, Session session){
        CopyOnWriteArraySet<Session> sessionSet = sessionMap.get(key);
        if(sessionSet==null){
            sessionSet = new CopyOnWriteArraySet<>();
            sessionSet.add(session);
            sessionMap.put(key,sessionSet);
        }else{
            sessionSet.add(session);
        }
    }


    /**
     * 客户端断开连接时将Session从Map中移除
     * @param key
     * @param session
     */
    public static void removeSession(String key, Session session){
        CopyOnWriteArraySet<Session> sessionSet = sessionMap.get(key);
        if(sessionSet!=null){
            sessionSet.remove(session);
            if(sessionSet.isEmpty()){
                sessionMap.remove(key);
            }
        }
    }

    /**
     * 地图设备状态刷新;
     */
    public void flashDeviceStatus(){
        for (String key:sessionMap.keySet()) {
            Map<String, String> formatUrlParams = formatParams(key);
            Integer areaId =Integer.parseInt(formatUrlParams.get("areaId"));
            Integer mapId = Integer.parseInt(formatUrlParams.get("mapId"));
            List<DeviceLocationCameraRespDTO> allDeviceLocation = locationService.findAllDeviceLocation(areaId, mapId);
            Map<String, Integer> newStatusList = allDeviceLocation.stream().
                    collect(Collectors.toMap((item)->item.getDeviceId().toString(),
                            DeviceLocationCameraRespDTO::getDeviceStatus));
            broadCastInfo(key,newStatusList);
            System.out.println(newStatusList);
        }
    }

    public static void flashAlarmCount(String count){
        broadCastInfo("alarm=1",count);
    }

    public static void flashAlarmBarData(Object data){
        CopyOnWriteArraySet<Session> sessions = sessionMap.get("alarmEchart=1");
        if (sessions!=null&&sessions.size()>0){
            for (Session session : sessions) {
                if(session.isOpen()){
                    sendObjMessage(session,data);
                }
            }
        }

    }

//    public static void main(String[] args) {
//        String password = "lz_1234567891";
//        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
//        String encode = passwordEncoder.encode(password);
//        System.out.println(encode.length());
//        System.out.println("$2a$10$RMIzz1FXG0G7yfPfi/NCiOOu9iStuNA/LAuvQwtqu.YIlhasEQkgm".length());
//        System.out.println(encode);
//        System.out.println(passwordEncoder.matches(password,"$2a$10$RMIzz1FXG0G7yfPfi/NCiOOu9iStuNA/LAuvQwtqu.YIlhasEQkgm"));
//    }

}
