package com.baosight.controller.vm;

import com.baosight.controller.http.HttpResult;
import com.baosight.dto.vm.req.ThirdpartyOperationReqDTO;
import com.baosight.iplat4j.core.web.threadlocal.UserSession;
import com.baosight.service.vm.ThirdpartyOperationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Date;

/**
 * 视频日志
 * @ClassName ThirdPartyOperationController
 * @Description TODO
 * @Author xu
 * @Date 2020/8/24 15:43
 */
@RestController
@RequestMapping("/backstage/vm/thirOper")
public class ThirdPartyOperationController {

    @Autowired
    private ThirdpartyOperationService thirdOpecService;

    /**
     * 添加视频日志
     */
    @PostMapping(value = "/save")
    public HttpResult save(String deviceCode) {
        ThirdpartyOperationReqDTO reqDTO = new ThirdpartyOperationReqDTO();
        reqDTO.setSystemNo("No:0001");
        reqDTO.setSystemName(UserSession.getLoginName());
        reqDTO.setDeviceCode(deviceCode);
        reqDTO.setQuestTime(new Date());
//        reqDTO.setCreateTime(new Date());
        thirdOpecService.save(reqDTO);
        return HttpResult.ok("添加成功");
    }
}
