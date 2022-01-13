package com.baosight.base.baseService;

/**
 * @ClassName BaseService
 * @Description TODO
 * @Autgor huang
 * @Date 2020-07-12 11:27
 */
public interface BaseService<T> extends CommonService {

    /**
     * 新增
     *
     * @param record
     * @return
     */
    boolean save(T record);

    /**
     * 修改
     *
     * @param record
     * @return
     */
    boolean update(T record);
}
