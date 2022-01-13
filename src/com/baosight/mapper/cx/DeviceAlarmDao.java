package com.baosight.mapper.cx;

import com.baosight.base.baseMapper.BaseMapper;
import com.baosight.dto.cx.query.DeviceAlarmQueryDTO;
import com.baosight.dto.cx.req.DeviceAlarmReqDTO;
import com.baosight.dto.cx.resp.DeviceAlarmOutRealTimeDataDTO;
import com.baosight.dto.cx.resp.DeviceRealTimeAlarmDataQespDTO;
import com.baosight.entity.cx.DeviceAlarmEntity;
import com.baosight.entity.cx.RemoteDeviceAlarmEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Mapper
public interface DeviceAlarmDao extends BaseMapper<DeviceAlarmEntity> {

    /**
     * 报警信息列表
     *
     * @param queryDTO
     * @return
     */
    List<DeviceAlarmEntity> selectDeviceAlarmList(DeviceAlarmQueryDTO queryDTO);

    List<DeviceAlarmEntity> selectDeviceAlarmAllList();

    /**
     * 保存远程报警信息列表
     * @param deviceAlarmData
     * @return
     */
    int SavedeviceAlarmData(ArrayList<RemoteDeviceAlarmEntity> deviceAlarmData);

    int insertDeviceAlarmData(List<DeviceRealTimeAlarmDataQespDTO> deviceAlarmReqDTO);

    int insertDeviceRealTimeAlarmData(DeviceAlarmOutRealTimeDataDTO data);

    int selectAlarmTypeCount(Integer typeCode);

    int selectAlarmCount();

    int updateAlarmFlag();

    int selectAlarmCountByDate(Date date);

    List<DeviceAlarmEntity> getRealTimeAlarmData();

    int isSaved(@Param("happenTime")Date time,@Param("equiPmentNum")String deviceCode);

    Integer flushAlarmData();

    String getTablePageName(@Param("formEname")String eName);




}
