package com.baosight.entity.cx;

import lombok.Data;

import java.util.Date;

@Data
public class RemoteDeviceAlarmEntity {

    /**
     * 设配名称
     */
    private String deviceName;
    /**
     * 报警类型
     */
    private Integer alarmType;
    /**
     * 报警日期
     */
    private Date alarmDateString;
    /**
     * 报警等级
     */
    private String alarmGrade;
    /**
     * 通道名称
     */
    private String channelName;
    /**
     *处理状态
     */
    private Integer handleStat;
}
