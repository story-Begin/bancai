<%--
  Created by IntelliJ IDEA.
  User: huang
  Date: 2020-07-13
  Time: 11:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/vue/index.css"/>
    <link href="${pageContext.request.contextPath}/static/cx/css/alarm.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/page-css.css"/>
    <style>
        .el-table--enable-row-hover .el-table__body tr:hover>td{
            background-color:#2F87F1 !important;
        }
    </style>
    <title>设备在离线历史记录</title>
</head>
<body style="background-color:#001F6B;">
<div>
    <div id="app">
        <div style="height: calc(100% - 40px); width: calc(100% - 20px); position: absolute">
            <%--  操作区 --%>
            <div style="height:45px; width: 100%;"  class="block-border">
                <div style="line-height:40px; width: 100%; float:left;">
                    <el-input v-model="queryContent" clearable style="width:18%; padding-left:3%; margin-right: 15px"
                              size="mini"
                              placeholder="请输入【设备类型】"></el-input>
                    <%--查询按钮--%>
                    <el-button
                            size="mini" type="primary" class="btn_search" icon="el-icon-search"
                    <%--@click="searchVideoList"--%>>
                        查询
                    </el-button>
                    <el-button-group style="width:200px; float:right; margin-top: 8px;">
                        <el-button type="primary" size="mini" class="btn_dark_blue" icon="el-icon-download" <%--@click="downloads"--%>>导出
                        </el-button>
                    </el-button-group>
                </div>
            </div>

            <el-tabs type="border-card" style="margin-top: 10px;height:calc(100% - 40px)"  @tab-click="handleClick"  class="block-border">
                <el-tab-pane>
                    <span slot="label"><i class="el-icon-date"> </i> 列表</span>
                    <div style="width:100%; margin-top: 8px; float:left;height: 90%">
                        <el-table
                                height="calc(100% - 40px)"
                                ref="videoTableRef"
                                v-loading="deviceHistoryTableLoading"
                                :data="deviceHistoryDataList"
                                border
                                size="mini"
                                tooltip-effect="dark"
                                style="width: 100%;height:calc(100% - 35px);"
                                highlight-current-row
                                element-loading-text="拼命加载中"
                                element-loading-spinner="el-icon-loading"
                                element-loading-background="rgba(0, 0, 0, 0.8)"
                                :header-cell-style="{'text-align': 'left'}"
                        >
                            <el-table-column label="设备编号" prop="deviceId" show-overflow-tooltip
                                             min-width="160"></el-table-column>
                            <el-table-column label="在线状态" show-overflow-tooltip
                                             min-width="200">
                                <template slot-scope="scope">
                                    <p v-if="scope.row.onlineStatus=='0'">
                                        <span style="color: #A9A9A9">●</span>
                                        <span>离线</span>
                                    </p>
                                    <p v-if="scope.row.onlineStatus=='1'">
                                        <span style="color: #00FF00">●</span>
                                        <span>在线</span>
                                    </p>
                                </template>
                            </el-table-column>
                            <el-table-column label="开始时间" prop="startTime" show-overflow-tooltip
                                             min-width="160"></el-table-column>
                            <el-table-column label="结束时间" prop="endTime" show-overflow-tooltip
                                             min-width="200"></el-table-column>
                            <el-table-column label="状态时长" prop="statusTimeStr" show-overflow-tooltip
                                             min-width="160"></el-table-column>
                        </el-table>
                        <div style="text-align:center; background: rgba(184,184,184,0.24)">
                            <el-pagination
                                    layout="total, sizes, prev, pager, next"
                                    :total="page.totalCount"
                                    :pager-count="5"
                                    :page-size="page.pageSize"
                                    :current-page="page.pageNo"
                                    :page-sizes="page.pageSizes"
                                    @current-change="handleCurrentChange"
                                    @size-change="handleSizeChange"
                            />
                        </div>
                    </div>
                </el-tab-pane>
                <el-tab-pane >
                    <span slot="label"><i class="el-icon-s-data"> </i> 统计</span>
                    <el-row style="width: 100%;height: 90%;">
                        <el-col :span="24">
                            <div class="pie" id="pie"
                                 style="height: 500px;width: 660px;margin-right: 10px;padding: 10px;border: 1px solid #ccc"></div>
                        </el-col>
                    </el-row>
                </el-tab-pane>
            </el-tabs>
        </div>
    </div>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/vue.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/element.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/axios.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/api/yw/maintain.js"></script>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script>
    var ctx = '${pageContext.request.contextPath}'
</script>
</body>
</html>

<script type="text/javascript" src="${pageContext.request.contextPath}/static/cx/js/echarts.min.js"></script>
<script type="text/javascript">
    //echarts图
    function initEchartsData(onlineObj,offlineObj){
        //扇形图
        var myChart = echarts.init(document.getElementById('pie'));
        var pie = {
            title: {
                text: '设备运行状态历史记录',
                left: "center",
                textStyle: {
                    color: "white"
                }
            },
            tooltip: {
                trigger: 'item',
                formatter: '{b} : {c} ({d}%)'
            },
            legend: {
                x: 'center',
                y: 'bottom',
                textStyle: {
                    color: "white"
                },
                data: [onlineObj.name, offlineObj.name]
            },
            series: [
                {
                    type: 'pie',
                    radius: '55%',
                    center: ['50%', '55%'],
                    data: [
                        {value: onlineObj.value, name: onlineObj.name, itemStyle:{color:'#63ABF0'}},
                        {value: offlineObj.value, name: offlineObj.name, itemStyle:{color:'#A9A9A9'}}
                    ],
                    // 设置值域的标签
                    label: {
                        normal: {
                            position: 'outer',  // 设置标签位置，默认在饼状图外 可选值：'outer' ¦ 'inner（饼状图上）'
                            // formatter: '{a} {b} : {c}个 ({d}%)'   设置标签显示内容 ，默认显示{b}
                            // {a}指series.name  {b}指series.data的name
                            // {c}指series.data的value  {d}%指这一部分占总数的百分比
                            formatter: '{b} : {c}'
                        }
                    },
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
        myChart.setOption(pie);
    }


    let doit = new Vue({
        el: '#app',
        data: {
            queryContent: null,
            deviceHistoryTableLoading: false,
            deviceHistoryDataList: [],
            sumDeviceHistoryDataList: [],
            onLine: [],
            offLine: [],
            page: {
                pageNo: 1,
                pageSize: 20,
                totalCount: 0,
                pageSizes: [20, 50, 100]
            },
            // 图表属性
            onlineNumb: 0,
            offlineNumb: 0,
            onlineObj: {
                value: 0,
                name: "在线",
            },
            offlineObj: {
                value: 0,
                name: "离线",
            },

        },
        created: function () {
            this.getDeviceHistoryList()
        },
        methods: {

            getDeviceHistoryList() {
                this.deviceHistoryTableLoading = true;
                getDeviceHistoryList().then(res => {
                    this.deviceHistoryTableLoading = false;
                    // this.deviceHistoryDataList = res.data.data;
                    this.sumDeviceHistoryDataList = res.data.data;
                    if (this.sumDeviceHistoryDataList.length > 0) {
                        for (let i = 0; i < this.sumDeviceHistoryDataList.length; i++) {
                            if (i < this.page.pageSize) {
                                this.deviceHistoryDataList.push(this.sumDeviceHistoryDataList[i]);
                            }
                        }
                    }
                    this.page.totalCount = this.sumDeviceHistoryDataList.length;
                    // 计算在线离线率
                    this.onLine = this.sumDeviceHistoryDataList.filter(it => it.onlineStatus === "1");
                    this.offLine = this.sumDeviceHistoryDataList.filter(it => it.onlineStatus === "0");
                    this.onlineObj.value = (this.onLine.length / this.sumDeviceHistoryDataList.length * 100).toFixed(2);
                    this.offlineObj.value = (this.offLine.length / this.sumDeviceHistoryDataList.length * 100).toFixed(2);
                    initEchartsData(this.onlineObj, this.offlineObj)
                }).catch(err => {
                    console.log(err)
                    this.deviceHistoryTableLoading = false;
                })
            },
            // 绘制图表
            handleClick() {
                initEchartsData(this.onlineObj,this.offlineObj)
            },

            //    分页
            handleCurrentChange(pageNo) {
                this.page.pageNo = pageNo;
                let startIndex = (pageNo - 1) * this.page.pageSize;
                let endIndex = pageNo * this.page.pageSize - 1;
                this.deviceHistoryDataList = [];
                if (this.sumDeviceHistoryDataList) {
                    for (let i = 0; i < this.sumDeviceHistoryDataList.length; i++) {
                        if (i >= startIndex && i <= endIndex) {
                            this.deviceHistoryDataList.push(this.sumDeviceHistoryDataList[i]);
                        }
                    }
                }
            },

            handleSizeChange(pageSize) {
                this.deviceHistoryTableLoading = true;
                this.page.pageSize = pageSize;
                this.page.pageNo = 1;
                this.deviceHistoryDataList = [];
                setTimeout(() => {
                    if (this.page.pageNo === 1) {
                        if (this.sumDeviceHistoryDataList.length > 0) {
                            for (let i = 0; i < this.sumDeviceHistoryDataList.length; i++) {
                                if (i < this.page.pageSize) {
                                    this.deviceHistoryDataList.push(this.sumDeviceHistoryDataList[i]);
                                }
                            }
                        }
                    }
                    this.deviceHistoryTableLoading = false;
                }, 500);
            },

            /**
             * 必填列标识
             */
            renderHeader(h, {column, $index}) {
                return h('span', {
                    domProps: {
                        transfer: true,
                        innerHTML: column.label + '<span style="color:red;"> *</span>'
                    }
                })
            },


        }
    })
</script>

<style>
    #app {
        font-family: "Helvetica Neue", Helvetica, "PingFang SC", "Hiragino Sans GB", "Microsoft YaHei", "微软雅黑", Arial, sans-serif;
        color: #756C83;
    }

    .el-table .cell {
        -webkit-box-sizing: border-box;
        box-sizing: border-box;
        white-space: normal;
        word-break: break-all;
        line-height: 23px;
        font-size: 6px;
    }

    .el-table--mini td, .el-table--mini th {
        padding: 4px 0;
    }

    .el-form-item__error {
        color: rgb(245, 108, 108);
        font-size: 12px;
        line-height: 1;
        padding-top: 4px;
        position: absolute;
        top: 70%;
        left: 0px;
    }

</style>
