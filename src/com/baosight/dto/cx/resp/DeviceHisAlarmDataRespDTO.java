package com.baosight.dto.cx.resp;


import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

@Data
public class DeviceHisAlarmDataRespDTO {

    /**
     * 设备历史报警源id
     */
    private Integer alarmHisRecordId;
    /**
     * 记录时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH-mm-ss")
    private Date logTime;
    /**
     * 设备编码
     */
    private String deviceCode;
    /**
     * 报警源名字
     */
    private String alarmSourceName;
    /**
     * 组织名称
     */
    private String orgName;
    /**
     * 报警源编码
     */
    private String alarmSourceCode;
    /**
     * 报警源标识
     */
    private String alarmSourceIndex;
    /**
     * 报警源id
     */
    private Integer alarmSourceId;
    /**
     * 未知
     */
    private Integer num;
    /**
     * 报警描述
     */
    private String alarmMsg;
    /**
     * 报警等级
     */
    private Integer alarmLevel;
    /**
     * 报警类型
     */
    private Integer alarmType;
    /**
     * 报警设备id
     */
    private Integer deviceId;
}
