
function initEchartsData() {
    // $("#pie").css({"width":$("#pie").width(),"height":$("#pie").height()});
    // $("#bar").css({"width":$("#bar").width(),"height":$("#bar").height()});
      pieData =[];
     barData = [];
     barDateList = [];
    console.log("初始化");
    getChartPieData();
    getChartbarData();
    barDateList = getDateList();

    console.log(barData);
    console.log(pieData);
    console.log(barDateList);

        var myChart = echarts.init(document
            .querySelector("#pie"));
        var option = {
            title: {
                text: '设备报警类型统计',
                left: 'center',
                textStyle:{
                    color: '#c8c8c8'
                }
            },
            tooltip: {
                trigger: 'item',
                formatter: '{a} <br/>{b} : {c} ({d}%)'
            },
            legend: {
                orient: 'vertical',
                left: 'left',
                textStyle:{
                    color:'#c6c6c6'
                }
            },
            series: [
                {

                    name: '总数',
                    type: 'pie',
                    radius: [30, 110],
                    data:pieData,
                    emphasis: {
                        itemStyle: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }
            ]
        };

        myChart.setOption(option,true);
        var myChart = echarts.init(document
            .querySelector("#bar"));
        var option = {
            title: {
                text: '设备报警统计',
                left:"center",
                textStyle:{
                    color: '#c4c4c4'
                }
            },
            color: ['#3398DB'],
            tooltip: {
                trigger: 'axis',
                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            xAxis: [
                {
                    type: 'category',
                    //data: ['周一', '周二', '周三', '周四', '周五', '周六', '周日'],
                    data:barDateList,
                    axisTick: {
                        alignWithLabel: true
                    },
                    axisLabel: {
                        color: "#c6c4bc"
                    }
                }

            ],
            yAxis: [
                {
                    type: 'value',
                    axisLabel: {
                        color: "#c3c3c3"
                    }
                }
            ],
            series: [
                {
                    name: '报警数量',
                    type: 'bar',
                    barWidth: '60%',
                    data: barData
                }
            ]
        };

        myChart.setOption(option,true);

}

function getChartPieData() {
    var url =ctx+"/backstage/cx/deviceAlarm/getChartPieData"
   $.ajax(
       {
           type: "GET",
           async: false,
           contentType: "application/json;charset=UTF-8",
           url: url,
           success: function (msg) {
               pieData = msg.data;
               console.log(pieData);
           },
           error: function (xmlR, status, e) {
               console.log("初始化失败！",xmlR,status,e);
           }
       });

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
function getChartbarData() {
    let url =ctx+"/backstage/cx/deviceAlarm/getEchartBarData"
    $.ajax(
        {
            type: "GET",
            async: false,
            contentType: "application/json;charset=UTF-8",
            url: url,
            success: function (msg) {
                console.log(msg.data);
                barData =  msg.data.reverse();
                console.log(barData);
            },
            error: function (xmlR, status, e) {
                console.log("初始化失败！",xmlR,status,e);
            }
        });


}

