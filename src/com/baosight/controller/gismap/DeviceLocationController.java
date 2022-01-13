package com.baosight.controller.gismap;


import com.baosight.controller.http.HttpResult;
import com.baosight.dto.gismap.req.DeviceLocationCameraReqDTO;
import com.baosight.dto.gismap.resp.DeviceLocationCameraRespDTO;
import com.baosight.service.gismap.DeviceLocationService;
import com.baosight.utils.WebSocketServer;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/backstage/gismap/devicelocation")
public class DeviceLocationController {

    @Resource
    DeviceLocationService deviceLocationService;

    @RequestMapping("/getdeviceList/{mapId}/{areaId}")
    public HttpResult findAllDeviceLocation(@PathVariable("mapId")Integer mapId,
                                            @PathVariable("areaId")Integer areaId){
        List<DeviceLocationCameraRespDTO> deviceLocationCameraRespDTOS = deviceLocationService.findAllDeviceLocation(areaId,mapId);
        return HttpResult.ok(deviceLocationCameraRespDTOS);
    }

    @RequestMapping("/byName")
    public HttpResult findDeviceByName(@RequestBody Map<String,String> map){
        String deviceName = map.get("deviceName");
        return HttpResult.ok(deviceLocationService
                             .findDeviceByName(map));
    }

    @GetMapping("/delete/{id}")
    public HttpResult deleteDeviceLocationById(@PathVariable("id")Integer id){
        if(id<0||null==id){
            return HttpResult
                    .error("参数不能为空");
        }
        int result = deviceLocationService
                     .deleteDeviceLocationById(id);
        return HttpResult
                .ok(result);
    }

    @PostMapping("/update")
    public HttpResult updateDeviceInfo(@RequestBody DeviceLocationCameraReqDTO deviceLocation){
        if(null==deviceLocation){
            return HttpResult.error("参数不能为空!");
        }
        return HttpResult.ok(deviceLocationService
                             .updateDeviceInfo(deviceLocation));
    }

    @PostMapping("/insert/{areaId}")
    public HttpResult insertDeviceInfo(@RequestBody DeviceLocationCameraReqDTO deviceLocation,
                                       @PathVariable("areaId")Integer lineArea){
        if(null==deviceLocation){
            return HttpResult.error("参数不能为空!");
        }
        return HttpResult.ok(deviceLocationService
                            .insertDeviceLocation(deviceLocation,lineArea));
    }

    @RequestMapping("/getPrgan/{id}")
    public HttpResult getOrganizationId(@PathVariable("id")Integer spaceId){

        return HttpResult.ok(deviceLocationService.getOrganizationList(spaceId));

    }

    @RequestMapping("getAreaName/{id}")
    public HttpResult getAreaName(@PathVariable("id")Integer areaId){

        return HttpResult.ok(deviceLocationService.getAreaName(areaId));

    }

    @RequestMapping("/getMapPath/{id}")
    public HttpResult getMapPath(@PathVariable("id")Integer id){
        return HttpResult.ok(deviceLocationService.getMapPath(id));
    }

}
