package com.baosight.dto.cx.resp;


import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
@Data
public class DeviceAlarmOutRealTimeDataDTO {
//3.1.15设备报警
//    字段	说明	类型	长度	是否必填	备注
//    orgCode	组织编码	string	32	N
    private String orgCode;
//    orgName	组织名称	string	64	N
    private String orgName;
//    deviceCode	设备编码	string	32	Y
    private String deviceCode;
//    deviceName	设备名称	string	64	Y
    private String deviceName;
//    alarmChannelCode	报警通道编码	string	32	Y
    private String alarmChannelCode;
//    alarmChannelName	报警通道名称	string	64	Y
    private String alarmChannelName;
//    alarmType	报警类型	int	3	Y
    private Integer alarmType;
//    alarmTime	报警时间	string	--	Y	yyyy-MM-dd HH:mm:ss
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone="GMT+8")
    private Date alarmTime;
//    alarmCode	报警编码	string	32	Y	用来联动录像,抓图的查询标识
    private String alarmCode;
//    alarmStat	报警状态	int	2	N
    private Integer alarmStat;
//    alarmPic1	抓图1	string	128	N	相对地址请加前缀http://{ip:port}/ CardSolution/snap/alarm/
    private String alarmPic1;
//    端口默认:8314
//    alarmData	报警内容	object	-	N	一般是特定报警类型的差异化字段
    private Object alarmData;
//    message	扩展信息	string	--	N	一般是特定报警类型的差异化图片字段
    private String message;


}
