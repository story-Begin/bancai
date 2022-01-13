package com.baosight.controller.equipment;

import com.baosight.base.enumeration.CodeType;
import com.baosight.base.page.PageVo;
import com.baosight.controller.http.HttpResult;
import com.baosight.dto.common.DeleteDTO;
import com.baosight.dto.equipment.query.YWHKDeviceQueryDTO;
import com.baosight.dto.equipment.req.CameraDataUpdateDTO;
import com.baosight.dto.equipment.req.YWHKDeviceReqDTO;
import com.baosight.service.data_field.CodeTypeValueService;
import com.baosight.service.equipment.HKDeviceService;
import com.baosight.service.equipment.YWHKDeviceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;

/**
 * @ClassName YWHKDeviceController
 * @Description TODO
 * @Author hph
 * @Date 2020/12/28 9:38 上午
 * @Version 1.0
 */
@RestController
@RequestMapping("/backstage/equipment/camera")
public class YWHKDeviceController {

    @Autowired
    private YWHKDeviceService ywhkDeviceService;
    @Autowired
    private HKDeviceService hkDeviceService;
    @Autowired
    private CodeTypeValueService codeTypeValueService;

    /**
     * 设备信息分页列表
     *
     * @param queryDTO
     * @return
     */
    @PostMapping("/cameraDataList")
    public HttpResult findPageList(@RequestBody YWHKDeviceQueryDTO queryDTO) {
        PageVo pageVo = ywhkDeviceService.findPageList(queryDTO);
        return HttpResult.ok(pageVo);
    }

    /**
     * 设备、组织分页列表
     *
     * @param queryDTO
     * @return
     */
    @PostMapping("/pageDevOrganization")
    public HttpResult findPageDevOrganizationList(@RequestBody YWHKDeviceQueryDTO queryDTO) {
        return HttpResult.ok(ywhkDeviceService.findPageDevOrganizationList(queryDTO));
    }

    /**
     * 添加设备
     *
     * @param reqDTO
     * @return
     */
    @PostMapping("/save")
    public HttpResult save(@RequestBody YWHKDeviceReqDTO reqDTO) {
        ywhkDeviceService.save(reqDTO);
        return HttpResult.ok("添加成功！");
    }

    /**
     * 更新数据
     *
     * @param
     * @return
     */
    @PostMapping("/flashCameraData")
    public HttpResult flashCameraData() throws IllegalAccessException, IOException {
        hkDeviceService.getHKDeviceList();
        return HttpResult.ok("更新成功！");
    }

    /**
     * 修改设备
     *
     * @param reqDTO
     * @return
     */
    @PostMapping("/update")
    public HttpResult update(@RequestBody YWHKDeviceReqDTO reqDTO) {
        ywhkDeviceService.update(reqDTO);
        return HttpResult.ok("修改成功！");
    }

    /**
     * 批量修改设备、组织
     *
     * @param updateDTO
     * @return
     */
    @PostMapping("/updateBatch")
    public HttpResult updateBatch(@RequestBody CameraDataUpdateDTO updateDTO) {
        ywhkDeviceService.updateCameraDataList(updateDTO);
        return HttpResult.ok("操作成功！");
    }

    /**
     * 删除设备
     *
     * @param deleteDTO
     * @return
     */
    @PostMapping("/delete")
    public HttpResult delete(@RequestBody DeleteDTO deleteDTO) {
        ywhkDeviceService.deleteBatch(deleteDTO);
        return HttpResult.ok("删除成功！");
    }

    /**
     * 设备总数
     *
     * @return
     */
    @PostMapping("/sumCameraData")
    public HttpResult sumCameraData() {
        return HttpResult.ok(ywhkDeviceService.countCameraData());
    }

    /**
     * 设备类型代码类型值
     *
     * @return
     */
    @GetMapping(value = "/selectDevCodeTypeValue")
    public HttpResult findByDevCodeType() {
        return HttpResult.ok(codeTypeValueService.findCodeTypeValueList(CodeType.DEVICE_TYPE));
    }

    /**
     * 代码类型值
     *
     * @return
     */
    @GetMapping(value = "/selectDevStatusCodeTypeValue")
    public HttpResult findByCodeType() {
        return HttpResult.ok(codeTypeValueService.findCodeTypeValueList(CodeType.DEVICE_STATUS));
    }
}
