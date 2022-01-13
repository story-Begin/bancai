package com.baosight.dto.vm.query;

import com.baosight.base.page.Page;
import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * @ClassName DeviceAccidentQueryDTO
 * @Description TODO
 * @Autgor huang
 * @Date 2020-09-10 15:57
 */
@Data
public class DeviceAccidentQueryDTO extends Page implements Serializable {
    private static final long serialVersionUID = -4618422973275281664L;

    /**
     * 发现人工号
     */
    private String finderJob;

    /**
     * 被推送人工号
     */
    private String accepterJob;

    /**
     * 开始时间
     */
    private String beginTime;

    /**
     * 结束时间
     */
    private String endTime;

    /**
     * 处理状态：0-未处理，1-已处理
     */
    private String status;

    /**
     * 任务id
     */
    private String taskId;

    /**
     * 突发事件的tab index
     */
    private Integer indexStatus;

    /**
     * 组织ID
     */
    private Integer organizationId;

    /**
     * 设备ID集合
     */
    private List<Integer> deviceIdList;

    /**
     * 任务ID
     */
    private List<String> taskList;
}
