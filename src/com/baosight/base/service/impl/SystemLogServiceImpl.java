package com.baosight.base.service.impl;

import com.baosight.base.entity.SysLog;
import com.baosight.base.page.PageVo;
import com.baosight.base.page.PageVoUtils;
import com.baosight.base.service.SystemLogService;
import com.baosight.dto.log.query.SysLogQueryDTO;
import com.baosight.mapper.log.SysLogMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * @ClassName SystemLogServiceImpl
 * @Description TODO
 * @Autgor huang
 * @Date 2020-08-25 16:55
 */
@Service
public class SystemLogServiceImpl implements SystemLogService {

    @Autowired
    private SysLogMapper systemLogMapper;

    /**
     * 日志数据列表
     *
     * @return
     */
    @Override
    public PageVo findPageList(SysLogQueryDTO dto) {
        PageHelper.startPage(dto.getPageNo(), dto.getPageSize());

        //如果时间
        if (dto.getCreateStartTime() == null && dto.getCreateEndTime() != null){
            dto.setCreateStartTime(new Date(0L));
        }
        if (dto.getCreateStartTime() != null && dto.getCreateEndTime() == null){
            dto.setCreateEndTime(new Date());
        }

        List<SysLog> sysLogs = systemLogMapper.selectPageList(dto);

        return PageVoUtils.pageFromMybatis(new PageInfo<SysLog>(sysLogs), SysLog.class);
    }

    @Override
    public PageVo findPageList() {
        return null;
    }

    /**
     * 新增日志
     *
     * @param record
     * @return
     */
    @Override
    public boolean save(SysLog record) {
        systemLogMapper.insertSelective(record);
        return true;
    }

    @Override
    public boolean update(SysLog record) {
        return false;
    }

    @Override
    public void delete(String ids) {

    }

}
