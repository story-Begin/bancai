package com.baosight.service.equipment;

import com.baosight.base.baseService.BaseService;
import com.baosight.base.page.PageVo;
import com.baosight.dto.equipment.query.NvrDataQueryDTO;
import com.baosight.dto.equipment.req.NvrDataReqDTO;

/**
 * 录像机信息
 *
 * @ClassName
 * @Description
 * @Author XSD
 * @Date 2020/7/14 16:28
 */
public interface NvrDataService extends BaseService<NvrDataReqDTO> {

    /**
     * 设备信息列表
     *
     * @param queryDTO
     * @return
     */
    PageVo findPageList(NvrDataQueryDTO queryDTO);

}
