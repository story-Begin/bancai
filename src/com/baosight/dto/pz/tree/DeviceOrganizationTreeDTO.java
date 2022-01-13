package com.baosight.dto.pz.tree;

import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * @ClassName DeviceOrganizationTreeDTO
 * @Description TODO
 * @Autgor huang
 * @Date 2020-07-07 09:46
 */
@Data
public class DeviceOrganizationTreeDTO implements Serializable {
    private static final long serialVersionUID = 6566392464262787072L;

    /**
     * ID
     */
    private Integer id;

    /**
     * 机构名称
     */
    private String organizationName;

    /**
     * 是否叶子节点
     */
    private boolean isLeaf;

    /**
     * 图标
     */
    private String icon;

    /**
     * 数据类型：1、组织 2、厂房 3、设备
     */
    private String dataType;

    /**
     * 1、枪机 2、球机 3、半球机
     */
    private Integer deviceType;

    /**
     * 设备代码
     */
    private String deviceCode;

    /**
     * 设备视频编码
     */
    private String cameraIndexCode;

    /**
     * 父级名称
     */
    private String organizationPathName;

    /**
     * 设备是否在线
     */
    private Integer status;

    /**
     * 安装位置
     */
    private String areaAddr;

    private Integer organizationParentId;

    private List<DeviceOrganizationTreeDTO> children;
}
