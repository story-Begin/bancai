package com.baosight.entity.alarmpoint;

import com.alibaba.druid.filter.AutoLoad;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "v_bc_alarm_info")
public class AlarmInfo{

    @Column(name = "alarm_id")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY,generator = "Mysql")
    private Integer alarmId;

    @Column(name = "alarm_source")
    private String alarmSource;

    @Column(name = "alarm_type")
    private String alarmType;

    @Column(name = "create_time")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date createTime;

    @Column(name = "remark")
    private String remark;
}
