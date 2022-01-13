package com.baosight.dto.yw.resp;

import lombok.Data;

import java.io.Serializable;

/**
 * ServerStatusRespDTO使用
 *
 * @ClassName PcsDTO
 * @Description TODO
 * @Autgor huang
 * @Date 2020-11-17 14:00
 */
@Data
public class PcsDTO implements Serializable {
    private static final long serialVersionUID = 7891240982957045916L;

    private String deviceName;

    private Integer deviceType;

    private Integer deviceIndex;

    private Integer deviceCode;

    private Integer onlineStatus;

    private Integer deviceId;
}
