package com.baosight.dto.yw.query;

import lombok.Data;

import java.io.Serializable;

/**
 * @ClassName DeviceStatusQueryDTO
 * @Description TODO
 * @Autgor huang
 * @Date 2020-11-17 10:59
 */
@Data
public class DeviceStatusQueryDTO implements Serializable {
    private static final long serialVersionUID = -4219102880607710020L;

    private Integer pageSize = 20;

    private Integer pageNo = 1;

    /**
     * 设备主类型：-1:查全部
     */
    private Integer neType = 1;

    /**
     * 设备类型：-1:查全部
     */
    private Integer devType = 1;

//    /**
//     * 组织id：传空或者不传这个参数为全查询
//     */
//    private String orgIds;
}
