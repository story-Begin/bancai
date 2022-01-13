package com.baosight.dto.pz.query;


import com.baosight.base.page.Page;
import lombok.Data;

import java.io.Serializable;

@Data
public class UserGroupDeviceQueryDTO  extends Page implements Serializable{

    /**
     * 搜索条件
     */
    private String queryContent;
}
