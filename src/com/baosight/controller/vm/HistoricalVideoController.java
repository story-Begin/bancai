package com.baosight.controller.vm;

import com.baosight.base.page.PageVo;
import com.baosight.controller.http.HttpResult;
import com.baosight.dto.vm.query.UserQueryDTO;
import com.baosight.dto.vm.req.DeviceAccidentReqDTO;
import com.baosight.iplat4j.core.web.threadlocal.UserSession;
import com.baosight.service.vm.DeviceAccidentService;
import com.baosight.service.vm.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;



/**
 * 历史视频
 *
 * @ClassName HistoricalVideoController
 * @Description TODO
 * @Author xu
 * @Date 2020/9/8 10:27
 */
@RestController
@RequestMapping("/backstage/vm/historicalVideo")
public class HistoricalVideoController {

    @Autowired
    private UserService userService;

    @Autowired
    private DeviceAccidentService deviceAccidentService;

    /**
     * 系统用户分页列表
     *
     * @param queryDTO
     * @return
     */
    @PostMapping(value = "/getPageList")
    public HttpResult queryPageList(@RequestBody UserQueryDTO queryDTO) {
        PageVo pageVo = userService.findPageList(queryDTO);
        return HttpResult.ok(pageVo);
    }
    /**
     * 新增突发事件
     *
     * @param reqDTO
     * @return
     */
    @PostMapping(value = "/save")
    public HttpResult save(@RequestBody DeviceAccidentReqDTO reqDTO) {
        //获取当前登录用户信息
        String loginCName = UserSession.getLoginCName();
        String loginName = UserSession.getLoginName();
        reqDTO.setFinderName(loginCName);
        reqDTO.setFinderJob(loginName);
        reqDTO.setStatus("0");
        deviceAccidentService.save(reqDTO);
        return HttpResult.ok("添加成功");
    }

    /**
     * 获取系统用户信息
     *
     * @return
     */
    @PostMapping(value = "/getUserInfo")
    public HttpResult getUserInfo(){
        String loginCName = UserSession.getLoginCName();
        String loginName = UserSession.getLoginName();
        String result = loginCName+"("+loginName+")";
        return HttpResult.ok(result);
    }


}


