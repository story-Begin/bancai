package com.baosight.dto.gismap.req;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;
import java.io.Serializable;
import java.util.Date;

@Data
public class DeviceLocationCameraReqDTO implements Serializable {


    private static final long serialVersionUID = -8367341355663869976L;

    /**
     * 设备id 唯一标识
     */
    private Integer deviceId;

    /**
     * 设备编码标识
      */

    private String deviceCode;
    /**
     * 设备名称
     */
    private String deviceName;
    /**
     * 设备安装位置
     */
    private String deviceAddr;
    /**
     * 设备ip
     */
    private String deviceIp;
    /**
     * 设备端口号
     */
    private String port;

    /**
     * 设备视频编码
     */
    private String deviceVedioCode;
    /**
     * 设备所在经度
     */
    private String longitude;
    /**
     * 设备所在纬度
     */
    private String latitude;

    /**
     * 摄像机状态
     */
    private Integer deviceStatus;
    /**
     * 创建时间
     */
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    private Integer deviceType;
}
