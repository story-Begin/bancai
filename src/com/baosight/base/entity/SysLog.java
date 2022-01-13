package com.baosight.base.entity;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * 日志
 *
 * @ClassName SysLog
 * @Description TODO
 * @Autgor huang
 * @Date 2020-08-25 16:07
 */
@Table(name = "sys_log")
@Data
public class SysLog implements Serializable {

    private static final long serialVersionUID = -5376594046775831018L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private String id;

    /**
     * 描述
     */
    @Column(name = "description")
    private String description;

    /**
     * 日志类型
     */
    @Column(name = "log_type")
    private Long logType;

    /**
     * 请求IP地址
     */
    @Column(name = "request_ip")
    private String requestIp;

    /**
     * 方法名称
     */
    @Column(name = "method")
    private String method;

    /**
     * 请求参数
     */
    @Column(name = "params")
    private String params;

    /**
     * 异常代码
     */
    @Column(name = "exception_code")
    private String exceptionCode;

    /**
     * 异常信息
     */
    @Column(name = "exception_detail")
    private String exceptionDetail;

    /**
     * 创建用户
     */
    @Column(name = "create_user")
    private String createUser;

    /**
     * 创建时间
     */
    @Column(name = "create_date")
    private Date createDate;

}
