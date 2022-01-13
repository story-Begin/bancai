package com.baosight.mapper.vm;

import com.baosight.base.baseMapper.BaseMapper;
import com.baosight.dto.vm.query.DeviceAccidentQueryDTO;
import com.baosight.entity.vm.DeviceAccidentEntity;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * @ClassName DeviceAccidentDao
 * @Description DOTO
 * @Author xu
 * @Date 2020/9/8 15:40
 */
@Mapper
public interface DeviceAccidentDao extends BaseMapper<DeviceAccidentEntity> {

    /**
     * 突发事件列表
     *
     * @param queryDTO
     * @return
     */
    List<DeviceAccidentEntity> selectDeviceAccidentList(DeviceAccidentQueryDTO queryDTO);

    /**
     * 当前审批事务
     *
     * @param queryDTO
     * @return
     */
    List<DeviceAccidentEntity> selectActiviti(DeviceAccidentQueryDTO queryDTO);
}
