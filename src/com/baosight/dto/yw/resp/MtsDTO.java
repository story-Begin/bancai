package com.baosight.dto.yw.resp;

import lombok.Data;

import java.io.Serializable;

/**
 * ServerStatusRespDTO使用
 *
 * @ClassName MtsDTO
 * @Description TODO
 * @Autgor huang
 * @Date 2020-11-17 14:03
 */
@Data
public class MtsDTO implements Serializable {
    private static final long serialVersionUID = 1200313354260802981L;

    private String deviceName;

    private Integer deviceType;

    private Integer deviceIndex;

    private Integer deviceCode;

    private Integer onlineStatus;

    private Integer deviceId;
}
