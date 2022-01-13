package com.baosight.dto.yw.resp;

import lombok.Data;

import java.io.Serializable;

/**
 * 获取设备在离线历史记录
 *
 * @ClassName DeviceHistoryRespDTO
 * @Description TODO
 * @Autgor huang
 * @Date 2020-11-17 11:21
 */
@Data
public class DeviceHistoryRespDTO implements Serializable {
    private static final long serialVersionUID = 3817831479591643856L;

    private String startTime;

    private String onlineStatus;

    private String endTime;

    private String statusTimeStr;

    private String deviceId;
}
