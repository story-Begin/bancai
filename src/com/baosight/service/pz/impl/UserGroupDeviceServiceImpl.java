package com.baosight.service.pz.impl;

import com.baosight.base.page.PageVo;
import com.baosight.base.page.PageVoUtils;
import com.baosight.dto.equipment.query.UserGroupDTO;
import com.baosight.dto.equipment.req.UserGroupDeviceDTO;
import com.baosight.dto.equipment.resp.YWHKDeviceRespDTO;
import com.baosight.entity.equipment.UserGroupEntity;
import com.baosight.entity.equipment.YWHKDeviceEntity;
import com.baosight.entity.pz.UserGroupDeviceEntity;
import com.baosight.mapper.equipment.YWHKDeviceDao;
import com.baosight.mapper.pz.UserGroupDao;
import com.baosight.service.pz.UserGroupDeviceService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import net.sf.json.JSONObject;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class UserGroupDeviceServiceImpl implements UserGroupDeviceService {

    @Autowired
    private UserGroupDao userGroupDao;
    @Autowired
    private YWHKDeviceDao ywhkDeviceDao;

    /**
     * 用户组设备：用户组列表
     *
     * @param queryDTO
     * @return
     */
    @Override
    public PageVo findPageList(UserGroupDTO queryDTO) {
        PageHelper.startPage(queryDTO.getPageNo(), queryDTO.getPageSize());
        List<UserGroupEntity> userGroupEntities = userGroupDao.findPageList(queryDTO);
        return PageVoUtils.pageFromMybatis(new PageInfo<>(userGroupEntities), UserGroupDTO.class);
    }

    /**
     * 设备分页列表
     *
     * @param queryDTO
     * @return
     */
    @Override
    public PageVo getDeviceList(UserGroupDTO queryDTO) {
        PageHelper.startPage(queryDTO.getPageNo(), queryDTO.getPageSize());
        List<YWHKDeviceEntity> ywhkDeviceEntities = ywhkDeviceDao.getDeviceList(queryDTO);
        return PageVoUtils.pageFromMybatis(new PageInfo<>(ywhkDeviceEntities), YWHKDeviceRespDTO.class);
    }

    /**
     * 批量添加
     *
     * @param userGroupDeviceDTO
     * @return
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public boolean save(UserGroupDeviceDTO userGroupDeviceDTO) {
        // 校验是否存在
        List<UserGroupDeviceEntity> userGroupDeviceEntities = userGroupDao.selectByGroupId(userGroupDeviceDTO);
        List<Integer> ids = userGroupDeviceEntities.stream().map(UserGroupDeviceEntity::getDeviceId).collect(Collectors.toList());
        if (CollectionUtils.isNotEmpty(userGroupDeviceEntities)) {
            List<Integer> groupIdList = userGroupDeviceDTO.getDeviceId().stream()
                    .filter(it -> !ids.contains(it)).collect(Collectors.toList());
            userGroupDeviceDTO.setDeviceId(groupIdList);
            if (CollectionUtils.isEmpty(groupIdList)) {
                return true;
            }
        }
        // 新增
        ArrayList<UserGroupDeviceEntity> list = new ArrayList<>();
        String userGroupId = userGroupDeviceDTO.getUsergroupId();
        for (Integer id : userGroupDeviceDTO.getDeviceId()) {
            UserGroupDeviceEntity item = new UserGroupDeviceEntity();
            item.setUserGroupId(userGroupId);
            item.setDeviceId(id);
            list.add(item);
        }
        userGroupDao.save(list);
        return true;
    }

    /**
     * 批量删除
     *
     * @param idList
     * @return
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public boolean delete(String idList) {
        JSONObject json = JSONObject.fromObject(idList);
        String idStr = (String) json.get("ids");
        List<Integer> ids = Arrays.asList(idStr.split(","))
                .stream().map(Integer::valueOf).collect(Collectors.toList());
        userGroupDao.deleteDevice(ids);
        return true;
    }

}
