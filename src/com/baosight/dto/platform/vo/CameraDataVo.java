package com.baosight.dto.platform.vo;

import lombok.Data;

import java.io.Serializable;

@Data
public class CameraDataVo implements Serializable {

    private static final long serialVersionUID = 1366627087087949244L;

    /**
     * 平台号
     */
    String sysNo;

    /**
     * 平台设备IP
     */
    private String deviceIp;
}
