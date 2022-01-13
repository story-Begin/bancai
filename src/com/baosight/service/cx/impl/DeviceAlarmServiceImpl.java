package com.baosight.service.cx.impl;

import com.baosight.base.aspect.AspectTime;
import com.baosight.base.enumeration.CodeType;
import com.baosight.base.page.BeanCopyUtils;
import com.baosight.base.page.PageVo;
import com.baosight.base.page.PageVoUtils;
import com.baosight.dto.common.DeleteDTO;
import com.baosight.dto.cx.query.DeviceAlarmQueryDTO;
import com.baosight.dto.cx.req.DeviceAlarmReqDTO;
import com.baosight.dto.cx.resp.DeviceAlarmOutRealTimeDataDTO;
import com.baosight.dto.cx.resp.DeviceAlarmRespDTO;
import com.baosight.dto.cx.resp.EchartPieDataDTO;
import com.baosight.dto.data_field.CodeTypeValueRespDTO;
import com.baosight.entity.cx.DeviceAlarmEntity;
import com.baosight.mapper.base.BaseDeleteMapper;
import com.baosight.mapper.cx.DeviceAlarmDao;
import com.baosight.mapper.data_field.CodeTypeValueMapper;
import com.baosight.service.cx.DeviceAlarmService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @ClassName DeviceAlarmServiceImpl
 * @Description TODO
 * @Autgor huang
 * @Date 2020-07-13 10:01
 */
@Service
public class DeviceAlarmServiceImpl implements DeviceAlarmService {

    @Autowired
    private DeviceAlarmDao deviceAlarmDao;
    @Autowired
    private CodeTypeValueMapper codeTypeValueMapper;
    @Autowired
    private BaseDeleteMapper deleteMapper;

    /**
     * 报警信息列表
     *
     * @param queryDTO
     * @return
     */
    @Override
    public PageVo findPageList(DeviceAlarmQueryDTO queryDTO) {
        PageHelper.startPage(queryDTO.getPageNo(), queryDTO.getPageSize());
        List<DeviceAlarmEntity> deviceAlarmEntities = deviceAlarmDao.selectDeviceAlarmList(queryDTO);
        if (CollectionUtils.isNotEmpty(deviceAlarmEntities)) {
            List<String> list = new ArrayList<>();
            list.add(CodeType.CALL_POLICE_GRADE);
            list.add(CodeType.CALL_POLICE_TYPE);
            List<CodeTypeValueRespDTO> codeTypeValueList = codeTypeValueMapper.selectByCodeTypeList(list);
            List<CodeTypeValueRespDTO> callPollGradeList = codeTypeValueList.stream()
                    .filter(it -> it.getCodeSetCode().contains(CodeType.CALL_POLICE_GRADE))
                    .collect(Collectors.toList());
            List<CodeTypeValueRespDTO> callPoliceTypeList = codeTypeValueList.stream()
                    .filter(it -> it.getCodeSetCode().contains(CodeType.CALL_POLICE_TYPE)).collect(Collectors.toList());
            deviceAlarmEntities.forEach(it -> {
                callPollGradeList.stream().filter(item -> item.getItemCode().contains(it.getCallPoliceGrade()))
                        .forEach(i -> it.setCallPoliceGradeName(i.getItemName()));
                callPoliceTypeList.stream().filter(item -> item.getItemCode().contains(it.getCallPoliceType()))
                        .forEach(i -> it.setCallPoliceTypeName(i.getItemName()));
            });
        }
        return PageVoUtils.pageFromMybatis(new PageInfo<>(deviceAlarmEntities), DeviceAlarmRespDTO.class);
    }

    /**
     * 新增报警信息
     *
     * @param record
     * @return
     */
    @AspectTime(operation = "create")
    @Override
    public boolean save(DeviceAlarmReqDTO record) {
        //DeviceAlarmEntity deviceAlarmentity = new DeviceAlarmentity();
        DeviceAlarmEntity deviceAlarmEntity = new DeviceAlarmEntity();
        BeanUtils.copyProperties(record, deviceAlarmEntity);
        deviceAlarmDao.insert(deviceAlarmEntity);
        return true;
    }


    /**
     * 修改报警信息
     *
     * @param record
     * @return
     */
    @Override
    public boolean update(DeviceAlarmReqDTO record) {
        DeviceAlarmEntity deviceAlarmEntity = new DeviceAlarmEntity();
        BeanUtils.copyProperties(record, deviceAlarmEntity);
        deviceAlarmDao.updateByPrimaryKeySelective(deviceAlarmEntity);
        return true;
    }

    /**
     * 删除
     *
     * @param ids
     */
    @Transactional
    @Override
    public void delete(String ids) {
    }

    /**
     * 批量删除
     *
     * @param deleteDTO
     */
    @Transactional
    @Override
    public void deleteBatch(DeleteDTO deleteDTO) {
        deleteDTO.setTableName(new DeviceAlarmEntity().getDynamicTableName());
        deleteMapper.deleteBatch(deleteDTO);
    }

    @Override
    public void downloadsExcelDown(HttpServletResponse response) throws IOException {
        DeviceAlarmQueryDTO queryDTO = new DeviceAlarmQueryDTO();
        List<DeviceAlarmEntity> deviceAlarmEntities = deviceAlarmDao.selectDeviceAlarmAllList();
        System.out.printf("------------" + deviceAlarmEntities.toString());
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet("信息列表");
        // 设置要导出的文件名字
        String fileName = "报警信息" + ".xls";
        int rowNum = 1;
        //headers表示excel表中第一行的表头 在excel表中添加表头
        String[] headers = {"创建时间", "设备名称", "设备编号", "通道名称", "通道号", "报警类型", "报警级别", "处理状态", "处理时间"};
        // 样式
        HSSFCellStyle style = workbook.createCellStyle();
        style.setWrapText(true); // 自动换行
        // 水平居中
        style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER); // 垂直
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 水平
        // 字体格式
        HSSFFont fonttitle1 = workbook.createFont();
        fonttitle1.setFontName("宋体");
        fonttitle1.setFontHeightInPoints((short) 12);
        fonttitle1.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
        style.setFont(fonttitle1);


        // 设置宽高
        sheet.setColumnWidth(0, 20 * 256);
        sheet.setColumnWidth(1, 20 * 256);
        sheet.setColumnWidth(2, 20 * 256);
        sheet.setColumnWidth(3, 20 * 256);
        sheet.setColumnWidth(4, 10 * 256);
        sheet.setColumnWidth(5, 20 * 256);
        sheet.setColumnWidth(6, 20 * 256);
        sheet.setColumnWidth(7, 20 * 256);
        sheet.setColumnWidth(8, 20 * 256);
        // 数据处理
        HSSFRow row = sheet.createRow(0);

        for (int i = 0; i < headers.length; i++) {
            HSSFCell cell = row.createCell(i);
            HSSFRichTextString text = new HSSFRichTextString(headers[i]);
            cell.setCellValue(text);
            // 设置样式
            cell.setCellStyle(style);
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        HSSFCellStyle rowStyle = workbook.createCellStyle();
        rowStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        rowStyle.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
        rowStyle.setBottomBorderColor(IndexedColors.GREY_50_PERCENT.getIndex());
        List<DeviceAlarmRespDTO> deviceAlarm =
                BeanCopyUtils.copyList(deviceAlarmEntities, DeviceAlarmRespDTO.class);
        for (DeviceAlarmRespDTO dev : deviceAlarm) {
            HSSFRow row1 = sheet.createRow(rowNum);
            row1.setHeightInPoints(18);
            row1.setRowStyle(rowStyle);


            //"创建时间","设备名称","设备编号","通道名称","通道号","报警类型","报警级别","处理状态","处理时间"
            row1.createCell((short) 0).setCellValue(sdf.format(dev.getCreateTime()));
            row1.createCell((short) 1).setCellValue(dev.getEquipmentName());
            row1.createCell((short) 2).setCellValue(dev.getEquipmentNum());
            row1.createCell((short) 3).setCellValue(dev.getPortName());
            if(dev.getPortCode()!=null){
                row1.createCell((short) 4).setCellValue(dev.getPortCode());
            }else{
                row1.createCell((short) 4).setCellValue("");
            }
            row1.createCell((short) 5).setCellValue(dev.getCallPoliceType());
            row1.createCell((short) 6).setCellValue(dev.getCallPoliceGrade());
            row1.createCell((short) 7).setCellValue(dev.getStatus());
            row1.createCell((short) 8).setCellValue(sdf.format(dev.getHappenTime()));
            rowNum++;
        }
        response.setContentType("application/octet-stream");
        response.setHeader("Content-disposition", "attachment;filename=" + fileName);
        response.flushBuffer();
        workbook.write(response.getOutputStream());
    }

    /**
     * 报警类型代码类型值
     *
     * @return
     */
    @Override
    public List<CodeTypeValueRespDTO> findByCodeType() {
        List<CodeTypeValueRespDTO> codeTypeList =
                codeTypeValueMapper.selectByCodeType(CodeType.CALL_POLICE_TYPE);
        return codeTypeList;
    }

    @Transactional
    @Override
    public int insertDeviceRealTimeAlarmData(DeviceAlarmOutRealTimeDataDTO data) {
        int status =  data.getAlarmStat();
        if(status==2){
            return -1;
        }else{
                return deviceAlarmDao.insertDeviceRealTimeAlarmData(data);
            }
    }

    /**
     * 获取报警统计图表饼图数据
     *
     * @return
     */
    @Override
    public List<EchartPieDataDTO> getEchartPieData() {
        List<EchartPieDataDTO> dataDTOList = new ArrayList<>();
        List<CodeTypeValueRespDTO> codeTypeList =
                codeTypeValueMapper.selectByCodeType(CodeType.CALL_POLICE_TYPE);

        for (int i = 0; i < codeTypeList.size(); i++) {
            int count = deviceAlarmDao.selectAlarmTypeCount(Integer.parseInt(codeTypeList.get(i).getItemCode()));
            dataDTOList.add(new EchartPieDataDTO(count, codeTypeList.get(i).getItemName()));
        }
        return dataDTOList;
    }

    /**
     * 查询报警数量
     *
     * @return
     */

    public int selectAlarmCount() {

        return deviceAlarmDao.selectAlarmCount();
    }

    /**
     * 更新报警flag状态
     *
     * @return
     */
    @Override
    public int updateAlarmFlag() {

        return deviceAlarmDao.updateAlarmFlag();

    }

    @Override
    public List<Integer> getEchartBarData() {

        List<Integer> countList = new ArrayList<>();
        for (int i = 0; i < 7; i++) {
            Calendar cld = Calendar.getInstance();
            cld.add(cld.DATE, -i);
            int count = deviceAlarmDao.selectAlarmCountByDate(cld.getTime());
            countList.add(count);
        }
        return countList;

    }

    @Override
    public List<DeviceAlarmRespDTO> getRealTimeAlarmData() {
        List<DeviceAlarmEntity> realTimeAlarmData = deviceAlarmDao.getRealTimeAlarmData();
        Map<String, String>  codeGradeList= codeTypeValueMapper.selectByCodeType(CodeType.CALL_POLICE_GRADE)
                .stream()
                .collect(Collectors.toMap(
                        CodeTypeValueRespDTO::getItemCode,
                        CodeTypeValueRespDTO::getItemName));
        Map<String, String> codeTypeList = codeTypeValueMapper.selectByCodeType(CodeType.CALL_POLICE_TYPE)
                .stream()
                .collect(Collectors.toMap(
                        CodeTypeValueRespDTO::getItemCode,
                        CodeTypeValueRespDTO::getItemName));
        realTimeAlarmData.forEach(item->{

            item.setCallPoliceGradeName(codeGradeList.get(item.getCallPoliceGrade()));

            item.setCallPoliceType(codeTypeList.get(item.getCallPoliceType()));

        });
        return BeanCopyUtils.copyList(realTimeAlarmData,DeviceAlarmRespDTO.class);
    }

    public Map<String,List<CodeTypeValueRespDTO>> getCodeTypeLevelData(){

        Map<String,List<CodeTypeValueRespDTO>> result = new HashMap<>();

       result.put("codeGrade",codeTypeValueMapper.selectByCodeType(CodeType.CALL_POLICE_TYPE));

       result.put("codeLevel",codeTypeValueMapper.selectByCodeType(CodeType.CALL_POLICE_GRADE));

        return result;

    }

    @Override
    public String getTablePageName(String eName) {
        return deviceAlarmDao.getTablePageName(eName);
    }

}
