package com.baosight.controller.hp;

import com.baosight.controller.http.HttpResult;
import com.baosight.service.hp.HomePageService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/backstage/hp/homepage")
public class HomePageController {

    @Resource
    HomePageService homePageService;

    /**
     * 返回报警类型数量（一般，提醒，紧急）
     * @return
     */
    @RequestMapping("/alarmCountLevel")
    public HttpResult getAlarmCountByLevel(){
        List<Integer> alarmCountLevel = homePageService.getAlarmCountByLevel();
        return HttpResult.ok(alarmCountLevel);

    }

    /**
     * 返回报警总数
     * @return
     */
    @RequestMapping("/alarmCountSum")
    public HttpResult getAlarmCountSum(){
        Integer alarmCountSum = homePageService.getAlarmCountSum();
        return HttpResult.ok(alarmCountSum);
    }

    /**
     * 返回已处理报警数量
     * @return
     */
    @RequestMapping("/getAlarmCountDealed")
    public HttpResult getAlarmCountDealed(){
        Integer alarmCountDealed = homePageService.getAlarmCountDealed();
        return HttpResult.ok(alarmCountDealed);
    }

    /**
     * 返回时间段的报警等级数组
     * @return
     */
    @RequestMapping("/alarmCountByLevelAndTime")
    public HttpResult getAlarmCountByLevelAndTime(){
        List<List<Integer>> result = homePageService.getAlarmCountByLevelAndTime();
        return HttpResult.ok(result);
    }

    /**
     * 返回摄像头在线离线状态数量
     * @return
     */
    @RequestMapping("/deviceCameraStatusLine")
    public HttpResult getDeviceCameraStatusLine(){
        List<Integer> result = new ArrayList<>();
        Integer onLineCount = homePageService.getDeviceCameraOnLine();
        Integer offLineCount = homePageService.getDeviceCamerOffLine();
        result.add(onLineCount);
        result.add(offLineCount);
        return HttpResult.ok(result);
    }

    /**
     * 返回视频监控平台调用
     * @return
     */
    @RequestMapping("/videoCallCount")
    public HttpResult getVideoCallCount(){
        List<Integer> videoCallCount = homePageService.getVideoCallCount();
        return HttpResult.ok(videoCallCount);
    }

    /**
     * 返回第三方视频调用
     * @return
     */
    @RequestMapping("/videoCallCountByThirdParty")
    public HttpResult getVideoCallCountByThirdParty(){
        List<Integer> videoThirdParty = homePageService.getVideoCallCountByThirdParty();
        return HttpResult.ok(videoThirdParty);
    }

    /**
     * 返回监控平台时间段调用数量
     * @return
     */
    @RequestMapping("videoCallCountByTime")
    public HttpResult getVideoCallCountByTime(){
        List<List<Integer>> result = new ArrayList<>();
        List<Integer> videoCount = homePageService.getVideoCallCountByTime();
        List<Integer> videoCountByThird = homePageService.getVideoCallCountByThirdPartyAndTime();
        result.add(videoCount);
        result.add(videoCountByThird);
        return HttpResult.ok(result);
    }

    @RequestMapping("/videoQuality")
    public HttpResult getVideoQuality(){

        return HttpResult.ok(homePageService.getVideoQuality());

    }

}
