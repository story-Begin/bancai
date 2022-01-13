package com.baosight.dto.pz.tree;

import lombok.Data;

import java.io.Serializable;

/**
 * @ClassName OrganizationTreeDTO
 * @Description TODO
 * @Autgor admin
 * @Date 2020-08-20 21:31
 */
@Data
public class OrganizationTreeDTO implements Serializable {
    private static final long serialVersionUID = -3587135765474457431L;
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
     * 是否叶子节点
     */
    private boolean isLeaf;

    /**
     * 图标
     */
    private String icon;

    /**
     * 父级路径名称
     */
    private String organizationPathName;
}
