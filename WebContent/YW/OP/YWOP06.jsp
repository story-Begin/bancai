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
    <title>平台状态管理</title>
</head>
<body style="background-color:#001F6B;">
<div>
    <div id="app">
        <div style="height: calc(100% - 20px); width: calc(100% - 20px); position: absolute">
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

            <div style="height: calc(100% - 57px); width:100%; margin-top: 8px; float:left;height: 90%" class="block-border">
                <el-table
                        height="calc(100% - 35px)"
                        ref="videoTableRef"
                        v-loading="platformTableLoading"
                        :data="platformDataList"
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
                    <el-table-column label="平台编号" prop="domainId" show-overflow-tooltip
                                     min-width="160"></el-table-column>
                    <el-table-column label="平台名称" prop="domainName" show-overflow-tooltip
                                     min-width="200"></el-table-column>
                    <el-table-column label="平台代码" prop="domainCode" show-overflow-tooltip
                                     min-width="160"></el-table-column>
                    <el-table-column label="平台IP" prop="domainIP" show-overflow-tooltip
                                     min-width="200"></el-table-column>
                    <el-table-column label="在线状态" prop="onlineStatus" show-overflow-tooltip
                                     min-width="160">
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
                    <el-table-column label="在线状态时间" prop="onlineStatusTime" show-overflow-tooltip
                                     min-width="200" :render-header="renderHeader"></el-table-column>
                </el-table>
                <div style="text-align:center; background: rgba(184,184,184,0.24)">
                    <el-pagination
                            layout="total, sizes, prev, pager, next"
                            :total="platformPage.totalCount"
                            :pager-count="5"
                            :page-size="platformPage.pageSize"
                            :current-page="platformPage.pageNo"
                            :page-sizes="platformPage.pageSizes"
                            @current-change="handleCurrentChange"
                            @size-change="handleSizeChange"
                    />
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/vue.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/element.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/axios.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/api/yw/maintain.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/enum/cx/devicePoll/callPoliceGradeEnum.js"></script>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script>
    var ctx = '${pageContext.request.contextPath}'
</script>
</body>
</html>

<script type="text/javascript" src="${pageContext.request.contextPath}/static/cx/js/echarts.min.js"></script>
<script type="text/javascript">
    //echarts图
    // function initEchartsData(){
    //     //扇形图
    //     var myChart = echarts.init(document.getElementById('pie'));
    //     var pie = {
    //         title: {
    //             text: '磁盘状态统计',
    //             left: 'center'
    //         },
    //         tooltip: {
    //             trigger: 'item',
    //             formatter: '{a} <br/>{b} : {c} ({d}%)'
    //         },
    //         legend: {
    //             orient: 'vertical',
    //             left: 'left',
    //             data: ['硬盘正常', '硬盘故障', '硬盘满', '硬盘空闲', '硬盘异常', '硬盘热备', '硬盘离线', '硬盘重建',
    //                 '硬盘备份', '硬盘移除', '硬盘同步']
    //         },
    //         series: [
    //             {
    //                 name: '磁盘状态',
    //                 type: 'pie',
    //                 radius: '55%',
    //                 center: ['50%', '60%'],
    //                 data: [
    //                     {value: 335, name: '硬盘正常'},
    //                     {value: 310, name: '硬盘故障'},
    //                     {value: 234, name: '硬盘满'},
    //                     {value: 135, name: '硬盘空闲'},
    //                     {value: 567, name: '硬盘异常'},
    //                     {value: 200, name: '硬盘热备'},
    //                     {value: 300, name: '硬盘离线'},
    //                     {value: 400, name: '硬盘重建'},
    //                     {value: 600, name: '硬盘备份'},
    //                     {value: 700, name: '硬盘移除'},
    //                     {value: 900, name: '硬盘同步'}
    //                 ],
    //                 emphasis: {
    //                     itemStyle: {
    //                         shadowBlur: 10,
    //                         shadowOffsetX: 0,
    //                         shadowColor: 'rgba(0, 0, 0, 0.5)'
    //                     }
    //                 }
    //             }
    //         ]
    //     };
    //     myChart.setOption(pie);
    //
    //     //柱状图
    //     var myChart = echarts.init(document.getElementById('bar'));
    //     var bar = {
    //         color: ['#3398DB'],
    //         tooltip: {
    //             trigger: 'axis',
    //             axisPointer: {            // 坐标轴指示器，坐标轴触发有效
    //                 type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
    //             }
    //         },
    //         grid: {
    //             left: '3%',
    //             right: '4%',
    //             bottom: '3%',
    //             containLabel: true
    //         },
    //         xAxis: [
    //             {
    //                 type: 'category',
    //                 data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
    //                 axisTick: {
    //                     alignWithLabel: true
    //                 }
    //             }
    //         ],
    //         yAxis: [
    //             {
    //                 type: 'value'
    //             }
    //         ],
    //         series: [
    //             {
    //                 name: '磁盘状态',
    //                 type: 'bar',
    //                 barWidth: '60%',
    //                 data: [10, 52, 200, 334, 390, 330, 220]
    //             }
    //         ]
    //     };
    //     myChart.setOption(bar);
    // }


    let doit = new Vue({
        el: '#app',
        data: {
            queryContent: null,
            platformTableLoading: false,
            platformDataList: [],
            platformPage: {
                pageNo: 1,
                pageSize: 20,
                totalCount: 0,
                pageSizes: [20, 50, 100]
            },
        },
        created: function () {
            this.getPlatformDomainList()
        },
        methods: {

            getPlatformDomainList() {
                let queryData = {
                    pageSize: this.platformPage.pageSize,
                    pageNo: this.platformPage.pageNo
                }
                this.platformTableLoading = true;
                getPlatformDomainList(queryData).then(res => {
                    this.platformTableLoading = false;
                    this.platformDataList = res.data.data.dataList;
                    this.platformPage.totalCount = res.data.data.totalCount;
                }).catch(err => {
                    console.log(err)
                    this.platformTableLoading = false;
                })
            },

            //  分页
            handleCurrentChange(pageNo) {
                this.platformPage.pageNo = pageNo
                this.getPlatformDomainList()
            },

            handleSizeChange(pageSize) {
                this.platformPage.pageSize = pageSize
                this.getPlatformDomainList()
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
