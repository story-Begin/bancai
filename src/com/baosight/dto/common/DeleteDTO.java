package com.baosight.dto.common;

import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * @ClassName DeleteDTO
 * @Description TODO
 * @Autgor admin
 * @Date 2020-08-27 10:50
 */
@Data
public class DeleteDTO implements Serializable {
    private static final long serialVersionUID = 7885168599165858048L;

    /**
     * id 集合
     */
    private List<Integer> idList;

    /**
     * 数据表名
     */
    private String tableName;
}
