package com.baosight.service.gismap;

import com.baosight.base.baseService.BaseService;
import com.baosight.dto.gismap.req.DeviceLocationCameraReqDTO;
import com.baosight.dto.gismap.resp.DeviceLocationCameraRespDTO;

import java.util.List;
import java.util.Map;

public interface DeviceLocationService {


    /**
     * 查询所有摄像头用于初始化地图
     * @return
     */
    public List<DeviceLocationCameraRespDTO> findAllDeviceLocation(Integer areaId,Integer mapId);

    /**
     * 根据摄像头名称查询列表
     * @param map
     * @return
     */
    public List<DeviceLocationCameraRespDTO> findDeviceByName(Map<String,String> map);

    /**
     * 根据摄像头唯一id进行删除操作
     * @param id
     * @return
     */
    public int deleteDeviceLocationById(Integer id);
    /**
     * 更新摄像头信息
     */
    public int updateDeviceInfo(DeviceLocationCameraReqDTO deviceLocation);
    /**
     * 插入数据
     */
    public int insertDeviceLocation(DeviceLocationCameraReqDTO deviceLocation,Integer lineArea);

    /**
     * 获取产线id数组
     */
    public  List<Map<String,Object>> getOrganizationList(Integer spaceId);

    String getAreaName(Integer areaId);

    Map<String,Object> getMapPath(Integer id);
}
