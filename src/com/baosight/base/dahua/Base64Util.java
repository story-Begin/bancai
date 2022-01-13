package com.baosight.base.dahua;

import java.util.Base64;

/**
 * @ClassName Base64
 * @Description 字符串转换base64
 * @Author xu
 * @Date 2020/8/12 11:00
 */
public class Base64Util {

    //定义字编码格式
    private static final String utf_8="UTF-8";

    //String转Base64
    public static String strConvertBase(String str){
        if (null != str){
            Base64.Encoder encoder = Base64.getEncoder();
            return encoder.encodeToString(str.getBytes());
        }
        return null;
    }

}
