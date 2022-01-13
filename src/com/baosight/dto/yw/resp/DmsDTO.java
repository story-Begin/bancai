package com.baosight.dto.yw.resp;

import lombok.Data;

import java.io.Serializable;

/**
 * ServerStatusRespDTO使用
 *
 * @ClassName DmsDTO
 * @Description TODO
 * @Autgor huang
 * @Date 2020-11-17 14:07
 */
@Data
public class DmsDTO implements Serializable {
    private static final long serialVersionUID = -8228131199313822926L;

    private String deviceName;

    private Integer deviceType;

    private Integer deviceIndex;

    private Integer deviceCode;

    private Integer onlineStatus;

    private Integer deviceId;
}
