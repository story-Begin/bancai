package com.baosight.dto.cx.query;


import lombok.Data;

@Data
public class DeviceRealTimeAlarmDataQueryDTO {


    /**
     * 每页显示数量
     */
    private Integer pageSize;

    /**
     * 当前页码
     */
    private Integer pageNo;

    /**
     * 版本号
     */
    private String orgIds;

}
