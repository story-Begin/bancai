package com.baosight.dto.equipment.resp;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 录像机
 *
 * @ClassName NvrDataRespDTO
 * @Description DOTO
 * @Author xu
 * @Date 2020/7/14 16:27
 */
@Data
public class NvrDataRespDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * id
     */
    private Integer id;

    /**
     * 创建时间
     */
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone="GMT+8")
    private Date createTime;

    /**
     * 录像机编号
     */
    private Integer nvrBh;

    /**
     * 录像机名称
     */
    private String nvrName;

    /**
     * 录像机型号
     */
    private String nvrModel;

    /**
     * 所属厂区
     */
    private String nvrArea;

    /**
     * 所属作业线
     */
    private Integer deviceOrganizationId;

    /**
     * 安装位置
     */
    private String nvrAddr;

    /**
     * 所挂IPC数量
     */
    private Integer ipCnum;

    /**
     * IP地址
     */
    private String nvrIp;

    /**
     * 端口
     */
    private String nvrPort;

    /**
     * 通道口
     */
    private Integer channelNumber;

    /**
     * 通道口名称
     */
    private String channelName;

    /**
     * 用户名
     */
    private String user;

    /**
     * 密码
     */
    private String pwd;

    /**
     * 状态
     */
    private Integer status;

    /**
     * 备注
     */
    private String remark;

}
