package com.baosight.entity.alarmpoint;


import com.alibaba.druid.filter.AutoLoad;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.bind.annotation.CrossOrigin;

import javax.persistence.*;
import java.util.Date;

@Table(name = "v_bc_alarm_config")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class AlarmConfig {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY,generator = "Mysql")
    private Integer id;

    @Column(name ="device_id")
    private String deviceId;

    @Column(name = "alarm_id")
    private String alarmId;

    @Column(name = "alarm_time_detail")
    private String alarmTimeDetail;

    @Column(name = "alarm_time_moban")
    private String alarmTimeMoban;


    @Column(name = "alarm_is_open")
    private Integer alarmIsOpen;

    @Column(name = "remark")
    private String remark;

    @Column(name = "remark2")
    private String remark2;

    @Column(name = "remark3")
    private String remark3;

    @Column(name = "createtime")
    private Date createTime;
}
