package com.baosight.dto.yw.resp;

import lombok.Data;

import java.io.Serializable;

/**
 * 录像详情
 *
 * @ClassName DailyDetailsDTO
 * @Description TODO
 * @Autgor huang
 * @Date 2020-11-17 10:02
 */
@Data
public class DailyDetailsDTO implements Serializable {
    private static final long serialVersionUID = -5516810278555229348L;

    private Integer hoursIndex;

    private Integer recordStatus;

    private Integer recordTime;

    private String percent;
}
