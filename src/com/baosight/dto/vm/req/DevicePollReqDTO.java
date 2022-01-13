package com.baosight.dto.vm.req;

import lombok.Data;

import java.io.Serializable;

/**
 * 轮询配置
 *
 * @ClassName DevicePollReqDTO
 * @Description TODO
 * @Autgor huang
 * @Date 2020-07-13 10:32
 */
@Data
public class DevicePollReqDTO implements Serializable {
    private static final long serialVersionUID = -6311936331168812982L;

    private Integer id;

    /**
     * 计划名称
     */
    private String planName;

    /**
     * 轮询周期
     */
    private String pollPeriod;

    /**
     * 设备编号
     */
    private String deviceCode;

    /**
     * 组织id
     */
    private String orgId;

    /**
     * 备注
     */
    private String remark;

}
