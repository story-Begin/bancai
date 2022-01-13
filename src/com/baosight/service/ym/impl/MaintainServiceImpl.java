package com.baosight.service.ym.impl;

import com.baosight.base.page.PageVo;
import com.baosight.base.page.PageVoUtils;
import com.baosight.base.utils.RestTemplateUtils;
import com.baosight.dto.yw.query.*;
import com.baosight.dto.yw.resp.*;
import com.baosight.service.ym.MaintainService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.PageInfo;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * @ClassName VideoAisleServiceImpl
 * @Description TODO
 * @Autgor huang
 * @Date 2020-11-16 16:50
 */
@Service
public class MaintainServiceImpl implements MaintainService {

    @Autowired
    public ObjectMapper objectMapper;

    /**
     * 获取视频通道状态
     *
     * @return
     */
    @Override
    public PageVo queryVideoAisleList(VideoAisleQueryDTO queryDTO) {

        int pageNo = queryDTO.getPageNo();
        List<VideoAisleRespDTO> videoAisleRespDTOS = null;
        List<VideoAisleRespDTO> resultList = new ArrayList<>();
        do {
            videoAisleRespDTOS = RestTemplateUtils.restTemplateApi(OpsUrlDTO.VIDEO_AISLE, queryDTO);
            resultList.addAll(videoAisleRespDTOS);
            pageNo++;
            queryDTO.setPageNo(pageNo);
        }while (videoAisleRespDTOS.size() == 20);
//        // 获取总页数
//        int addSumNo = 0;
//        queryDTO.setPageNo(1);
//        int sumPageSize = getVideoAislePageNo(queryDTO, addSumNo);
//        queryDTO.setPageNo(pageNo);
//        queryDTO.setPageSize(pageSize);
        PageInfo page = new PageInfo();
        page.setTotal(resultList.size());
        page.setList(resultList);
        return PageVoUtils.pageFromMybatis(page);
    }

    private int getVideoAislePageNo(VideoAisleQueryDTO queryDTO, int sumPageSize) {

        queryDTO.setPageSize(100);
        List<VideoAisleRespDTO> videoAisleRespDTOS = RestTemplateUtils.restTemplateApi(OpsUrlDTO.VIDEO_AISLE, queryDTO);
        if (CollectionUtils.isNotEmpty(videoAisleRespDTOS)) {
            sumPageSize += videoAisleRespDTOS.size();
            if (videoAisleRespDTOS.size() == queryDTO.getPageSize()) {
                queryDTO.setPageNo(queryDTO.getPageNo() + 1);
                sumPageSize = getVideoAislePageNo(queryDTO, sumPageSize);
            }
        }

        return sumPageSize;
    }

    /**
     * 获取录像信息
     *
     * @return
     */
    @Override
    public PageVo queryVideoRecordList(VideoRecordQueryDTO queryDTO) {
        List<VideoRecordRespDTO> videoAisleRespList = RestTemplateUtils.restTemplateApi(OpsUrlDTO.VIDEO_DETAIL, queryDTO);
        int addSumNo = 0;
        // 获取总页数
        VideoRecordQueryDTO videoRecordQueryDTO = new VideoRecordQueryDTO();
        videoRecordQueryDTO.setRecordDate(queryDTO.getRecordDate());
        int sumPageSize = getVideoRecordPageNo(videoRecordQueryDTO, addSumNo);
        PageInfo page = new PageInfo();
        page.setTotal(sumPageSize);
        page.setList(videoAisleRespList);
        return PageVoUtils.pageFromMybatis(page);
    }

    private int getVideoRecordPageNo(VideoRecordQueryDTO queryDTO, int sumPageSize) {
        queryDTO.setPageSize(100);
        List<VideoRecordRespDTO> videoAisleRespList = RestTemplateUtils.restTemplateApi(OpsUrlDTO.VIDEO_DETAIL, queryDTO);
        if (CollectionUtils.isNotEmpty(videoAisleRespList)) {
            sumPageSize += videoAisleRespList.size();
            if (videoAisleRespList.size() == queryDTO.getPageSize()) {
                queryDTO.setPageNo(queryDTO.getPageNo() + 1);
                sumPageSize = getVideoRecordPageNo(queryDTO, sumPageSize);
            }
        }
        return sumPageSize;
    }

    /**
     * 获取磁盘状态
     *
     * @return
     */
    @Override
    public PageVo queryDeviceDiskList(DeviceDiskQueryDTO queryDTO) {

        int pageNo = queryDTO.getPageNo();
        List<DeviceDiskRespDTO> deviceDiskRespList= null;
        List<DeviceDiskRespDTO> resultList = new ArrayList<>();
        do {
            deviceDiskRespList = RestTemplateUtils.restTemplateApi(OpsUrlDTO.DEVICE_DISK, queryDTO);
            resultList.addAll(deviceDiskRespList);
            pageNo++;
            queryDTO.setPageNo(pageNo);

        }while (deviceDiskRespList.size()==20);
//        int addSumNo = 0;
//        // 获取总页数
//        int sumPageSize = getDeviceDiskPageNo(new DeviceDiskQueryDTO(), addSumNo);
        PageInfo page = new PageInfo();
        page.setTotal(resultList.size());
        page.setList(resultList);
        return PageVoUtils.pageFromMybatis(page);
    }

    private int getDeviceDiskPageNo(DeviceDiskQueryDTO queryDTO, int sumPageSize) {
        queryDTO.setPageSize(100);
        List<DeviceDiskRespDTO> deviceDiskRespList = RestTemplateUtils.restTemplateApi(OpsUrlDTO.DEVICE_DISK, queryDTO);
        if (CollectionUtils.isNotEmpty(deviceDiskRespList)) {
            sumPageSize += deviceDiskRespList.size();
            if (deviceDiskRespList.size() == queryDTO.getPageSize()) {
                queryDTO.setPageNo(queryDTO.getPageNo() + 1);
                sumPageSize = getDeviceDiskPageNo(queryDTO, sumPageSize);
            }
        }
        return sumPageSize;
    }

    /**
     * 获取设备状态
     *
     * @param queryDTO
     * @return
     */
    @Override
    public PageVo queryDeviceStatusList(DeviceStatusQueryDTO queryDTO) {
//        ResponseEntity<RepositorySerializable> deviceStatusSerializableResult =
//                restTemplate.postForEntity(deviceStatus, queryDTO, RepositorySerializable.class);
//        RepositorySerializable repositorySerializable = deviceStatusSerializableResult.getBody();
//        List<DeviceStatusRespDTO> deviceDiskRespList = (List<DeviceStatusRespDTO>) repositorySerializable.getData();
        int pageNo = queryDTO.getPageNo();
        List<DeviceStatusRespDTO> deviceDiskRespList =null;
        List<DeviceStatusRespDTO> resultList =new ArrayList<>();

        do {
            deviceDiskRespList = RestTemplateUtils.restTemplateApi(OpsUrlDTO.DEVICE_STATUS, queryDTO);
            resultList.addAll(deviceDiskRespList);
            pageNo++;
            queryDTO.setPageNo(pageNo);
        }while (deviceDiskRespList.size()==20);
//        int addSumNo = 0;
//        // 获取总页数
//        int sumPageSize = getDeviceStatusPageNo(new DeviceStatusQueryDTO(), addSumNo);
        PageInfo page = new PageInfo();
        page.setTotal(resultList.size());
        page.setList(resultList);
        return PageVoUtils.pageFromMybatis(page);
    }

    private int getDeviceStatusPageNo(DeviceStatusQueryDTO queryDTO, int sumPageSize) {
        queryDTO.setPageSize(100);
        List<DeviceStatusRespDTO> deviceDiskRespList = RestTemplateUtils.restTemplateApi(OpsUrlDTO.DEVICE_STATUS, queryDTO);
        if (CollectionUtils.isNotEmpty(deviceDiskRespList)) {
            sumPageSize += deviceDiskRespList.size();
            if (deviceDiskRespList.size() == queryDTO.getPageSize()) {
                queryDTO.setPageNo(queryDTO.getPageNo() + 1);
                sumPageSize = getDeviceStatusPageNo(queryDTO, sumPageSize);
            }
        }
        return sumPageSize;
    }

    /**
     * 获取设备在离线历史记录
     *
     * @return
     */
    @Override
    public List<DeviceHistoryRespDTO> queryDeviceHistoryList() {
        List<DeviceHistoryRespDTO> deviceHistoryList = RestTemplateUtils.restTemplateApi(OpsUrlDTO.DEVICE_OFF_LINE, null);
        return deviceHistoryList;
    }

    /**
     * 获取平台状态
     *
     * @return
     */
    @Override
    public PageVo queryPlatformDomainList(VideoAisleQueryDTO queryDTO) {
        List<PlatformDomainRespDTO> platformDomainList = RestTemplateUtils.restTemplateApi(OpsUrlDTO.PLATFORM_DOMAIN, queryDTO);
        int addSumNo = 0;
        // 获取总页数
        int sumPageSize = getPlatformDomainPageNo(new VideoAisleQueryDTO(), addSumNo);
        PageInfo page = new PageInfo();
        page.setTotal(sumPageSize);
        page.setList(platformDomainList);
        return PageVoUtils.pageFromMybatis(page);
    }

    private int getPlatformDomainPageNo(VideoAisleQueryDTO queryDTO, int sumPageSize) {
        queryDTO.setPageSize(100);
        List<PlatformDomainRespDTO> platformDomainList = RestTemplateUtils.restTemplateApi(OpsUrlDTO.PLATFORM_DOMAIN, null);
        if (CollectionUtils.isNotEmpty(platformDomainList)) {
            sumPageSize += platformDomainList.size();
            if (platformDomainList.size() == queryDTO.getPageSize()) {
                queryDTO.setPageNo(queryDTO.getPageNo() + 1);
                sumPageSize = getPlatformDomainPageNo(queryDTO, sumPageSize);
            }
        }
        return sumPageSize;
    }

    /**
     * 获取服务状态
     *
     * @param queryDTO
     * @return
     */
    @Override
    public PageVo queryServerStatusList(VideoAisleQueryDTO queryDTO) {
        List<ServerStatusRespDTO> ServerStatusList = RestTemplateUtils.restTemplateApi(OpsUrlDTO.SERVER_STATUS, queryDTO);
        int addSumNo = 0;
        // 获取总页数
        int sumPageSize = getServerStatusPageNo(new VideoAisleQueryDTO(), addSumNo);
        PageInfo page = new PageInfo();
        page.setTotal(sumPageSize);
        page.setList(ServerStatusList);
        return PageVoUtils.pageFromMybatis(page);
    }

    private int getServerStatusPageNo(VideoAisleQueryDTO queryDTO, int sumPageSize) {
        queryDTO.setPageSize(100);
        List<ServerStatusRespDTO> ServerStatusList = RestTemplateUtils.restTemplateApi(OpsUrlDTO.SERVER_STATUS, null);
        if (CollectionUtils.isNotEmpty(ServerStatusList)) {
            sumPageSize += ServerStatusList.size();
            if (ServerStatusList.size() == queryDTO.getPageSize()) {
                queryDTO.setPageNo(queryDTO.getPageNo() + 1);
                sumPageSize = getServerStatusPageNo(queryDTO, sumPageSize);
            }
        }
        return sumPageSize;
    }


}
