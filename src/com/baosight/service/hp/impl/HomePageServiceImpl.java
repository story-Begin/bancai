package com.baosight.service.hp.impl;

import com.alibaba.fastjson.JSONObject;
import com.baosight.base.utils.RestTemplateUtils;
import com.baosight.dto.yw.query.OpsUrlDTO;
import com.baosight.dto.yw.query.VideoAisleQueryDTO;
import com.baosight.dto.yw.resp.VideoAisleRespDTO;
import com.baosight.mapper.hp.HomePageMapper;
import com.baosight.service.hp.HomePageService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;

@Service
public class HomePageServiceImpl implements HomePageService {

    @Resource
    HomePageMapper homePageMapper;

    @Override
    public List<Integer> getAlarmCountByLevel() {

        List<Integer> result = new ArrayList<>();
        List<int[]> levels = new ArrayList<>();
        levels.add(new int[]{1,2});
        levels.add(new int[]{3});
        levels.add(new int[]{4,5});
        for (int i = 0; i < 3; i++) {
            Map<String,Object> params = new HashMap<>();
            params.put("level",levels.get(i));
            result.add(homePageMapper.getAlarmCount(params));
        }
        return result;
    }

    @Override
    public Integer getAlarmCountSum() {
        return homePageMapper.getAlarmCount(null);
    }

    @Override
    public Integer getAlarmCountDealed() {
        Map<String,Object> params = new HashMap<>();
        params.put("status",1);
        return homePageMapper.getAlarmCount(params);
    }

    @Override
    public List<List<Integer>> getAlarmCountByLevelAndTime() {
        List<List<Integer>> result = new ArrayList<>();
        List<int[]> levels = new ArrayList<>();
        levels.add(new int[]{1,2});
        levels.add(new int[]{3});
        levels.add(new int[]{4,5});
        for (int i = 0; i < 3; i++) {
            List<Integer> alarmCount = new ArrayList<>();
            for (int j = 0; j < 7; j++) {
                Calendar clr = Calendar.getInstance();
                clr.add(Calendar.DATE,-j);
                Map<String,Object> params = new HashMap<>();
                params.put("level",levels.get(i));
                params.put("createTime",clr.getTime());
                alarmCount.add(homePageMapper.getAlarmCount(params));
            }
            Collections.reverse(alarmCount);
            result.add(alarmCount);
        }
            return result;
    }


    @Override
    public Integer getDeviceCameraOnLine() {
        return homePageMapper.getCameraCount(1);
    }

    @Override
    public Integer getDeviceCamerOffLine() {
        return homePageMapper.getCameraCount(2);
    }

    @Override
    public List<Integer> getVideoCallCount() {
        List<Integer> result = new ArrayList<>();//MGvideo001
        Integer cameraCountSum = homePageMapper.getCameraInvokeCount("MGvideo001", false, null);
        Integer cameraCountToday = homePageMapper.getCameraInvokeCount("MGvideo001", true, null);
        result.add(cameraCountSum);
        result.add(cameraCountToday);
        return result;
    }

    @Override
    public List<Integer> getVideoCallCountByThirdParty() {
        List<Integer> result = new ArrayList<>();//No:0001
        Integer cameraCountSum = homePageMapper.getCameraInvokeCount("No:0001", false, null);
        Integer cameraCountToday = homePageMapper.getCameraInvokeCount("No:0001", true, null);
        result.add(cameraCountSum);
        result.add(cameraCountToday);
        return result;
    }

    @Override
    public List<Integer> getVideoCallCountByTime() {
        List<Integer> result = new ArrayList<>();
        for (int i = 0; i < 5; i++) {
            Calendar clr = Calendar.getInstance();
            clr.add(Calendar.HOUR,-i);
            result.add(homePageMapper.getCameraInvokeCount("No:0001", false, clr.getTime()));
        }
        return result;
    }

    @Override
    public List<Integer> getVideoCallCountByThirdPartyAndTime() {
        List<Integer> result = new ArrayList<>();
        for (int i = 0; i < 5; i++) {
            Calendar clr = Calendar.getInstance();
            clr.add(Calendar.HOUR,-i);
            result.add(homePageMapper.getCameraInvokeCount("MGvideo001", false, clr.getTime()));
        }
        return result;
    }

    @Override
    public List<Integer> getVideoQuality() {
        List<Integer> result = new ArrayList<>();
        VideoAisleQueryDTO queryDTO = new VideoAisleQueryDTO();
        int pageNo = 1;
        queryDTO.setPageNo(pageNo);
        queryDTO.setPageSize(20);
        Map<String,Integer> map = new HashMap<>();
        map.put("1",0);
        map.put("2",1);
        map.put("5",2);
        map.put("8",3);
//        4.diagnoseResult  字段['图像正常', '图异常', '诊断失败', '未检测'],
//        1:正常；2：视频丢失；3：视频质量不合格；4：离线；5:点播失败；6：点播超时；7：平台离线；8：未检测   9:码流不足
        List<VideoAisleRespDTO> videoAisleRespDTOS = null;
        for (int i = 0; i <4 ; i++) {
            result.add(i);
        }
        do {
            videoAisleRespDTOS = RestTemplateUtils.restTemplateApi(OpsUrlDTO.VIDEO_AISLE, queryDTO);
            videoAisleRespDTOS = JSONObject.parseArray(JSONObject.toJSONString(videoAisleRespDTOS), VideoAisleRespDTO.class);
            for (VideoAisleRespDTO videoAisleRespDTO : videoAisleRespDTOS) {
                String type =videoAisleRespDTO.getDiagnoseResult();
                Integer index = map.get(type);
                if(index==null){
                    continue;
                }
                Integer count = result.get(index);
                count++;
                result.set(index,count);
            }
            pageNo++;
            queryDTO.setPageNo(pageNo);
        }while (videoAisleRespDTOS.size() == 20);

        return result;

    }

}
