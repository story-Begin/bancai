package com.baosight.dto.equipment.resp;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

@Data
public class UserGroupAllListDTO implements Serializable{
    private String id;
    private String groupEname;
    private String groupCname;

//    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone="GMT+8")
    private String recCreateTime;

}
