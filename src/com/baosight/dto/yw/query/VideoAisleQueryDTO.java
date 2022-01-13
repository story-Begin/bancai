package com.baosight.dto.yw.query;

import lombok.Data;

import java.io.Serializable;

/**
 * 获取视频通道状态DTO
 *
 * @ClassName VideoAisleQueryDTO
 * @Description TODO
 * @Autgor huang
 * @Date 2020-11-16 17:02
 */
@Data
public class VideoAisleQueryDTO implements Serializable {
    private static final long serialVersionUID = -628075223500827136L;

    private Integer pageSize = 20;

    private Integer pageNo = 1;
}
