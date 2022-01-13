package com.baosight.service.alarmpoint;

import com.baosight.base.baseService.BaseService;
import com.baosight.base.page.PageVo;
import com.baosight.dto.alarminfo.query.AlarmInfoQueryDTO;
import com.baosight.entity.alarmpoint.AlarmInfo;

import java.util.List;

public interface AlarmInfoService extends BaseService<AlarmInfo> {

    PageVo getList(AlarmInfoQueryDTO queryDTO);

}
