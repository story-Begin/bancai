package com.baosight.utils;

import com.alibaba.fastjson.JSONObject;
import com.baosight.dto.gismap.resp.DeviceLocationCameraRespDTO;
import com.baosight.service.gismap.DeviceLocationService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
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

@ServerEndpoint(value = "/ws/asset/alarm/",encoders = {DataEncoder.class})
@Component
public class WebSocketServerV2 {


    @Autowired
    DeviceLocationService locationService;

    private static Logger log = LoggerFactory.getLogger(WebSocketServerV2.class);
    private static final AtomicInteger OnlineCount = new AtomicInteger(0);
    // concurrent包的线程安全Map，用来存放每个地图的session对象组
    private static CopyOnWriteArraySet<Session> sessionSet = new CopyOnWriteArraySet<>();
    /**
     * 连接建立成功调用的方法
     */
    @OnOpen
    public void onOpen(Session session) {
        addSession(session);
        int cnt = OnlineCount.incrementAndGet();
        log.info("有连接成功！，当前连接数为：{}", cnt);
        System.out.println(sessionSet);
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
        System.out.println(sessionSet);
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
    public static void broadCastInfo(Object message) {
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
     * @param session
     */
    public static void addSession( Session session){
        if(sessionSet==null){
            sessionSet = new CopyOnWriteArraySet<>();
            sessionSet.add(session);
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
        if(sessionSet!=null){
            sessionSet.remove(session);
        }
    }

}
