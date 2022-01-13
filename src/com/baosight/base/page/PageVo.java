package com.baosight.base.page;

/**
 * @ClassName PageVo
 * @Description TODO
 * @Autgor huang
 * @Date 2020-07-07 18:31
 */

import java.io.Serializable;
import java.util.List;

public class PageVo<T> implements Serializable {
    private static final long serialVersionUID = 4513304518842188605L;

    private final int pageSize;
    private final int pageNo;
    private final long totalCount;
    private final List<T> dataList;

    public PageVo() {
        this.pageSize = 0;
        this.pageNo = 0;
        this.totalCount = 0L;
        this.dataList = null;
    }

    private PageVo(Builder<T> builder) {
        this.pageSize = builder.pageSize;
        this.pageNo = builder.pageNo;
        this.totalCount = builder.totalCount;
        this.dataList = builder.dataList;
    }

    public int getPageSize() {
        return this.pageSize;
    }

    public int getPageNo() {
        return this.pageNo;
    }

    public long getTotalCount() {
        return this.totalCount;
    }

    public List<T> getDataList() {
        return this.dataList;
    }

    public static class Builder<T> {
        private int pageSize;
        private int pageNo;
        private long totalCount;
        private List<T> dataList;

        public Builder() {
        }

        public Builder<T> pageSize(int pageSize) {
            this.pageSize = pageSize;
            return this;
        }

        public Builder<T> pageNo(int pageNo) {
            this.pageNo = pageNo;
            return this;
        }

        public Builder<T> totalCount(long totalCount) {
            this.totalCount = totalCount;
            return this;
        }

        public Builder<T> dataList(List<T> dataList) {
            this.dataList = dataList;
            return this;
        }

        public PageVo<T> build() {
            return new PageVo(this);
        }
    }
}
