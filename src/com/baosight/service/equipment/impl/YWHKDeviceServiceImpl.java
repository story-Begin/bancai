package com.baosight.service.equipment.impl;

import com.baosight.base.aspect.AspectTime;
import com.baosight.base.page.BeanCopyUtils;
import com.baosight.base.page.PageVo;
import com.baosight.base.page.PageVoUtils;
import com.baosight.base.utils.MotorRoomUtil;
import com.baosight.dto.common.DeleteDTO;
import com.baosight.dto.equipment.query.YWHKDeviceQueryDTO;
import com.baosight.dto.equipment.req.CameraDataUpdateDTO;
import com.baosight.dto.equipment.req.YWHKDeviceReqDTO;
import com.baosight.dto.equipment.resp.YWHKDeviceRespDTO;
import com.baosight.dto.pz.tree.DeviceOrganizationTree;
import com.baosight.entity.equipment.HKDeviceEntity;
import com.baosight.entity.equipment.YWHKDeviceEntity;
import com.baosight.mapper.base.BaseDeleteMapper;
import com.baosight.mapper.data_field.CodeTypeValueMapper;
import com.baosight.mapper.equipment.HKDeviceDao;
import com.baosight.mapper.equipment.YWHKDeviceDao;
import com.baosight.mapper.pz.DeviceOrganizationDao;
import com.baosight.mapper.pz.UserGroupDao;
import com.baosight.service.equipment.YWHKDeviceService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import net.sf.json.JSONObject;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @ClassName YWHKDeviceServiceImpl
 * @Description TODO
 * @Author hph
 * @Date 2020/12/25 9:40 上午
 * @Version 1.0
 */
@Service
public class YWHKDeviceServiceImpl implements YWHKDeviceService {

    @Autowired
    private YWHKDeviceDao ywhkDeviceDao;
    @Autowired
    private DeviceOrganizationDao deviceOrganizationDao;
    @Autowired
    private CodeTypeValueMapper codeTypeValueMapper;
    @Autowired
    private HKDeviceDao hkDeviceDao;
    @Autowired
    private YWHKDeviceService ywhkDeviceService;
    @Autowired
    private BaseDeleteMapper baseDeleteMapper;
    @Resource
    private RestTemplate restTemplate;
    @Autowired
    private UserGroupDao userGroupDao;
    @Autowired
    private ObjectMapper objectMapper;

    /**
     * 设备列表
     *
     * @param queryDTO
     * @return
     */
    @Override
    public PageVo findPageList(YWHKDeviceQueryDTO queryDTO) {
        List<Integer> ids = new ArrayList<>();
        if (CollectionUtils.isNotEmpty(queryDTO.getDeviceOrganizationIds())) {
            ids.addAll(queryDTO.getDeviceOrganizationIds());
            List<Integer> idList = getIds(ids, new ArrayList<>());
            queryDTO.setDeviceOrganizationIds(idList);
        }
        if (queryDTO.getUserGroupId() != null) {
            List<Integer> deviceIds = userGroupDao.selectByUserGroupId(queryDTO.getUserGroupId());
            queryDTO.setUserGroupList(deviceIds);
        }
        PageHelper.startPage(queryDTO.getPageNo(), queryDTO.getPageSize());
        List<YWHKDeviceEntity> ywhkDeviceEntities = ywhkDeviceDao.findPageList(queryDTO);
//        List<String> codeType = new ArrayList<>();
//        codeType.add(CodeType.DEVICE_TYPE);
//        List<CodeTypeValueRespDTO> codeTypeValueList = codeTypeValueMapper.selectByCodeTypeList(codeType);
//        List<CodeTypeValueRespDTO> deviceTypeList = codeTypeValueList.stream()
//                .filter(it -> it.getCodeSetCode().contains(CodeType.DEVICE_TYPE))
//                .collect(Collectors.toList());
//        ywhkDeviceEntities.forEach(it -> {
//            deviceTypeList.stream().filter(item -> it.getCameraType() == Integer.parseInt(item.getItemCode()))
//                    .forEach(i -> it.setCameraTypeName(i.getItemName()));
//        });
        return PageVoUtils.pageFromMybatis(new PageInfo<>(ywhkDeviceEntities),YWHKDeviceRespDTO.class);
    }

    @Override
    public JSONObject cameraList() {
        String jsonStr = MotorRoomUtil.checkOutOneCamerasPoint("1", "20");
        JSONObject jsonObject = JSONObject.fromObject(jsonStr);
        return jsonObject;
    }

    /**
     * 递归获取子节点
     *
     * @param ids
     * @param resultId
     * @return
     */
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

    /**
     * 设备、组织分页列表
     *
     * @param queryDTO
     * @return
     */
    @Override
    public PageVo findPageDevOrganizationList(YWHKDeviceQueryDTO queryDTO) {
        PageHelper.startPage(queryDTO.getPageNo(), queryDTO.getPageSize());
        List<YWHKDeviceEntity> cameraDataEntities = ywhkDeviceDao.selectDevOrganization(queryDTO);
        return PageVoUtils.pageFromMybatis(new PageInfo<>(cameraDataEntities), YWHKDeviceRespDTO.class);
    }

    /**
     * 批量修改分组状态
     *
     * @param updateDTO
     */
    @Override
    public void updateCameraDataList(CameraDataUpdateDTO updateDTO) {
        ywhkDeviceDao.updateBatch(updateDTO);
    }

    /**
     * 添加设备
     *
     * @param reqDTO
     * @return
     */
    @AspectTime(operation = "create")
    @Override
    public boolean save(YWHKDeviceReqDTO reqDTO) {
        YWHKDeviceEntity ywhkDeviceEntity = new YWHKDeviceEntity();
        BeanUtils.copyProperties(reqDTO, ywhkDeviceEntity);
        ywhkDeviceDao.insert(ywhkDeviceEntity);
        return true;
    }


    /**
     * 批量更新数据
     *
     * @param hkDeviceEntities
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void saveCameraDataList(List<HKDeviceEntity> hkDeviceEntities) {
        List<YWHKDeviceEntity> ywhkDeviceEntities = ywhkDeviceDao.selectAll();
        List<String> entityIds = ywhkDeviceEntities.stream().map(YWHKDeviceEntity::getCameraUuid)
                .collect(Collectors.toList());
        List<HKDeviceEntity> hkDeviceEntityList = hkDeviceEntities.stream()
                .filter(it -> !entityIds.contains(it.getCameraUuid()))
                .collect(Collectors.toList());
        if (CollectionUtils.isNotEmpty(hkDeviceEntityList)) {
            List<YWHKDeviceEntity> insertCameraDataList = BeanCopyUtils.copyList(hkDeviceEntities, YWHKDeviceEntity.class);
            insertCameraDataList.forEach(it -> {
                it.setOrgId(-1);
                it.setParentId("/-1");
                it.setOrgPath("/总厂/其他");
            });
            ywhkDeviceDao.insertList(insertCameraDataList);
        }
    }

    /**
     * 修改设备
     *
     * @param reqDTO
     * @return
     */
    @Override
    public boolean update(YWHKDeviceReqDTO reqDTO) {
        YWHKDeviceEntity ywhkDeviceEntity = new YWHKDeviceEntity();
        BeanUtils.copyProperties(reqDTO, ywhkDeviceEntity);
        ywhkDeviceDao.updateByPrimaryKeySelective(ywhkDeviceEntity);
        return true;
    }

    /**
     * 删除设备
     *
     * @param ids
     * @return
     */
    @Override
    public void delete(String ids) {
        JSONObject json = JSONObject.fromObject(ids);
        String idStr = (String) json.get("ids");
        List<Integer> idList = Arrays.asList(idStr.split(","))
                .stream().map(Integer::valueOf).collect(Collectors.toList());
        ywhkDeviceDao.deleteBatch(idList);

    }

    /**
     * 删除
     *
     * @param deleteDTO
     */
    @Override
    public void deleteBatch(DeleteDTO deleteDTO) {
        deleteDTO.setTableName(new YWHKDeviceEntity().getDynamicTableName());
        baseDeleteMapper.deleteBatch(deleteDTO);

    }

    /**
     * 获取设备总数
     *
     * @return
     */
    @Override
    public int countCameraData() {
        return ywhkDeviceDao.countCameraData();
    }

    /**
     * 批量更新数据:
     * 1-海康表：清空表数据，重新添加
     * 2-设备表：对比数据是否存在，不存在则添加、存在则更新，大华表不存在而设备表存在则删除
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void flashCameraData(List<HKDeviceEntity> hkDeviceEntities) {
        // 获取已存在设备
        List<YWHKDeviceEntity> cameraDataEntities = ywhkDeviceDao.selectCameraDataAll();
        List<String> cameraDataIds = cameraDataEntities.stream().map(YWHKDeviceEntity::getCameraUuid).collect(Collectors.toList());
        // 获取未存在的，进行添加
        List<HKDeviceEntity> insertHkDeviceEntities = hkDeviceEntities.stream().filter(it ->
                !cameraDataIds.contains(it.getCameraUuid())).collect(Collectors.toList());
        if (CollectionUtils.isNotEmpty(insertHkDeviceEntities)) {
            // 新增设备
            ywhkDeviceService.saveCameraDataList(insertHkDeviceEntities);
        }
        // 编辑设备
        List<HKDeviceEntity> insertVCameraDataDaHuaList = hkDeviceEntities.stream().filter(it ->
                cameraDataIds.contains(it.getCameraUuid())).collect(Collectors.toList());
        List<YWHKDeviceEntity> ywhkDeviceEntities = new ArrayList<>();
        if (CollectionUtils.isNotEmpty(insertVCameraDataDaHuaList)) {
            insertVCameraDataDaHuaList.forEach(it -> {
                YWHKDeviceEntity ywhkDeviceEntity = new YWHKDeviceEntity();
                ywhkDeviceEntity.setChannelNo(it.getChannelNo());
                ywhkDeviceEntity.setOnLineStatus(it.getOnLineStatus());
                ywhkDeviceEntity.setCameraIndexCode(it.getCameraIndexCode());
                ywhkDeviceEntities.add(ywhkDeviceEntity);
            });
            ywhkDeviceDao.updateBatchCameraData(ywhkDeviceEntities);
        }
    }
}
