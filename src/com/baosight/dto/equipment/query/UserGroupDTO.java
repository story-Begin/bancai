package com.baosight.dto.equipment.query;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;
import com.baosight.base.page.Page;
import org.springframework.format.annotation.DateTimeFormat;

/**
 * 用户组设备展示
 */
@Data
public class UserGroupDTO  extends Page implements Serializable{

    private static final long serialVersionUID = 3008741696449366287L;
    /**
     * 用户群组ID
     */
    private  String id;

    private String groupEname;

    /**
     * 群组中文名
     */
    private String groupCname;

    /**
     * 群组类型
     */
    private String groupType;

    /**
     * 排序
     */
    private Integer sortIndex;

    /**
     * 创建人
     */
    private String recCreator;

    /**
     * 创建时间
     */
    private String recCreateTime;

    /**
     * 修改人
     */
    private String recRevisor;

    /**
     * 修改时间
     */
    private String recReviseTime;

    /**
     * 归档标记
     */
    private String archiveFlag;

    /**
     * 管辖组
     */
    private String manageGroupEname;

    /**
     * 设备名称
     */
    private String mDeviceName;

}
