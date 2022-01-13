package com.baosight.service.platform;

import com.baosight.base.baseService.BaseService;
import com.baosight.base.page.PageVo;
import com.baosight.dto.platform.query.DHCameraBrutQueryDTO;
import com.baosight.dto.platform.req.DHCameraBrutReqDTO;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 原始数据表
 * @author yangyulong
 */
public interface DHCameraBrutService extends BaseService<DHCameraBrutReqDTO> {

    /**
     * 返回前端信息
     */
    PageVo findPageList(DHCameraBrutQueryDTO queryDTO, String userId);

    /**
     * 获取目前数据库内所有设备的数据库ID
     * @return
     */
    List<Integer> findAllId();
}
