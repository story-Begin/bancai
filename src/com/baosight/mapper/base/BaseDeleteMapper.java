package com.baosight.mapper.base;


import com.baosight.dto.common.DeleteDTO;

/**
 * @ClassName BaseDeleteMapper
 * @Description TODO
 * @Autgor huang
 * @Date 2020-08-25 13:22
 */
public interface BaseDeleteMapper {

    /**
     * 删除
     *
     * @param reqDTO
     */
    void deleteBatch(DeleteDTO reqDTO);
}
