package com.baosight.service.vm.impl;

import com.baosight.base.aspect.AspectTime;
import com.baosight.base.page.BeanCopyUtils;
import com.baosight.base.page.PageVo;
import com.baosight.base.page.PageVoUtils;
import com.baosight.dto.vm.query.DevicePollQueryDTO;
import com.baosight.dto.vm.req.DevicePollReqDTO;
import com.baosight.dto.vm.resp.DevicePollRespDTO;
import com.baosight.entity.vm.DevicePollEntity;
import com.baosight.mapper.vm.DevicePollDao;
import com.baosight.service.vm.DevicePollService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import net.sf.json.JSONObject;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @ClassName DevicePollServiceImpl
 * @Description TODO
 * @Autgor huang
 * @Date 2020-07-13 10:35
 */
@Service
public class DevicePollServiceImpl implements DevicePollService {

    @Autowired
    private DevicePollDao devicePollDao;

    /**
     * 轮询配置分页列表
     *
     * @param queryDTO
     * @return
     */
    @Override
    public PageVo findPageList(DevicePollQueryDTO queryDTO) {
        PageHelper.startPage(queryDTO.getPageNo(), queryDTO.getPageSize());
        List<DevicePollEntity> devicePollEntities = devicePollDao.selectDevicePollList(queryDTO);
        return PageVoUtils.pageFromMybatis(new PageInfo<>(devicePollEntities), DevicePollRespDTO.class);
    }

    /**
     * 查询轮询名称
     * @return
     */
    @Override
    public List<DevicePollReqDTO> findDevicePollNameList() {
        List<DevicePollReqDTO> devicePollReqDTOS = devicePollDao.selectDevicePollNameList();
        return BeanCopyUtils.copyList(devicePollReqDTOS,DevicePollReqDTO.class);
    }

    /**
     * 新增轮询配置
     *
     * @param record
     * @return
     */
    @AspectTime(operation = "create")
    @Override
    public boolean save(DevicePollReqDTO record) {
        DevicePollEntity devicePollEntity = new DevicePollEntity();
        BeanUtils.copyProperties(record, devicePollEntity);
        devicePollDao.insert(devicePollEntity);
        return true;
    }

    /**
     * 修改轮询配置
     *
     * @param record
     * @return
     */
    @Override
    public boolean update(DevicePollReqDTO record) {
        DevicePollEntity devicePollEntity = new DevicePollEntity();
        BeanUtils.copyProperties(record, devicePollEntity);
        devicePollDao.updateByPrimaryKeySelective(devicePollEntity);
        return true;
    }

    /**
     * 批量删除
     *
     * @param ids
     */
    @Transactional
    @Override
    public void delete(String ids) {
        JSONObject json = JSONObject.fromObject(ids);
        String idStr = (String) json.get("ids");
        List<Integer> idList = Arrays.asList(idStr.split(","))
                .stream().map(Integer::valueOf).collect(Collectors.toList());
        idList.forEach(it -> devicePollDao.deleteByPrimaryKey(it));
    }
}
