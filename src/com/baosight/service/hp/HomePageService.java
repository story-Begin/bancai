package com.baosight.service.hp;

import java.util.List;

public interface HomePageService {


    /**
     * 返回报警类型数量（一般，提醒，紧急）
     * @return
     */
    public List<Integer> getAlarmCountByLevel();

    /**
     * 返回报警总数
     * @return
     */
    public Integer getAlarmCountSum();


    /**
     * 返回已处理报警数量
     * @return
     */
    public Integer getAlarmCountDealed();

    /**
     * 返回时间段的报警等级数组
     * @return
     */
    public List<List<Integer>> getAlarmCountByLevelAndTime();

    /**
     * 返回在线摄像头数量
     * @return
     */
    public Integer getDeviceCameraOnLine();

    /**
     * 返回离线摄像头数量
     * @return
     */
    public Integer getDeviceCamerOffLine();

    /**
     * 返回视频监控平台调用
     * @return
     */
    public List<Integer> getVideoCallCount();

    /**
     * 返回第三方视频调用
     * @return
     */
    public List<Integer> getVideoCallCountByThirdParty();

    /**
     * 返回监控平台时间段调用数量
     * @return
     */
    public List<Integer> getVideoCallCountByTime();

    /**
     * 返回时间段第三方视频调用
     * @return
     */
    public List<Integer> getVideoCallCountByThirdPartyAndTime();

    /**
     * 获取视频质量
     * @return
     */
    List<Integer> getVideoQuality();


}
