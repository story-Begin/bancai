package com.baosight.dto.platform.resp;

import lombok.Data;

@Data
public class ZTreeDTO {
    private String id;

    private String name;

    private String icon;

    private String pId;

    private String type;

    private String isParent;

    private boolean checked;

    private boolean halfCheck;

    private int sort;
}