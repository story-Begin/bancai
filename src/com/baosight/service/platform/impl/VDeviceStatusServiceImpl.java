package com.baosight.service.platform.impl;

import com.baosight.entity.platform.VDeviceStatus;
import com.baosight.mapper.platform.VDeviceStatusDao;
import com.baosight.service.platform.VDeviceStatusService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class VDeviceStatusServiceImpl implements VDeviceStatusService {

    @Autowired
    private VDeviceStatusDao vDeviceStatusDao;


    @Override
    public boolean save(VDeviceStatus record) {
        return false;
    }

    @Override
    public boolean update(VDeviceStatus record) {
        return false;
    }

    @Override
    public void delete(String ids) {
        for(String id : ids.split(",")){
            vDeviceStatusDao.deleteByPrimaryKey(id);
        }
    }

}
