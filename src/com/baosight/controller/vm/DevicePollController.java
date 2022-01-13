package com.baosight.controller.vm;

import com.baosight.base.page.PageVo;
import com.baosight.controller.http.HttpResult;
import com.baosight.dto.vm.query.DevicePollQueryDTO;
import com.baosight.dto.vm.req.DevicePollReqDTO;
import com.baosight.service.vm.DevicePollService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 轮询配置
 *
 * @ClassName DevicePollController
 * @Description TODO
 * @Autgor huang
 * @Date 2020-07-13 10:44
 */
@RestController
@RequestMapping("/backstage/vm/devicePoll")
public class DevicePollController {

    @Autowired
    private DevicePollService devicePollService;

    /**
     * 轮询配置分页列表
     *
     * @param queryDTO
     * @return
     */
    @PostMapping(value = "/getPageList")
    public HttpResult queryPageList(@RequestBody DevicePollQueryDTO queryDTO) {
        PageVo pageVo = devicePollService.findPageList(queryDTO);
        return HttpResult.ok(pageVo);
    }

    /**
     * 查询轮询名称的
     * @return
     */
    @PostMapping(value = "/getNamesList")
    public HttpResult queryNameList() {
        return HttpResult.ok(devicePollService.findDevicePollNameList());
    }

    /**
     * 新增轮询配置
     *
     * @param reqDTO
     * @return
     */
    @PostMapping(value = "/save")
    public HttpResult save(@RequestBody DevicePollReqDTO reqDTO) {
        devicePollService.save(reqDTO);
        return HttpResult.ok("添加成功");
    }

    /**
     * 编辑轮询配置
     *
     * @param reqDTO
     * @return
     */
    @PostMapping(value = "/update")
    public HttpResult change(@RequestBody DevicePollReqDTO reqDTO) {
        devicePollService.update(reqDTO);
        return HttpResult.ok("编辑成功");
    }

    /**
     * 删除轮询配置
     *
     * @param ids
     * @return
     */
    @PostMapping(value = "/delete")
    public HttpResult delete(@RequestBody String ids) {
        devicePollService.delete(ids);
        return HttpResult.ok("删除成功");
    }
}
