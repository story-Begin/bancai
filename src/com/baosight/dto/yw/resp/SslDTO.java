package com.baosight.dto.yw.resp;

import lombok.Data;

import java.io.Serializable;

/**
 * ServerStatusRespDTO使用
 *
 * @ClassName SslDTO
 * @Description TODO
 * @Autgor huang
 * @Date 2020-11-17 14:13
 */
@Data
public class SslDTO implements Serializable {
    private static final long serialVersionUID = -7411351297484483099L;

    private String deviceName;

    private Integer deviceType;

    private Integer deviceIndex;

    private Integer deviceCode;

    private Integer onlineStatus;

    private Integer deviceId;
}
