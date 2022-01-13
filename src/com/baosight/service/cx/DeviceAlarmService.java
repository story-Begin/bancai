package com.baosight.service.cx;

import com.baosight.base.baseService.BaseService;
import com.baosight.base.page.PageVo;
import com.baosight.dto.common.DeleteDTO;
import com.baosight.dto.cx.query.DeviceAlarmQueryDTO;
import com.baosight.dto.cx.req.DeviceAlarmReqDTO;
import com.baosight.dto.cx.resp.DeviceAlarmOutRealTimeDataDTO;
import com.baosight.dto.cx.resp.DeviceAlarmRespDTO;
import com.baosight.dto.cx.resp.EchartPieDataDTO;
import com.baosight.dto.data_field.CodeTypeValueRespDTO;
import com.baosight.entity.cx.DeviceAlarmEntity;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * @ClassName DeviceAlarmService
 * @Description TODO
 * @Autgor huang
 * @Date 2020-07-13 09:59
 */
public interface DeviceAlarmService extends BaseService<DeviceAlarmReqDTO> {

    /**
     * 报警信息列表
     *
     * @param queryDTO
     * @return
     */
    PageVo findPageList(DeviceAlarmQueryDTO queryDTO);

    /**
     * 导出
     *
     * @param response
     * @throws IOException
     */
    void downloadsExcelDown(HttpServletResponse response) throws IOException;

    /**
     * 报警类型代码类型值
     *
     * @return
     */
    List<CodeTypeValueRespDTO> findByCodeType();

    void deleteBatch(DeleteDTO deleteDTO);


    int insertDeviceRealTimeAlarmData(DeviceAlarmOutRealTimeDataDTO data);

    List<EchartPieDataDTO> getEchartPieData();

    int selectAlarmCount();

    int updateAlarmFlag();

    List<Integer> getEchartBarData();

    List<DeviceAlarmRespDTO> getRealTimeAlarmData();

    Map<String,List<CodeTypeValueRespDTO>> getCodeTypeLevelData();

    String getTablePageName(String eName);

}
