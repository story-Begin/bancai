package com.baosight.dto.equipment.resp;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

@Data
public class DeviceAllListDTO implements Serializable {
    private static final long serialVersionUID = 5727687422510560315L;

    Integer id;

    String mDeviceName;

    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone="GMT+8")
    private Date createTime;

}
