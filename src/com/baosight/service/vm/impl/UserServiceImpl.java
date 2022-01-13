package com.baosight.service.vm.impl;

import com.baosight.base.page.PageVo;
import com.baosight.base.page.PageVoUtils;
import com.baosight.dto.vm.query.UserQueryDTO;
import com.baosight.dto.vm.req.UserReqDTO;
import com.baosight.dto.vm.resp.DevicePollRespDTO;
import com.baosight.dto.vm.resp.UserRespDTO;
import com.baosight.entity.vm.UserEntity;
import com.baosight.mapper.vm.UserDao;
import com.baosight.service.vm.UserService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @ClassName
 * @Description
 * @Author XSD
 * @Date 2020/9/8 13:48
 */
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    /**
     * 系统用户分页列表
     *
     * @param queryDTO
     * @return
     */
    @Override
    public PageVo findPageList(UserQueryDTO queryDTO) {
        PageHelper.startPage(queryDTO.getPageNo(), queryDTO.getPageSize());
        List<UserEntity> userEntities = userDao.selectUserList(queryDTO);
        return PageVoUtils.pageFromMybatis(new PageInfo<>(userEntities), UserRespDTO.class);
    }

    @Override
    public boolean save(UserReqDTO record) {
        return false;
    }

    @Override
    public boolean update(UserReqDTO record) {
        return false;
    }

    @Override
    public void delete(String ids) {

    }
}
