package com.baosight.service.alarmpoint;

import com.baosight.base.baseService.BaseService;
import com.baosight.base.page.PageVo;
import com.baosight.dto.alarminfo.query.AlarmConfigQueryDTO;
import com.baosight.entity.alarmpoint.AlarmConfig;

public interface AlarmConfigService extends BaseService<AlarmConfig> {
    PageVo getList(AlarmConfigQueryDTO queryDTO);
}
