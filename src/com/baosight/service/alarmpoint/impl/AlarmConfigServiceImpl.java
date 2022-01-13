package com.baosight.service.alarmpoint.impl;

import com.baosight.base.page.PageVo;
import com.baosight.base.page.PageVoUtils;
import com.baosight.dto.alarminfo.query.AlarmConfigQueryDTO;
import com.baosight.entity.alarmpoint.AlarmConfig;
import com.baosight.mapper.alarmpoint.AlarmConfigMapper;
import com.baosight.service.alarmpoint.AlarmConfigService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AlarmConfigServiceImpl implements AlarmConfigService {

    @Autowired
    private AlarmConfigMapper configMapper;

    @Override
    public boolean save(AlarmConfig record) {
        return configMapper.insert(record)>0;
    }

    @Override
    public boolean update(AlarmConfig record) {
         configMapper.updateById(record);
        return true;
    }

    @Override
    public void delete(String ids) {

        configMapper.deleteById(ids);

    }

    @Override
    public PageVo getList(AlarmConfigQueryDTO queryDTO) {
        PageHelper.startPage(queryDTO.getPageNo(),queryDTO.getPageSize());

        return PageVoUtils.pageFromMybatis(new PageInfo<>(configMapper.getList(queryDTO)));
    }
}
