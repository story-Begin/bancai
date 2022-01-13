

package com.baosight.controller.alarminfo;
import com.baosight.controller.http.HttpResult;
import com.baosight.dto.alarminfo.query.AlarmConfigQueryDTO;
import com.baosight.dto.alarminfo.query.AlarmInfoQueryDTO;
import com.baosight.entity.alarmpoint.AlarmConfig;
import com.baosight.entity.alarmpoint.AlarmInfo;
import com.baosight.service.alarmpoint.AlarmConfigService;
import com.baosight.service.alarmpoint.AlarmInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/alarmConfig")
public class AlarmConfigController {


    
    @Autowired
    private AlarmConfigService alarmConfigService;
    
    @PostMapping("/update")
    public HttpResult updateAlarmInfo(@RequestBody AlarmConfig alarmConfig){
        boolean update = alarmConfigService.update(alarmConfig);
        if(update){
            return HttpResult.ok("操作成功！");
        }else{
            return HttpResult.error("操作失败！");
        }
    }

    @PostMapping("/add")
    public HttpResult addAlarmInfo(@RequestBody AlarmConfig alarmConfig){
        boolean update = alarmConfigService.save(alarmConfig);
        if(update){
            return HttpResult.ok("操作成功！");
        }else{
            return HttpResult.error("操作失败！");
        }
    }

    @RequestMapping("/del/{id}")
    public HttpResult delAlarmConfigById(@PathVariable(value = "id") String id) {
        alarmConfigService.delete(id);
        return HttpResult.ok("操作成功！");
    }

    @PostMapping("/getList")
    private HttpResult getList(@RequestBody AlarmConfigQueryDTO queryDTO){

        return HttpResult.ok("获取成功！",alarmConfigService.getList(queryDTO));

    }
}
