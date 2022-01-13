package com.baosight.dto.vm.req;

import lombok.Data;

import javax.persistence.Column;
import java.io.Serializable;
import java.util.Date;

/**
 * 视频日志
 * @ClassName ThirdpartyOperationReqDTO
 * @Description DTO
 * @Author xu
 * @Date 2020/8/24 15:16
 */
@Data
public class ThirdpartyOperationReqDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 系统号
     */
    @Column(name = "system_no")
    private String systemNo;

    /**
     * 系统名称
     */
    @Column(name = "system_name")
    private String systemName;

    /**
     * 请求时间
     */
    @Column(name = "quest_time")
    private Date questTime;

    /**
     * 设备唯一编号
     */
    @Column(name = "device_code")
    private String deviceCode;

    /**
     * 创建时间
     */
    @Column(name = "create_time")
    private Date createTime;
}
