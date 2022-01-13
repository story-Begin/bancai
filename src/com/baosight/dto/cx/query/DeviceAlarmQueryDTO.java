package com.baosight.dto.cx.query;

import com.baosight.base.page.Page;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 报警信息表
 *
 * @ClassName DeviceAlarmQueryDTO
 * @Description TODO
 * @Autgor huang
 * @Date 2020-07-13 09:40
 */
@Data
public class DeviceAlarmQueryDTO extends Page implements Serializable {
    private static final long serialVersionUID = 453137048175020240L;

    /**
     * 设备名称
     */
    private String equipmentName;

    /**
     * 报警类型
     */
    private Integer callPoliceType;

    /**
     * 开始时间
     */
    private Date startTime;

    /**
     * 结束时间
     */
    private Date endTime;


}
