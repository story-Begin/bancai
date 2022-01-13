package com.baosight.service.vm.impl;

import com.baosight.base.aspect.AspectTime;
import com.baosight.dto.vm.req.ThirdpartyOperationReqDTO;
import com.baosight.entity.vm.ThirdpartyOperationEntity;
import com.baosight.mapper.vm.ThirdpartyOperationDao;
import com.baosight.service.vm.ThirdpartyOperationService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @ClassName ThirdpartyOperationServiceImpl
 * @Description TODO
 * @Author xu
 * @Date 2020/8/24 15:21
 */
@Service
public class ThirdpartyOperationServiceImpl implements ThirdpartyOperationService {

    @Autowired
    private ThirdpartyOperationDao thirdpartyOperationDao;

    /**
     * 添加视频日志
     */
    @AspectTime(operation = "create")
    @Override
    public boolean save(ThirdpartyOperationReqDTO reqDTO) {
        ThirdpartyOperationEntity operationEntity = new ThirdpartyOperationEntity();
        BeanUtils.copyProperties(reqDTO,operationEntity);
        thirdpartyOperationDao.insert(operationEntity);
        return true;
    }

    @Override
    public boolean update(ThirdpartyOperationReqDTO record) {
        return false;
    }

    @Override
    public void delete(String ids) {

    }
}
