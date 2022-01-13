package com.baosight.entity.pz;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * 组织机构表
 *
 * @ClassName DeviceOrganizationEntity
 * @Description TODO
 * @Autgor huang
 * @Date 2020-07-06 15:02
 */
@Data
@Table(name = "v_device_organization")
public class DeviceOrganizationEntity implements Serializable {
    private static final long serialVersionUID = 9034818607027423337L;

    /**
     * ID
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    /**
     * 数据类型
     */
    @Column(name = "data_type")
    private Integer dataType;

    /**
     * 机构名称
     */
    @Column(name = "organization_name")
    private String organizationName;

    /**
     * 机构目录
     */
    @Column(name = "organization_path")
    private String organizationPath;

    /**
     * 父级Id
     */
    @Column(name = "fk_organization_parent_id")
    private Integer organizationParentId;

    /**
     * 父级名称
     */
    @Column(name = "organization_path_name")
    private String organizationPathName;

    /**
     * icon图标
     */
    @Column(name = "icon")
    private String icon;

    /**
     * 创建时间
     */
    @Column(name = "create_time")
    private Date createTime;

}
