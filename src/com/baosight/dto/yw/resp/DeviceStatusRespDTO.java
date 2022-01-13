package com.baosight.dto.yw.resp;

import lombok.Data;

import java.io.Serializable;

/**
 * 获取设备状态
 *
 * @ClassName DeviceStatusRespDTO
 * @Description TODO
 * @Autgor huang
 * @Date 2020-11-17 10:57
 */
@Data
public class DeviceStatusRespDTO implements Serializable {
    private static final long serialVersionUID = 7759288365180874886L;

    private Integer orgId;

    private String deviceIp;

    private String deviceName;

    private String deviceType;

    private String deviceCode;

    private String nodeIndexCode;

    private String orgName;

    /**
     * 是否在线
     */
    private Integer onlineStatus;

    private String statusTimeStr;


    private Integer deviceId;

}
