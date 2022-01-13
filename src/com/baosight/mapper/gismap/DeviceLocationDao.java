package com.baosight.mapper.gismap;


import com.baosight.base.baseMapper.BaseMapper;
import com.baosight.dto.gismap.req.DeviceLocationCameraReqDTO;
import com.baosight.entity.gismap.DeviceLocationEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import java.util.Map;

@Mapper
public interface DeviceLocationDao extends BaseMapper<DeviceLocationEntity> {

 List<DeviceLocationCameraReqDTO> findDeviceAll(@Param("idList")List<Integer> idList,@Param("areaId") Integer areaId,@Param("mapId") Integer mapId,@Param("deListId")List<Integer> deListId);

 List<DeviceLocationCameraReqDTO> findDeviceByName(@Param("deviceName")String deviceName,@Param("mapId") Integer mapId,@Param("idList")List<Integer> list,@Param("deListId")List<Integer> deListId);

 int deleteDeviceLocationById(@Param("id") Integer id);

 int updateDeviceInfo(DeviceLocationCameraReqDTO deviceLocation);

 int insertDeviceInfo(@Param("deviceLocation") DeviceLocationCameraReqDTO deviceLocation,@Param("lineArea")Integer lineArea);
 List<Map<String,Object>> getOrganizationList(@Param("spaceId") Integer spaceId);
 String getAreaName(@Param("areaId")Integer areaId);

 String getMapPath(@Param("id")Integer id);

}
