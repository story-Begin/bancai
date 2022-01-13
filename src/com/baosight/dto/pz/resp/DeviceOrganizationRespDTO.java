package com.baosight.dto.pz.resp;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 组织机构
 *
 * @ClassName DeviceOrganizationRespDTO
 * @Description TODO
 * @Autgor huang
 * @Date 2020-07-06 15:44
 */
@Data
public class DeviceOrganizationRespDTO implements Serializable {
    private static final long serialVersionUID = 2840125788425535792L;

    /**
     * ID
     */
    private Integer id;

    /**
     * 业务分类
     */
    private Integer businessType;

    /**
     * 机构名称
     */
    private String organizationName;

    /**
     * 父级Id
     */
    private Integer organizationParentId;

    /**
     * 父级名称
     */
    private String organizationPathName;

    /**
     * icon图标
     */
    private String icon;

    /**
     * 机构目录
     */
    private String organizationPath;

    /**
     * 创建时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;
}
