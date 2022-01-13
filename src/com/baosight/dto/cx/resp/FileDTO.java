package com.baosight.dto.cx.resp;

import lombok.Data;

import java.io.Serializable;

/**
 * @ClassName FileDTO
 * @Description TODO
 * @Autgor admin
 * @Date 2020-10-13 10:11
 */
@Data
public class FileDTO implements Serializable {
    private static final long serialVersionUID = -885093171531387799L;

    private String realPath;


    private String dbName;

}
