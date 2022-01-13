package com.baosight.dto.vm.query;

import com.baosight.base.page.Page;
import lombok.Data;

import java.io.Serializable;

/**
 * 轮询配置
 *
 * @ClassName DevicePollQueryDTO
 * @Description TODO
 * @Autgor huang
 * @Date 2020-07-13 10:22
 */
@Data
public class DevicePollQueryDTO extends Page implements Serializable {
    private static final long serialVersionUID = 6371281636445394661L;

    /**
     * 计划名称
     */
    private String planName;


}
