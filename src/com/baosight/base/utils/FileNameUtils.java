package com.baosight.base.utils;

import java.util.UUID;

/**
 * @ClassName FileNameUtils
 * @Description TODO
 * @Autgor huang
 * @Date 2020-09-11 09:26
 */

public class FileNameUtils {

    /**
     * 获取文件后缀
     *
     * @param fileName
     * @return
     */
    public static String getSuffix(String fileName) {
        return fileName.substring(fileName.lastIndexOf("."));
    }

    /**
     * 生成新的文件名
     *
     * @param fileOriginName 源文件名
     * @return
     */
    public static String getFileName(String fileOriginName) {
        return getUUID() + FileNameUtils.getSuffix(fileOriginName);
    }

    /**
     * 生成UUID
     *
     * @return
     */
    public static String getUUID() {
        return UUID.randomUUID().toString().replace("-", "");
    }

}
