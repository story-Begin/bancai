var myAlarmChar = null;
var myVideoQualityChar = null;
$(document).ready(function () {
    // sumPre();
    onLineRate();
    imageRate();
    videoQuality();
    videoStatistics();
    callPoliceRate();
    // 监控点总数
    // sumPreAjax();
    sumCameraData();
    // 报警总数
    callPoliceSum();
    // 已处理报警数
    processedCallPoliceNum();
    // 报警统计趋势图
    callPoliceStatistics();
    // 监控点在线离线率
    deviceCameraStatusLine();
    // 平台当日和累计调用数量
    videoCallCount();
    // 第三方当日和累计调用数量
    videoCallCountByThirdParty();
    // 视频调用统计趋势图
    videoCallCountByTime();
});

/**
 * 设备总数
 */
function sumCameraData() {
    $(function () {
        $.ajax({
            type: "POST",
            contentType: "application/json;charset=UTF-8",
            url: ctx + "/backstage/equipment/camera/sumCameraData",
            success: function (result) {
                // document.getElementById('sumCameraData').innerHTML = result.data;
                var str="";
                var res=result.data.toString();
                for(var i=0;i<res.length;i++){
                    if(res.charAt(i)==1)
                        str+='<img src="'+ctx+'/static/img/openfile/sbsl/1.png" class="text-css"/>';
                    else if(res.charAt(i)==2)
                        str+='<img src="'+ctx+'/static/img/openfile/sbsl/2.png" class="text-css"/>';
                    else if(res.charAt(i)==3)
                        str+='<img src="'+ctx+'/static/img/openfile/sbsl/3.png" class="text-css"/>';
                    else if(res.charAt(i)==4)
                        str+='<img src="'+ctx+'/static/img/openfile/sbsl/4.png" class="text-css"/>';
                    else if(res.charAt(i)==5)
                        str+='<img src="'+ctx+'/static/img/openfile/sbsl/5.png" class="text-css"/>';
                    else if(res.charAt(i)==6)
                        str+='<img src="'+ctx+'/static/img/openfile/sbsl/6.png" class="text-css"/>';
                    else if(res.charAt(i)==7)
                        str+='<img src="'+ctx+'/static/img/openfile/sbsl/7.png" class="text-css"/>';
                    else if(res.charAt(i)==8)
                        str+='<img src="'+ctx+'/static/img/openfile/sbsl/8.png" class="text-css"/>';
                    else if(res.charAt(i)==9)
                        str+='<img src="'+ctx+'/static/img/openfile/sbsl/9.png" class="text-css"/>';
                    else if(res.charAt(i)==0)
                        str+='<img src="'+ctx+'/static/img/openfile/sbsl/0.png" class="text-css"/>';
                }
                $('#sumCameraData').append(str);
            },
            error: function (e) {
                console.log(e.status);
                console.log(e.responseText);
            }
        });
    });
}

/**
 * 监控点总数
 */
// function sumPreAjax() {
//     $(function () {
//         // let list = {};
//         $.ajax({
//             type: "POST",
//             contentType: "application/json;charset=UTF-8",
//             url: ctx + "/backstage/hp/homepage/alarmCountLevel",
//             // data: JSON.stringify(list),
//             success: function (result) {
//                 $("#slide1").append("<p style='background-image:linear-gradient(#22659a 0%, #14466b 50%, #562db9 100%);width:105px;'><span>&nbsp;一般</span></br><spam id=\"police-span\">" + result.data[0] + "</spam></p>");
//                 $("#slide1").append("<p style='background-image:linear-gradient(#0d6f50 0%, #044631 50%, #34c194 100%);width:105px;'><span>&nbsp;提醒</span></br><spam id=\"police-span\">" + result.data[1] + "</spam></p>");
//                 $("#slide1").append("<p style='background-image:linear-gradient(#646f0d 0%, #535d0a 50%, #c1d61e 100%);width:105px;'><span>&nbsp;紧急</span></br><spam id=\"police-span\">" + result.data[2] + "</spam></p>");
//                 let slide2 = document.getElementById("slide2");
//                 let slide1 = document.getElementById("slide1");
//                 slide2.innerHTML = slide1.innerHTML
//             },
//             error: function (e) {
//                 console.log(e.status);
//                 console.log(e.responseText);
//             }
//         });
//     });
// }

/**
 * 报警总数
 */
function callPoliceSum() {
    $(function () {
        $.ajax({
            type: "POST",
            contentType: "application/json;charset=UTF-8",
            url: ctx + "/backstage/hp/homepage/alarmCountSum",
            success: function (result) {
                console.log(result);
                document.getElementById('sumNum').innerHTML = result.data;
            },
            error: function (e) {
                console.log(e.status);
                console.log(e.responseText);
            }
        });
    });
}

/**
 * 已处理报警数
 */
function processedCallPoliceNum() {
    $(function () {
        $.ajax({
            type: "POST",
            contentType: "application/json;charset=UTF-8",
            url: ctx + "/backstage/hp/homepage/getAlarmCountDealed",
            success: function (result) {
                document.getElementById('disposeNum').innerHTML = result.data;
            },
            error: function (e) {
                console.log(e.status);
                console.log(e.responseText);
            }
        });
    });
}

/**
 * 报警统计趋势图
 */
function callPoliceStatistics() {
    $(function () {
        $.ajax({
            type: "POST",
            contentType: "application/json;charset=UTF-8",
            url: ctx + "/backstage/hp/homepage/alarmCountByLevelAndTime",
            success: function (result) {
                callPoliceRate(result.data[0], result.data[1], result.data[2])
            },
            error: function (e) {
                console.log(e.status);
                console.log(e.responseText);
            }
        });
    });
}


/**
 * 监控点在线离线率
 */
function deviceCameraStatusLine() {
    $(function () {
        $.ajax({
            type: "POST",
            contentType: "application/json;charset=UTF-8",
            url: ctx + "/backstage/hp/homepage/deviceCameraStatusLine",
            success: function (result) {
                onLineRate(result.data[0], result.data[1]);
            },
            error: function (e) {
                console.log(e.status);
                console.log(e.responseText);
            }
        });
    });
}

/**
 * 平台当日和累计调用数量
 */
function videoCallCount() {
    $(function () {
        $.ajax({
            type: "POST",
            contentType: "application/json;charset=UTF-8",
            url: ctx + "/backstage/hp/homepage/videoCallCount",
            success: function (result) {
                document.getElementById('without_day_sum').innerHTML = result.data[1];
                document.getElementById('without_add_sum').innerHTML = result.data[0];
            },
            error: function (e) {
                console.log(e.status);
                console.log(e.responseText);
            }
        });
    });
}

/**
 * 第三方当日和累计调用数量
 */
function videoCallCountByThirdParty() {
    $(function () {
        $.ajax({
            type: "POST",
            contentType: "application/json;charset=UTF-8",
            url: ctx + "/backstage/hp/homepage/videoCallCountByThirdParty",
            success: function (result) {
                document.getElementById('platform_day_sum').innerHTML = result.data[1];
                document.getElementById('platform_add_sum').innerHTML = result.data[0];
            },
            error: function (e) {
                console.log(e.status);
                console.log(e.responseText);
            }
        });
    });
}
function videoQuality() {
    $(function () {
        $.ajax({
            type: "POST",
            contentType: "application/json;charset=UTF-8",
            url: ctx + "/backstage/hp/homepage/videoQuality",
            success: function (result) {
                flashvideoQualiy(result.data);
            },
            error: function (e) {
                console.log(e.status);
                console.log(e.responseText);
            }
        });
    });
}

/**
 * 视频调用统计趋势图
 */
function videoCallCountByTime() {
    $(function () {
        $.ajax({
            type: "POST",
            contentType: "application/json;charset=UTF-8",
            url: ctx + "/backstage/hp/homepage/videoCallCountByTime",
            success: function (result) {
                videoStatistics(result.data[0], result.data[1])
            },
            error: function (e) {
                console.log(e.status);
                console.log(e.responseText);
            }
        });
    });
}

/**
 * 监控点总数
 */
// function sumPre() {
//     let chart = echarts.init(document.getElementById('sumPre'));
//     let option = {
//         color: ['#ffdb5c', '#32c5e9', '#9fe6b8'],
//         backgroundColor:'#1e475a87',
//         title: {
//             text: '监控点总数',
//             left: 'left',
//             textStyle: {
//                 color: 'white',
//                 align: 'center',
//                 fontSize: 12
//             }
//         },
//         tooltip: {
//             trigger: 'item',
//             formatter: "{a} <br/>{b} : {c} ({d}%)"
//         },
//         toolbox: {
//             show: true,
//
//         },
//         grid: {
//             top: '2%',
//             left: '1%',
//             right: '2%',
//             bottom: '2%',
//         },
//         legend: {
//             type: "scroll",
//             orient: 'vertical',
//             left: '70%',
//             data: ['高清', '标清', '未检测'],
//             align: 'left',
//             top: 'middle',
//             textStyle: {
//                 color: 'white'
//             },
//             right: "5%",
//             height: 150
//         },
//         series: [
//             {
//                 name: '业务警种',
//                 type: 'pie',
//                 radius: [0, 30],
//                 center: ['35%', '50%'],
//                 data: [
//                     {value: 20, name: '高清'},
//                     {value: 30, name: '标清'},
//                     {value: 25, name: '未检测'}
//                 ]
//             }
//         ]
//     };
//
//     chart.setOption(option, true);
// }

/**
 * 监点在线离线率
 */
function onLineRate(onLine, offLine) {
    let chart = echarts.init(document.getElementById('onLineRate'));
    let option = {
        color: ['#ffdb5c', '#32c5e9', '#9fe6b8'],
        // backgroundColor:'#1e475a87',
        title: {
            text: '',
            left: 'left',
            textStyle: {
                color: 'white',
                align: 'center',
                fontSize: 12
            }
        },
        tooltip: {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        toolbox: {
            show: true,

        },
        grid: {
            top: '2%',
            left: '1%',
            right: '2%',
            bottom: '2%',
        },
        legend: {
            type: "scroll",
            orient: 'vertical',
            left: '70%',
            data: ['在线', '离线'],
            align: 'left',
            top: 'middle',
            textStyle: {
                color: 'white'
            },
            right: "5%",
            height: 150
        },
        series: [
            {
                name: '业务警种',
                type: 'pie',
                radius: [0, 50],
                center: ['35%', '50%'],
                data: [
                    {value: onLine, name: '在线'},
                    {value: offLine, name: '离线'}
                ]
            }
        ]
    };

    chart.setOption(option, true);
}

/**
 * 图像正常率
 */
function imageRate() {
    let chart = echarts.init(document.getElementById('imageRate'));
    let option = {
        color: ['#ffdb5c', '#32c5e9', '#9fe6b8', '#F76F01'],
        // backgroundColor:'#1e475a87',
        title: {
            text: '',
            left: 'left',
            textStyle: {
                color: 'white',
                align: 'center',
                fontSize: 12
            }
        },
        tooltip: {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        toolbox: {
            show: true,
        },
        grid: {
            top: '3%',
            left: '1%',
            right: '2%',
            bottom: '1%',
        },
        legend: {
            type: "scroll",
            orient: 'vertical',
            left: '70%',
            data: ['图像正常', '图像异常', '诊断失败', '未检测'],
            align: 'left',
            top:'5%',
            textStyle: {
                color: 'white'
            },
            right: "5%",
            height: 150,

        },
        series: [
            {
                name:"视频质量",
                type: 'pie',
                radius: [0,50],
                center: ['35%', '50%'],
                data:[
                    {value: 0, name: '图像正常'},
                    {value: 0, name: '图像异常'},
                    {value: 0, name: '诊断失败'},
                    {value: 0, name: '未检测'},
                ]
            }
        ]
    };

    chart.setOption(option, true);
    myVideoQualityChar = chart;
}

/**
 * 视频调用统计趋势图
 */
function videoStatistics(platfrom, without) {
    let chart = echarts.init(document.getElementById('videoStatistics'));
    let fontColor = '#fff';
    let option = {
        color: ['#F76F01', '#f9e264'],
        // backgroundColor:'#1e475a87',
        textStyle: {
            fontSize: 14
        },
        title: {
            text: '',
            left: 'left',
            textStyle: {
                color: fontColor,
                align: 'center',
                fontSize: 14
            }
        },
        grid: {
            left: '0',
            right: '40',
            bottom: '10',
            top: '80',
            containLabel: true
        },
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'shadow',
                label: {
                    show: true,
                    backgroundColor: '#333'
                }
            }
        },
        legend: {
            show: true,
            x: 'center',
            top: '12%',
            textStyle: {
                color: fontColor,
                fontSize: '12px'
            },
            data: ['监控平台', '第三方平台']
        },
        xAxis: [{
            type: 'category',
            boundaryGap: false,
            axisLabel: {
                color: fontColor
            },
            axisLine: {
                show: true,
                lineStyle: {
                    color: '#397cbc'
                }
            },
            data: ['10：30', '11：30', '12：30', '13：30', '14：30']
        }],
        yAxis: [{
            type: 'value',
            name: '统计数据',
            top: '10px',
            show: false,
            axisLine: {
                lineStyle: {
                    color: fontColor
                }
            }
        }],
        series: [{
            name: '监控平台',
            type: 'line',
            symbolSize: 8,
            label: {
                normal: {
                    show: true,
                    position: 'top'
                }
            },
            itemStyle: {
                normal: {
                    areaStyle: {
                        color: new echarts.graphic.LinearGradient(0, 1, 0, 0, [{
                            offset: 0,
                            color: 'rgba(7,44,90,0.3)'
                        }, {
                            offset: 1,
                            color: 'rgba(0,146,246,0.9)'
                        }]),
                    }
                }
            },
            data: platfrom,
        },
            {
                name: '第三方平台',
                type: 'line',
                symbol: 'circle',
                symbolSize: 8,
                label: {
                    normal: {
                        show: true,
                        position: 'top'
                    }
                },
                itemStyle: {
                    normal: {
                        areaStyle: {
                            //color: '#94C9EC'
                            color: new echarts.graphic.LinearGradient(0, 1, 0, 0, [{
                                offset: 0,
                                color: 'rgba(7,44,90,0.3)'
                            }, {
                                offset: 1,
                                color: 'rgba(0,212,199,0.9)'
                            }]),
                        }
                    }
                },
                data: without
            }
        ]
    };

    chart.setOption(option, true);
}

/**
 * 报警统计-趋势图
 */
function callPoliceRate(ordinary, remind, urgency) {
    var chart = echarts.init(document.getElementById('callPoliceRate'));
    var fontColor = '#fff';
    let option = {
        color: ['#bf19ff', '#02cdff', '#f9e264'],
        textStyle: {
            fontSize: 14
        },
        title: {
            text: '',
            left: 'left',
            textStyle: {
                color: fontColor,
                align: 'center',
                fontSize: 14
            }
        },
        grid: {
            left: '0',
            right: '10',
            bottom: '10',
            top: '70',
            containLabel: true
        },
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'shadow',
                label: {
                    show: true,
                    backgroundColor: '#333'
                }
            }
        },
        legend: {
            show: true,
            x: 'center',
            top: '12%',
            textStyle: {
                color: fontColor,
                fontSize: '12px'
            },
            data: ['一级', '二级', '三级']
        },
        xAxis: [{
            type: 'category',
            boundaryGap: false,
            axisLabel: {
                color: fontColor,
                fontSize: 8
            },
            axisLine: {
                show: true,
                lineStyle: {
                    color: '#397cbc'
                }
            },
            data: getDateList()
        }],
        yAxis: [{
            type: 'value',
            name: '统计数据',
            top: '10px',
            show: false,
            axisLine: {
                lineStyle: {
                    color: fontColor
                }
            }
        }],
        series: [
            {
                name: '一级',
                type: 'line',
                symbolSize: 8,
                label: {
                    normal: {
                        show: true,
                        position: 'top'
                    }
                },
                itemStyle: {
                    normal: {
                        areaStyle: {
                            color: new echarts.graphic.LinearGradient(0, 1, 0, 0, [{
                                offset: 0,
                                color: 'rgba(7,44,90,0.3)'
                            }, {
                                offset: 1,
                                color: 'rgba(0,146,246,0.9)'
                            }]),
                        }
                    }
                },
                data: ordinary
            }, {
                name: '二级',
                type: 'line',
                symbolSize: 8,
                label: {
                    normal: {
                        show: true,
                        position: 'top'
                    }
                },
                itemStyle: {
                    normal: {
                        areaStyle: {
                            color: new echarts.graphic.LinearGradient(0, 1, 0, 0, [{
                                offset: 0,
                                color: 'rgba(7,46,101,0.3)'
                            }, {
                                offset: 1,
                                color: 'rgba(0,166,246,0.9)'
                            }]),
                        }
                    }
                },
                data: remind,
            }, {
                name: '三级',
                type: 'line',
                symbol: 'circle',
                symbolSize: 8,
                label: {
                    normal: {
                        show: true,
                        position: 'top'
                    }
                },
                itemStyle: {
                    normal: {
                        areaStyle: {
                            color: new echarts.graphic.LinearGradient(0, 1, 0, 0, [{
                                offset: 0,
                                color: 'rgba(7,44,90,0.3)'
                            }, {
                                offset: 1,
                                color: 'rgba(0,212,199,0.9)'
                            }]),
                        }
                    }
                },
                data: urgency
            }
        ]
    };

    chart.setOption(option, true);
    myAlarmChar = chart;
}

function getDateList(){
    var dateList = [];
    var date = new Date();
    for (let i=0; i< 7; i++) {
        let month =date.getMonth()+1<10?"0"+(date.getMonth()+1):date.getMonth()+1;
        let day = date.getDate()<10?"0"+(date.getDate()):date.getDate();
        dateList.unshift(month+"月"+day+"号");
        date.setDate(date.getDate()-1);
    }
    console.log(dateList);
    return dateList;
}

function flashAlarmCharData(newData) {
    var option = myAlarmChar.getOption();
    for (let i = 0; i <newData.length ; i++) {
        option.series[i].data=newData[i];
    }
    console.log("正在刷新数据");
    myAlarmChar.setOption(option);
}
function flashvideoQualiy(newData) {
    var option = myVideoQualityChar.getOption();
    var data = [
        {value: newData[0], name: '图像正常'},
        {value: newData[1], name: '图像异常'},
        {value: newData[2], name: '诊断失败'},
        {value: newData[3], name: '未检测'},
    ]
    option.series[0].data =data;
    console.log("正在刷新数据");
    myVideoQualityChar.setOption(option);
}

