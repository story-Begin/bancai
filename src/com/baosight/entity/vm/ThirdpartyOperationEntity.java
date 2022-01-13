package com.baosight.entity.vm;

import com.baosight.base.entity.BaseEntity;
import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;

/**
 * 视频日志表
 * @ClassName ThirdpartyOperationEntity
 * @Description TODO
 * @Author xu
 * @Date 2020/8/24 14:42
 */
@Data
@Table(name = "v_thirdparty_operation")
public class ThirdpartyOperationEntity  extends BaseEntity implements Serializable {
    private static final long serialVersionUID = 9034818607027423337L;

    /**
     * 系统号
     */
    @Column(name = "system_no")
    private String systemNo;

    /**
     * 系统名称
     */
    @Column(name = "system_name")
    private String systemName;

    /**
     * 请求时间
     */
    @Column(name = "quest_time")
    private Date questTime;

    /**
     * 设备唯一编号
     */
    @Column(name = "device_code")
    private String deviceCode;

}
