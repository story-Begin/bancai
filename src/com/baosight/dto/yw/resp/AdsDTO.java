package com.baosight.dto.yw.resp;

import lombok.Data;

import java.io.Serializable;

/**
 * ServerStatusRespDTO使用
 *
 * @ClassName AdsDTO
 * @Description TODO
 * @Autgor huang
 * @Date 2020-11-17 14:16
 */
@Data
public class AdsDTO implements Serializable {
    private static final long serialVersionUID = 8808753933050227520L;

    private String deviceName;

    private Integer deviceType;

    private Integer deviceIndex;

    private Integer deviceCode;

    private Integer onlineStatus;

    private Integer deviceId;
}
