package com.baosight.service.pz.impl;

import com.baosight.base.enumeration.DevIsOnLineEnum;
import com.baosight.base.enumeration.DeviceOrganizationTypeEnum;
import com.baosight.base.page.BeanCopyUtils;
import com.baosight.base.page.PageVo;
import com.baosight.base.page.PageVoUtils;
import com.baosight.dto.common.DeleteDTO;
import com.baosight.dto.equipment.resp.CameraDataCountRespDTO;
import com.baosight.dto.pz.query.DeviceOrganizationQueryDTO;
import com.baosight.dto.pz.req.DeviceOrganizationReqDTO;
import com.baosight.dto.pz.resp.DeviceOrganizationRespDTO;
import com.baosight.dto.pz.tree.DeviceOrganizationTree;
import com.baosight.dto.pz.tree.DeviceOrganizationTreeDTO;
import com.baosight.dto.pz.tree.OrganizationTree;
import com.baosight.dto.pz.tree.OrganizationTreeDTO;
import com.baosight.entity.equipment.YWHKDeviceEntity;
import com.baosight.entity.pz.DeviceOrganizationEntity;
import com.baosight.iplat4j.core.web.threadlocal.UserSession;
import com.baosight.mapper.equipment.YWHKDeviceDao;
import com.baosight.mapper.pz.DeviceOrganizationDao;
import com.baosight.mapper.pz.UserGroupDao;
import com.baosight.service.pz.DeviceOrganizationService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.Collator;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @ClassName DeviceOrganizationServiceImpl
 * @Description TODO
 * @Autgor huang
 * @Date 2020-07-07 09:16
 */
@Service
public class DeviceOrganizationServiceImpl implements DeviceOrganizationService {

    @Autowired
    private DeviceOrganizationDao deviceOrganizationDao;
    @Autowired
    private YWHKDeviceDao ywhkDeviceDao;
    @Autowired
    private UserGroupDao userGroupMapper;

    /**
     * 组织机构分页列表
     *
     * @param queryDTO
     * @return
     */
    @Override
    public PageVo findPageList(DeviceOrganizationQueryDTO queryDTO) {
        PageHelper.startPage(queryDTO.getPageNo(), queryDTO.getPageSize());
        List<DeviceOrganizationEntity> organizationEntities =
                deviceOrganizationDao.selectByOrganizationName(queryDTO);
        return PageVoUtils.pageFromMybatis(new PageInfo<>(organizationEntities), DeviceOrganizationRespDTO.class);
    }

    /**
     * 组织机构树
     *
     * @param queryDTO
     * @return
     */
    @Override
    public List<OrganizationTreeDTO> getOrganizationTree(DeviceOrganizationQueryDTO queryDTO) {
        List<OrganizationTree> list = deviceOrganizationDao.queryOrganizationChildren(queryDTO.getId());
        List<OrganizationTreeDTO> result = new ArrayList<>();
        if (CollectionUtils.isNotEmpty(list)) {
            for (OrganizationTree entity : list) {
                OrganizationTreeDTO dto = new OrganizationTreeDTO();
                BeanUtils.copyProperties(entity, dto);
                if (CollectionUtils.isEmpty(entity.getChildren())) {
                    dto.setLeaf(true);
                }
                result.add(dto);
            }
        }
        return result;
    }

    /**
     * 组织设备树组件
     *
     * @param queryDTO
     * @return
     */
    @Override
    public List<DeviceOrganizationTreeDTO> getOrganizationEquipmentTree(DeviceOrganizationQueryDTO queryDTO) {
        // 当前用户设备
        List<String> userGroupIds = userGroupMapper.selectUserGroupId(UserSession.getUserUuid());
        List<YWHKDeviceEntity> cameraDataList = ywhkDeviceDao.authorityCameraData(userGroupIds)
                .stream().filter(it -> it != null).collect(Collectors.toList());
        List<DeviceOrganizationTreeDTO> result = new ArrayList<>();
        if (CollectionUtils.isNotEmpty(cameraDataList)) {
            List<Integer> cameraDataIdList = cameraDataList.stream().map(YWHKDeviceEntity::getId).collect(Collectors.toList());
            // 下级节点
            List<DeviceOrganizationTree> deviceOrganizationTrees = deviceOrganizationDao.queryChildren(queryDTO.getId());
            if (CollectionUtils.isNotEmpty(deviceOrganizationTrees)) {
                for (DeviceOrganizationTree entity : deviceOrganizationTrees) {
                    List<Integer> ids = new ArrayList<>();
                    ids.add(entity.getId());
                    CameraDataCountRespDTO countDTO = queryCameraDataCount(ids, cameraDataIdList); // 下级设备总数
                    DeviceOrganizationTreeDTO dto = new DeviceOrganizationTreeDTO();
                    BeanUtils.copyProperties(entity, dto);
                    dto.setOrganizationName(dto.getOrganizationName() + "【" + countDTO.getOnLine() + "/" + countDTO.getSumOnLine() + "】");
                    // 校验是否叶子节点
                    List<YWHKDeviceEntity> deviceOrganizationNode = cameraDataList.stream()
                            .filter(it -> entity.getId().equals(it.getOrgId())).collect(Collectors.toList());
                    if (CollectionUtils.isEmpty(entity.getChildren()) && CollectionUtils.isEmpty(deviceOrganizationNode)) {
                        continue;
//                    dto.setLeaf(true);
                    }
                    result.add(dto);
                }
            } else {
                List<Integer> ids = new ArrayList<>();
                ids.add(queryDTO.getId());
                List<YWHKDeviceEntity> cameraDataEntities = ywhkDeviceDao.selectByOrganizationId(ids);
                List<YWHKDeviceEntity> filter = cameraDataEntities.stream()
                        .filter(it -> cameraDataIdList.contains(it.getId())).collect(Collectors.toList());
                DeviceOrganizationEntity deviceOrganization = deviceOrganizationDao.selectByPrimaryKey(queryDTO.getId());
//                cameraDataEntities.sort((or1,or2) -> {
//                    Collator collator = Collator.getInstance(Locale.CHINA);
//                    return collator.compare(or1.getCameraName(),or2.getCameraName());
//                });
                filter.forEach(it -> {
                    DeviceOrganizationTreeDTO dto = new DeviceOrganizationTreeDTO();
                    dto.setId(it.getId());
                    dto.setOrganizationName(it.getCameraName());
                    dto.setLeaf(true);
                    dto.setOrganizationPathName(deviceOrganization.getOrganizationPathName());
                    dto.setStatus(it.getOnLineStatus());
                    dto.setDeviceType(it.getCameraType());
                    result.add(dto);
                });
            }
        }
        return result;
    }

    @Override
    public List<DeviceOrganizationTreeDTO> getPowerOrganizationEquipmentAllTree(DeviceOrganizationQueryDTO queryDTO) {
        // 1、当前用户组设备权限
        List<String> userGroupIds = userGroupMapper.selectUserGroupId(UserSession.getUserUuid());
        List<YWHKDeviceEntity> cameraDataList = ywhkDeviceDao.authorityCameraData(userGroupIds)
                .stream().filter(it -> it != null).collect(Collectors.toList());
        List<DeviceOrganizationTreeDTO> result = new ArrayList<>();
        if (CollectionUtils.isNotEmpty(cameraDataList)) {
            // 设备分组，便于最后一级组织节点拼接数据
            Map<Integer, List<YWHKDeviceEntity>> resultMap = cameraDataList.stream()
                    .collect(Collectors.groupingBy(YWHKDeviceEntity::getOrgId));
            List<Integer> childrenIds = new ArrayList<>();
            // 获取所有的Key来查询最下级节点
            for (Integer key : resultMap.keySet()) {
                childrenIds.add(key);
            }
            // 获取最下级节点
            List<DeviceOrganizationTree> deviceOrganizationTrees = deviceOrganizationDao.selectPowerOrganizationTree(childrenIds);
            List<DeviceOrganizationTreeDTO> resultDeviceOrganizationTreeDTO = BeanCopyUtils.copyList(deviceOrganizationTrees, DeviceOrganizationTreeDTO.class);
            // 设备拼接到最下级节点
            resultDeviceOrganizationTreeDTO.forEach(it -> {
                if (resultMap.getOrDefault(it.getId(), Collections.emptyList()) != null) {
                    List<YWHKDeviceEntity> cameraDataEntities = resultMap.getOrDefault(it.getId(), Collections.emptyList());
                    List<DeviceOrganizationTreeDTO> results = new ArrayList<>();
                    cameraDataEntities.forEach(s -> {
                        DeviceOrganizationTreeDTO dto = new DeviceOrganizationTreeDTO();
                        dto.setId(s.getId());
                        dto.setOrganizationName(s.getCameraName());
                        dto.setLeaf(true);
                        dto.setCameraIndexCode(s.getCameraIndexCode());
                        dto.setOrganizationPathName(it.getOrganizationPathName());
                        dto.setStatus(s.getOnLineStatus());
                        dto.setDeviceType(s.getCameraType());
                        results.add(dto);
                    });
                    it.setChildren(results);
                }
            });
            // 递归获取上级节点
            List<DeviceOrganizationTreeDTO> resultData = getParentNode(resultDeviceOrganizationTreeDTO, result);
            // 分组匹配下级节点
            Map<Integer, List<DeviceOrganizationTreeDTO>> deviceOrganizationTreeMap = resultData.stream()
                    .collect(Collectors.groupingBy(DeviceOrganizationTreeDTO::getOrganizationParentId));
            // 获取顶级节点
            List<DeviceOrganizationTreeDTO> map = deviceOrganizationTreeMap.get(queryDTO.getOrganizationParentId());
            result = group(map, deviceOrganizationTreeMap, cameraDataList);
        }
        return result;
    }

    private List<DeviceOrganizationTreeDTO> getParentNode(List<DeviceOrganizationTreeDTO> childrenNode,
                                                          List<DeviceOrganizationTreeDTO> resultDeviceOrganizationTree) {
        // 避免顶级节点和最低级节点递归网上查询时候数据重复
        List<Integer> parentIds = childrenNode.stream().map(DeviceOrganizationTreeDTO::getOrganizationParentId).collect(Collectors.toList());
        List<Integer> distinctIds = childrenNode.stream().map(DeviceOrganizationTreeDTO::getId).collect(Collectors.toList());
        if (CollectionUtils.isNotEmpty(resultDeviceOrganizationTree)) {
            resultDeviceOrganizationTree = resultDeviceOrganizationTree.stream().filter(it -> !distinctIds.contains(it.getId())).collect(Collectors.toList());
        }
        resultDeviceOrganizationTree.addAll(childrenNode);

        List<DeviceOrganizationTree> deviceOrganizationTrees = new ArrayList<>();
        if (CollectionUtils.isNotEmpty(parentIds)) {
            deviceOrganizationTrees = deviceOrganizationDao.selectPowerOrganizationTree(parentIds);
        }
        if (CollectionUtils.isNotEmpty(deviceOrganizationTrees)) {
            List<DeviceOrganizationTreeDTO> resultDeviceOrganizationTreeDTO = BeanCopyUtils.copyList(deviceOrganizationTrees, DeviceOrganizationTreeDTO.class);
            resultDeviceOrganizationTree = getParentNode(resultDeviceOrganizationTreeDTO, resultDeviceOrganizationTree);
        }
        return resultDeviceOrganizationTree;
    }

    /**
     * 设备分组数据子节点赋值
     *
     * @param deviceOrganizationTreeList // 上级节点
     * @param deviceOrganizationTreeMap  // 设备数据递归分组
     * @param cameraDataList             // 当前用户组所有设备
     * @return
     */
    private List<DeviceOrganizationTreeDTO> group(List<DeviceOrganizationTreeDTO> deviceOrganizationTreeList,
                                                  Map<Integer, List<DeviceOrganizationTreeDTO>> deviceOrganizationTreeMap,
                                                  List<YWHKDeviceEntity> cameraDataList) {
        List<Integer> cameraDataIdList = cameraDataList.stream().map(YWHKDeviceEntity::getId).collect(Collectors.toList());
        deviceOrganizationTreeList.forEach(it -> {
            List<Integer> resultIds = new ArrayList<>();
            resultIds.add(it.getId());
            // 当前节点下设备【在、离线】数量
            CameraDataCountRespDTO countDTO = countDev(resultIds, cameraDataIdList);
            it.setOrganizationName(it.getOrganizationName() + "【" + countDTO.getOnLine() + "/" + countDTO.getSumOnLine() + "】");
            if (deviceOrganizationTreeMap.get(it.getId()) != null) {
                it.setChildren(deviceOrganizationTreeMap.get(it.getId()));
                group(deviceOrganizationTreeMap.get(it.getId()), deviceOrganizationTreeMap, cameraDataList);
            }
        });
        return deviceOrganizationTreeList;
    }


    /**
     * 用户组权限下级设备总数
     *
     * @param ids
     * @return
     */
    private CameraDataCountRespDTO countDev(List<Integer> ids, List<Integer> cameraDataIdList) {
        List<Integer> resultIds = getIds(ids, new ArrayList<>());
        List<YWHKDeviceEntity> cameraDataEntities = ywhkDeviceDao.selectByOrganizationId(resultIds);
        List<YWHKDeviceEntity> filterCameraData = cameraDataEntities.stream()
                .filter(it -> cameraDataIdList.contains(it.getId()))
                .collect(Collectors.toList());
        // 统计在线数量
        List<YWHKDeviceEntity> onLineCameraData = filterCameraData.stream()
                .filter(it -> it.getOnLineStatus().equals(DevIsOnLineEnum.IS)).collect(Collectors.toList());
        CameraDataCountRespDTO countDTO = new CameraDataCountRespDTO();
        countDTO.setOnLine(onLineCameraData.size());
        countDTO.setSumOnLine(filterCameraData.size());
        return countDTO;
    }

    /**
     * VMYL03页面弹框内树
     *
     * @param queryDTO
     * @return
     */
    @Override
    public List<DeviceOrganizationTreeDTO> getOrganizationEquipmentAllTree(DeviceOrganizationQueryDTO queryDTO) {
        // 获取所有组织
        List<DeviceOrganizationEntity> deviceOrganizationTreeAllList = deviceOrganizationDao.selectAll();
        List<DeviceOrganizationTreeDTO> deviceOrganizationResp =
                BeanCopyUtils.copyList(deviceOrganizationTreeAllList, DeviceOrganizationTreeDTO.class);
        Map<Integer, List<DeviceOrganizationTreeDTO>> resultMap = deviceOrganizationResp.stream()
                .collect(Collectors.groupingBy(DeviceOrganizationTreeDTO::getOrganizationParentId));
        // 获取所有设备
        List<YWHKDeviceEntity> cameraDataList = ywhkDeviceDao.selectCameraDataAll();
        List<DeviceOrganizationTreeDTO> deviceOrganizationTreeList =
                resultMap.getOrDefault(queryDTO.getOrganizationParentId(), Collections.emptyList());
        recursiveNode(deviceOrganizationTreeList, resultMap, cameraDataList);
        return deviceOrganizationTreeList;
    }

    /**
     * 递归获取下级节点
     *
     * @param deviceOrganizationTreeList 上级节点集合
     * @param map                        所有节点分组
     * @param cameraDataList             所有设备
     * @return
     */
    private List<DeviceOrganizationTreeDTO> recursiveNode(List<DeviceOrganizationTreeDTO> deviceOrganizationTreeList,
                                                          Map<Integer, List<DeviceOrganizationTreeDTO>> map, List<YWHKDeviceEntity> cameraDataList) {
        List<Integer> cameraDataIdList = cameraDataList.stream().map(YWHKDeviceEntity::getId).collect(Collectors.toList());
        deviceOrganizationTreeList.forEach(it -> {
            List<Integer> ids = new ArrayList<>();
            ids.add(it.getId());
            CameraDataCountRespDTO countDTO = queryCameraDataCount(ids, cameraDataIdList); // 下级设备总数
            it.setOrganizationName(it.getOrganizationName() + "【" + countDTO.getOnLine() + "/" + countDTO.getSumOnLine() + "】");
            List<DeviceOrganizationTreeDTO> deviceOrganizationTrees = map.getOrDefault(it.getId(), Collections.emptyList());
            if (CollectionUtils.isNotEmpty(deviceOrganizationTrees)) {
                it.setChildren(deviceOrganizationTrees);
                recursiveNode(deviceOrganizationTrees, map, cameraDataList);
            } else {
                List<DeviceOrganizationTreeDTO> result = new ArrayList<>();
                List<YWHKDeviceEntity> cameraDataEntities = ywhkDeviceDao.selectByOrganizationId(ids);
                List<YWHKDeviceEntity> filter = cameraDataEntities.stream()
                        .filter(item -> cameraDataIdList.contains(item.getId())).collect(Collectors.toList());
                filter.forEach(item -> {
                    DeviceOrganizationTreeDTO dto = new DeviceOrganizationTreeDTO();
                    dto.setId(item.getId());
                    dto.setCameraIndexCode(item.getCameraIndexCode());
                    dto.setOrganizationName(item.getCameraName());
                    dto.setLeaf(true);
                    dto.setDeviceType(item.getCameraType());
                    dto.setOrganizationPathName(it.getOrganizationPathName());
                    result.add(dto);
                });
                it.setChildren(result);
            }
        });
        return deviceOrganizationTreeList;
    }

    /**
     * 组织设备树组件，统计设备总数、在线数量
     *
     * @param ids
     * @param cameraDataIdList
     * @return
     */
    @Override
    public CameraDataCountRespDTO queryCameraDataCount(List<Integer> ids, List<Integer> cameraDataIdList) {
        // 当前节点下所有节点id
        List<Integer> resultIds = getIds(ids, new ArrayList<>());
        // 当前节点下所有设备
        List<YWHKDeviceEntity> cameraDataEntities = ywhkDeviceDao.selectByOrganizationId(resultIds);
        List<YWHKDeviceEntity> filterCameraData = cameraDataEntities.stream()
                .filter(it -> cameraDataIdList.contains(it.getId()))
                .collect(Collectors.toList());
        // 统计在线数量
        List<YWHKDeviceEntity> onLineCameraData = filterCameraData.stream()
                .filter(it -> it.getOnLineStatus() == DevIsOnLineEnum.IS).collect(Collectors.toList());
        CameraDataCountRespDTO countDTO = new CameraDataCountRespDTO();
        countDTO.setOnLine(onLineCameraData.size());
        countDTO.setSumOnLine(filterCameraData.size());
        return countDTO;
    }

    /**
     * VMYL03: 视频轮询 统计设备总数、在线数量
     *
     * @param ids
     * @return
     */
    @Override
    public CameraDataCountRespDTO queryCameraDataSumNum(List<Integer> ids) {
        // 当前节点下所有节点id
        List<Integer> resultIds = getIds(ids, new ArrayList<>());
        // 当前节点下所有设备
        List<YWHKDeviceEntity> cameraDataEntities = ywhkDeviceDao.selectByOrganizationId(resultIds);
        // 统计在线数量
        List<YWHKDeviceEntity> onLineCameraData = cameraDataEntities.stream()
                .filter(it -> it.getOnLineStatus() == DevIsOnLineEnum.IS).collect(Collectors.toList());
        CameraDataCountRespDTO countDTO = new CameraDataCountRespDTO();
        countDTO.setOnLine(onLineCameraData.size());
        countDTO.setSumOnLine(cameraDataEntities.size());
        return countDTO;
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
     * 新增组织机构
     *
     * @param reqDTO
     * @return
     */
    @Override
    public boolean save(DeviceOrganizationReqDTO reqDTO) {
        DeviceOrganizationEntity deviceOrganizationEntity = new DeviceOrganizationEntity();
        BeanUtils.copyProperties(reqDTO, deviceOrganizationEntity);
        deviceOrganizationEntity.setDataType(DeviceOrganizationTypeEnum.ACTIVITY_LINE);
        deviceOrganizationEntity.setCreateTime(new Date());
        deviceOrganizationDao.insert(deviceOrganizationEntity);
        return true;
    }

    /**
     * 编辑组织机构
     *
     * @param reqDTO
     */
    @Override
    public boolean update(DeviceOrganizationReqDTO reqDTO) {
        DeviceOrganizationEntity deviceOrganizationEntity = new DeviceOrganizationEntity();
        BeanUtils.copyProperties(reqDTO, deviceOrganizationEntity);
        deviceOrganizationDao.updateByPrimaryKeySelective(deviceOrganizationEntity);
        return true;
    }

    /**
     * 删除
     *
     * @param deleteDTO
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void deleteBatch(DeleteDTO deleteDTO) {
        deviceOrganizationDao.deleteBatch(deleteDTO.getIdList());
        List<DeviceOrganizationEntity> deviceOrganizationList = deviceOrganizationDao.selectChildrenNode(deleteDTO.getIdList());
        // 递归删除子节点
        if (CollectionUtils.isNotEmpty(deviceOrganizationList)) {
            List<Integer> idArrayList = deviceOrganizationList.stream().map(DeviceOrganizationEntity::getId)
                    .collect(Collectors.toList());
            DeleteDTO delete = new DeleteDTO();
            delete.setIdList(idArrayList);
            deleteBatch(delete);
        }
    }

    @Override
    public void delete(String ids) {

    }

}
