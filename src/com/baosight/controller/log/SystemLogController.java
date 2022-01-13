package com.baosight.controller.log;

import com.baosight.base.service.SystemLogService;
import com.baosight.controller.http.HttpResult;
import com.baosight.dto.log.query.SysLogQueryDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/backstage/log")
public class SystemLogController {
    @Autowired
    private SystemLogService systemLogService;

    @RequestMapping("/findPageList")
    public HttpResult findPageList(@RequestBody SysLogQueryDTO dto){
        HttpResult ok = HttpResult.ok(systemLogService.findPageList(dto));
        return ok;
    }
}
