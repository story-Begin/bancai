package com.baosight.dto.equipment.query;

import lombok.Data;

import java.io.Serializable;

/**
 * @ClassName JsonParam
 * @Description TODO
 * @Autgor huang
 * @Date 2020-11-02 17:43
 */
@Data
public class JsonParam implements Serializable {
    private static final long serialVersionUID = 1942041567858229210L;

    //    Pagination pagination = new Pagination();
    Param param = new Param();
}


