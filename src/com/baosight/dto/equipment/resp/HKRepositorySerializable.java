package com.baosight.dto.equipment.resp;

import com.baosight.entity.equipment.HKDeviceEntity;
import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * @ClassName HKRepositorySerializable
 * @Description TODO
 * @Author hph
 * @Date 2020/12/26 10:40 上午
 * @Version 1.0
 */
@Data
public class HKRepositorySerializable implements Serializable {

    private Integer total;

    private Integer pageSize;

    private Integer pageNo;

    private Object list;
}
