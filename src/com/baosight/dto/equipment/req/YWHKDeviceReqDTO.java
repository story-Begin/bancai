package com.baosight.dto.equipment.req;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * @ClassName HKDevice
 * @Description TODO
 * @Author hph
 * @Date 2020/12/24 10:49 上午
 * @Version 1.0
 */
@Data
public class YWHKDeviceReqDTO implements Serializable {
    private static final long serialVersionUID = 4044527184085374242L;

    private Integer id;

    /**
     * 监控点唯一标识
     */
    private String cameraIndexCode;

    /**
     * 监控点UUID
     */
    private String cameraUuid;

    /**
     * 监控点名称
     */
    private String cameraName;

    /**
     * 监控点类型 （0：枪机，1：半球，2：快球，3：带云镜枪机）
     */
    private Integer cameraType;

    /**
     * 通道号
     */
    private Integer cameraChannelNum;

    /**
     * 专业智能类型码（1：周界防范；2：人脸抓拍；3：热度图；4：客流分析；5：人脸对比服务；
     * 6：卡扣；7：GPS设备；8：课时与设备；9：人脸比对设备；a：密度相机）
     */
    private String smartType;

    /**
     * 是否支持智能（0：不支持智能；1：普通智能；2：专业智能）
     */
    private Integer smartSupport;

    /**
     * 在线状态（0：不在线；1：在线）
     */
    private Integer onLineStatus;

    /**
     * 键盘矩阵UUID
     */
    private String keyBoardCode;

    /**
     * 排序字段
     */
    private Integer orderNum;

    /**
     * 更新时间
     */
    private String updateTime;

    /**
     * 中心UUID
     */
    private String unitUuid;

    /**
     * 区域UUID
     */
    private String regionUuid;

    /**
     * 编码设备UUID
     */
    private String encoderUuid;

    /**
     * 资源权限集
     */
    private String resauths;

    /**
     * 国际标准码
     */
    private String gbIndexCode;

    /**
     * 网域名字
     */
    private String netZone;

    /**
     * 网域相关的UUID
     */
    private String netZoneCode;

    /**
     * 组织id
     */
    private Integer orgId;

    /**
     * 父级id
     */
    private String parentId;

    /**
     * 父级name
     */
    private String orgPath;

    /**
     * 备注
     */
    private Integer remark;

}
