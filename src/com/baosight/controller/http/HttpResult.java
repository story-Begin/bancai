package com.baosight.controller.http;


/**
 * @ClassName HttpResult
 * @Description TODO
 * @Autgor huang
 * @Date 2020-02-23 10:39
 */

public class HttpResult {

    private int code = 200;

    private String msg;

    private Object data;

    public static HttpResult error() {
        return error(HttpStatus.SC_INTERNAL_SERVER_ERROR, "未知异常，请联系管理员");
    }

    public static HttpResult error(String msg) {
        return error(HttpStatus.SC_INTERNAL_SERVER_ERROR, msg);
    }

    public static HttpResult error(int code, String msg) {
        HttpResult result = new HttpResult();
        result.setCode(code);
        result.setMsg(msg);
        return result;
    }

    public static HttpResult ok(String msg, Object data) {
        HttpResult result = new HttpResult();
        result.setCode(HttpStatus.SC_OK);
        result.setMsg(msg);
        result.setData(data);
        return result;
    }

    public static HttpResult ok(Object data) {
        HttpResult result = new HttpResult();
        result.setMsg(HttpStatus.MSG_OK);
        result.setData(data);
        return result;
    }

    public static HttpResult ok() {
        return new HttpResult();
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}
