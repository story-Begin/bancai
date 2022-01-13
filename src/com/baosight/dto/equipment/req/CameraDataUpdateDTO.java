package com.baosight.dto.equipment.req;

import lombok.Data;

import java.util.List;

/**
 * 设备批量修改分组状态
 *
 * @ClassName CameraDataUpdateDTO
 * @Description TODO
 * @Autgor huang
 * @Date 2020-08-19 14:38
 */
@Data
public class CameraDataUpdateDTO {

    /**
     * 所属作业线
     */
    private Integer deviceOrganizationId;

    /**
     * 父级作业线
     */
    private String organizationPathNamePath;

    /**
     * 分组状态
     */
    private Integer groupStatus;

    /**
     * 设备id集合
     */
    private List<Integer> cameraDataIdList;
}
