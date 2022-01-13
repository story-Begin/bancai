package com.baosight.base.enumeration;

/**
 * 突发事件状态
 *
 * @ClassName DeviceAccidentStatus
 * @Description TODO
 * @Autgor huang
 * @Date 2020-09-12 14:24
 */
public interface DeviceAccidentStatus {

    /**
     * 未处理
     */
    String UNTREATED = "0";

    /**
     * 已处理
     */
    String PROCESSED = "1";

    /**
     * 用于展示判断本人发现事件
     */
    Integer TAB_INDEX = 1;
}
