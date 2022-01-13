package com.baosight.dto.yw.resp;

import lombok.Data;

import java.io.Serializable;

/**
 * ServerStatusRespDTO使用
 *
 * @ClassName CmsDTO
 * @Description TODO
 * @Autgor huang
 * @Date 2020-11-17 14:21
 */
@Data
public class CmsDTO implements Serializable {
    private static final long serialVersionUID = -929150656713466060L;

    private String deviceName;

    private Integer deviceType;

    private Integer deviceIndex;

    private Integer deviceCode;

    private Integer onlineStatus;

    private Integer deviceId;
}
