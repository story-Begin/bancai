package com.baosight.controller.pz;

import com.baosight.base.page.PageVo;
import com.baosight.controller.http.HttpResult;
import com.baosight.dto.common.DeleteDTO;
import com.baosight.dto.equipment.resp.CameraDataCountRespDTO;
import com.baosight.dto.pz.query.DeviceOrganizationQueryDTO;
import com.baosight.dto.pz.req.DeviceOrganizationReqDTO;
import com.baosight.dto.pz.tree.DeviceOrganizationTreeDTO;
import com.baosight.entity.equipment.YWHKDeviceEntity;
import com.baosight.iplat4j.core.web.threadlocal.UserSession;
import com.baosight.mapper.equipment.YWHKDeviceDao;
import com.baosight.mapper.pz.UserGroupDao;
import com.baosight.service.pz.DeviceOrganizationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 组织机构
 *
 * @ClassName DeviceOrganizationController
 * @Description TODO
 * @Autgor huang
 * @Date 2020-07-07 14:29
 */
@RestController
@RequestMapping("/backstage/equipment/organization")
public class DeviceOrganizationController {

    @Autowired
    private DeviceOrganizationService deviceOrganizationService;
    @Autowired
    private YWHKDeviceDao cameraDataDao;
    @Autowired
    private UserGroupDao userGroupMapper;

    /**
     * 组织机构分页列表
     *
     * @param queryDTO
     * @return
     */
    @PostMapping(value = "/getPageList")
    public HttpResult queryPageList(@RequestBody DeviceOrganizationQueryDTO queryDTO) {
        PageVo pageVo = deviceOrganizationService.findPageList(queryDTO);
        return HttpResult.ok(pageVo);
    }

    /**
     * 组织机构树
     *
     * @param queryDTO
     * @return
     */
    @PostMapping(value = "/organizationTree")
    public HttpResult organizationTree(@RequestBody DeviceOrganizationQueryDTO queryDTO) {
        return HttpResult.ok(deviceOrganizationService.getOrganizationTree(queryDTO));
    }

    /**
     * 组织设备树
     *
     * @return
     */
    @PostMapping(value = "/organizationEquipmentTree")
    public HttpResult organizationEquipmentTree(@RequestBody DeviceOrganizationQueryDTO queryDTO) {
        return HttpResult.ok(deviceOrganizationService.getOrganizationEquipmentTree(queryDTO));
    }

    /**
     * 用户权限组织设备树
     *
     * @return
     */
    @PostMapping(value = "/powerOrganizationEquipmentTree")
    public HttpResult powerOrganizationEquipmentTree(@RequestBody DeviceOrganizationQueryDTO queryDTO) {
        return HttpResult.ok(deviceOrganizationService.getPowerOrganizationEquipmentAllTree(queryDTO));
    }

    /**
     * 递归获取所有设备信息
     *
     * @param queryDTO
     * @return
     */
    @PostMapping(value = "/getOrganizationEquipmentAllTree")
    public HttpResult getOrganizationEquipmentAllTree(@RequestBody DeviceOrganizationQueryDTO queryDTO) {
        List<DeviceOrganizationTreeDTO> deviceOrganizationTreeDTOS = deviceOrganizationService.getOrganizationEquipmentAllTree(queryDTO);
        return HttpResult.ok(deviceOrganizationTreeDTOS);
    }

    /**
     * 统计设备总数、在线数量
     *
     * @param id
     * @return
     */
    @PostMapping(value = "/getCameraDataCount")
    public HttpResult getCameraDataCount(@RequestParam(value = "id") Integer id) {
        List<String> userGroupIds = userGroupMapper.selectUserGroupId(UserSession.getUserUuid());
        List<YWHKDeviceEntity> cameraDataList = cameraDataDao.authorityCameraData(userGroupIds)
                .stream().filter(it -> it != null).collect(Collectors.toList());
        List<Integer> cameraDataIdList = cameraDataList.stream().map(YWHKDeviceEntity::getId).collect(Collectors.toList());
        List<Integer> ids = new ArrayList<>();
        ids.add(id);
        CameraDataCountRespDTO cameraDataCount = deviceOrganizationService.queryCameraDataCount(ids, cameraDataIdList);
        return HttpResult.ok(cameraDataCount);
    }

    /**
     * 设备轮询：统计设备总数、在线数量
     *
     * @param id
     * @return
     */
    @PostMapping(value = "/getCameraDataSumNum")
    public HttpResult getCameraDataSumNum(@RequestParam(value = "id") Integer id) {
        List<Integer> ids = new ArrayList<>();
        ids.add(id);
        CameraDataCountRespDTO cameraDataCount = deviceOrganizationService.queryCameraDataSumNum(ids);
        return HttpResult.ok(cameraDataCount);
    }

    /**
     * 新增组织机构
     *
     * @param record
     * @return
     */
//    @Log(operationType = "add操作", operationName = "添加织设备树")
    @PostMapping(value = "/save")
    public HttpResult save(@RequestBody DeviceOrganizationReqDTO record) {
        deviceOrganizationService.save(record);
        return HttpResult.ok("添加成功");
    }

    /**
     * 编辑组织机构
     *
     * @param record
     * @return
     */
//    @Log(operationType = "update操作", operationName = "编辑组织设备树")
    @PostMapping(value = "/update")
    public HttpResult change(@RequestBody DeviceOrganizationReqDTO record) {
        deviceOrganizationService.update(record);
        return HttpResult.ok("编辑成功");
    }

    /**
     * 删除组织机构
     *
     * @param deleteDTO
     * @return
     */
//    @Log(operationType = "delete操作", operationName = "删除组织设备树")
    @PostMapping(value = "/delete")
    public HttpResult delete(@RequestBody DeleteDTO deleteDTO) {
        deviceOrganizationService.deleteBatch(deleteDTO);
        return HttpResult.ok("删除成功");
    }

}
