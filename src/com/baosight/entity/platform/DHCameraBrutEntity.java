package com.baosight.entity.platform;

import com.baosight.base.entity.BaseEntity;
import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Data
@Table(name = "v_dh_camera_brut")
public class DHCameraBrutEntity extends BaseEntity implements Serializable {
  private static final Long serialVersionUID = -59678954143347677L;
//
//  @Id
//  @GeneratedValue(strategy = GenerationType.IDENTITY)
//  @Column(name = "id")
//  private Integer id;
//  /**
//   * 监控点创建时间（IOS8601格式yyyy-MM-dd’T’HH:mm:ss.SSSzzz）
//   */
//  @Column(name = "create_time")
//  private Date createTime;


  /**
   * 监控点国标编号
   */
  @Column(name = "gbIndexCode")
  private String gbIndexCode;

  /**
   * 监控点编号
   */
  @Column(name = "cameraIndexCode")
  private String cameraIndexCode;

  /**
   * 监控点名称
   */
  @Column(name = "name")
  private String name;


  /**
   * 所属设备编号
   */
  @Column(name = "deviceIndexCode")
  private String deviceIndexCode;


  /**
   * 经度
   */
  @Column(name = "longitude")
  private String longitude;

  /**
   * 纬度
   */
  @Column(name = "latitude")
  private String latitude;


  /**
   * 海拔高度
   */
  @Column(name = "altitude")
  private String altitude;

  /**
   * 摄像机像素（1-普通像素，2-130万高清，3-200万高清，4-300万高清，取值参考【数据字典】，typeCode为xresmgr.piexl）
   */
  @Column(name = "pixel")
  private Long pixel;


  /**
   * 监控点类型（0-枪机,1-半球,2-快球,3-带云台枪机,取值参考【数据字典】，typeCode为xresmgr.camera_type）
   */
  @Column(name = "cameraType")
  private Long cameraType;


  /**
   * 监控点类型说明
   */
  @Column(name = "cameraTypeName")
  private String cameraTypeName;


  /**
   * 安装位置
   */
  @Column(name = "installPlace")
  private String installPlace;


  /**
   * 矩阵编号
   */
  @Column(name = "matrixCode")
  private String matrixCode;


  /**
   * 通道号
   */
  @Column(name = "chanNum")
  private Long chanNum;


  /**
   * 可视域相关（JSON格式）
   */
  @Column(name = "viewshed")
  private String viewshed;


  /**
   * 能力集（详见【数据字典】，typeCode为xresmgr.capability_set）
   */
  @Column(name = "capabilitySet")
  private String capabilitySet;


  /**
   * 能力集说明
   */
  @Column(name = "capabilitySetName")
  private String capabilitySetName;


  /**
   * 智能分析能力集（详见【数据字典】，typeCode为xresmgr.intelligent_set）
   */
  @Column(name = "intelligentSet")
  private String intelligentSet;


  /**
   * 智能分析能力集说明
   */
  @Column(name = "intelligentSetName")
  private String intelligentSetName;


  /**
   * 录像存储位置（0-中心存储，1-设备存储，取值参考【数据字典】，typeCode为xresmgr.record_location）
   */
  @Column(name = "recordLocation")
  private String recordLocation;


  /**
   * 录像存储位置说明
   */
  @Column(name = "recordLocationName")
  private String recordLocationName;


  /**
   * 云镜类型（1-全方位云台（带转动和变焦），2-只有变焦,不带转动，3-只有转动，不带变焦，4-无云台，无变焦，取值参考【数据字典】，typeCode为xresmgr.ptz_type）
   */
  @Column(name = "ptz")
  private Long ptz;

  /**
   * 云镜类型说明
   */
  @Column(name = "ptzName")
  private String ptzName;


  /**
   * 云台控制（1-DVR,2-模拟矩阵,3-MU4000,4-NC600，取值参考【数据字典】，typeCode为xresmgr.ptz_control_type）
   */
  @Column(name = "ptzController")
  private Long ptzController;


  /**
   * 云台控制说明
   */
  @Column(name = "ptzControllerName")
  private String ptzControllerName;


  /**
   * 所属设备类型（详见【数据字典】，typeCode为xresmgr.resource_type）
   */
  @Column(name = "deviceResourceType")
  private String deviceResourceType;


  /**
   * 所属设备类型说明
   */
  @Column(name = "deviceResourceTypeName")
  private String deviceResourceTypeName;


  /**
   * 通道子类型（详见【数据字典】，typeCode为xresmgr.device_type_code.camera）
   */
  @Column(name = "channelType")
  private String channelType;

  /**
   * 通道子类型说明
   */
  @Column(name = "channelTypeName")
  private String channelTypeName;


  /**
   * 传输协议（0-UDP，1-TCP，取值参考【数据字典】，typeCode为xresmgr.transType）
   */
  @Column(name = "transType")
  private Long transType;


  /**
   * 传输协议说明
   */
  @Column(name = "transTypeName")
  private String transTypeName;


  /**
   * 监控点更新时间（IOS8601格式yyyy-MM-dd’T’HH:mm:ss.SSSzzz）
   */
  @Column(name = "updateTime")
  private String updateTime;


  /**
   * 所属组织编号（通用唯一识别码UUID）
   */
  @Column(name = "unitIndexCode")
  private String unitIndexCode;


  /**
   * 接入协议（详见【数据字典】，typeCode为xresmgr.protocol_type）
   */
  @Column(name = "treatyType")
  private String treatyType;


  /**
   * 接入协议说明
   */
  @Column(name = "treatyTypeName")
  private String treatyTypeName;


  /**
   * 在线状态（0-不在线，1-在线，取值参考【数据字典】，typeCode为xresmgr.status）
   */
  @Column(name = "status")
  private String status;


  /**
   * 在线状态说明
   */
  @Column(name = "statusName")
  private String statusName;

}
