package com.baosight.dto.vm.resp;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 轮询配置
 *
 * @ClassName DevicePollRespDTO
 * @Description TODO
 * @Autgor huang
 * @Date 2020-07-13 10:47
 */
@Data
public class DevicePollRespDTO implements Serializable {

    private static final long serialVersionUID = -2065389881394174640L;

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

    /**
     * 创建时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;

}
