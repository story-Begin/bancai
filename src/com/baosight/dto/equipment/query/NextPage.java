package com.baosight.dto.equipment.query;

import lombok.Data;

import java.io.Serializable;

/**
 * @ClassName NextPage
 * @Description TODO
 * @Autgor huang
 * @Date 2020-11-02 17:23
 */
@Data
public class NextPage implements Serializable {
    private static final long serialVersionUID = -2970233718239785843L;

    private String id;

    private String name;

    private String nodeNo;
}
