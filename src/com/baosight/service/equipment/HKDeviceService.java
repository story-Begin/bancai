package com.baosight.service.equipment;

import java.io.IOException;

public interface HKDeviceService {

    /**
     * 展示所有
     *
     * @return
     */
    void getHKDeviceList() throws IOException, IllegalAccessException;

    String camerasPreviewURLsInfo(String cameraIndexCode,String protocol);

}
