package com.baosight.base.dahua;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLConnection;
import java.text.SimpleDateFormat;
import java.util.Date;


/**
 * @ClassName 下载图片
 * @Description 下载图片
 * @Author xu
 * @Date 2020/8/17 11:21
 */
public class DownloadImage {

    public static String downloadPic(String urlString, String savePath) throws Exception {
        URL url = new URL(urlString);
        URLConnection con = url.openConnection();
        con.setConnectTimeout(5*1000);
        InputStream is = con.getInputStream();
        byte[] bs = new byte[1024];
        int len;
        File sf=new File(savePath);
        if(!sf.exists()){
            sf.mkdirs();
        }
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd_hhmmss");
        Date date = new Date();
        String imgName = simpleDateFormat.format(date);
        String newFileName =  imgName+ ".png";
        OutputStream os = new FileOutputStream(sf.getPath()+"\\"+newFileName);
        while ((len = is.read(bs)) != -1) {
            os.write(bs, 0, len);
        }
        String resultPath = savePath+newFileName;
        os.close();
        is.close();
        return resultPath;
    }





}
