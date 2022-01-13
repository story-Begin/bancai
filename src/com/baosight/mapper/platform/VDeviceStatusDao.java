package com.baosight.mapper.platform;

import com.baosight.base.baseMapper.BaseMapper;
import com.baosight.entity.platform.VDeviceStatus;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * 设备状态表Dao
 */
@Mapper
public interface VDeviceStatusDao  extends BaseMapper<VDeviceStatus> {
    /**
     * 根据唯一设备码查找设备状态
     * @param deviceIndexCode
     * @return
     */
    VDeviceStatus selectByDeviceKey(@Param("deviceIndexCode") String deviceIndexCode);

    /**
     * 根据唯一设备码更新设备状态表
     * @param vDeviceStatus
     */
    void updateByDeviceKey(VDeviceStatus vDeviceStatus);
}
