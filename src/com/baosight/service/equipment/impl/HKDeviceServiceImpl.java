package com.baosight.service.equipment.impl;


import com.baosight.base.utils.MotorRoomUtil;
import com.baosight.dto.equipment.resp.HKRepositorySerializable;
import com.baosight.dto.equipment.resp.YWHKDeviceStatusDTO;
import com.baosight.entity.equipment.HKDeviceEntity;
import com.baosight.mapper.equipment.HKDeviceDao;
import com.baosight.service.equipment.HKDeviceService;
import com.baosight.service.equipment.YWHKDeviceService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import net.sf.json.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * @ClassName HKDeviceServiceImpl
 * @Description TODO
 * @Author hph
 * @Date 2020/12/26 1:31 下午
 * @Version 1.0
 */
@EnableScheduling
@Component
@Service
public class HKDeviceServiceImpl implements HKDeviceService {

    @Autowired
    private HKDeviceDao hkDeviceDao;
    @Autowired
    private ObjectMapper objectMapper;
    @Autowired
    private YWHKDeviceService ywhkDeviceService;

    /**
     * 获取所有
     * @return
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void getHKDeviceList() throws IOException, IllegalAccessException {
        String pageNo = "1";
        String pageSize = "1000";
        List<HKDeviceEntity> hkRepositoryList = new ArrayList<>();
        List<HKDeviceEntity> list = new ArrayList<>();
        do {
            list.clear();
            String jsonStr = MotorRoomUtil.checkOutCamerasPointInfo(pageNo, pageSize);
            if (StringUtils.isNotEmpty(jsonStr)) {
                JSONObject jsonObject = JSONObject.fromObject(jsonStr);
                Object resultData = jsonObject.get("data");
                String str = resultData.toString();
                if (!resultData.equals("null")) {
                    HKRepositorySerializable hkRepositorySerializable =  objectMapper.readValue(str, new TypeReference<HKRepositorySerializable>() {});
                    List<HKDeviceEntity> repositoryData = objectMapper.convertValue(hkRepositorySerializable.getList(), new TypeReference<List<HKDeviceEntity>>() { });
                    hkRepositoryList.addAll(repositoryData);
                    pageNo = Integer.parseInt(pageNo) + 1 + "";
                    list = repositoryData;
                }
            }
        } while (list.size() == Integer.parseInt(pageSize));
        List<YWHKDeviceStatusDTO> ywhkDeviceStatusList = insertBatch();
        for (HKDeviceEntity it : hkRepositoryList) {
            ywhkDeviceStatusList.stream().filter(s -> s.getIndexCode().contains(it.getCameraIndexCode()))
                    .forEach(i -> it.setOnLineStatus(i.getOnline()));
        }
        // 清空表数据
        hkDeviceDao.truncateTable();
        hkDeviceDao.insertList(hkRepositoryList);
        ywhkDeviceService.flashCameraData(hkRepositoryList);
    }

    @Override
    public String camerasPreviewURLsInfo(String cameraIndexCode, String protocol) {
        String jsonStr = MotorRoomUtil.camerasPreviewURLsInfo(cameraIndexCode, protocol);
        return jsonStr;
    }

    /**
     * 设备状态
     *
     * @return
     * @throws IOException
     */
    private List<YWHKDeviceStatusDTO> insertBatch() throws IOException {
        String pageNo = "1";
        String pageSize = "1000";
        List<YWHKDeviceStatusDTO> hkRepositoryList = new ArrayList<>();
        List<YWHKDeviceStatusDTO> list = new ArrayList<>();
        hkDeviceDao.truncateTable(); // 清空表数据
        do {
            list.clear();
            String jsonStr = MotorRoomUtil.getOnlineStatus(pageNo, pageSize);
            if (StringUtils.isNotEmpty(jsonStr)) {
                JSONObject jsonObject = JSONObject.fromObject(jsonStr);
                Object resultData = jsonObject.get("data");
                String str = resultData.toString();
                if (!resultData.equals("null")) {
                    HKRepositorySerializable hkRepositorySerializable =  objectMapper.readValue(str, new TypeReference<HKRepositorySerializable>() {});
                    List<YWHKDeviceStatusDTO> repositoryData = objectMapper.convertValue(hkRepositorySerializable.getList(), new TypeReference<List<YWHKDeviceStatusDTO>>() { });
                    hkRepositoryList.addAll(repositoryData);
                    pageNo = Integer.parseInt(pageNo) + 1 + "";
                    list = repositoryData;
                }
            }
        } while (list.size() == Integer.parseInt(pageSize));
        return hkRepositoryList;
    }

    /**
     * 定时刷新设备状态
     */
    @Scheduled(cron = "0 */5 * * * ?")
    @Async
    public void flashEquipmentStatus() throws IOException, IllegalAccessException {
        getHKDeviceList();
    }
}
