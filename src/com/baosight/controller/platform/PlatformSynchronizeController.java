package com.baosight.controller.platform;

import com.baosight.controller.http.HttpResult;
import com.baosight.service.platform.DHCameraBrutService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/backstage/platform/sync")
public class PlatformSynchronizeController {

    @Autowired
    private DHCameraBrutService dhCameraBrutService;

    /**
     * 获取所有现存设备ID
     * @param
     * @return
     */
    @RequestMapping("/findAllId")
    public HttpResult findAllId(){
        HttpResult ok = HttpResult.ok(dhCameraBrutService.findAllId());
        return ok;
    }

}
