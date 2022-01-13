package com.baosight.mapper.vm;

import com.baosight.base.baseMapper.BaseMapper;
import com.baosight.dto.vm.query.UserQueryDTO;
import com.baosight.entity.vm.DevicePollEntity;
import com.baosight.entity.vm.UserEntity;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * @ClassName UserDao
 * @Description DOTO
 * @Author xu
 * @Date 2020/9/8 13:36
 */
@Mapper
public interface UserDao extends BaseMapper<UserEntity> {

    /**
     * 系统用户列表
     *
     * @param queryDTO
     * @return
     */
    List<UserEntity> selectUserList(UserQueryDTO queryDTO);

}
