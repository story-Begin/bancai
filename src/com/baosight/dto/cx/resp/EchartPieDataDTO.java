package com.baosight.dto.cx.resp;


import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;

@AllArgsConstructor
@Data
public class EchartPieDataDTO {

    /**
     * 报警数量
     */
    private Integer value;

    /**
     * 报警名称
     */
    private String name;

}
