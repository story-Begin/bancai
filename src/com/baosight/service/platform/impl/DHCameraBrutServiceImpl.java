package com.baosight.service.platform.impl;

import com.baosight.base.page.PageVo;
import com.baosight.base.page.PageVoUtils;
import com.baosight.dto.platform.query.DHCameraBrutQueryDTO;
import com.baosight.dto.platform.req.DHCameraBrutReqDTO;
import com.baosight.entity.platform.DHCameraBrutEntity;
import com.baosight.entity.platform.VThirdpartyOperation;
import com.baosight.mapper.platform.DHCameraBrutDao;
import com.baosight.mapper.platform.VThirdpartyOperationDao;
import com.baosight.service.platform.DHCameraBrutService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class DHCameraBrutServiceImpl implements DHCameraBrutService {
    @Autowired
    private DHCameraBrutDao dhCameraBrutDao;

    @Autowired
    private VThirdpartyOperationDao vThirdpartyOperationDao;

    /**
     * 返回前端信息
     */
    @Override
    public PageVo findPageList(DHCameraBrutQueryDTO queryDTO,String userId) {
        //使用DTO查询数据
        PageHelper.startPage(queryDTO.getPageNo(), queryDTO.getPageSize());
        List<DHCameraBrutEntity> pageList = dhCameraBrutDao.findPageList(queryDTO);
        //写入操作日志
        VThirdpartyOperation vThirdpartyOperation = new VThirdpartyOperation();
        vThirdpartyOperation.setSystemNo(userId);
        vThirdpartyOperation.setSystemName("Test");
        vThirdpartyOperation.setCreateTime(new Date());
        vThirdpartyOperationDao.insert(vThirdpartyOperation);
        //返回
        return PageVoUtils.pageFromMybatis(new PageInfo<>(pageList), DHCameraBrutQueryDTO.class);
    }

    /**
     * 获取目前数据库内所有设备的数据库ID
     * @return
     */
    @Override
    public List<Integer> findAllId() {
        return dhCameraBrutDao.findAllId();
    }

    /**
     * 保存Entity
     *
     * @param reqDTO
     * @return
     */
    @Override
    public boolean save(DHCameraBrutReqDTO reqDTO) {
        DHCameraBrutEntity cameraBrutEntity = new DHCameraBrutEntity();
        BeanUtils.copyProperties(reqDTO, cameraBrutEntity);
        int insert = dhCameraBrutDao.insert(cameraBrutEntity);
        if (insert > 0) {
            return true;
        }
        return false;
    }

    /**
     * 基于ID更新Entity
     *
     * @param reqDTO
     * @return
     */
    @Override
    public boolean update(DHCameraBrutReqDTO reqDTO) {
        DHCameraBrutEntity cameraBrutEntity = new DHCameraBrutEntity();
        BeanUtils.copyProperties(reqDTO, cameraBrutEntity);
        int insert = dhCameraBrutDao.updateByPrimaryKey(cameraBrutEntity);
        if (insert > 0) {
            return true;
        }
        return false;
    }

    /**
     * 删除Entity，此处为物理删除
     *
     * @param ids
     */
    @Override
    public void delete(String ids) {
        ArrayList<Integer> idList = new ArrayList<>();
        for (String id : ids.split(",")) {
            idList.add(Integer.valueOf(id));
        }
        dhCameraBrutDao.deleteBatch(idList);
    }

}
