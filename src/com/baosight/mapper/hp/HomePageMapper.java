package com.baosight.mapper.hp;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.Map;

@Mapper
public interface HomePageMapper {

     Integer getAlarmCount(Map<String,Object> params);

     Integer getCameraCount(@Param("status") Integer status);

     Integer getCameraInvokeCount(@Param("sysNo")String sysNo,@Param("timeToday") boolean flag,@Param("date")Date date);

}
