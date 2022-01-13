package com.baosight.dto.alarminfo.query;

import com.baosight.base.page.Page;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Column;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AlarmConfigQueryDTO extends Page {


    private String alarmTimeDetail;

    private String alarmTimeMoban;

    private Integer alarmIsOpen;

}
