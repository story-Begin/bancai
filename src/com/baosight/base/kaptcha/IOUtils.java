package com.baosight.base.kaptcha;

import java.io.Closeable;
import java.io.IOException;

/**
 * @ClassName IOUtils
 * @Description TODO
 * @Autgor huang
 * @Date 2020-08-08 18:03
 */
public class IOUtils {

    /**
     * 关闭对象，连接
     *
     * @param closeable
     */
    public static void closeQuietly(final Closeable closeable) {
        try {
            if (closeable != null) {
                closeable.close();
            }
        } catch (final IOException ioe) {
            // ignore
        }
    }
}
