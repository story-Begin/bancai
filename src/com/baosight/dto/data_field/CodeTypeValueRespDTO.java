package com.baosight.dto.data_field;

import lombok.Data;

import java.io.Serializable;

/**
 * 代码类型
 *
 * @ClassName CodeTypeValueRespDTO
 * @Description TODO
 * @Autgor huang
 * @Date 2020-08-26 14:49
 */
@Data
public class CodeTypeValueRespDTO implements Serializable {
    private static final long serialVersionUID = 8184296222877184007L;

    /**
     * 代码分类编号
     */
    private String codeSetCode;

    /**
     * 值代码
     */
    private String itemCode;

    /**
     * 代码类别值名称
     */
    private String itemName;
}
