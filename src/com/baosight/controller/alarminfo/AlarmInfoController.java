package com.baosight.controller.alarminfo;


import com.baosight.controller.http.HttpResult;
import com.baosight.dto.alarminfo.query.AlarmInfoQueryDTO;
import com.baosight.entity.alarmpoint.AlarmInfo;
import com.baosight.service.alarmpoint.AlarmInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/alarmInfo")
public class AlarmInfoController {

    @Autowired
    private AlarmInfoService alarmInfoService;


    @PostMapping("/getList")
    private HttpResult getList(@RequestBody AlarmInfoQueryDTO queryDTO){

        return HttpResult.ok("获取成功！",alarmInfoService.getList(queryDTO));

    }

    @PostMapping("/update")
    public HttpResult updateAlarmInfo(@RequestBody AlarmInfo alarmInfo){
        boolean update = alarmInfoService.update(alarmInfo);
        if(update){
            return HttpResult.ok("操作成功！");
        }else{
            return HttpResult.error("操作失败！");
        }
    }

    @PostMapping("/add")
    public HttpResult addAlarmInfo(@RequestBody AlarmInfo alarmInfo){
        boolean update = alarmInfoService.save(alarmInfo);
        if(update){
            return HttpResult.ok("操作成功！");
        }else{
            return HttpResult.error("操作失败！");
        }
    }

    @RequestMapping("/del/{id}")
    public HttpResult delAlarmInfoById(@PathVariable(value = "id",required = true) String id) {
        alarmInfoService.delete(id);
        return HttpResult.ok("操作成功！");
    }
}
