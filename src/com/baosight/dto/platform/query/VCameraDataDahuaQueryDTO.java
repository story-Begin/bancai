package com.baosight.dto.platform.query;

import com.baosight.base.entity.BaseEntity;
import com.baosight.base.page.Page;
import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Table;
import java.io.Serializable;

@Data
public class VCameraDataDahuaQueryDTO extends Page implements Serializable  {

  private Long id;

  private String userId;
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
  private Long isDeviceonLine;

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
  private Long category;

  /**
   *
   */
  private Long type;

  /**
   *
   */
  private Long unitType;

  /**
   *
   */
  private Long channelType;
}
