package com.baosight.base.page;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import org.apache.commons.collections4.CollectionUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * @ClassName BeanCopyUtils
 * @Description TODO
 * @Autgor huang
 * @Date 2020-07-07 18:33
 */
public class BeanCopyUtils {
    public BeanCopyUtils() {
    }

    public static <T> List<T> copyList(List list, Class<T> clazz) {
        return (List) (CollectionUtils.isEmpty(list) ? new ArrayList() : JSONArray.parseArray(JSON.toJSONString(list), clazz));
    }
}
