package com.baosight.entity.platform;

import com.baosight.base.entity.BaseEntity;
import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Table;
import java.io.Serializable;

@Data
@Table(name = "v_thirdparty_operation")
public class VThirdpartyOperation extends BaseEntity implements Serializable {
  /**
   *
   */
  @Column(name = "system_no")
  private String systemNo;

  /**
   *
   */
  @Column(name = "system_name")
  private String systemName;

  /**
   *
   */
  @Column(name = "quest_time")
  private java.sql.Timestamp questTime;

  /**
   *
   */
  @Column(name = "device_code")
  private String deviceCode;

  /**
   *
   */
  @Column(name = "remark")
  private String remark;

}
