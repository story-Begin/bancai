package com.baosight.dto.yw.query;

import lombok.Data;

import java.io.Serializable;

/**
 * @ClassName DeviceDiskQueryDTO
 * @Description TODO
 * @Autgor huang
 * @Date 2020-11-17 10:38
 */
@Data
public class DeviceDiskQueryDTO implements Serializable {
    private static final long serialVersionUID = 4802877534711969128L;

    private Integer pageSize = 20;

    private Integer pageNo = 1;

    private Integer neType = -1;

    private Integer devType = -1;

}
