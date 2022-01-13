package com.baosight.dto.yw.resp;

import lombok.Data;

import java.io.Serializable;

/**
 * 平台状态
 *
 * @ClassName PlatformDomainRespDTO
 * @Description TODO
 * @Autgor huang
 * @Date 2020-11-17 13:46
 */
@Data
public class PlatformDomainRespDTO implements Serializable {
    private static final long serialVersionUID = 5990764239400966280L;

    private String onlineStatusTime;

    private String domainIP;

    private Integer domainId;

    private String domainName;

    private Integer onlineStatus;

    private String domainCode;
}
