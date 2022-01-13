package com.baosight.base.utils;

import com.baosight.dto.yw.resp.RepositorySerializable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;

import java.util.List;

/**
 * @ClassName RestTemplateUtils
 * @Description TODO
 * @Autgor huang
 * @Date 2020-11-18 08:48
 */
public class RestTemplateUtils {

    /**
     *
     * @param url 请求地址
     * @param request 请求参数
     * @param <T> 返回类型
     * @return
     */
    public static <T> List<T> restTemplateApi(String url, Object request) {
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<RepositorySerializable> repositorySerializableResponse =
                restTemplate.postForEntity(url, request, RepositorySerializable.class);
        RepositorySerializable repositorySerializable = repositorySerializableResponse.getBody();
        List<T> resultList = (List<T>) repositorySerializable.getData();
        return resultList;
    }
}
