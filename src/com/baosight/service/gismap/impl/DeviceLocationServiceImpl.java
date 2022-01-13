package com.baosight.service.gismap.impl;

import com.alibaba.fastjson.JSONObject;
import com.baosight.base.page.BeanCopyUtils;
import com.baosight.dto.gismap.req.DeviceLocationCameraReqDTO;
import com.baosight.dto.gismap.resp.DeviceLocationCameraRespDTO;
import com.baosight.dto.pz.tree.DeviceOrganizationTree;
import com.baosight.iplat4j.core.web.threadlocal.UserSession;
import com.baosight.mapper.gismap.DeviceLocationDao;
import com.baosight.mapper.pz.DeviceOrganizationDao;
import com.baosight.mapper.pz.UserGroupDao;
import com.baosight.service.gismap.DeviceLocationService;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.websocket.Session;
import java.util.*;
import java.util.stream.Collectors;


@Service
public class DeviceLocationServiceImpl implements DeviceLocationService {

    @Autowired
    DeviceLocationDao deviceLocationDao;

    @Autowired
    DeviceOrganizationDao deviceOrganizationDao;
    
    @Autowired
    UserGroupDao userGroupDao;



    @Transactional
    @Override
    public List<DeviceLocationCameraRespDTO> findAllDeviceLocation(Integer areaId,Integer mapId){

        String userUuid = UserSession.getUserUuid();
        List<Integer> userFkDeviceId = null;
        if(userUuid!=null&& (!userUuid.equals(""))){
            List<String> list = userGroupDao.selectUserGroupId(userUuid);
            userFkDeviceId = userGroupDao.selectByUserGroupId(list.get(0));
        }
        List<Integer> ids = new ArrayList<>();
        ids.add(areaId);
            List<Integer> idList = getIds(ids, new ArrayList<>());
        List<DeviceLocationCameraReqDTO> deviceLocationList = deviceLocationDao.findDeviceAll(idList,areaId,mapId,userFkDeviceId);
        return BeanCopyUtils.copyList(deviceLocationList, DeviceLocationCameraRespDTO.class);
    }

    private List<Integer> getIds(List<Integer> ids, List<Integer> resultId) {
        for (Integer id : ids) {
            List<DeviceOrganizationTree> deviceOrganizationTrees = deviceOrganizationDao.queryChildren(id);
            List<Integer> idList = deviceOrganizationTrees.stream().map(DeviceOrganizationTree::getId).collect(Collectors.toList());
            if (CollectionUtils.isNotEmpty(deviceOrganizationTrees)) {
                getIds(idList, resultId);
            }
            resultId.add(id);
        }
        return resultId;
    }

    @Override
    public List<DeviceLocationCameraRespDTO> findDeviceByName(Map<String,String> map) {

        String userUuid = UserSession.getUserUuid();
        List<Integer> userFkDeviceId = null;
        if(userUuid!=null&& (!userUuid.equals(""))){
            List<String> list = userGroupDao.selectUserGroupId(userUuid);
            userFkDeviceId = userGroupDao.selectByUserGroupId(list.get(0));
        }
        List<Integer> ids = new ArrayList<>();
        ids.add(Integer.parseInt(map.get("areaId")));
        List<Integer> idList = getIds(ids, new ArrayList<>());
        String deviceName = map.get("deviceName");
        Integer mapId =Integer.parseInt(map.get("mapId"));
        List<DeviceLocationCameraReqDTO> deviceLocationByNameList = deviceLocationDao
                                                                          .findDeviceByName(deviceName,mapId,idList,userFkDeviceId);
      return BeanCopyUtils.copyList(deviceLocationByNameList,DeviceLocationCameraRespDTO.class);
    }
    /**
     * 删除设备位置信息
     * @param id
     */
    @Override
    public int deleteDeviceLocationById(Integer id) {

        return deviceLocationDao
                .deleteDeviceLocationById(id);
    }

    /**
     * 更新摄像头信息
     * @param deviceLocation
     * @return
     */
    @Override
    public int updateDeviceInfo(DeviceLocationCameraReqDTO deviceLocation) {

        return deviceLocationDao
                .updateDeviceInfo(deviceLocation);
    }

    /**
     * 添加摄像头信息
     * @param deviceLocation
     * @return
     */
    @Override
    public int insertDeviceLocation(DeviceLocationCameraReqDTO deviceLocation,Integer lineArea) {

        return deviceLocationDao
                .insertDeviceInfo(deviceLocation,lineArea);
    }

    @Override
    public  List<Map<String,Object>> getOrganizationList(Integer spaceId) {
        return deviceLocationDao.getOrganizationList(spaceId);
    }

    @Override
    public String getAreaName(Integer areaId) {
        return deviceLocationDao.getAreaName(areaId);
    }

    @Override
    public Map<String, Object> getMapPath(Integer id) {
        Map<String,Object> result = null;
        String pathStr = deviceLocationDao.getMapPath(id);
        if(pathStr==null||pathStr.equals("")){
        }else{
            result = new HashMap<>();
            int subIndex = pathStr.indexOf(":");
            String pathPre = pathStr.substring(0,subIndex);
            String[] mapList = pathStr.substring(subIndex+1).split(",");
            result.put("pathPre",pathPre);
            result.put("pathList",mapList);
        }
        return result;
    }

}
