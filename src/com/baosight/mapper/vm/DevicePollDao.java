package com.baosight.mapper.vm;

import com.baosight.base.baseMapper.BaseMapper;
import com.baosight.dto.vm.query.DevicePollQueryDTO;
import com.baosight.dto.vm.req.DevicePollReqDTO;
import com.baosight.entity.vm.DevicePollEntity;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * @ClassName DevicePollDao
 * @Description TODO
 * @Autgor huang
 * @Date 2020-07-13 10:21
 */
@Mapper
public interface DevicePollDao extends BaseMapper<DevicePollEntity> {

    /**
     * 轮询配置列表
     *
     * @param queryDTO
     * @return
     */
    List<DevicePollEntity> selectDevicePollList(DevicePollQueryDTO queryDTO);


    /**
     * 轮询配置名称
     *
     * @return
     */
    List<DevicePollReqDTO> selectDevicePollNameList();

}
