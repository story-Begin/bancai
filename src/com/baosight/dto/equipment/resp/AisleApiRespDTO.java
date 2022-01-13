package com.baosight.dto.equipment.resp;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import org.apache.ibatis.type.Alias;

import java.io.Serializable;

/**
 * @ClassName AisleApiRespDTO
 * @Description TODO
 * @Autgor huang
 * @Date 2020-11-02 18:13
 */
@Data
public class AisleApiRespDTO implements Serializable {
    private static final long serialVersionUID = 2219822964209907091L;

    private String id;

    /**
     * 通道类型
     */
    private Integer channelType;

    /**
     * 设备类型
     */
    private String deviceType;

    /**
     * 在线状态
     */
    private Boolean checked;

    /**
     *
     */
    private String type;

    private String name;

}
