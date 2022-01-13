package com.baosight.base.baseService;

/**
 * @ClassName BaseServiceResult
 * @Description TODO
 * @Autgor huang
 * @Date 2020-05-12 22:33
 * T: 传参
 * E：实体类
 */
public interface BaseServiceResult<T, E> extends CommonService {

    /**
     * 新增
     *
     * @param record
     * @return
     */
    E save(T record);

    /**
     * 修改
     *
     * @param record
     * @return
     */
    void update(T record);

}
