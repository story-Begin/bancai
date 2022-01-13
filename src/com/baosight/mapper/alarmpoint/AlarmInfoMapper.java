package com.baosight.mapper.alarmpoint;

import com.baosight.base.baseMapper.BaseMapper;
import com.baosight.dto.alarminfo.query.AlarmInfoQueryDTO;
import com.baosight.entity.alarmpoint.AlarmInfo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface AlarmInfoMapper extends BaseMapper<AlarmInfo> {

    boolean updateById(AlarmInfo record);

    void deleteById(@Param("id")String id);

    List<AlarmInfo> getList(AlarmInfoQueryDTO queryDTO);
}
