package com.baosight.dto.cx.query;

import lombok.Data;

import java.util.Date;

@Data
public class DeviceHisAlarmDataQueryDTO {
//    {
//        "pageSize":1,
//            "pageNo":1,
//            "startDate":"2019-10-11 10:31:17",
//            "endDate":"2019-10-23 15:03:01",
//            "orgIds":"1,7"
//    }
    /**
     * 获取每页显示数据条数
     */
    private Integer pageSize;
    /**
     * 页码
     */
    private Integer pageNo;
    /**
     * 开始日期
     */
    private Date startDate;
    /**
     * 截止日期
     */
    private Date endDate;
    /**
     * 版本号
     */
    private String orgIds;

}
