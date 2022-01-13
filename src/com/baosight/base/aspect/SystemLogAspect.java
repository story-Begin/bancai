package com.baosight.base.aspect;

import com.alibaba.fastjson.JSON;
import com.baosight.base.entity.SysLog;
import com.baosight.base.utils.JsonUtil;
import com.baosight.iplat4j.core.web.threadlocal.UserSession;
import com.baosight.mapper.log.SysLogMapper;
import lombok.Data;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.lang.reflect.Method;
import java.util.Date;
import java.util.UUID;

/**
 * @ClassName AspectTime
 * @Description TODO
 * @Autgor huang
 * @Date 2020-08-25 16:37
 */
@Aspect
@Component
public class SystemLogAspect {

    @Resource
    private SysLogMapper systemLogService;

    private static final Logger logger = LoggerFactory.getLogger(SystemLogAspect.class);

    @Pointcut("@annotation(com.baosight.base.aspect.Log)")
    public void controllerAspect() {
    }

    /**
     * 后置通知
     *
     * @param joinPoint
     */
    @After("controllerAspect()")
    public void after(JoinPoint joinPoint) {
        try {
            Object[] args = joinPoint.getArgs();
            String params = JSON.toJSONString(args);
            OperationDetail operationDetail = getOperationType(joinPoint);
            System.out.println("=====controller后置通知开始=====");
            System.out.println("请求方法:" + (joinPoint.getTarget().getClass().getName() + "."
                    + joinPoint.getSignature().getName() + "()") + "." + operationDetail.getOperationType());
            System.out.println("方法参数:" + params);
            System.out.println("方法描述:" + operationDetail.getOperationName());
            System.out.println("请求人:" + UserSession.getLoginCName());
            SysLog log = new SysLog();
            log.setId(UUID.randomUUID().toString().replace("-", ""));
            log.setDescription(operationDetail.getOperationName());
            log.setMethod((joinPoint.getTarget().getClass().getName() + "." + joinPoint.getSignature().getName()
                    + "()") + "." + operationDetail.getOperationType());
            log.setLogType((long) 0);
            log.setExceptionCode(null);
            log.setExceptionDetail(operationDetail.getOperationType());
            log.setParams(params);
            log.setRequestIp(UserSession.getIpaddress());
            log.setCreateUser(UserSession.getLoginCName());
            log.setCreateDate(new Date());
            systemLogService.insert(log);
            System.out.println("=====controller后置通知结束=====");
        } catch (Exception e) {
            logger.error("==后置通知异常==");
            logger.error("异常信息:{}", e.getMessage());
        }
    }

    @Data
    static class OperationDetail {
        String operationType;
        String operationName;
    }

    /**
     * 注释详情
     *
     * @param joinPoint
     * @return
     * @throws Exception
     */
    public static OperationDetail getOperationType(JoinPoint joinPoint) throws Exception {
        String targetName = joinPoint.getTarget().getClass().getName();
        String methodName = joinPoint.getSignature().getName();
        Class targetClass = Class.forName(targetName);
        Method[] methods = targetClass.getMethods();
        Object[] args = joinPoint.getArgs();
        OperationDetail operationDetail = new OperationDetail();
        for (Method method : methods) {
            if (method.getName().equals(methodName)) {
                Class[] clazzs = method.getParameterTypes();
                if (clazzs.length == args.length) {
                    operationDetail.setOperationName(method.getAnnotation(Log.class).operationName());
                    operationDetail.setOperationType(method.getAnnotation(Log.class).operationType());
                    break;
                }
            }
        }
        return operationDetail;
    }

    /**
     * 异常通知 用于拦截记录异常日志
     *
     * @param joinPoint
     * @param e
     */
    @AfterThrowing(pointcut = "controllerAspect()", throwing = "e")
    public void doAfterThrowing(JoinPoint joinPoint, Throwable e) {
        String params = param(joinPoint);
        try {
            OperationDetail operationDetail = getOperationType(joinPoint);
            System.out.println("=====异常通知开始=====");
            System.out.println("异常代码:" + e.getClass().getName());
            System.out.println("异常信息:" + e.getMessage());
            System.out.println("异常方法:" + (joinPoint.getTarget().getClass().getName() + "."
                    + joinPoint.getSignature().getName() + "()") + "." + operationDetail.getOperationType());
            System.out.println("方法描述:" + operationDetail.getOperationName());
            System.out.println("请求人:" + UserSession.getLoginCName());
            System.out.println("请求参数:" + params);
            SysLog log = new SysLog();
            log.setId(UUID.randomUUID().toString());
            log.setDescription(operationDetail.getOperationName());
            log.setExceptionCode(e.getClass().getName());
            log.setLogType((long) 1);
            log.setExceptionDetail(e.getMessage());
            log.setMethod((joinPoint.getTarget().getClass().getName() + "." + joinPoint.getSignature().getName() + "()"));
            log.setParams(params);
            log.setRequestIp(UserSession.getIpaddress());
            log.setCreateUser(UserSession.getLoginCName());
            log.setCreateDate(new Date());
            systemLogService.insert(log);
            System.out.println("=====异常通知结束=====");
        } catch (Exception ex) {
            logger.error("==异常通知异常==");
            logger.error("异常信息:{}", ex.getMessage());
        }
        // 记录本地异常日志
        logger.error("异常方法:{}异常代码:{}异常信息:{}参数:{}", joinPoint.getTarget().getClass().getName()
                + joinPoint.getSignature().getName(), e.getClass().getName(), e.getMessage(), params);
    }

    public static String param(JoinPoint joinPoint) {
        String params = "";
        if (joinPoint.getArgs() != null && joinPoint.getArgs().length > 0) {
            for (int i = 0; i < joinPoint.getArgs().length; i++) {
                params += JsonUtil.getJsonStr(joinPoint.getArgs()[i]) + ";";
            }
        }
        return params;
    }

}
