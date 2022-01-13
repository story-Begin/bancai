package com.baosight.dto.cx.resp;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import java.util.Date;

@Data
public class DeviceRealTimeAlarmDataQespDTO {
    /**
     *  该报警对应的历史报警
     */
    private Integer alarmHisRecordId;
    /**
     * 记录时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH-mm-ss")
    private Date logTime;
    /**
     *
     */
    private String deviceCode;
    /**
     * 告警源名称
     */
    private String alarmSourceName;
    /**
     * 报警id
     */
    private Integer id;
    /**
     * //告警源网元编码
     */
    private String alarmSourceCode;
    /**
     * 告警源网元编码
     */
    private String alarmSourceIndex;
    /**
     *  告警源的ID
     */
    private Integer alarmSourceId;
    /**
     * //告警内容
     */
    private String alarmMsg;
    /**
     * 报警等级
     */
    private Integer alarmLevel;
    /**
     *未知
     */
    private Integer read;
    /**
     * 报警类型
     */
    private Integer alarmType;
    /**
     * 设备id
     */
    private Integer deviceId;

    /**
     * 报警标识
     */
    private String flag;

}
