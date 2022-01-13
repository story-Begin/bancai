package com.baosight.dto.yw.resp;

import lombok.Data;

import java.io.Serializable;

/**
 * @ClassName VideoAisleRespDTO
 * @Description TODO
 * @Autgor huang
 * @Date 2020-11-16 16:25
 */
@Data
public class VideoAisleRespDTO implements Serializable {
    private static final long serialVersionUID = -5270468929031860696L;

    private String cameraIp;
    private String brightnessStatus;
    private String noiseStatus;
    private String ctRunawayStatus;
    private String scenechangeStatus;
    private String coverStatus;
    private String striationStatus;
    private String deviceIp;
    private String frozenStatus;
    private String deviceName;
    private String cameraStatus;
    private String diagnoseResult;
    private String statusTimeStr;
    private String deviceId;
    private String bwImageStatus;
    private String deviceCode;
    private String contrastStatus;
    private String unbalanceStatus;
    private String blurStatus;
    private String diagnoseTime;
    private String ditherStatus;
    private String lossStatus;
    private String cameraStatusTime;
    private String pictureUrl;
    private String cameraName;
    private String channelIndex;
    private String videoShakeUpStatus;
    private String failedCause;

}
