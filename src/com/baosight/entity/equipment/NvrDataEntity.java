package com.baosight.entity.equipment;

import com.baosight.base.entity.BaseEntity;
import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Table;
import java.io.Serializable;

/**
 * 录像机表
 *
 * @ClassName NvrDataEntity
 * @Description TODO
 * @Author xu
 * @Date 2020/7/14 15:59
 */
@Data
@Table(name = "v_nvr_data")
public class NvrDataEntity extends BaseEntity implements Serializable {
    private static final long serialVersionUID = 9034818607027423337L;

    /**
     * 录像机编号
     */
    @Column(name = "fk_nvr_bh")
    private Integer nvrBh;

    /**
     * 录像机名称
     */
    @Column(name = "nvr_name")
    private String nvrName;

    /**
     * 录像机型号
     */
    @Column(name = "nvr_model")
    private String nvrModel;

    /**
     * 所属厂区
     */
    @Column(name = "nvr_area")
    private String nvrArea;

    /**
     * 所属作业线
     */
    @Column(name = "fk_device_organization_id")
    private Integer deviceOrganizationId;

    /**
     * 安装位置
     */
    @Column(name = "nvr_addr")
    private String nvrAddr;

    /**
     * 所挂IPC数量
     */
    @Column(name = "ip_cnum")
    private Integer ipCnum;

    /**
     * IP地址
     */
    @Column(name = "nvr_ip")
    private String nvrIp;

    /**
     * 端口
     */
    @Column(name = "nvr_port")
    private String nvrPort;

    /**
     * 通道口
     */
    @Column(name = "channel_number")
    private Integer channelNumber;

    /**
     * 通道口名称
     */
    @Column(name = "channel_name")
    private String channelName;

    /**
     * 用户名
     */
    @Column(name = "user")
    private String user;

    /**
     * 密码
     */
    @Column(name = "pwd")
    private String pwd;

    /**
     * 状态
     */
    @Column(name = "status")
    private Integer status;

}
