package com.baosight.base.service;

import com.baosight.base.baseService.BaseService;
import com.baosight.base.entity.SysLog;
import com.baosight.base.page.PageVo;
import com.baosight.dto.log.query.SysLogQueryDTO;

public interface SystemLogService extends BaseService<SysLog> {

    PageVo findPageList();

    PageVo findPageList(SysLogQueryDTO dto);
}
