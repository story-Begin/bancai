package com.baosight.service.equipment;

import com.baosight.base.baseService.BaseService;
import com.baosight.base.page.PageVo;
import com.baosight.dto.common.DeleteDTO;
import com.baosight.dto.equipment.query.YWHKDeviceQueryDTO;
import com.baosight.dto.equipment.req.CameraDataUpdateDTO;
import com.baosight.dto.equipment.req.YWHKDeviceReqDTO;
import com.baosight.entity.equipment.HKDeviceEntity;
import net.sf.json.JSONObject;

import java.util.List;

public interface YWHKDeviceService extends BaseService<YWHKDeviceReqDTO> {

    /**
     * 设备信息列表
     *
     * @param queryDTO
     * @return
     */
    PageVo findPageList(YWHKDeviceQueryDTO queryDTO);

    JSONObject cameraList();

    /**
     * 设备、组织分页列表
     *
     * @param queryDTO
     * @return
     */
    PageVo findPageDevOrganizationList(YWHKDeviceQueryDTO queryDTO);

    /**
     * 批量修改分组状态
     */
    void updateCameraDataList(CameraDataUpdateDTO updateDTO);

    /**
     * 批量新增设备数据
     *
     * @param hkDeviceEntities
     */
    void saveCameraDataList(List<HKDeviceEntity> hkDeviceEntities);

    /**
     * 获取设备总数
     *
     * @return
     */
    int countCameraData();

    /**
     * 更新数据
     *
     * @param
     */
    void flashCameraData(List<HKDeviceEntity> hkDeviceEntities) throws IllegalAccessException;

    /**
     * 删除
     */
    void deleteBatch(DeleteDTO deleteDTO);
}
