package com.baosight.entity.vm;

import lombok.Data;
import tk.mybatis.mapper.entity.IDynamicTableName;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * @ClassName DeviceAccidentEntity
 * @Description DOTO
 * @Author xu
 * @Date 2020/9/8 15:05
 */
@Data
@Table(name = "v_device_accident")
public class DeviceAccidentEntity implements IDynamicTableName, Serializable {
    private static final long serialVersionUID = -5886390666909273630L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    /**
     * 实例ID
     */
    @Column(name = "process_id")
    private String processId;

    /**
     * 事件名称
     */
    @Column(name = "event_name")
    private String eventName;

    /**
     * 发生时间
     */
    @Column(name = "happen_time")
    private Date happenTime;

    /**
     * 预计完成时间
     */
    @Column(name = "completion_time")
    private Date completionTime;

    /**
     * 设备编号
     */
    @Column(name = "device_code")
    private String deviceCode;

    /**
     * 生产线id
     */
    @Column(name = "fk_device_organization_id")
    private Integer deviceOrganizationId;

    /**
     * 组织机构路径
     */
    @Column(name = "organization_path")
    private String organizationPath;

    /**
     * 安装位置
     */
    @Column(name = "area_addr")
    private String areaAddr;

    /**
     * 图片路径
     */
    @Column(name = "pic_url")
    private String picUrl;

    /**
     * 被推人工号
     */
    @Column(name = "accepter_job")
    private String accepterJob;

    /**
     * 被推人名称
     */
    @Column(name = "accepter_name")
    private String accepterName;

    /**
     * 发现人工号
     */
    @Column(name = "finder_job")
    private String finderJob;

    /**
     * 发现人名称
     */
    @Column(name = "finder_name")
    private String finderName;

    /**
     * 处理报告
     */
    @Column(name = "disposer_remark")
    private String disposerRemark;

    /**
     * 现场图片
     */
    @Column(name = "disposer_pic_url")
    private String disposerPicUrl;

    /**
     * 处理状态：0-未处理，1-已处理
     */
    @Column(name = "status")
    private String status;

    /**
     * 备注
     */
    @Column(name = "remark")
    private String remark;

    /**
     * 备注
     */
    @Column(name = "remark2")
    private String remark2;

    /**
     * 备注
     */
    @Column(name = "remark3")
    private String remark3;

    /**
     * 创建时间
     */
    @Column(name = "create_time")
    private Date createTime;

    @Override
    public String getDynamicTableName() {
        return "v_device_accident";
    }
}
