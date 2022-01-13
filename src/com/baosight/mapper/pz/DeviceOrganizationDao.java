package com.baosight.mapper.pz;

import com.baosight.base.baseMapper.BaseMapper;
import com.baosight.dto.pz.tree.DeviceOrganizationTree;
import com.baosight.dto.pz.query.DeviceOrganizationQueryDTO;
import com.baosight.dto.pz.tree.OrganizationTree;
import com.baosight.entity.pz.DeviceOrganizationEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface DeviceOrganizationDao extends BaseMapper<DeviceOrganizationEntity> {

    /**
     * 组织机构设备树
     *
     * @return
     */
    List<DeviceOrganizationTree> queryChildren(@Param(value = "parentId") Integer parentId);

    /**
     * 获取设备权限树
     *
     * @param ids
     * @return
     */
    List<DeviceOrganizationTree> selectPowerOrganizationTree(@Param(value = "ids") List<Integer> ids);

    /**
     * 组织机构树
     *
     * @return
     */
    List<OrganizationTree> queryOrganizationChildren(@Param(value = "parentId") Integer parentId);

    /**
     * 组织机构列表
     *
     * @param queryDTO
     * @return
     */
    List<DeviceOrganizationEntity> selectByOrganizationName(DeviceOrganizationQueryDTO queryDTO);


    /**
     * 删除
     *
     * @param idList
     */
    void deleteBatch(@Param(value = "idList") List<Integer> idList);

    /**
     * 父级找下级
     *
     * @param parentIdList
     * @return
     */
    List<DeviceOrganizationEntity> selectChildrenNode(@Param(value = "parentIdList") List<Integer> parentIdList);

}
