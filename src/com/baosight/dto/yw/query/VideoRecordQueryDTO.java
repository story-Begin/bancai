package com.baosight.dto.yw.query;

import lombok.Data;

/**
 * 录像信息查询DTO
 *
 * @ClassName VideoRecordQueryDTO
 * @Description TODO
 * @Autgor huang
 * @Date 2020-11-17 09:26
 */
@Data
public class VideoRecordQueryDTO {

    private Integer pageSize = 20;

    private Integer pageNo = 1;

    /**
     * 日期
     */
    private String recordDate;

}
