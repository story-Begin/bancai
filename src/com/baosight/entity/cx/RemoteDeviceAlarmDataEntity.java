package com.baosight.entity.cx;

import com.baosight.dto.cx.resp.DeviceAlarmOutRealTimeDataDTO;
import lombok.Data;

import java.io.Serializable;

@Data
public class RemoteDeviceAlarmDataEntity implements Serializable {

       //远程参数{"sessionId":1,"interfaceCode":"EVENT_SWING_CARD_RECORD","data":{}}
    /**
     * 回话id
     */
    private String sessionId;

    /**
     *事件类型
     */
    private String interfaceCode;

    /**
     *数据流
     */
    private DeviceAlarmOutRealTimeDataDTO data;


}
