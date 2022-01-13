package com.baosight.entity.equipment;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;

/**
 * @ClassName HKDevice
 * @Description TODO
 * @Author hph
 * @Date 2020/12/24 10:49 上午
 * @Version 1.0
 */
@Data
@Table(name = "v_hk_device")
public class HKDeviceEntity implements Serializable {
    private static final long serialVersionUID = 5239344733832435946L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    /**
     * 监控点唯一标识
     */
    @Column(name = "CAMERAINDEXCODE")
    private String cameraIndexCode;

    /**
     * 监控点UUID
     */
    @Column(name = "CAMERAUUID")
    private String cameraUuid;

    /**
     * 监控点名称
     */
    @Column(name = "CAMERANAME")
    private String cameraName;

    /**
     * 监控点类型 （0：枪机，1：半球，2：快球，3：带云镜枪机）
     */
    @Column(name = "CAMERATYPE")
    private Integer cameraType;

    /**
     * 通道号
     */
    @Column(name = "CAMERACHANNELNUM")
    private Integer channelNo;

    /**
     * 专业智能类型码（1：周界防范；2：人脸抓拍；3：热度图；4：客流分析；5：人脸对比服务；
     * 6：卡扣；7：GPS设备；8：课时与设备；9：人脸比对设备；a：密度相机）
     */
    @Column(name = "SMARTTYPE")
    private String smartType;

    /**
     * 是否支持智能（0：不支持智能；1：普通智能；2：专业智能）
     */
    @Column(name = "SMARTSUPPORT")
    private Integer smartSupport;

    /**
     * 在线状态（0：不在线；1：在线）
     */
    @Column(name = "ONLINESTATUS")
    private Integer onLineStatus;

    /**
     * 键盘矩阵UUID
     */
    @Column(name = "KEYBOARDCODE")
    private String keyBoardCode;

    /**
     * 排序字段
     */
    @Column(name = "ORDERNUM")
    private Integer orderNum;

//    /**
//     * 更新时间
//     */
//    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
//    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
//    @Column(name = "UPDATETIME")
//    private Date updateTime;

    /**
     * 中心UUID
     */
    @Column(name = "UNITUUID")
    private String unitUuid;

    /**
     * 区域UUID
     */
    @Column(name = "REGIONUUID")
    private String regionUuid;

    /**
     * 编码设备UUID
     */
    @Column(name = "ENCODERUUID")
    private String encoderUuid;

    /**
     * 资源权限集
     */
    @Column(name = "RESAUTHS")
    private String resauths;

    /**
     * 国际标准码
     */
    @Column(name = "GBINDEXCODE")
    private String gbIndexCode;

    /**
     * 网域名字
     */
    @Column(name = "NETZONE")
    private String netZone;

    /**
     * 网域相关的UUID
     */
    @Column(name = "NETZONECODE")
    private String netZoneCode;
}
