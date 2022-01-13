package com.baosight.mapper.log;

import com.baosight.base.baseMapper.BaseMapper;
import com.baosight.base.entity.SysLog;
import com.baosight.dto.log.query.SysLogQueryDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * @ClassName SysLogMapper
 * @Description TODO
 * @Autgor huang
 * @Date 2020-08-25 16:05
 */
@Mapper
public interface SysLogMapper extends BaseMapper<SysLog> {

    List<SysLog> selectPageList();

    List<SysLog> selectPageList(SysLogQueryDTO dto);
}
