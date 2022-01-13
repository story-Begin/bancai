package com.baosight.dto.cx.resp;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 报警信息表
 *
 * @ClassName DeviceAlarmRespDTO
 * @Description TODO
 * @Autgor huang
 * @Date 2020-07-13 09:56
 */
@Data
public class DeviceAlarmRespDTO implements Serializable {
    private static final long serialVersionUID = 5495216763669439124L;

    private Integer id;

    /**
     * 设备编号
     */
    private String equipmentNum;

    /**
     * 设备名称
     */
    private String equipmentName;

    /**
     * 报警类型
     */
    private String callPoliceType;

    /**
     * 发生时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date happenTime;

    /**
     * 报警级别
     */
    private String callPoliceGrade;

    /**
     * 备注
     */

    private String remark;

    /**
     * 创建时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;

    /**
     * 通道名称
     */
    private String portName;
    /**
     * 通道号
     */
    private Integer portCode;
    /**
     * 处理状态
     */
    private String status;

    /**
     * 报警类型名称
     */
    private String callPoliceTypeName;

    /**
     * 报警级别名称
     */
    private String callPoliceGradeName;

    /**
     * 报警内容
     */
    private String alarmMsg;
}
