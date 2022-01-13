package com.baosight.dto.equipment.req;

import lombok.Data;

import java.io.Serializable;
import java.util.List;

@Data
public class UserGroupDeviceDTO implements Serializable {

    /**
     *  用户组ID
     */
    String usergroupId;

    /**
     * 设备ID
     */
    List<Integer> deviceId;
}
