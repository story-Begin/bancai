package com.baosight.dto.equipment.query;

import com.baosight.base.page.Page;
import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * @ClassName YWHKDeviceQueryDTO
 * @Description TODO
 * @Author hph
 * @Date 2020/12/24 1:06 下午
 * @Version 1.0
 */
@Data
public class YWHKDeviceQueryDTO extends Page implements Serializable {
    private static final long serialVersionUID = 7559337999267213530L;

    /**
     * id
     */
    private String cameraUuid;

    /**
     * 视频流ID
     */
    private List<Integer> idList;

    /**
     * 设备名称
     */
    private String cameraName;

    /**
     * 设备类型
     */
    private Integer cameraType;

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
