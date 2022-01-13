package com.baosight.service.data_field;

import com.baosight.dto.data_field.CodeTypeValueRespDTO;

import java.util.List;

/**
 * @ClassName CodeTypeValueService
 * @Description TODO
 * @Autgor huang
 * @Date 2020-08-26 15:00
 */
public interface CodeTypeValueService {

    List<CodeTypeValueRespDTO> findCodeTypeValueList(String itemCode);
}
