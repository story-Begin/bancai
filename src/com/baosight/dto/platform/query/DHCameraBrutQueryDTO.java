package com.baosight.dto.platform.query;

import com.baosight.base.page.Page;
import lombok.Data;

import javax.persistence.Column;
import java.io.Serializable;
import java.util.Date;

@Data
public class DHCameraBrutQueryDTO extends Page implements Serializable {
    private static final Long serialVersionUID = 2960461839287503185L;

    /**
     * id
     */
    private Integer id;

    /**
     * 监控点创建时间（IOS8601格式yyyy-MM-dd’T’HH:mm:ss.SSSzzz）
     */
    private Date createTime;

    /**
     * 监控点编号
     */
    private String cameraIndexCode;

    /**
     * 监控点国标编号
     */
    private String gbIndexCode;

    /**
     * 监控点名称
     */
    private String name;

    /**
     * 所属设备编号
     */
    private String deviceIndexCode;

    /**
     * 经度
     */
    private String longitude;

    /**
     * 纬度
     */
    private String latitude;

    /**
     * 海拔高度
     */
    private String altitude;

    /**
     * 摄像机像素（1-普通像素，2-130万高清，3-200万高清，4-300万高清，取值参考【数据字典】，typeCode为xresmgr.piexl）
     */
    private Long pixel;

    /**
     * 监控点类型（0-枪机,1-半球,2-快球,3-带云台枪机,取值参考【数据字典】，typeCode为xresmgr.camera_type）
     */
    private Long cameraType;

    /**
     * 监控点类型说明
     */
    private String cameraTypeName;

    /**
     * 安装位置
     */
    private String installPlace;

    /**
     * 矩阵编号
     */
    private String matrixCode;

    /**
     * 通道号
     */
    private Long chanNum;

    /**
     * 可视域相关（JSON格式）
     */
    private String viewshed;

    /**
     * 能力集（详见【数据字典】，typeCode为xresmgr.capability_set）
     */
    private String capabilitySet;

    /**
     * 能力集说明
     */
    private String capabilitySetName;

    /**
     * 智能分析能力集（详见【数据字典】，typeCode为xresmgr.intelligent_set）
     */
    private String intelligentSet;

    /**
     * 智能分析能力集说明
     */
    private String intelligentSetName;

    /**
     * 录像存储位置（0-中心存储，1-设备存储，取值参考【数据字典】，typeCode为xresmgr.record_location）
     */
    private String recordLocation;

    /**
     * 录像存储位置说明
     */
    private String recordLocationName;

    /**
     * 云镜类型（1-全方位云台（带转动和变焦），2-只有变焦,不带转动，3-只有转动，不带变焦，4-无云台，无变焦，取值参考【数据字典】，typeCode为xresmgr.ptz_type）
     */
    private Long ptz;

    /**
     * 云镜类型说明
     */
    private String ptzName;

    /**
     * 云台控制（1-DVR,2-模拟矩阵,3-MU4000,4-NC600，取值参考【数据字典】，typeCode为xresmgr.ptz_control_type）
     */
    private Long ptzController;

    /**
     * 云台控制说明
     */
    private String ptzControllerName;

    /**
     * 所属设备类型（详见【数据字典】，typeCode为xresmgr.resource_type）
     */
    private String deviceResourceType;

    /**
     * 所属设备类型说明
     */
    private String deviceResourceTypeName;

    /**
     * 通道子类型（详见【数据字典】，typeCode为xresmgr.device_type_code.camera）
     */
    private String channelType;

    /**
     * 通道子类型说明
     */
    private String channelTypeName;

    /**
     * 传输协议（0-UDP，1-TCP，取值参考【数据字典】，typeCode为xresmgr.transType）
     */
    private Long transType;

    /**
     * 传输协议说明
     */
    private String transTypeName;

    /**
     * 监控点更新时间（IOS8601格式yyyy-MM-dd’T’HH:mm:ss.SSSzzz）
     */
    private String updateTime;

    /**
     * 所属组织编号（通用唯一识别码UUID）
     */
    private String unitIndexCode;

    /**
     * 接入协议（详见【数据字典】，typeCode为xresmgr.protocol_type）
     */
    private String treatyType;

    /**
     * 接入协议说明
     */
    private String treatyTypeName;

    /**
     * 在线状态（0-不在线，1-在线，取值参考【数据字典】，typeCode为xresmgr.status）
     */
    private String status;

    /**
     * 在线状态说明
     */
    private String statusName;

    private String remark;
    private String remark2;
    private String remark3;
    private String remark4;
}
