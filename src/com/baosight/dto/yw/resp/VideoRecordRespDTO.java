package com.baosight.dto.yw.resp;

import lombok.Data;

import java.io.Serializable;

/**
 * 录像信息
 *
 * @ClassName VideoRecordRespDTO
 * @Description TODO
 * @Autgor huang
 * @Date 2020-11-17 09:23
 */
@Data
public class VideoRecordRespDTO implements Serializable {
    private static final long serialVersionUID = 1491323632776980320L;

    private Integer id;

    /**
     * 录像保存天数
     */
    private String recordIntervalTime;

    /**
     * 最早录像时间
     */
    private String displayedEarlestRecordTime;

    /**
     * 通道名称
     */
    private String channelName;

    /**
     * 设备名称
     */
    private String deviceName;

    /**
     *
     */
    private Integer deviceIndex;

    /**
     *
     */
    private Integer channelIndex;

    /**
     * 所属设备编号
     */
    private Integer deviceId;

    /**
     * 录像详情
     */
    private DailyDetailsDTO dailyDetails;

    /**
     * 是否正在录像（0:正在录像，1：未在录像）
     */
    private Integer recordingStatus;
}
