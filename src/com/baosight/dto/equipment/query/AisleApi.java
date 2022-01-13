package com.baosight.dto.equipment.query;

import com.alibaba.fastjson.JSONObject;
import lombok.Data;

/**
 * 通道Api参数
 *
 * @ClassName AisleApi
 * @Description TODO
 * @Autgor huang
 * @Date 2020-11-02 16:14
 */
@Data
public class AisleApi {

    private String interfaceId = "admin_001_006";

    private String jsonParam = JSONObject.toJSONString(new JsonParam());
}


