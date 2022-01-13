package com.baosight.entity.cx;

import com.baosight.base.entity.BaseEntity;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;
import tk.mybatis.mapper.entity.IDynamicTableName;

import javax.persistence.Column;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;

/**
 * 报警信息表
 *
 * @ClassName DeviceAlarmEntity
 * @Description TODO
 * @Autgor huang
 * @Date 2020-07-13 09:23
 */
@Data
@Table(name = "v_device_alarm")
public class DeviceAlarmEntity extends BaseEntity implements IDynamicTableName, Serializable {

    private static final long serialVersionUID = 2503447492878888248L;
    /**
     * 设备编号
     */
    @Column(name = "equipment_num")
    private String equipmentNum;

    /**
     * 设备名称
     */
    @Column(name = "equipment_name")
    private String equipmentName;

    /**
     * 报警类型
     */
    @Column(name = "call_police_type")
    private String callPoliceType;

    /**
     * 发生时间
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Column(name = "happen_time")
    private Date happenTime;

    /**
     * 报警级别
     */
    @Column(name = "call_police_grade")
    private String callPoliceGrade;
    /**
     * 通道名称
     */
    @Column(name = "port_name")
    private String portName;
    /**
     * 通道号
     */
    @Column(name = "port_code")
    private Integer portCode;

    /**
     * 处理状态
     */
    @Column(name = "status")
    private String status;

    /**
     * 报警类型名称
     */
    @Column(insertable = false, updatable = false)
    private String callPoliceTypeName;

    @Column(name = "flag")
    private String flag;


    /**
     * 报警内容
     */
    @Column(name = "alarm_msg")
    private String alarmMsg;

    /**
     * 报警级别名称
     */
    @Column(insertable = false, updatable = false)
    private String callPoliceGradeName;

    @Override
    public String getDynamicTableName() {
        return "v_device_alarm";
    }
}
