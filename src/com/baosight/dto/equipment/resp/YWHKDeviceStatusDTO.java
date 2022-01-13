package com.baosight.dto.equipment.resp;

import lombok.Data;

import java.io.Serializable;

/**
 * @ClassName YWHKDeviceStatusDTO
 * @Description TODO
 * @Author hph
 * @Date 2020/12/28 4:52 下午
 * @Version 1.0
 */
@Data
public class YWHKDeviceStatusDTO implements Serializable {

    /**
     * 监控点唯一标识
     */
    private String indexCode;

    /**
     * 是否在线
     */
    private Integer online;
}
