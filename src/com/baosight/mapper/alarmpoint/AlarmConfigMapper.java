package com.baosight.mapper.alarmpoint;

import com.baosight.base.baseMapper.BaseMapper;
import com.baosight.dto.alarminfo.query.AlarmConfigQueryDTO;
import com.baosight.entity.alarmpoint.AlarmConfig;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface AlarmConfigMapper extends BaseMapper<AlarmConfig> {

    void updateById(AlarmConfig config);

    void deleteById(@Param("id") String ids);

    List<AlarmConfig> getList(AlarmConfigQueryDTO queryDTO);
}
