package com.baosight.service.vm;

import com.baosight.base.baseService.BaseService;
import com.baosight.base.page.PageVo;
import com.baosight.dto.vm.query.UserQueryDTO;
import com.baosight.dto.vm.req.UserReqDTO;

/**
 * @ClassName UserService
 * @Description DOTO
 * @Author xu
 * @Date 2020/9/8 13:46
 */
public interface UserService extends BaseService<UserReqDTO> {

    /**
     * 轮询配置分页列表
     *
     * @param queryDTO
     * @return
     */
    PageVo findPageList(UserQueryDTO queryDTO);
}
