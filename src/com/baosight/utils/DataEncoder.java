package com.baosight.utils;

import com.alibaba.fastjson.JSONObject;

import javax.websocket.EncodeException;
import javax.websocket.Encoder;
import javax.websocket.EndpointConfig;

public class DataEncoder implements Encoder.Text<ServerData> {
    @Override
    public String encode(ServerData serverData) throws EncodeException {

        return JSONObject.toJSONString(serverData);
    }

    @Override
    public void init(EndpointConfig endpointConfig) {

    }

    @Override
    public void destroy() {

    }
}
