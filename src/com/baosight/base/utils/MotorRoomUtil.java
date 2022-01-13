package com.baosight.base.utils;

import com.alibaba.fastjson.JSONObject;
import com.hikvision.artemis.sdk.ArtemisHttpUtil;
import com.hikvision.artemis.sdk.config.ArtemisConfig;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

import java.io.IOException;
import java.net.URI;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MotorRoomUtil {

    private static final String base64Id = "Basic c2t4dm1ibGc3cGtpOnVicDV2cHhpenpuNA==";
    private static final String Oauth2 = "Bearer ";


    static {
        //184平台,摄像头平台
        ArtemisConfig.host = "192.168.24.20:443"; //  artemis 网关服务器 ip 端口
        ArtemisConfig.appKey = "20751516";  // 秘钥appkey
        ArtemisConfig.appSecret = "8Ub8ANS58Q2xpKuFGCJT";// 秘钥appSecret

        //49
//        ArtemisConfig.host = "10.1.128.49:443"; //  artemis 网关服务器 ip 端口
//        ArtemisConfig.appKey = "20470493";  // 秘钥appkey
//        ArtemisConfig.appSecret = "5cBadPDF5xIIhNizJAXH";// 秘钥appSecret

      //公司环境
//        ArtemisConfig.host = "10.1.155.184:443"; //  artemis 网关服务器 ip 端口
//        ArtemisConfig.appKey = "20470493";  // 秘钥appkey
//        ArtemisConfig.appSecret = "5cBadPDF5xIIhNizJAXH";// 秘钥appSecret

    }

    private static final String ARTEMIS_PATH = "/artemis";


    /**
     * 判断是否是Json格式
     */
    public static boolean isGoodJson(String content) {
        try {
            JSONObject json = JSONObject.parseObject(content);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static String doPostJson(String url, Map<String, String> param) {
        // 创建Httpclient对象 
        CloseableHttpClient httpClient = HttpClients.createMinimal();
        //设置请求超时时间
        CloseableHttpResponse response = null;
        String resultString = "";
        try {
            // 创建Http Post请求 
            HttpPost httpPost = new HttpPost(url);
            List<NameValuePair> params = new ArrayList<NameValuePair>();
            httpPost.setHeader("Authorization", base64Id);
            httpPost.setHeader("Content-Type", "application/x-www-form-urlencoded");
            for (Map.Entry<String, String> entry : param.entrySet()) {
                params.add(new BasicNameValuePair(entry.getKey(), entry.getValue()));
            }
            httpPost.setEntity(new UrlEncodedFormEntity(params));
            response = httpClient.execute(httpPost);
            HttpEntity entity = response.getEntity();
            resultString = EntityUtils.toString(entity);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                response.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return resultString;
    }

    public static String doGet(String url, Map<String, String> param, String access_token) {
        // 创建Httpclient对象 
        CloseableHttpClient httpclient = HttpClients.createDefault();
        String resultString = "";
        CloseableHttpResponse response = null;
        try {
            // 创建uri 
            URIBuilder builder = new URIBuilder(url);
            if (param != null) {
                for (String key : param.keySet()) {
                    builder.addParameter(key, param.get(key));
                }
            }
            URI uri = builder.build();
            // 创建http GET请求 
            HttpGet httpGet = new HttpGet(uri);
            //给这个请求设置请求配置
            httpGet.setHeader("Authorization", Oauth2 + access_token);
            httpGet.setHeader("Content-Type", "application/json");
            // 执行请求 
            response = httpclient.execute(httpGet);
            // 判断返回状态是否为200 
            if (response.getStatusLine().getStatusCode() == 200) {
                resultString = EntityUtils.toString(response.getEntity(), "UTF-8");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (response != null) {
                    response.close();
                }
                httpclient.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return resultString;
    }



    //查询摄像头监控点列表
    public static String  checkOutCamerasPointInfo(String pageNo, String pageSize) {
        //获取监控点列表接口可用来全量同步监控点信息，返回结果分页展示。
        String requestUrl = ARTEMIS_PATH + "/api/resource/v1/cameras";
        Map<String, String> path = new HashMap<String, String>(2) {
            {
                //49
//                put("http://", requestUrl);
                // 184 端口443
                put("https://", requestUrl);
            }
        };
        if (StringUtils.isEmpty(pageNo)) {
            pageNo = "1";
        }
        if (StringUtils.isEmpty(pageSize)) {
            pageSize = "1000";
        }
        JSONObject jsonBody = new JSONObject();
        jsonBody.put("pageNo", Integer.valueOf(pageNo));
        jsonBody.put("pageSize", Integer.valueOf(pageSize));
        String body = jsonBody.toJSONString();
        String result = ArtemisHttpUtil.doPostStringArtemis(path, body, null, null, "application/json", null);// post请求application/json类型参数
        return result;
    }

    //查询单个摄像头监控点列表
    public static String  checkOutOneCamerasPoint(String pageNo, String pageSize) {
        //获取监控点列表接口可用来全量同步监控点信息，返回结果分页展示。
        String requestUrl = ARTEMIS_PATH + "/api/resource/v1/cameras/indexCode";
        Map<String, String> path = new HashMap<String, String>(2) {
            {
                //49
//                put("http://", requestUrl);
                // 184 端口443
                put("https://", requestUrl);
            }
        };
        if (StringUtils.isEmpty(pageNo)) {
            pageNo = "1";
        }
        if (StringUtils.isEmpty(pageSize)) {
            pageSize = "1000";
        }
        JSONObject jsonBody = new JSONObject();
        jsonBody.put("cameraIndexCode", "31000004001310000033");
//        jsonBody.put("pageSize", Integer.valueOf(pageSize));
        String body = jsonBody.toJSONString();
        String result = ArtemisHttpUtil.doPostStringArtemis(path, body, null, null, "application/json", null);// post请求application/json类型参数
        return result;
    }





    //获取监控点预览取流URL
    public static String camerasPreviewURLsInfo(String cameraIndexCode,String protocol) {
        String requestUrl = ARTEMIS_PATH + "/api/video/v1/cameras/previewURLs";
        Map<String, String> path = new HashMap<String, String>(2) {
            {
                put("https://", requestUrl);
            }
        };
        if(StringUtils.isEmpty(protocol)){
            protocol = "rtsp";
        }
        JSONObject jsonBody = new JSONObject();
        jsonBody.put("cameraIndexCode", cameraIndexCode);
        jsonBody.put("streamType", "0");
        jsonBody.put("protocol", protocol);
        jsonBody.put("expand", "streamform=ps");//streamform=ps streamform=gb28181
        jsonBody.put("transmode", "1");
        String body = jsonBody.toJSONString();
        String result = ArtemisHttpUtil.doPostStringArtemis(path, body, null, null, "application/json", null);// post请求application/json类型参数
        return result;
    }

    //监控点云台控制
    public static String camerasControlling(String cameraIndexCode,String action,String command,String speed) {
        String requestUrl = ARTEMIS_PATH + "/api/video/v1/ptzs/controlling";
        Map<String, String> path = new HashMap<String, String>(2) {
            {
                put("https://", requestUrl);
            }
        };

        if(speed==null || StringUtils.isEmpty(speed)){
            speed = "30";
        }
        JSONObject jsonBody = new JSONObject();
        jsonBody.put("cameraIndexCode", cameraIndexCode);
        jsonBody.put("action", action);
        jsonBody.put("command", command);
        jsonBody.put("speed", speed);//转动速度默认为30
        String body = jsonBody.toJSONString();
        String result = ArtemisHttpUtil.doPostStringArtemis(path, body, null, null, "application/json", null);// post请求application/json类型参数
        return result;
    }


    //监控点在线状态查询
    public static String getOnlineStatus(String pageNo,String pageSize ) {
        String requestUrl = ARTEMIS_PATH + "/api/nms/v1/online/camera/get";
        Map<String, String> path = new HashMap<String, String>(2) {
            {
                put("https://", requestUrl);
            }
        };
        if (StringUtils.isEmpty(pageNo)) {
            pageNo = pageNo;
        }
        if (StringUtils.isEmpty(pageSize)) {
            pageSize = pageSize;
        }
        JSONObject jsonBody = new JSONObject();
        jsonBody.put("pageNo", Integer.valueOf(pageNo));
        jsonBody.put("pageSize", Integer.valueOf(pageSize));
        jsonBody.put("includeSubNode", "1");//是否包含下级区域中的资源数据，1包含，0不包含（若regionId为空，则该参数不起作用）
        String body = jsonBody.toJSONString();
        String result = ArtemisHttpUtil.doPostStringArtemis(path, body, null, null, "application/json", null);// post请求application/json类型参数
        return result;
    }

    //根据监控点列表查询视频质量诊断结果
    public static String getVideoPoint(String pageNo,String pageSize, String[] indexCodes) {
        String requestUrl = ARTEMIS_PATH + "/api/nms/v1/vqd/list";
        Map<String, String> path = new HashMap<String, String>(2) {
            {
                put("https://", requestUrl);
            }
        };

        if (StringUtils.isEmpty(pageNo)) {
            pageNo = "1";
        }
        if (StringUtils.isEmpty(pageSize)) {
            pageSize = "1000";
        }
        JSONObject jsonBody = new JSONObject();
        jsonBody.put("pageNo", Integer.valueOf(pageNo));
        jsonBody.put("pageSize", Integer.valueOf(pageSize));
        jsonBody.put("indexCodes", indexCodes);//这是要请求的cameraIndexCode的集合
        String body = jsonBody.toJSONString();
        String result = ArtemisHttpUtil.doPostStringArtemis(path, body, null, null, "application/json", null);// post请求application/json类型参数
        return result;
    }

}
