package com.baosight.dto.cx.req;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

/**
 * 报警信息表
 *
 * @ClassName DeviceAlarmReqDTO
 * @Description TODO
 * @Autgor huang
 * @Date 2020-07-13 09:53
 */
@Data
public class DeviceAlarmReqDTO implements Serializable {
    private static final long serialVersionUID = -3512512442828449538L;

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
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date happenTime;

    /**
     * 报警级别
     */
    private String callPoliceGrade;

    /**
     * 备注
     */
    private String flag;


}
