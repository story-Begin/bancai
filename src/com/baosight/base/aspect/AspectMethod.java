package com.baosight.base.aspect;

import com.baosight.iplat4j.core.log.Logger;
import com.baosight.iplat4j.core.log.LoggerFactory;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.beans.BeanWrapper;
import org.springframework.beans.BeanWrapperImpl;
import org.springframework.stereotype.Component;

import java.lang.reflect.Method;
import java.util.Date;

/**
 * @ClassName AspectTime
 * @Description TODO
 * @Autgor huang
 * @Date 2020-07-30 13:37
 */
@Aspect
@Component
public class AspectMethod {
    private static final String CREATE_TIME = "createTime";
    private static final String UPDATED_TIME = "updateTime";
    // TODO 带后期拓展字段
    private static final String CREATEDPERSON = "CREATEDPERSON";
    private static final String UPDATEDPERSON = "UPDATEDPERSON";
    private static final String ISDELETE = "ISDELETE";

    private static final Logger logger = LoggerFactory.getLogger(AspectMethod.class);

    @Pointcut("@annotation(com.baosight.base.aspect.AspectTime)")
    public void operationPointCut() {
    }

    @Before("operationPointCut()")
    public void around(JoinPoint point) {
        MethodSignature signature = (MethodSignature) point.getSignature();
        Method method = signature.getMethod();
        AspectTime dal = method.getAnnotation(AspectTime.class);
        if ("create".equals(dal.operation())) {
            beforeInsert(point);
        } else {
            beforeUpdate(point);
        }
    }

    public void beforeInsert(JoinPoint point) {
        Object[] args = point.getArgs();
        if (args != null && args.length > 0) {
            Object argument = args[0];
            BeanWrapper beanWrapper = new BeanWrapperImpl(argument);
            // 设置创建时间
            if (beanWrapper.isWritableProperty(CREATE_TIME)) {
                beanWrapper.setPropertyValue(CREATE_TIME, new Date());
            }
            logger.info("After insert = {}",
                    ToStringBuilder.reflectionToString(argument, ToStringStyle.SHORT_PREFIX_STYLE));
        }
    }

    public void beforeUpdate(JoinPoint point) {
        Object[] args = point.getArgs();
        if (args != null && args.length > 0) {
            Object argument = args[0];
            BeanWrapper beanWrapper = new BeanWrapperImpl(argument);
            // 设置修改时间
            if (beanWrapper.isWritableProperty(UPDATED_TIME)) {
                beanWrapper.setPropertyValue(UPDATED_TIME, new Date());
            }
            logger.info("After update = {}",
                    ToStringBuilder.reflectionToString(argument, ToStringStyle.SHORT_PREFIX_STYLE));
        }
    }
}
