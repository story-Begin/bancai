package com.baosight.base.aspect;

import java.lang.annotation.*;

/**
 * @ClassName AspectTime
 * @Description TODO
 * @Autgor huang
 * @Date 2020-07-30 10:57
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface AspectTime {
    /**
     * 操作
     */
    String operation() default "";
}

