package com.baosight.service.pz;

import com.baosight.base.page.PageVo;
import com.baosight.dto.equipment.query.UserGroupDTO;
import com.baosight.dto.equipment.req.UserGroupDeviceDTO;
import com.baosight.dto.pz.query.UserGroupDeviceQueryDTO;


public interface UserGroupDeviceService {

    PageVo findPageList(UserGroupDTO queryDTO);

    PageVo getDeviceList(UserGroupDTO queryDTO);

    boolean save(UserGroupDeviceDTO userGroupDeviceDTO);

    boolean delete(String idList);

}
