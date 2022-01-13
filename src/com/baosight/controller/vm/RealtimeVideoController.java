package com.baosight.controller.vm;

import com.baosight.base.dahua.Base64Util;
import com.baosight.base.dahua.DownloadImage;
import com.baosight.base.dahua.ToInterface;
import com.baosight.controller.http.HttpResult;
import com.baosight.dto.yw.query.OpsUrlDTO;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @ClassName
 * @Description
 * @Author xu
 * @Date 2020/8/12 14:43
 */
@RestController
@RequestMapping("/backstage/vm/realtimeVideo")
public class RealtimeVideoController {

    @Value("${video.imgPath}")
    private String imgPath;

    /**
     * 获取大华云台用户token
     */
    @RequestMapping("/getToken")
    public HttpResult getToken(){
        String res1 = null;
        String ps = null;
        //获取cryptKey
        String cryptKey = ToInterface.interfaseUtil(OpsUrlDTO.VIDEO_URL + "/WPMS/getCryptKey", "{\"loginName\":\"system\"}");
        int startIndex1 = cryptKey.indexOf("publicKey")+12;
        int endIndex1 = cryptKey.indexOf("nonce")-3;
        res1 = cryptKey.substring(startIndex1,endIndex1);
        //获取token
        String pass = OpsUrlDTO.VIDEO_LOGIN_PASSWORD + res1;
        //转换base64
        ps = Base64Util.strConvertBase(pass);
        String info = ToInterface.interfaseUtil(OpsUrlDTO.VIDEO_URL + "/WPMS/apiLogin", "{\"loginName\":\"system\",\"loginPass\":\"" + ps + "\"}");
        int startIndex2 = info.indexOf("token")+8;
        int endIndex2 = info.indexOf("id")-3;
        String token = info.substring(startIndex2,endIndex2);
        return HttpResult.ok(token);
    }


    /**
     * 获取抓拍的图片地址
     */
    @RequestMapping("/getCapturePic")
    public HttpResult getCapturePic(String cameraIndexCode) throws Exception {
        String result = ToInterface.interfaseUtil(OpsUrlDTO.MANUAL_CAPTURE_EX, "{\"cameraIndexCode\":\"" + cameraIndexCode + "\"}");
        int startIndex = result.indexOf("picUrl")+9;
        int endIndex = result.indexOf("jpg")+3;
        String res = result.substring(startIndex,endIndex);
        String imgsPath = DownloadImage.downloadPic(res,imgPath);
        return HttpResult.ok(imgsPath);
    }

}
