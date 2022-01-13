package com.baosight.mapper.data_field;

import com.baosight.base.baseMapper.BaseMapper;
import com.baosight.dto.data_field.CodeTypeValueRespDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @ClassName CodeTypeValueMapper
 * @Description TODO
 * @Autgor huang
 * @Date 2020-08-26 14:59
 */
@Mapper
public interface CodeTypeValueMapper extends BaseMapper<CodeTypeValueRespDTO> {

    /**
     * 代码值获取
     *
     * @param itemCode
     * @return
     */
    List<CodeTypeValueRespDTO> selectByCodeType(@Param(value = "itemCode") String itemCode);

    /**
     * 代码值集合获取
     *
     * @param itemCodeList
     * @return
     */
    List<CodeTypeValueRespDTO> selectByCodeTypeList(@Param(value = "itemCodeList") List<String> itemCodeList);
}
