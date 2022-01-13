package com.baosight.base.page;

/**
 * @ClassName Page
 * @Description TODO
 * @Autgor huang
 * @Date 2020-07-07 18:31
 */
public class Page {
    private int pageNo = 1;
    private int pageSize = 10;

    public Page() {
    }

    public int getPageNo() {
        return this.pageNo;
    }

    public int getPageSize() {
        return this.pageSize;
    }

    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }


    @Override
    public boolean equals(Object o) {
        if (o == this) {
            return true;
        } else if (!(o instanceof Page)) {
            return false;
        } else {
            Page other = (Page) o;
            if (!other.canEqual(this)) {
                return false;
            } else if (this.getPageNo() != other.getPageNo()) {
                return false;
            } else {
                return this.getPageSize() == other.getPageSize();
            }
        }
    }

    protected boolean canEqual(Object other) {
        return other instanceof Page;
    }


    @Override
    public int hashCode() {
        int result = 1;
        result = result * 59 + this.getPageNo();
        result = result * 59 + this.getPageSize();
        return result;
    }


    @Override
    public String toString() {
        return "Page(pageNo=" + this.getPageNo() + ", pageSize=" + this.getPageSize() + ")";
    }
}
