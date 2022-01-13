package com.baosight.dto.alarminfo.query;

import com.baosight.base.page.Page;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AlarmInfoQueryDTO  extends Page {
    private Integer id;
    private String alarmSource;
    private String alarmType;
}
