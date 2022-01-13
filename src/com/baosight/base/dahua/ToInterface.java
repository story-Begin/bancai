package com.baosight.base.dahua;


import com.baosight.dto.yw.query.OpsUrlDTO;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;

/**
 * @ClassName 调用http接口
 * @Description 调用大华平台的http接口
 * @Author xu
 * @Date 2020/8/11 16:10
 */
public class ToInterface {

    public static String interfaseUtil(String path, String data){
        String result = null;
        try{
            URL url = new URL(path);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            PrintWriter out = null;
            conn.setRequestMethod("POST");
            conn.setRequestProperty("accept", "*/*");
            conn.setRequestProperty("connection", "Keep-Alive");
            conn.setRequestProperty("Content-Type","application/json;charset=UTF-8");
            conn.setRequestProperty("user-agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)");
            conn.setDoOutput(true);
            conn.setDoInput(true);
            out = new PrintWriter(conn.getOutputStream());
            out.print(data);
            out.flush();
            InputStream is = conn.getInputStream();
            BufferedReader br = new BufferedReader(new InputStreamReader(is));
            String str ="";
            while ((str = br.readLine()) != null){
                result += str;
                System.out.println(str);
            }
            is.close();
            conn.disconnect();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }


    public static void main(String[] args) {
        //获取随机数值
        String path1 = interfaseUtil(OpsUrlDTO.VIDEO_URL + "/WPMS/getCryptKey", "{\"loginName\":\"system\"}");
        int startIndex = path1.indexOf("publicKey")+12;
        int endIndex = path1.indexOf("nonce")-3;
        String res = path1.substring(startIndex,endIndex);
        System.out.println(res);


        //1.密码+随机数=base64
        String pwd = "admin123456789";
        //拼接后
        String ps = pwd+res;
        //转换base64
        String token = Base64Util.strConvertBase(ps);
        String path2 = interfaseUtil(OpsUrlDTO.VIDEO_URL + "/WPMS/apiLogin", "{\"loginName\":\"system\",\"loginPass\":\"" + token + "\"}");
        int startIndex2 = path2.indexOf("token")+8;
        int endIndex2 = path2.indexOf("id")-3;
        String res2 = path2.substring(startIndex2,endIndex2);
        System.out.println(res2);
    }

}


