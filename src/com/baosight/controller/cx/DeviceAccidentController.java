package com.baosight.controller.cx;

import com.baosight.base.page.PageVo;
import com.baosight.controller.http.HttpResult;
import com.baosight.dto.common.DeleteDTO;
import com.baosight.dto.vm.query.DeviceAccidentQueryDTO;
import com.baosight.dto.vm.req.DeviceAccidentReqDTO;
import com.baosight.service.vm.DeviceAccidentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

/**
 * 突发事件
 *
 * @ClassName DeviceAccidentController
 * @Description TODO
 * @Autgor huang
 * @Date 2020-09-10 16:30
 */
@RestController
@RequestMapping("/cx/accident")
public class DeviceAccidentController {

    @Autowired
    private DeviceAccidentService deviceAccidentService;


    /**
     * 自己待办任务
     *
     * @return
     */
    @PostMapping("/querySelfActivity")
    public HttpResult querySelfActivity(@RequestBody DeviceAccidentQueryDTO queryDTO) {
        PageVo pageVo = deviceAccidentService.findAllActivity(queryDTO);
        return HttpResult.ok(pageVo);
    }

    /**
     * 突发事件页面列表
     *
     * @param queryDTO
     * @return
     */
    @RequestMapping("/queryPageList")
    public HttpResult queryAccidentPageList(@RequestBody DeviceAccidentQueryDTO queryDTO) {
        PageVo pageVo = deviceAccidentService.findPageList(queryDTO);
        return HttpResult.ok(pageVo);
    }

    /**
     * 突发事件列表
     *
     * @param queryDTO
     * @return
     */
    @RequestMapping("/queryAllPageList")
    public HttpResult queryAccidentAllPageList(@RequestBody DeviceAccidentQueryDTO queryDTO) {
        PageVo pageVo = deviceAccidentService.findAllPageList(queryDTO);
        return HttpResult.ok(pageVo);
    }

    /**
     * 新增突发事件
     *
     * @param reqDTO
     * @return
     */
    @RequestMapping("/saveAccident")
    public HttpResult saveAccident(@RequestBody DeviceAccidentReqDTO reqDTO) {
        return HttpResult.ok(deviceAccidentService.save(reqDTO));
    }


    /**
     * 图片上传
     *
     * @param file
     * @return
     */
    @PostMapping("/fileUpload")
    public HttpResult upload(@RequestParam("file") MultipartFile file, String jsonReqDTO) {
        boolean flag = deviceAccidentService.fileUpload(file, jsonReqDTO);
        if (flag) {
            return HttpResult.ok("上传成功!");
        }
        return HttpResult.ok("上传失败!");
    }

    /**
     * 删除突发事件
     *
     * @param deleteDTO
     * @return
     */
    @PostMapping("/deleteList")
    public HttpResult deleteAccidentList(@RequestBody DeleteDTO deleteDTO) {
        deviceAccidentService.deleteBatch(deleteDTO);
        return HttpResult.ok("删除成功！");
    }

    /**
     * 突发事件工作流审批
     *
     * @return
     */
    @PostMapping("/examineActivity")
    public HttpResult examineActivity(@RequestParam("file") MultipartFile file, String jsonReqDTO) {
        deviceAccidentService.examine(file, jsonReqDTO);
        return HttpResult.ok("审批成功！");
    }
}
