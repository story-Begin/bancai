package com.baosight.dto.yw.resp;

import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * 服务状态
 *
 * @ClassName ServerStatusRespDTO
 * @Description TODO
 * @Autgor huang
 * @Date 2020-11-17 13:55
 */
@Data
public class ServerStatusRespDTO implements Serializable {
    private static final long serialVersionUID = 187210406253806013L;

    private List<PcsDTO> pcsList;

    private String domainIP;

    private List<MtsDTO> mtsList;

    private Integer dmsFault;

    private List<DmsDTO> dmsDTOList;

    private Integer ptsTotal;

    private Integer ssTotal;

    private Integer onlineStatus;

    private Integer cmsFault;

    private List<ptsDTO> ptsList;

    private Integer adsTotal;

    private List<SslDTO> sslList;

    private Integer pcsTotal;

    private Integer cmsTotal;

    private List<AdsDTO> adsList;

    private Integer domainId;

    private Integer vmsFault;

    private Integer dmsTotal;

    private Integer adsFault;

    private Integer mtsFault;

    private Integer domainCode;

    private Integer mtsTotal;

    private Integer ptsFault;

    private Integer domainName;

    private List<CmsDTO> cmsList;

    private Integer ssFault;

    private Integer vmsTotal;

    private Integer pcsFault;
}
