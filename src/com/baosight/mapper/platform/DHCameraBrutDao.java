package com.baosight.mapper.platform;

import com.baosight.base.baseMapper.BaseMapper;
import com.baosight.dto.platform.query.DHCameraBrutQueryDTO;
import com.baosight.entity.platform.DHCameraBrutEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 原始设备信息表
 */
@Mapper
public interface DHCameraBrutDao extends BaseMapper<DHCameraBrutEntity> {

    /**
     * 设备信息列表
     *
     * @param queryDTO 查询
     * @return
     */
    List<DHCameraBrutEntity> findPageList(DHCameraBrutQueryDTO queryDTO);

    /**
     * 批量删除
     *
     * @param idList 需要删除的id列表
     */
    void deleteBatch(@Param(value = "idList") List<Integer> idList);

    /**
     * 获取当前所有数据的ID
     * @return
     */
    List<Integer> findAllId();

    /**
     * 根据设备唯一识别码更新原始设备中的在线状态
     * @param status
     * @param code
     * @return
     */
    int updateOnlineStatusByDeviceIndexCode(@Param("status") String status, @Param("code") String code);

    /**
     * 根据设备唯一识别码查找原始设备信息
     * @param deviceIndexCode
     * @return
     */
    List<DHCameraBrutEntity> findCameraByDeviceIndexCode(String deviceIndexCode);
}
