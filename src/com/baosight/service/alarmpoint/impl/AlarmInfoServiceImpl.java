package com.baosight.service.alarmpoint.impl;

import com.baosight.base.page.PageVo;
import com.baosight.base.page.PageVoUtils;
import com.baosight.dto.alarminfo.query.AlarmInfoQueryDTO;
import com.baosight.entity.alarmpoint.AlarmInfo;
import com.baosight.mapper.alarmpoint.AlarmInfoMapper;
import com.baosight.service.alarmpoint.AlarmInfoService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AlarmInfoServiceImpl implements AlarmInfoService {

    @Autowired
    private AlarmInfoMapper mapper;

    @Override
    public boolean save(AlarmInfo record) {
        int insert = mapper.insert(record);
        return insert>0;
    }

    @Override
    public boolean update(AlarmInfo record) {
        if(record.getAlarmId()!=null){
            mapper.updateById(record);
        };
        return true;
    }

    @Override
    public void delete(String ids) {
        mapper.deleteById(ids);
    }

    @Override
    public PageVo getList(AlarmInfoQueryDTO queryDTO) {
        PageHelper.startPage(queryDTO.getPageNo(),queryDTO.getPageSize());
        return PageVoUtils.pageFromMybatis(new PageInfo<>(mapper.getList(queryDTO)));
    }
}
