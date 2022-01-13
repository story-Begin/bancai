package com.baosight.entity.pz;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;

/**
 * 设备分组关系表
 */
@Data
@Table(name = "v_user_group_device")
public class UserGroupDeviceEntity implements Serializable {

    private static final long serialVersionUID = 546536544169163558L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private String id;

    @Column(name = "fk_user_group_id")
    private String userGroupId;

    @Column(name = "fk_device_id")
    private Integer deviceId;
}
