package com.baosight.mapper.equipment;

import com.baosight.base.baseMapper.BaseMapper;
import com.baosight.entity.equipment.HKDeviceEntity;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface HKDeviceDao extends BaseMapper<HKDeviceEntity> {

//    void deleteBatch(List<Integer> ids);

    int truncateTable();
}
