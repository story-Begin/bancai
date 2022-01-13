package com.baosight.mapper.equipment;

import com.baosight.base.baseMapper.BaseMapper;
import com.baosight.dto.equipment.query.NvrDataQueryDTO;
import com.baosight.entity.equipment.NvrDataEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;


/**
 * @ClassName NvrDataDao
 * @Description
 * @Author xu
 * @Date 2020/7/15 9:12
 */
@Mapper
public interface NvrDataDao extends BaseMapper<NvrDataEntity> {

    /**
     * 设备信息列表
     *
     * @param queryDTO
     * @return
     */
    List<NvrDataEntity> findPageList(NvrDataQueryDTO queryDTO);

    /**
     * 删除
     *
     * @param idList
     */
    void deleteBatch(@Param(value = "idList") List<Integer> idList);


}
