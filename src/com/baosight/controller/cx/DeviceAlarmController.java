package com.baosight.controller.cx;

import com.baosight.base.page.PageVo;
import com.baosight.controller.http.HttpResult;
import com.baosight.dto.common.DeleteDTO;
import com.baosight.dto.cx.query.DeviceAlarmQueryDTO;
import com.baosight.dto.cx.req.DeviceAlarmReqDTO;
import com.baosight.dto.yw.query.OpsUrlDTO;
import com.baosight.service.cx.DeviceAlarmRemoteDataService;
import com.baosight.service.cx.DeviceAlarmService;
import com.baosight.utils.FTPUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;

/**
 * 报警信息表
 *
 * @ClassName DeviceAlarmController
 * @Description TODO
 * @Autgor huang
 * @Date 2020-07-13 10:13
 */
@RestController
@RequestMapping("/backstage/cx/deviceAlarm")
public class DeviceAlarmController {

    @Autowired
    private DeviceAlarmService deviceAlarmService;
    @Autowired
    private DeviceAlarmRemoteDataService remoteDataService;


    /**
     * 报警信息分页列表
     *
     * @param queryDTO
     * @return
     */
    @PostMapping(value = "/getPageList")
    public HttpResult queryPageList(@RequestBody DeviceAlarmQueryDTO queryDTO) {
        PageVo pageVo = deviceAlarmService.findPageList(queryDTO);
        return HttpResult.ok(pageVo);
    }

    /**
     * 新增报警信息
     *
     * @param reqDTO
     * @return
     */
    @PostMapping(value = "/save")
    public HttpResult save(@RequestBody DeviceAlarmReqDTO reqDTO) {
        deviceAlarmService.save(reqDTO);
        return HttpResult.ok("添加成功");
    }

    /**
     * 编辑报警信息
     *
     * @param reqDTO
     * @return
     */
    @PostMapping(value = "/update")
    public HttpResult change(@RequestBody DeviceAlarmReqDTO reqDTO) {
        deviceAlarmService.update(reqDTO);
        return HttpResult.ok("编辑成功");
    }

    /**
     * 删除报警信息
     *
     * @param deleteDTO
     * @return
     */
    @PostMapping(value = "/delete")
    public HttpResult delete(@RequestBody DeleteDTO deleteDTO) {
        deviceAlarmService.deleteBatch(deleteDTO);
        return HttpResult.ok("删除成功");
    }

    /**
     * 报警信息下载
     *
     * @param response
     * @throws IOException
     */
    @GetMapping(value = "/downloadsExcelDown")
    public void downloadsExcelDown(HttpServletResponse response) throws IOException {

        deviceAlarmService.downloadsExcelDown(response);

    }

    /**
     * 报警类型代码类型值
     *
     * @return
     */
    @GetMapping(value = "/selectCallPoliceType")
    public HttpResult findByCodeType() {
        return HttpResult.ok(deviceAlarmService.findByCodeType());
    }

    /**
     * 获取第三方接口历史报警数据
     *
     * @param
     * @return
     */
    @PostMapping(value = "/getAlarmHisData")
    public HttpResult getAlarmHisData() {

        boolean result = remoteDataService
                .getRemoteHisAlarmData();
        return HttpResult.ok(result);

    }

    /**
     * 获取实时报警信息
     *
     * @return
     */
    @PostMapping("/getAlarmRealTimeData")
    public HttpResult getAlarmRealTimeData() {
        boolean result = remoteDataService.getRpcRealTimeAlarmData();
        return HttpResult.ok(result);
    }

    @GetMapping("/getalarmCount")
    public HttpResult getAlarmCount() {

        return HttpResult.ok(deviceAlarmService.selectAlarmCount());

    }

    @GetMapping("/updataFlag")
    public HttpResult updataFlag() {
        return HttpResult.ok(deviceAlarmService.updateAlarmFlag());
    }

    /**
     * 饼图
     *
     * @return
     */
    @GetMapping("/getChartPieData")
    public HttpResult getChartPieData() {

        return HttpResult.ok(deviceAlarmService.getEchartPieData());

    }

    /**
     * 柱状图
     *
     * @return
     */
    @GetMapping("/getEchartBarData")
    public HttpResult getEchartBarData() {

        return HttpResult.ok(deviceAlarmService.getEchartBarData());

    }

    @GetMapping("/getRealTimeAlarmData")
    public HttpResult getRealTimeAlarmData(){

        Map<String,Object> result = new HashMap<>();

        result.put("dataList",deviceAlarmService.getRealTimeAlarmData());

        result.put("codeList",deviceAlarmService.getCodeTypeLevelData());

        return HttpResult.ok(result);

    }

    @RequestMapping("/getTablePageName")
    public HttpResult getTablePageName(@RequestBody Map<String,String> params){
        String formEname = params.get("formEname");
        String tablePageName = "";
        if(formEname!=null){
             tablePageName = deviceAlarmService.getTablePageName(formEname);
        }
        return HttpResult.ok(tablePageName);
    }

    @GetMapping("getFile/{name}")
    public void getFile(HttpServletResponse response,@PathVariable("name")String name)throws Exception{
            String prePath = "video";
            String videoName = name;
            response.setContentType("application/force-download");// 设置强制下载不打开
            response.addHeader("Content-Disposition", "attachment;fileName="+videoName);
            OutputStream os = response.getOutputStream();
            response.reset();
        FTPUtils.downloadFtpFile(OpsUrlDTO.VIDEO_IP, "dss", "Admin_123", 21,
                    prePath,videoName,os);
        }

}

