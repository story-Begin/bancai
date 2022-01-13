package com.baosight.dto.yw.query;

/**
 * 运维接口路径
 *
 * @ClassName OpsUrlDTO
 * @Description TODO
 * @Author hph
 * @Date 2020/12/22 9:47 上午
 * @Version 1.0
 */
public interface OpsUrlDTO {

    String VIDEO_IP = "10.44.140.3";

    /**
     * 视频地址
     */
    String VIDEO_URL = "http://10.44.140.3:8314";

    /**
     * 获取token使用
     */
    String LOGIN_NAME = "system";
    String VIDEO_LOGIN_PASSWORD = "Admin_123";

    /**
     * 历史视频地址
     */
    String HISTORY_VIDEO_URL = VIDEO_URL + "/admin/rest/api";

    /**
     * 图片抓拍地址
     */
    String MANUAL_CAPTURE_EX = VIDEO_URL + "/admin/rest/device/rest/getManualCaptureEx";

    /** ------------------------------------------------ 运维模块IP ------------------------------------------------ **/

    /**
     * 运维ip
     */
    String YW_IP = "http://10.44.140.7:80";

    /**
     * 获取视频通道状态
     */
    String VIDEO_AISLE = YW_IP + "/nms/rest/camera/cameraList";

    /**
     * 获取通道录像
     */
    String VIDEO_DETAIL = YW_IP + "/nms/rest/videoRecord/videoRecordList";

    /**
     * 获取磁盘状态
     */
    String DEVICE_DISK = YW_IP + "/nms/rest/device/deviceDiskList";

    /**
     * 获取设备状态
     */
    String DEVICE_STATUS = YW_IP + "/nms/rest/device/deviceStatusList";

    /**
     * 获取设备在离线历史记录
     */
    String DEVICE_OFF_LINE = YW_IP + "/nms/rest/device/deviceHisList";

    /**
     * 获取平台状态
     */
    String PLATFORM_DOMAIN = YW_IP + "/nms/rest/domain/domainList";

    /**
     * 获取服务状态
     */
    String SERVER_STATUS = YW_IP + "/nms/rest/domain/domainSatatusList";

    /**
     * 实时报警
     */
    String REAL_TIME_ALARM = YW_IP + "/nms/rest/alarm/realTimeAlarmList";

    /**
     * 历史报警
     */
    String HIS_ALARM = YW_IP + "/nms/rest/alarm/hisAlarmList";
}
