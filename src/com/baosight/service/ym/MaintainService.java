package com.baosight.service.ym;

import com.baosight.base.page.PageVo;
import com.baosight.dto.yw.query.DeviceDiskQueryDTO;
import com.baosight.dto.yw.query.DeviceStatusQueryDTO;
import com.baosight.dto.yw.query.VideoAisleQueryDTO;
import com.baosight.dto.yw.query.VideoRecordQueryDTO;
import com.baosight.dto.yw.resp.DeviceHistoryRespDTO;

import java.util.List;

/**
 * @ClassName MaintainService
 * @Description TODO
 * @Autgor huang
 * @Date 2020-11-16 16:19
 */
public interface MaintainService {

    /**
     * 获取视频通道状态
     * @return
     */
    PageVo queryVideoAisleList(VideoAisleQueryDTO queryDTO);

    /**
     * 获取录像信息
     * @return
     */
    PageVo queryVideoRecordList(VideoRecordQueryDTO queryDTO);

    /**
     * 获取磁盘状态
     * @param queryDTO
     * @return
     */
    PageVo queryDeviceDiskList(DeviceDiskQueryDTO queryDTO);

    /**
     * 获取设备状态
     * @param queryDTO
     * @return
     */
    PageVo queryDeviceStatusList(DeviceStatusQueryDTO queryDTO);

    /**
     * 获取设备在离线历史记录
     * @return
     */
    List<DeviceHistoryRespDTO> queryDeviceHistoryList();

    /**
     * 获取平台状态
     * @param queryDTO
     * @return
     */
    PageVo queryPlatformDomainList(VideoAisleQueryDTO queryDTO);

    /**
     * 获取服务状态
     * @param queryDTO
     * @return
     */
    PageVo queryServerStatusList(VideoAisleQueryDTO queryDTO);
}
