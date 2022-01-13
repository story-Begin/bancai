package com.baosight.dto.pz.tree;

import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * @ClassName OrganizationTree
 * @Description TODO
 * @Autgor admin
 * @Date 2020-08-20 21:31
 */
@Data
public class OrganizationTree implements Serializable {
    private static final long serialVersionUID = 306691999025415283L;
    /**
     * ID
     */
    private Integer id;

    /**
     * 机构名称
     */
    private String organizationName;

    /**
     * 数据类型
     */
    private String dataType;

    /**
     * icon图标
     */
    private String icon;

    /**
     * 父级路径名称
     */
    private String organizationPathName;

    private List<DeviceOrganizationTree> children;
}
