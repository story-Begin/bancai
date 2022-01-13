package com.baosight.dto.vm.resp;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * @ClassName DeviceAccidentRespDTO
 * @Description TODO
 * @Autgor huang
 * @Date 2020-09-10 16:01
 */
@Data
public class DeviceAccidentRespDTO implements Serializable {
    private static final long serialVersionUID = -5837603340443314869L;

    private Integer id;

    /**
     * 实例ID
     */
    private String processId;

    /**
     * 事件名称
     */
    private String eventName;

    /**
     * 发生时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date happenTime;

    /**
     * 预计完成时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date completionTime;

    /**
     * 设备名称
     */
    private String deviceCode;

    /**
     * 生产线id
     */
    private Integer deviceOrganizationId;

    /**
     * 组织机构路径
     */
    private String organizationPath;

    /**
     * 安装位置
     */
    private String areaAddr;

    /**
     * 图片路径
     */
    private String picUrl;

    /**
     * 被推人工号
     */
    private String accepterJob;

    /**
     * 被推人名称
     */
    private String accepterName;

    /**
     * 发现人工号
     */
    private String finderJob;

    /**
     * 发现人名称
     */
    private String finderName;

    /**
     * 处理状态
     */
    private String status;

    /**
     * 处理报告
     */
    private String disposerRemark;

    /**
     * 现场图片
     */
    private String disposerPicUrl;

    /**
     * 备注
     */
    private String remark;

    /**
     * 创建时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;

}
