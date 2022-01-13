package com.baosight.controller.pz;

import com.baosight.base.page.PageVo;
import com.baosight.controller.http.HttpResult;
import com.baosight.dto.equipment.query.UserGroupDTO;
import com.baosight.dto.equipment.req.UserGroupDeviceDTO;
import com.baosight.dto.pz.query.UserGroupDeviceQueryDTO;
import com.baosight.service.pz.UserGroupDeviceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RequestMapping("/backstage/pz/userGroupDevice")
public class UserGroupDeviceController {

    @Autowired
    private UserGroupDeviceService userGroupDeviceService;

//    /**
//     * 用户组分页列表
//     *
//     * @param queryDTO
//     * @return
//     */
//    @PostMapping("/getUserGroupList")
//    public HttpResult findPageList(@RequestBody UserGroupDTO queryDTO) {
//        PageVo pageVo = userGroupDeviceService.findPageList(queryDTO);
//        return HttpResult.ok(pageVo);
//    }

    /**
     * 设备分页
     *
     * @param queryDTO
     * @return
     */
    @PostMapping("/getDeviceList")
    public HttpResult getDeviceList(@RequestBody UserGroupDTO queryDTO) {
        PageVo pageVo = userGroupDeviceService.getDeviceList(queryDTO);
        return HttpResult.ok(pageVo);
    }

    @PostMapping("/getUserGroupAllList")
    public HttpResult getUserGroupAllList(@RequestBody UserGroupDTO queryDTO) {
        return HttpResult.ok(userGroupDeviceService.findPageList(queryDTO));
    }

    /**
     * 新增
     *
     * @param userGroupDeviceDTO
     * @return
     */
    @PostMapping("/save")
    public HttpResult save(@RequestBody UserGroupDeviceDTO userGroupDeviceDTO) {
        userGroupDeviceService.save(userGroupDeviceDTO);
        return HttpResult.ok("添加成功");
    }

    /**
     * 删除
     *
     * @param idList
     * @return
     */
    @PostMapping("/delete")
    public HttpResult delete(@RequestBody String idList) {
        userGroupDeviceService.delete(idList);
        return HttpResult.ok("删除成功");
    }
}
