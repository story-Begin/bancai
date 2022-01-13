package com.baosight.dto.log.query;

import com.baosight.base.page.PageVo;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

@Data
public class SysLogQueryDTO extends PageVo<SysLogQueryDTO> implements Serializable {
    private static final long serialVersionUID = -2635762696775831018L;

    private String id;

    /**
     * 描述
     */
    private String description;

    /**
     * 日志类型
     */
    private Long logType;

    /**
     * 请求IP地址
     */
    private String requestIp;

    /**
     * 方法名称
     */
    private String method;

    /**
     * 请求参数
     */
    private String params;

    /**
     * 异常代码
     */
    private String exceptionCode;

    /**
     * 异常信息
     */
    private String exceptionDetail;

    /**
     * 创建用户
     */
    private String createUser;

    /**
     * 创建时间
     */
    private Date createDate;

    private Date createEndTime;

    private Date createStartTime;
}
