package com.baosight.base.entity;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.io.Serializable;
import java.util.Date;

/**
 * @ClassName BaseEntity
 * @Description TODO
 * @Autgor huang
 * @Date 2020-07-13 09:25
 */
@Data
public class BaseEntity implements Serializable {
    private static final long serialVersionUID = -596789541000517677L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "create_time")
    private Date createTime;

    /**
     * 备注
     */
    @Column(name = "remark")
    private String remark;

    /**
     * 预留1
     */
    @Column(name = "remark2")
    private String remark2;

    /**
     * 预留2
     */
    @Column(name = "remark3")
    private String remark3;

    /**
     * 预留3
     */
    @Column(name = "remark4")
    private String remark4;

}
