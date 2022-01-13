package com.baosight.base.utils;


import com.google.gson.Gson;

import java.io.Serializable;

/**
 * @ClassName JsonUtil
 * @Description TODO
 * @Autgor huang
 * @Date 2020-08-25 18:55
 */
public class JsonUtil implements Serializable {

    private static final long serialVersionUID = 8093649779271673754L;

    public static String getJsonStr(Object obj) {
        Gson gson = new Gson();
        String str = gson.toJson(obj);
        return str;
    }
}
