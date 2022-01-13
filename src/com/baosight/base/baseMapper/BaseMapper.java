package com.baosight.base.baseMapper;

import tk.mybatis.mapper.common.Mapper;
import tk.mybatis.mapper.common.MySqlMapper;

/**
 * @ClassName BaseMapper
 * @Description TODO
 * @Autgor huang
 * @Date 2020-07-09 18:07
 */
public interface BaseMapper<T> extends Mapper<T>, MySqlMapper<T> {

}
