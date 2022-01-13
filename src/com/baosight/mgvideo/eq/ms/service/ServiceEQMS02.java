package com.baosight.mgvideo.eq.ms.service;

import com.baosight.iplat4j.core.ei.EiInfo;
import com.baosight.iplat4j.core.service.impl.ServiceEPBase;

/**
 * @ClassName ServiceEQMS02
 * @Description TODO
 * @Autgor huang
 * @Date 2020-07-26 16:51
 */
public class ServiceEQMS02 extends ServiceEPBase {

//    @Autowired
//    private DeviceAlarmService deviceAlarmService;

    @Override
    public EiInfo initLoad(EiInfo inInfo) {
        return inInfo;
    }

    @Override
    public EiInfo query(EiInfo inInfo) {
//        DeviceAlarmQueryDTO queryDTO = new DeviceAlarmQueryDTO();
//        PageVo pageVo = deviceAlarmService.findPageList(queryDTO);
//        EiInfo outInfo = new EiInfo();
//        Map map = new HashMap<>();
//        map.put("page", pageVo);
//        outInfo.setAttr(map);
//        return outInfo;
        return inInfo;
    }
}
