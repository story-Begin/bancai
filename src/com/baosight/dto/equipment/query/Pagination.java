package com.baosight.dto.equipment.query;

import lombok.Data;

import java.io.Serializable;

/**
 * @ClassName Pagination
 * @Description TODO
 * @Autgor huang
 * @Date 2020-11-02 17:46
 */
@Data
public class Pagination implements Serializable {
    private static final long serialVersionUID = -1576423095403890557L;

    Integer currentPage = 1;

    Integer pageSize = 10;
}
