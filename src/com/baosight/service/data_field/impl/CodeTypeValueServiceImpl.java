package com.baosight.service.data_field.impl;

import com.baosight.dto.data_field.CodeTypeValueRespDTO;
import com.baosight.mapper.data_field.CodeTypeValueMapper;
import com.baosight.service.data_field.CodeTypeValueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 数据字典
 *
 * @ClassName CodeTypeValueServiceImpl
 * @Description TODO
 * @Autgor huang
 * @Date 2020-08-26 15:02
 */
@Service
public class CodeTypeValueServiceImpl implements CodeTypeValueService {

    @Autowired
    private CodeTypeValueMapper codeTypeValueMapper;

    /**
     * 类型代码值
     *
     * @return
     */
    @Override
    public List<CodeTypeValueRespDTO> findCodeTypeValueList(String itemCode) {
        List<CodeTypeValueRespDTO>  codeTypeValueList = codeTypeValueMapper.selectByCodeType(itemCode);
        return codeTypeValueList;
    }
}
