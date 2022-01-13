function initEchartsData() {
    (function(){
        var myChart = echarts.init(document
            .querySelector(".pie2 .char"));
        var option = {

            tooltip: {
                trigger: 'item',
                formatter: '{a} <br/>{b} : {c} ({d}%)',
                textStyle:{
                    fontSize:10
                }
            },
            legend: {
                left: 'center',
                top: 'bottom',
                itemWidth:10,
                itemHeight:10,
                textStyle:{
                    fontSize:8,
                    color:"rgba(255,255,255,0.6)"
                }
            },
            series: [
                {
                    name: '面积模式',
                    type: 'pie',
                    radius:['10%','70%'],
                    center: ['50%', '50%'],
                    roseType: 'area',
                    label:{
                        fontSize:10
                    },
                    labelLine:{
                        length:6,
                        length2:8
                    },

                    data: [
                        {value: 10, name: '河南'},
                        {value: 5, name: '山东'},
                        {value: 15, name: '上海'},
                        {value: 25, name: '北京'},
                        {value: 30, name: '深圳'},
                        {value: 35, name: '杭州'},
                        {value: 30, name: '云南'}
                    ]
                }
            ]
        };
        myChart.setOption(option);
    })();
    (function () {
        var myChart = echarts.init(document
            .querySelector(".bar1 .char"));
        var option = {
            grid: {
                left: '12%',
                top: '5%',
                bottom: '12%',
                right: '8%'
            },
            xAxis: {
                data: ['周一', '周二', '周三', '周四', '周五', '周六', '周日'],
                axisTick: {
                    show: false
                },
                axisLine: {
                    lineStyle: {
                        color: 'rgba(255, 129, 109, 0.1)',
                        width: 1 //这里是为了突出显示加上的
                    }
                },
                axisLabel: {
                    textStyle: {
                        color: '#999',
                        fontSize: 12
                    }
                }
            },
            yAxis: [{
                splitNumber: 2,
                axisTick: {
                    show: false
                },
                axisLine: {
                    lineStyle: {
                        color: 'rgba(255, 129, 109, 0.1)',
                        width: 1 //这里是为了突出显示加上的
                    }
                },
                axisLabel: {
                    textStyle: {
                        color: '#999'
                    }
                },
                splitArea: {
                    areaStyle: {
                        color: 'rgba(255,255,255,.5)'
                    }
                },
                splitLine: {
                    show: true,
                    lineStyle: {
                        color: 'rgba(255, 129, 109, 0.1)',
                        width: 0.5,
                        type: 'dashed'
                    }
                }
            }
            ],
            series: [{
                name: 'hill',
                type: 'pictorialBar',
                barCategoryGap: '0%',
                symbol: 'path://M0,10 L10,10 C5.5,10 5.5,5 5,0 C4.5,5 4.5,10 0,10 z',
                label: {
                    show: true,
                    position: 'top',
                    distance: 15,
                    color: '#DB5E6A',
                    fontWeight: 'bolder',
                    fontSize: 20,
                },
                itemStyle: {
                    normal: {
                        color: {
                            type: 'linear',
                            x: 0,
                            y: 0,
                            x2: 0,
                            y2: 1,
                            colorStops: [{
                                offset: 0,
                                color: 'rgba(232, 94, 106, .8)' //  0%  处的颜色
                            },
                                {
                                    offset: 1,
                                    color: 'rgba(232, 94, 106, .1)' //  100%  处的颜色
                                }
                            ],
                            global: false //  缺省为  false
                        }
                    },
                    emphasis: {
                        opacity: 1
                    }
                },
                data: [123, 60, 25, 18, 12, 9, 2],
                z: 10
            }]
        };
        myChart.setOption(option);
    })();


    (function () {
        var myChart = echarts.init(document
            .querySelector(".line1 .char"));
        var option = {
            tooltip: {
                trigger: 'axis',
                axisPointer: {
                    lineStyle: {
                        color: {
                            type: 'linear',
                            x: 0,
                            y: 0,
                            x2: 0,
                            y2: 1,
                            colorStops: [{
                                offset: 0,
                                color: 'rgba(0, 255, 233,0)'
                            }, {
                                offset: 0.5,
                                color: 'rgba(255, 255, 255,1)',
                            }, {
                                offset: 1,
                                color: 'rgba(0, 255, 233,0)'
                            }],
                            global: false
                        }
                    },
                },
            },
            legend: {
                top:10,
                left:20,
                textStyle: {
                    color: '#ffffff',
                }
            },
            grid: {
                top: '15%',
                left: '10%',
                right: '5%',
                bottom: '15%',
                // containLabel: true
            },
            xAxis: [{
                type: 'category',
                axisLine: {
                    show: false,
                    color:'#A582EA'
                },

                axisLabel: {
                    color: '#A582EA',
                    width:100
                },
                splitLine: {
                    show: false
                },
                boundaryGap: false,
                data: ["6月","7月","8月","9月","10月","11月","12月"]//this.$moment(data.times).format("HH-mm") ,

            }],

            yAxis: [{
                type: 'value',
                min: 0,
                // max: 140,
                splitNumber: 4,
                splitLine: {
                    show: true,
                    lineStyle: {
                        color: '#00BFF3',
                        opacity:0.23
                    }
                },
                axisLine: {
                    show: false,
                },
                axisLabel: {
                    show: true,
                    margin: 20,
                    textStyle: {
                        color: '#fff',

                    },
                },
                axisTick: {
                    show: false,
                },
            }],
            series: [
                {
                    name:"A级警报",
                    type: 'line',
                    showAllSymbol: true,
                    symbol: 'circle',
                    symbolSize: 10,
                    lineStyle: {
                        normal: {
                            color: "#A582EA",
                        },
                    },
                    label: {
                        show: true,
                        position: 'top',
                        textStyle: {
                            color: '#A582EA',
                        }
                    },
                    itemStyle: {
                        color: "#A582EA",
                        borderColor: "#A582EA",
                        borderWidth: 2,
                    },
                    areaStyle: {
                        normal: {
                            color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                                {
                                    offset: 0,
                                    color: 'rgba(43,193,145,0.3)'
                                },
                                {
                                    offset: 1,
                                    color: 'rgba(43,193,145,0)'
                                }
                            ], false),
                        }
                    },
                    data: [4,7,5,4,3,5,8]//data.values
                },
                {
                    name:"B级警报",
                    type: 'line',
                    showAllSymbol: true,
                    symbol: 'circle',
                    symbolSize: 10,
                    lineStyle: {
                        normal: {
                            color: "#2CABE3",
                        },
                    },
                    label: {
                        show: true,
                        position: 'top',
                        textStyle: {
                            color: '#2CABE3',
                        }
                    },
                    itemStyle: {
                        color: "#2CABE3",
                        borderColor: "#2CABE3",
                        borderWidth: 2,
                    },
                    areaStyle: {
                        normal: {
                            color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                                {
                                    offset: 0,
                                    color: 'rgba(81,150,164,0.3)'
                                },
                                {
                                    offset: 1,
                                    color: 'rgba(81,150,164,0)'
                                }
                            ], false),
                        }
                    },
                    data: [3,5,4,2,1,7,6]//data.values
                },
            ]
        };
        myChart.setOption(option);
    })();
    (function () {
        var myChart = echarts.init(document
            .querySelector(".pie1 .char"));
        var option = {
            title: {

                x: 'center',
                y: 'center',
                textStyle: {
                    color: "#fff",
                    fontSize: 30,
                    fontWeight: 'normal'
                },
                subtextStyle: {
                    color: "rgba(255,255,255,.45)",
                    fontSize: 14,
                    fontWeight: 'normal'
                }
            },
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            legend: {
                x: 'center',
                y: 'bottom',
                data: ['rose3', 'rose5', 'rose6', 'rose7', 'rose8']
            },
            calculable: true,
            series: [

                {
                    name: '面积模式',
                    type: 'pie',
                    radius: [50, 80],
                    center: ['50%', '50%'],
                    data: [{
                        value: 34,
                        name: '吴际帅\n牛亚莉',
                        itemStyle: {

                            color: new echarts.graphic.LinearGradient(0, 1, 0, 0, [{
                                offset: 0,
                                color: '#f6e3a1'
                            }, {
                                offset: 1,
                                color: '#ff4236'
                            }])
                        },
                        label: {
                            color: "rgba(255,255,255,.45)",
                            fontSize: 14,
                            formatter: '完成梳理部门\n{a|34}个',
                            rich: {
                                a: {
                                    color: "#fff",
                                    fontSize: 20,
                                    lineHeight: 30
                                },
                            }
                        }
                    },
                        {
                            value: 52,
                            name: 'rose2',
                            itemStyle: {
                                color: "transparent"
                            }
                        }
                    ]
                },
                {
                    name: '面积模式',
                    type: 'pie',
                    radius: [50, 80],
                    center: ['50%', '50%'],
                    data: [{
                        value: 34,
                        name: '吴际帅\n牛亚莉',
                        itemStyle: {
                            color: "transparent"
                        }
                    },
                        {
                            value: 52,
                            name: 'rose2',
                            itemStyle: {

                                color: new echarts.graphic.LinearGradient(0, 1, 0, 0, [{
                                    offset: 0,
                                    color: '#348fe6'
                                }, {
                                    offset: 1,
                                    color: '#625bef'
                                }])
                            },
                            label: {
                                color: "rgba(255,255,255,.45)",
                                fontSize: 14,
                                formatter: '部门总量\n{a|52}个',
                                rich: {
                                    a: {
                                        color: "#fff",
                                        fontSize: 20,
                                        lineHeight: 30
                                    },
                                }
                            }
                        }
                    ]
                }
            ]
        };
        myChart.setOption(option);
    })();
}