package com.baosight.service.cx;


import com.baosight.dto.cx.query.DeviceHisAlarmDataQueryDTO;
import com.baosight.dto.cx.query.DeviceRealTimeAlarmDataQueryDTO;
import com.baosight.dto.cx.resp.DeviceHisAlarmDataRespDTO;
import com.baosight.dto.cx.resp.DeviceRealTimeAlarmDataQespDTO;

import java.util.ArrayList;
import java.util.Map;

public interface DeviceAlarmRemoteDataService {


    /**
     * 获取第三方平台接口数据
     * @param
     * @return
     */
    public boolean getRemoteHisAlarmData();

    /**
     * 获取第三方平台实时报警数据
     */
    public boolean getRpcRealTimeAlarmData();

    Integer flushAlarmData();

}
