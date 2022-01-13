package com.baosight.entity.platform;

import com.baosight.base.entity.BaseEntity;
import com.fasterxml.jackson.annotation.JsonAlias;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Table;
import java.io.Serializable;

@Data
@Table(name = "v_camera_data_dahua")
public class VCameraDataDahua extends BaseEntity implements Serializable {
    private static final long serialVersionUID = -5279607263261946724L;

    /**
     * 通道编号
     */
    @Column(name = "channelId")
    private String channelId;

    /**
     * 通道名称
     */
    @Column(name = "channelName")
    private String channelName;

    /**
     * 设备Id
     */
    @Column(name = "deviceId")
    private String deviceId;

    /**
     * 设备名称
     */
    @Column(name = "deviceName")
    private String deviceName;

    /**
     * 设备IP
     */
    @Column(name = "deviceIp")
    private String deviceIp;

    /**
     * 设备是否在线
     */
    @JsonProperty("isDeviceOnline")
    @JsonAlias("isDeviceOnline")
    @Column(name = "isDeviceonLine")
    private String deviceOnline;

    /**
     * 所属组织编码
     */
    @Column(name = "orgCode")
    private String orgCode;

    /**
     * 所属组织编码
     */
    @Column(name = "sn")
    private String sn;

    /**
     * 设备大类
     */
    @JsonProperty("type")
    @JsonAlias("type")
    @Column(name = "category")
    private Integer category;

    /**
     * 设备类型
     */
    @JsonProperty("category")
    @JsonAlias("category")
    @Column(name = "type")
    private String type;

    /**
     * 单元类型
     */
    @Column(name = "unitType")
    private Integer unitType;

    /**
     * 通道类型
     */
    @Column(name = "channelType")
    private Integer channelType;
}
