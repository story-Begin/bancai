package com.baosight.dto.vm.req;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * @ClassName DeviceAccidentReqDTO
 * @Description DOTO
 * @Author xu
 * @Date 2020/9/8 15:22
 */
@Data
public class DeviceAccidentReqDTO implements Serializable {

    private static final long serialVersionUID = -6311936331168812982L;

    private Integer id;

    /**
     * 实例ID
     */
    private String processId;

    /**
     * 发生时间
     */
    private Date happenTime;

    /**
     * 事件名称
     */
    private String eventName;

    /**
     * 预计完成时间
     */
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
    private Date createTime;


}
