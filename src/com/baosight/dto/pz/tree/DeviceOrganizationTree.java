package com.baosight.dto.pz.tree;

import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * @ClassName DeviceOrganizationTree
 * @Description TODO
 * @Autgor huang
 * @Date 2020-07-07 09:40
 */
@Data
public class DeviceOrganizationTree implements Serializable {
    private static final long serialVersionUID = 6340042961246714076L;

    /**
     * ID
     */
    private Integer id;

    /**
     * 机构名称
     */
    private String organizationName;

    /**
     * 设备视频编码
     */
    private String cameraIndexCode;

    /**
     * 数据类型
     */
    private String dataType;

    /**
     * 设备是否在线
     */
    private String status;

    /**
     * 父级名称
     */
    private String organizationPathName;

    /**
     * icon图标
     */
    private String icon;

    private Integer organizationParentId;

    private List<DeviceOrganizationTree> children;

}
