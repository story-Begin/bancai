package com.baosight.entity.platform;

import com.baosight.base.entity.BaseEntity;
import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Table;
import java.io.Serializable;

@Data
@Table(name = "v_device_status")
public class VDeviceStatus extends BaseEntity implements Serializable {

    private static final long  serialVersionUID = -22653769143347677L;

    /**
     * 设备型号
     */
    @Column(name = "deviceType")
    private String deviceType;

    /**
     * 设备唯一编码
     */
    @Column(name = "deviceIndexCode")
    private String deviceIndexCode;

    /**
     * 区域编码
     */
    @Column(name = "regionIndexCode")
    private String regionIndexCode;

    /**
     * 采集时间
     */
    @Column(name = "collectTime")
    private java.sql.Timestamp collectTime;

    /**
     * 区域名字
     */
    @Column(name = "regionName")
    private String regionName;

    /**
     * 资源唯一编码
     */
    @Column(name = "indexCode")
    private String indexCode;

    /**
     * 设备名称
     */
    @Column(name = "cn")
    private String cn;

    /**
     * 码流传输协议，0：UDP，1：TCP
     */
    @Column(name = "treatyType")
    private String treatyType;

    /**
     * 厂商，hikvision-海康，dahua-大华
     */
    @Column(name = "manufacturer")
    private String manufacturer;

    /**
     * ip地址，监控点无此值
     */
    @Column(name = "ip")
    private String ip;

    /**
     * 端口，监控点无此值
     */
    @Column(name = "port")
    private Long  port;

    /**
     * 在线状态，0离线，1在线
     */
    @Column(name = "online")
    private Long  online;
}
