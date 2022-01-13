package com.baosight.entity.equipment;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.Column;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;


/**
 * 用户分组表
 *
 * @ClassName UserGroupEntity
 * @Description TODO
 * @Autgor hong
 * @Date 2020-08-05 16:42
 */
@Data
@Table(name = "xs_user_group")
public class UserGroupEntity implements Serializable {

    private static final long serialVersionUID = 1730696321110898585L;
    /**
     * 用户群组ID
     */
    @Column(name = "id")
    private String id;

    /**
     * 用户组名称
     */
    @Column(name = "group_ename")
    private String groupEname;

    /**
     * 群组中文名
     */
    @Column(name = "group_cname")
    private String groupCname;

    /**
     * 群组类型
     */
    @Column(name = "group_type")
    private String groupType;

    /**
     * 排序
     */
    @Column(name = "sort_index")
    private Integer sortIndex;

    /**
     * 创建人
     */
    @Column(name = "rec_creator")
    private String recCreator;

    /**
     * 创建时间
     */
    @Column(name = "rec_create_time")
    private String recCreateTime;

    /**
     * 修改人
     */
    @Column(name = "rec_revisor")
    private String recRevisor;

    /**
     * 修改时间
     */
    @Column(name = "rec_revise_time")
    private String recReviseTime;

    /**
     * 归档标记
     */
    @Column(name = "archive_flag")
    private String archiveFlag;

    /**
     * 管辖组
     */
    @Column(name = "manage_group_ename")
    private String manageGroupEname;

}
