package com.baosight.dto.platform.resp;

import com.baosight.base.page.Page;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

@Data
public class VCameraDataDahuaRespDTO extends Page implements Serializable  {

  private static final long serialVersionUID = -5196887937351207997L;
  private Integer id;

  /**
   *
   */
  private String channelId;

  /**
   *
   */
  private String channelName;

  /**
   *
   */
  private String deviceId;

  /**
   *
   */
  private String deviceName;

  /**
   *
   */
  private String deviceIp;

  /**
   *
   */
  private String isDeviceonLine;

  /**
   *
   */
  private String orgCode;

  /**
   *
   */
  private String sn;

  /**
   *
   */
  private Integer category;

  /**
   *
   */
  private String type;

  /**
   *
   */
  private Integer unitType;

  /**
   *
   */
  private Integer channelType;

  private Date createTime;
}
