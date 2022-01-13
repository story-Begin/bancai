package com.baosight.dto.vm.query;

import com.baosight.base.page.Page;
import lombok.Data;

import java.io.Serializable;

/**
 * 系统用户
 * @ClassName UserQueryDTO
 * @Description DOTO
 * @Author XSD
 * @Date 2020/9/8 13:22
 */
@Data
public class UserQueryDTO extends Page implements Serializable {
    private static final long serialVersionUID = 6371281636445394661L;

    /**
     * 登录名
     */
    private String loginName;

    /**
     * 用户名
     */
    private String userName;



}
