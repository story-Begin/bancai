package com.baosight.dto.yw.resp;

import lombok.Data;

import java.io.Serializable;

/**
 * @ClassName DiskDTO
 * @Description TODO
 * @Autgor huang
 * @Date 2020-11-17 10:48
 */
@Data
public class DiskDTO implements Serializable {
    private static final long serialVersionUID = 2791168873457704079L;

    private Integer id;

    /**
     * 故障时间
     */
    private String diskStatusTimeStr;

    /**
     * 故障状态
     */
    private String diskStatus;

    /**
     * 硬盘序号
     */
    private String diskIndex;

    /**
     * 银盘容量
     */
    private String diskCapacity;

    /**
     * 剩余容量
     */
    private String diskRemain;
}
