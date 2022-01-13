package com.baosight.mapper.equipment;

import com.baosight.base.baseMapper.BaseMapper;
import com.baosight.dto.equipment.query.UserGroupDTO;
import com.baosight.dto.equipment.query.YWHKDeviceQueryDTO;
import com.baosight.dto.equipment.req.CameraDataUpdateDTO;
import com.baosight.entity.equipment.YWHKDeviceEntity;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface YWHKDeviceDao extends BaseMapper<YWHKDeviceEntity> {

    /**
     * 设备信息列表
     *
     * @param queryDTO
     * @return
     */
    List<YWHKDeviceEntity> findPageList(YWHKDeviceQueryDTO queryDTO);

    /**
     * 删除
     *
     * @param idList
     */
    void deleteBatch(@Param(value = "idList") List<Integer> idList);

    /**
     * 作业线获取数据
     *
     * @param organizationIdList
     * @return
     */
    List<YWHKDeviceEntity> selectByOrganizationId(
            @Param(value = "organizationIdList") List<Integer> organizationIdList);

    /**
     * 设备、组织列表
     *
     * @param queryDTO
     * @return
     */
    List<YWHKDeviceEntity> selectDevOrganization(YWHKDeviceQueryDTO queryDTO);

    /**
     * 批量修改分组状态
     *
     * @param updateDTO return
     */
    void updateBatch(CameraDataUpdateDTO updateDTO);

    /**
     * 用户组设备权限
     *
     * @return
     */
    List<YWHKDeviceEntity> authorityCameraData(@Param(value = "userGroupIds") List<String> userGroupIds);

    /**
     * 获取所有数据：用于比较平台设备数据比较
     *
     * @return
     */
    List<YWHKDeviceEntity> selectCameraDataAll();

    /**
     * 批量修改数据
     *
     * @param ywhkDeviceEntities
     */
    void updateBatchCameraData(@Param(value = "cameraDataEntities") List<YWHKDeviceEntity> ywhkDeviceEntities);

    int countCameraData();

    /**
     * 设备信息
     *
     * @param queryDTO
     * @return
     */
    List<YWHKDeviceEntity> getDeviceList(UserGroupDTO queryDTO);
}
