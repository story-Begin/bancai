package com.baosight.base.page;

import com.github.pagehelper.PageInfo;
import com.baosight.base.page.PageVo;
import com.baosight.base.page.BeanCopyUtils;

/**
 * @ClassName PageVoUtils
 * @Description TODO
 * @Autgor huang
 * @Date 2020-07-07 19:17
 */
public class PageVoUtils {
    public PageVoUtils() {
    }

    public static <T> PageVo<T> pageFromMybatis(PageInfo<T> pageInfo) {
        if (pageInfo != null) {
            PageVo<T> pageVo = (new PageVo.Builder()).totalCount(pageInfo.getTotal())
                    .pageNo(pageInfo.getPageNum())
                    .pageSize(pageInfo.getPageSize())
                    .dataList(pageInfo.getList()).build();
            return pageVo;
        } else {
            return (new PageVo.Builder()).build();
        }
    }

    public static <T, B> PageVo<B> pageFromMybatis(PageInfo<T> pageInfo, Class<B> clazz) {
        if (pageInfo != null) {
            PageVo<B> pageVo = (new PageVo.Builder()).totalCount(pageInfo.getTotal())
                    .pageNo(pageInfo.getPageNum())
                    .pageSize(pageInfo.getPageSize())
                    .dataList(BeanCopyUtils.copyList(pageInfo.getList(), clazz))
                    .build();
            return pageVo;
        } else {
            return (new PageVo.Builder()).build();
        }
    }
}
