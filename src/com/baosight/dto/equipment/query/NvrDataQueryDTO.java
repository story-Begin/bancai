package com.baosight.dto.equipment.query;

import com.baosight.base.page.Page;
import lombok.Data;

import java.io.Serializable;

/**
 * 录像机
 *
 * @ClassName NvrDataQuery
 * @Description DOTO
 * @Author xu
 * @Date 2020/7/14 16:18
 */
@Data
public class NvrDataQueryDTO extends Page implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * id
     */
    private Integer id;

    /**
     * 录像机名称
     */
    private String nvrName;

}
