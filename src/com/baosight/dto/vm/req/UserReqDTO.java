package com.baosight.dto.vm.req;

import lombok.Data;

import java.io.Serializable;

/**
 * 系统用户
 * @ClassName UserReqDTO
 * @Description DOTO
 * @Author xu
 * @Date 2020/9/8 13:28
 */
@Data
public class UserReqDTO implements Serializable {
    private static final long serialVersionUID = -6311936331168812982L;

    private String userId;

    private String loginName;

    private String userName;

}
