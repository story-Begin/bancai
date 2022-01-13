package com.baosight.dto.vm.resp;

import lombok.Data;

import java.io.Serializable;

/**
 * 系统用户
 * @ClassName UserRespDTO
 * @Description DOTO
 * @Author xu
 * @Date 2020/9/8 13:31
 */
@Data
public class UserRespDTO implements Serializable {

    private static final long serialVersionUID = -2065389881394174640L;

    private String userId;

    private String loginName;

    private String userName;



}
