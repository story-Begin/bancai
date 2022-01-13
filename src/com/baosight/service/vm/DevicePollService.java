package com.baosight.service.vm;

import com.baosight.base.baseService.BaseService;
import com.baosight.base.page.PageVo;
import com.baosight.dto.vm.query.DevicePollQueryDTO;
import com.baosight.dto.vm.req.DevicePollReqDTO;

import java.util.List;

/**
 * @ClassName DevicePollService
 * @Description TODO
 * @Autgor huang
 * @Date 2020-07-13 10:31
 */
public interface DevicePollService extends BaseService<DevicePollReqDTO> {

    /**
     * 轮询配置分页列表
     *
     * @param queryDTO
     * @return
     */
    PageVo findPageList(DevicePollQueryDTO queryDTO);

    /**
     * 查询轮询名称
     * @return
     */
    List<DevicePollReqDTO> findDevicePollNameList();
}
