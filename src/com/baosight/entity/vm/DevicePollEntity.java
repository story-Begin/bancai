package com.baosight.entity.vm;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * 轮询配置信息
 *
 * @ClassName DevicePollEntity
 * @Description TODO
 * @Autgor huang
 * @Date 2020-07-13 10:16
 */
@Data
@Table(name = "v_device_poll")
public class DevicePollEntity implements Serializable {
    private static final long serialVersionUID = -5886390666909273630L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    /**
     * 计划名称
     */
    @Column(name = "plan_name")
    private String planName;

    /**
     * 轮询周期
     */
    @Column(name = "poll_period")
    private String pollPeriod;

    /**
     * 设备编号
     */
    @Column(name = "device_code")
    private String deviceCode;

    /**
     * 组织id
     */
    @Column(name = "org_id")
    private String orgId;

    /**
     * 备注
     */
    @Column(name = "remark")
    private String remark;

    @Column(name = "create_time")
    private Date createTime;

}
