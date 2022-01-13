package com.baosight.dto.yw.resp;

import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * @ClassName DeviceDiskRespDTO
 * @Description TODO
 * @Autgor huang
 * @Date 2020-11-17 10:36
 */
@Data
public class DeviceDiskRespDTO implements Serializable {
    private static final long serialVersionUID = 4376822820217823524L;

    private List<DiskDTO> diskDTOList;

    /**
     * 设备名称
     */
    private String deviceName;

    /**
     * 设备类型
     */
    private String deviceType;

    /**
     * 是否在线
     */
    private Integer onlineStatus;

    private String statusTimeStr;

    /**
     * 设备id
     */
    private Integer deviceId;

}
