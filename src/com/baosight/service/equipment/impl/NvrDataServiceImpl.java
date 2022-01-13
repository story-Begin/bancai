package com.baosight.service.equipment.impl;

import com.baosight.base.aspect.AspectTime;
import com.baosight.base.page.PageVo;
import com.baosight.base.page.PageVoUtils;
import com.baosight.dto.equipment.query.NvrDataQueryDTO;
import com.baosight.dto.equipment.req.NvrDataReqDTO;
import com.baosight.dto.equipment.resp.NvrDataRespDTO;
import com.baosight.entity.equipment.NvrDataEntity;
import com.baosight.mapper.equipment.NvrDataDao;
import com.baosight.service.equipment.NvrDataService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import net.sf.json.JSONObject;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @ClassName NvrDataServiceImpl
 * @Description
 * @Author xu
 * @Date 2020/7/15 9:15
 */
@Service
public class NvrDataServiceImpl implements NvrDataService {

    @Autowired
    private NvrDataDao nvrDataDao;

    /**
     * 录像机列表
     *
     * @param queryDTO
     * @return
     */
    @Override
    public PageVo findPageList(NvrDataQueryDTO queryDTO) {
        PageHelper.startPage(queryDTO.getPageNo(), queryDTO.getPageSize());
        List<NvrDataEntity> nvrDataEntities = nvrDataDao.findPageList(queryDTO);
        return PageVoUtils.pageFromMybatis(new PageInfo<>(nvrDataEntities), NvrDataRespDTO.class);
    }

    /**
     * 添加录像机
     *
     * @param reqDTO
     * @return
     */
    @AspectTime(operation = "create")
    @Override
    public boolean save(NvrDataReqDTO reqDTO) {
        NvrDataEntity nvrDataEntity = new NvrDataEntity();
        BeanUtils.copyProperties(reqDTO, nvrDataEntity);
        nvrDataDao.insert(nvrDataEntity);
        return true;
    }

    /**
     * 修改录像机
     *
     * @param reqDTO
     * @return
     */
    @Override
    public boolean update(NvrDataReqDTO reqDTO) {
        NvrDataEntity nvrDataEntity = new NvrDataEntity();
        BeanUtils.copyProperties(reqDTO, nvrDataEntity);
        nvrDataDao.updateByPrimaryKeySelective(nvrDataEntity);
        return false;
    }

    /**
     * 删除录像机
     *
     * @param ids
     * @return
     */
    @Override
    public void delete(String ids) {
        JSONObject jsonObject = JSONObject.fromObject(ids);
        String idStr = (String) jsonObject.get("ids");
        List<Integer> idList = Arrays.asList(idStr.split(","))
                .stream().map(Integer::valueOf).collect(Collectors.toList());
        nvrDataDao.deleteBatch(idList);
    }
}
