package com.baosight.dto.equipment.resp;

import lombok.Data;

import java.io.Serializable;

/**
 * 统计设备数量
 */
@Data
public class CameraDataCountRespDTO implements Serializable {
    private static final long serialVersionUID = 9220272792554112142L;

    /**
     * 在线数量
     */
    private Integer onLine = 0;

    /**
     * 总设备数量
     */
    private Integer sumOnLine = 0;

}
