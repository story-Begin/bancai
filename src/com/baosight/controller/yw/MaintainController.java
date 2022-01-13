package com.baosight.controller.yw;

import com.baosight.base.page.PageVo;
import com.baosight.controller.http.HttpResult;
import com.baosight.dto.yw.query.DeviceDiskQueryDTO;
import com.baosight.dto.yw.query.DeviceStatusQueryDTO;
import com.baosight.dto.yw.query.VideoAisleQueryDTO;
import com.baosight.dto.yw.query.VideoRecordQueryDTO;
import com.baosight.dto.yw.resp.DeviceHistoryRespDTO;
import com.baosight.service.ym.MaintainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @ClassName MaintainController
 * @Description TODO
 * @Autgor huang
 * @Date 2020-11-17 15:03
 */
@RestController
@RequestMapping("/maintainService")
public class MaintainController {

    @Autowired
    private MaintainService maintainService;

    /**
     * 获取视频通道状态
     *
     * @param queryDTO
     * @return
     */
    @PostMapping(value = "getVideoAisleList")
    public HttpResult getVideoAisleList(@RequestBody VideoAisleQueryDTO queryDTO) {
        PageVo pageVo = maintainService.queryVideoAisleList(queryDTO);
        return HttpResult.ok("数据获取成功", pageVo);
    }

    /**
     * 获取录像信息
     *
     * @param queryDTO
     * @return
     */
    @PostMapping(value = "getVideoRecordList")
    public HttpResult getVideoRecordList(@RequestBody VideoRecordQueryDTO queryDTO) {
        PageVo pageVo = maintainService.queryVideoRecordList(queryDTO);
        return HttpResult.ok("数据获取成功", pageVo);
    }

    /**
     * 获取磁盘信息
     *
     * @param queryDTO
     * @return
     */
    @PostMapping(value = "getDeviceDiskList")
    public HttpResult getDeviceDiskList(@RequestBody DeviceDiskQueryDTO queryDTO) {
        PageVo pageVo = maintainService.queryDeviceDiskList(queryDTO);
        return HttpResult.ok("数据获取成功", pageVo);
    }

    /**
     * 获取设备状态
     *
     * @param queryDTO
     * @return
     */
    @PostMapping(value = "getDeviceStatusList")
    public HttpResult getDeviceStatusList(@RequestBody DeviceStatusQueryDTO queryDTO) {
        PageVo pageVo = maintainService.queryDeviceStatusList(queryDTO);
        return HttpResult.ok("数据获取成功", pageVo);
    }

    /**
     * 获取设备在离线历史记录
     *
     * @return
     */
    @PostMapping(value = "getDeviceHistoryList")
    public HttpResult getDeviceHistoryList() {
        List<DeviceHistoryRespDTO> deviceHistoryList = maintainService.queryDeviceHistoryList();
        return HttpResult.ok("数据获取成功", deviceHistoryList);
    }

    /**
     * 获取平台状态
     *
     * @param queryDTO
     * @return
     */
    @PostMapping(value = "getPlatformDomainList")
    public HttpResult getPlatformDomainList(@RequestBody VideoAisleQueryDTO queryDTO) {
        PageVo pageVo = maintainService.queryPlatformDomainList(queryDTO);
        return HttpResult.ok("数据获取成功", pageVo);
    }

    /**
     * 获取服务状态
     *
     * @param queryDTO
     * @return
     */
    @PostMapping(value = "getServerStatusList")
    public HttpResult getServerStatusList(@RequestBody VideoAisleQueryDTO queryDTO) {
        PageVo pageVo = maintainService.queryServerStatusList(queryDTO);
        return HttpResult.ok("数据获取成功", pageVo);
    }
}
