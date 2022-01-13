package com.baosight.service.pz;

import com.baosight.base.baseService.BaseService;
import com.baosight.base.page.PageVo;
import com.baosight.dto.common.DeleteDTO;
import com.baosight.dto.equipment.resp.CameraDataCountRespDTO;
import com.baosight.dto.pz.query.DeviceOrganizationQueryDTO;
import com.baosight.dto.pz.req.DeviceOrganizationReqDTO;
import com.baosight.dto.pz.tree.DeviceOrganizationTreeDTO;
import com.baosight.dto.pz.tree.OrganizationTreeDTO;

import java.util.List;

public interface DeviceOrganizationService extends BaseService<DeviceOrganizationReqDTO> {

    /**
     * 组织机构列表
     *
     * @param queryDTO
     * @return
     */
    PageVo findPageList(DeviceOrganizationQueryDTO queryDTO);

    /**
     * 组织机构树
     *
     * @param queryDTO
     * @return
     */
    List<OrganizationTreeDTO> getOrganizationTree(DeviceOrganizationQueryDTO queryDTO);

    /**
     * 组织设备树
     *
     * @param queryDTO
     * @return
     */
    List<DeviceOrganizationTreeDTO> getOrganizationEquipmentTree(DeviceOrganizationQueryDTO queryDTO);

    /**
     * 递归获取用户组所有设备信息
     *
     * @return
     */
    List<DeviceOrganizationTreeDTO> getPowerOrganizationEquipmentAllTree(DeviceOrganizationQueryDTO queryDTO);

    /**
     * 递归获取所有设备信息
     *
     * @param queryDTO
     * @return
     */
    List<DeviceOrganizationTreeDTO> getOrganizationEquipmentAllTree(DeviceOrganizationQueryDTO queryDTO);

    /**
     * 批量删除
     *
     * @param deleteDTO
     */
    void deleteBatch(DeleteDTO deleteDTO);


    /**
     * 统计设备总数、在线数量
     *
     * @param ids
     * @param cameraDataIdList
     * @return
     */
    CameraDataCountRespDTO queryCameraDataCount(List<Integer> ids, List<Integer> cameraDataIdList);

    /**
     * VMYL03: 视频轮询 统计设备总数、在线数量
     *
     * @param ids
     * @return
     */
    CameraDataCountRespDTO queryCameraDataSumNum(List<Integer> ids);

}
