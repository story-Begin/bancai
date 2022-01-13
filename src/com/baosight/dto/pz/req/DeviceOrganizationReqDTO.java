package com.baosight.dto.pz.req;

import lombok.Data;

import java.io.Serializable;

/**
 * 组织机构
 *
 * @ClassName DeviceOrganizationReqDTO
 * @Description TODO
 * @Autgor huang
 * @Date 2020-07-06 15:43
 */
@Data
public class DeviceOrganizationReqDTO implements Serializable {
    private static final long serialVersionUID = -1180849248687733762L;

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
     * 机构目录
     */
    private String organizationPath;

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

}
