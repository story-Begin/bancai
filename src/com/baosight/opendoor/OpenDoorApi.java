package com.baosight.opendoor;

import com.baosight.controller.http.HttpResult;
import com.baosight.dto.alarminfo.query.AlarmInfoQueryDTO;
import com.baosight.entity.alarmpoint.AlarmConfig;
import com.baosight.entity.alarmpoint.AlarmInfo;
import com.baosight.entity.cx.RemoteDeviceAlarmDataEntity;
import com.baosight.service.alarmpoint.AlarmConfigService;
import com.baosight.service.alarmpoint.AlarmInfoService;
import com.baosight.service.cx.DeviceAlarmService;
import com.baosight.service.equipment.HKDeviceService;
import com.baosight.utils.WebSocketServerV2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 对外开放API
 *
 * @ClassName OpenDoorApi
 * @Description TODO
 * @Autgor huang
 * @Date 2020-09-02 12:54
 */
@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/api")
public class OpenDoorApi {

    @Autowired
    private HKDeviceService hkDeviceService;
    @Autowired
    private DeviceAlarmService deviceAlarmService;

    @Autowired
    private AlarmInfoService alarmInfoService;

    @Autowired
    private AlarmConfigService configService;

    @PostMapping(value = "/test")
    public HttpResult queryPageList() {
        return HttpResult.ok("请求成功");
    }

    @PostMapping("/getList")
    private HttpResult getList(@RequestBody AlarmInfoQueryDTO queryDTO){

        return HttpResult.ok("获取成功！",alarmInfoService.getList(queryDTO));

    }
    @PostMapping(value = "/add")
    public HttpResult add(@RequestBody AlarmConfig config) {
//        alarmInfo.setCreateTime(new Date());
//        alarmInfoService.save(alarmInfo);
        config.setCreateTime(new Date());
        configService.save(config);
        return HttpResult.ok("请求成功");
    }

    @PostMapping(value = "/update")
    public HttpResult update(@RequestBody AlarmConfig config) {
//        alarmInfo.setCreateTime(new Date());
//        alarmInfoService.save(alarmInfo);
        config.setCreateTime(new Date());
        configService.update(config);
        return HttpResult.ok("请求成功");
    }

    @GetMapping(value = "/sendMsg")
    public String sendMsg(){
        Map map = new HashMap();
        map.put("divItem","该角色机房");
        map.put("H1content","测试机组");
        try {
            WebSocketServerV2.broadCastInfo(map);
        }catch (Exception e){
            return "error";
        }
        return "success";
    }

    /**
     * 远程接口回调函数
     *
     * @param deviceAlarmDataEntity
     */
    @PostMapping(value = "/getRemoteData")
    public void getRemoteAlarmData(@RequestBody RemoteDeviceAlarmDataEntity deviceAlarmDataEntity) {
        deviceAlarmService.insertDeviceRealTimeAlarmData(deviceAlarmDataEntity.getData());
    }

    @GetMapping(value = "/camerasPreviewURLsInfo")
    public HttpResult camerasPreviewURLsInfo(String cameraIndexCode, String protocol) {
        return HttpResult.ok(hkDeviceService.camerasPreviewURLsInfo(cameraIndexCode, protocol));
    }
}
