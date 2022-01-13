package com.baosight.dto.yw.resp;

import lombok.Data;

import java.io.Serializable;

/**
 * ServerStatusRespDTO使用
 *
 * @ClassName ptsDTO
 * @Description TODO
 * @Autgor huang
 * @Date 2020-11-17 14:10
 */
@Data
public class ptsDTO implements Serializable {
    private static final long serialVersionUID = 4993434000738682892L;

    private String deviceName;

    private Integer deviceType;

    private Integer deviceIndex;

    private Integer deviceCode;

    private Integer onlineStatus;

    private Integer deviceId;
}
