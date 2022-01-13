package com.baosight.dto.gismap.query;


import lombok.Data;

import java.io.Serializable;

@Data
public class DeviceLocationQueryDTO implements Serializable {
    private static final long serialVersionUID = 6918059146493765571L;

    /**
     * 设备id
     */
    private Integer deviceId;

    /**
     * 设备类型
     */
    private Integer deviceType;

    /**
     * 所属厂区
     */
    private Integer areaType;
}
