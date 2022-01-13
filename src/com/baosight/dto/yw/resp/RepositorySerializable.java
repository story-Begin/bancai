package com.baosight.dto.yw.resp;

import lombok.Data;
import java.io.Serializable;

/**
 * @ClassName RepositorySerializable
 * @Description TODO
 * @Autgor huang
 * @Date 2020-11-17 09:03
 */
@Data
public class RepositorySerializable implements Serializable {
    private static final long serialVersionUID = -3892341575701147958L;

    private Integer pageSize;

    private Object data;

    private Integer currentPage;

    private Boolean success;

}
