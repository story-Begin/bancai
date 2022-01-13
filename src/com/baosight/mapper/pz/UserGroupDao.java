package com.baosight.mapper.pz;

import com.baosight.base.baseMapper.BaseMapper;
import com.baosight.dto.equipment.query.UserGroupDTO;
import com.baosight.dto.equipment.req.UserGroupDeviceDTO;
import com.baosight.entity.equipment.UserGroupEntity;
import com.baosight.entity.pz.UserGroupDeviceEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface UserGroupDao extends BaseMapper<UserGroupEntity> {

    List<UserGroupEntity> findPageList(UserGroupDTO queryDTO);

    /**
     * 获取用户组ID
     *
     * @param userId
     * @return
     */
    List<String> selectUserGroupId(String userId);

    int countUserGroup();

    /**
     * 获取当前用户组已存在的设备
     *
     * @param userGroupDeviceDTO
     * @return
     */
    List<UserGroupDeviceEntity> selectByGroupId(UserGroupDeviceDTO userGroupDeviceDTO);

    /**
     * 用户组ID获取
     * @param userGroupId
     * @return
     */
    List<Integer> selectByUserGroupId(String userGroupId);

    /**
     * 新增
     *
     * @param list
     * @return
     */
    boolean save(@Param(value = "list") List<UserGroupDeviceEntity> list);

    /**
     * 删除设备
     *
     * @param idList
     * @return
     */
    boolean deleteDevice(@Param(value = "idList") List<Integer> idList);
}
