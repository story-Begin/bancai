package com.baosight.dto.equipment.query;

import com.baosight.base.page.Page;
import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * 设备管理
 *
 * @ClassName CameraDataDTO
 * @Description TODO
 * @Author xu
 * @Date 2020/7/7 13:12
 */
@Data
public class CameraDataQueryDTO extends Page implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * id
     */
    private Integer id;

    /**
     * 平台设备IP
     */
    private String deviceIp;

    /**
     * 客户自己维护设备IP
     */
    private String remark2;

    /**
     * 区域
     */
    private String remark3;

    /**
     * 视频流ID
     */
    private List<Integer> idList;

    /**
     * 设备名称
     */
    private String mDeviceName;

    /**
     * 设备名称
     */
    private String deviceName;

    /**
     * 所属作业线
     */
    private Integer deviceOrganizationId;

    /**
     * 设备组织集合：用于权限分配
     */
    private List<Integer> deviceOrganizationIds;

    /**
     * 用户组id：用于权限分配
     */
    private String userGroupId;

    /**
     * 授权使用字段
     */
    private List<Integer> userGroupList;

    /**
     * 设备类型：1-枪机，2-球机
     */
    private Integer deviceType;

    /**
     * 设备是否分组：0-未分组，1-已分组
     */
    private Integer groupStatus;


}
