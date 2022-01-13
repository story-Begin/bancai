package com.baosight.dto.pz.query;

import com.baosight.base.page.Page;
import lombok.Data;

import java.io.Serializable;

/**
 * @ClassName DeviceOrganizationQueryDTO
 * @Description TODO
 * @Autgor huang
 * @Date 2020-07-06 15:51
 */
@Data
public class DeviceOrganizationQueryDTO extends Page implements Serializable {
    private static final long serialVersionUID = -2969789535743503185L;

    private Integer id;
    /**
     * 机构名称
     */
    private String organizationName;

    private Integer organizationParentId;

    /**
     * 用于设备组织树的设备节点校验
     */
    private String status;
}
