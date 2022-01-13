package com.baosight.service.cx.impl;

import com.alibaba.fastjson.JSONObject;
import com.baosight.dto.cx.resp.DeviceRealTimeAlarmDataQespDTO;
import com.baosight.dto.yw.query.OpsUrlDTO;
import com.baosight.mapper.cx.DeviceAlarmDao;
import com.baosight.service.cx.DeviceAlarmRemoteDataService;
import com.baosight.service.hp.HomePageService;
import com.baosight.utils.ServerData;
import com.baosight.utils.WebSocketServer;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.web.client.ResourceAccessException;
import org.springframework.web.client.RestTemplate;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

//@EnableScheduling
//@Component
@Service
public class DeviceAlarmRemoteDataServiceImpl implements DeviceAlarmRemoteDataService {

    @Resource
    private DeviceAlarmDao deviceAlarmDao;
    @Resource
    private RestTemplate restTemplate;
    @Resource
    private HomePageService homePageService;

    /**
     * 从第三方接口获取历史报警数据
     * @return
     */
    @Override
    public boolean getRemoteHisAlarmData() {

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        Integer pageSize = 20;
        Integer pageNo = 0;
        String startDate = "2020-11-13 15:12:34";
        String endDate = sdf.format(new Date());
        List<DeviceRealTimeAlarmDataQespDTO> dataList;

            try {
                do {
                    pageNo++;
                    //远程接口需要的参数
                    Map<String, Object> params = new HashMap<>();
                    params.put("pageSize", pageSize);
                    params.put("pageNo", pageNo);
                    params.put("startDate", startDate);
                    params.put("endDate", endDate);
                    //返回结果
                    String result = restTemplate.postForObject(OpsUrlDTO.REAL_TIME_ALARM, params, String.class);
                    JSONObject jsonData = JSONObject.parseObject(result);
                    dataList = JSONObject.parseArray(jsonData.get("data").toString(), DeviceRealTimeAlarmDataQespDTO.class);
                    for (DeviceRealTimeAlarmDataQespDTO deviceRealTimeAlarmDataQespDTO : dataList) {
                        deviceRealTimeAlarmDataQespDTO.setFlag("3");
                    }
                    deviceAlarmDao.insertDeviceAlarmData(dataList);

                }while (dataList.size() == 20);
                return true;
            }catch (Exception e){
                e.printStackTrace();
                return false;
            }
    }

    /**
     * 获取实时报警
     * @return
     */
    @Override
    public boolean getRpcRealTimeAlarmData() {

        Integer pageSize = 20;
        Integer pageNo = 0;
        List<DeviceRealTimeAlarmDataQespDTO> data;
        try {
            do {
                pageNo++;
                Map<String,Object> params = new HashMap<>();
                params.put("pageSize",pageSize);
                params.put("pageNo",pageNo);
                //返回结果
                String result = restTemplate.postForObject(OpsUrlDTO.HIS_ALARM, params, String.class);
                JSONObject jsonData = JSONObject.parseObject(result);
                data = JSONObject.parseArray(jsonData.get("data").toString(), DeviceRealTimeAlarmDataQespDTO.class);
                for (DeviceRealTimeAlarmDataQespDTO datum : data) {
                    datum.setFlag("2");
                }
                if(data.size() > 0){
                    deviceAlarmDao.insertDeviceAlarmData(data);
                }

            }while (data.size() == 20);
            return true;
        }catch (ResourceAccessException e){
            e.printStackTrace();
            System.out.println("请求超时");
            return false;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }

    }

    @Override
    public Integer flushAlarmData() {
        return deviceAlarmDao.flushAlarmData();
    }

//    @PostConstruct
//    @Async
//    @Scheduled(cron = "0 */15 * * * ?")
    public void cxTask(){
        flushAlarmData();
        getRpcRealTimeAlarmData();
        getRemoteHisAlarmData();
        Integer count = deviceAlarmDao.selectAlarmCount();
        WebSocketServer.flashAlarmCount(count.toString());
        List<List<Integer>> alarmCountByLevelAndTime = homePageService.getAlarmCountByLevelAndTime();
        ServerData serverData = new ServerData();
        serverData.setData(alarmCountByLevelAndTime);
        WebSocketServer.flashAlarmBarData(serverData);
    }
}

