package com.baosight.entity.vm;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

/**
 * 系统用户信息
 * @ClassName
 * @Description
 * @Author XSD
 * @Date 2020/9/8 10:36
 */
@Data
@Table(name = "xs_user")
public class UserEntity  implements Serializable {
    private static final long serialVersionUID = -5886390666909273630L;

    /**
     * 用户ID
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_id")
    private String userId;

    /**
     * 登录名
     */
    @Column(name = "login_name")
    private String loginName;

    /**
     * 密码
     */
    @Column(name = "password")
    private String password;

    /**
     * 状态
     */
    @Column(name = "status")
    private String status;

    /**
     * 用户名
     */
    @Column(name = "user_name")
    private String userName;

    /**
     * 性别
     */
    @Column(name = "gender")
    private String gender;

    /**
     * 电话
     */
    @Column(name = "mobile")
    private String mobile;

    /**
     * 邮箱
     */
    @Column(name = "email")
    private String email;

    /**
     * 用户类型
     */
    @Column(name = "user_type")
    private String userType;

    @Column(name = "account_expire_date")
    private String accountExpireDate;

    @Column(name = "pwd_expire_date")
    private String pwdExpireDate;

    @Column(name = "is_locked")
    private String isLocked;

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
     * 密码修改时间
     */
    @Column(name = "pwd_revise_date")
    private String pwdReviseDate;

    /**
     * 密码修改人
     */
    @Column(name = "pwd_revisor")
    private String pwdRevisor;

    /**
     * 归档标记
     */
    @Column(name = "archive_flag")
    private String archiveFlag;

    /**
     * 用户组
     */
    @Column(name = "user_group_ename")
    private String userGroupEname;

}
