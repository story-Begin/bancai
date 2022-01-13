package com.baosight.entity.gismap;


import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;

@Data
@Table(name = "v_device_location")
public class DeviceLocationEntity implements Serializable {
    private static final long serialVersionUID = 4967481323529707678L;
    /**
     * 设备id
     */
    @Column(name = "device_id")
    private  Integer deviceId;

    /**
     * 设备类型
     */
    @Column(name = "device_type")
    private  Integer deviceType;

    /**
     * 设备所属产线
     */
    @Column(name= "line_area")
    private String lineArea;

    /**
     * 设备所在经度
     */
    @Column(name= "longitude")
    private String longitude;
    /**
     * 设备纬度
     */
    @Column(name="latitude")
    private String latitude;

    /**
     * 创建时间
     */
    @Column(name="create_time")
    private Date createTime;
}
