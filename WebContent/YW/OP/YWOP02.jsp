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
    <title>通道录像信息</title>
</head>
<body style="background-color:#001F6B;">
<div>
    <div id="app">
        <div style="height: calc(100% - 20px); width: calc(100% - 20px); position: absolute;">
            <div style="height:45px; width: 100%;" class="block-border">
                <div style="line-height:40px; width: 100%; float:left;">
                    <el-date-picker
                            size="mini"
                            clearable
                            style="width: 20%; margin-left:10%;"
                            v-model="queryRecordDate"
                            type="date"
                            value-format="yyyy-MM-dd"
                            placeholder="请选择日期">
                    </el-date-picker>
                    <el-button size="mini" type="primary" class="btn_search" icon="el-icon-search"
                               @click="searchDevicePollList">
                        查询
                    </el-button>
                </div>
            </div>
            <div style="height: calc(55% - 50px); width:100%; margin-top: 8px; float:left;" class="block-border">
                <el-table
                        ref="videoRecordTableRef"
                        v-loading="videoTableLoading"
                        :data="videoRecordData"
                        border
                        size="mini"
                        tooltip-effect="dark"
                        style="width: 100%;"
                        highlight-current-row
                        height="calc(100% - 34px)"
                        element-loading-text="拼命加载中"
                        element-loading-spinner="el-icon-loading"
                        element-loading-background="rgba(0, 0, 0, 0.8)"
                        @row-click="handleClickDevicePollRow"
                        :header-cell-style="{'text-align': 'left'}"
                >
                    <el-table-column label="设备名称" prop="deviceName" show-overflow-tooltip
                                     min-width="120"></el-table-column>
                    <el-table-column label="设备序号" prop="deviceIndex" show-overflow-tooltip
                                     min-width="100"></el-table-column>
                    <el-table-column label="设备编号" prop="deviceId" show-overflow-tooltip
                                     min-width="100"></el-table-column>
                    <el-table-column label="通道名称" prop="channelName" show-overflow-tooltip
                                     min-width="120"></el-table-column>
                    <el-table-column label="通道序号" prop="channelIndex" show-overflow-tooltip
                                     min-width="100"></el-table-column>
                    <el-table-column label="是否正在录像" prop="recordingStatus" show-overflow-tooltip
                                     min-width="100" :formatter="getDocStatusName"></el-table-column>
                    <el-table-column label="最早录像时间" prop="displayedEarlestRecordTime" show-overflow-tooltip
                                     min-width="120"></el-table-column>
                    <el-table-column label="录像保存天数" prop="recordIntervalTime" show-overflow-tooltip
                                     min-width="100"></el-table-column>
                </el-table>
                <div style="text-align:center; height: 35px;">
                    <el-pagination
                            style="height: 90%; padding-top:2px;"
                            layout="total, sizes, prev, pager, next"
                            :total="videoPage.totalCount"
                            :pager-count="5"
                            :page-size="videoPage.pageSize"
                            :current-page="videoPage.pageNo"
                            :page-sizes="videoPage.pageSizes"
                            @current-change="handleCurrentChange"
                            @size-change="handleSizeChange"
                    />
                </div>
            </div>
            <div style="height: calc(45% - 10px); width:100%; margin-top: 8px; float:left;" class="block-border">
                <el-table
                        ref="cameraDataTableRef"
                        v-loading="videoDetailTableLoading"
                        :data="videoDetail"
                        border
                        size="mini"
                        tooltip-effect="dark"
                        style="width: 100%;"
                        highlight-current-row
                        height="100%"
                        :header-cell-style="{'text-align': 'left'}"
                >
                    <el-table-column label="录像序号" prop="hoursIndex" show-overflow-tooltip min-width="180"
                                     ></el-table-column>
                    <el-table-column label="录像状态" prop="recordStatus" show-overflow-tooltip min-width="150"
                                     ></el-table-column>
                    <el-table-column label="录像时间" prop="recordTime" show-overflow-tooltip min-width="180"
                                     ></el-table-column>
                    <el-table-column label="在线时长率" prop="percent" show-overflow-tooltip min-width="240"
                                     ></el-table-column>
                </el-table>
            </div>
        </div>

    </div>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/dahua/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/vue.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/element.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/axios.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/enum/YW/recordingStatus/recordingStatus.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/api/yw/maintain.js"></script>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script>
    var ctx = '${pageContext.request.contextPath}'
</script>
</body>
</html>
<script type="text/javascript">

    let doit = new Vue({
        el: '#app',
        data: {
            queryRecordDate: null,
            videoRowIndex: 0,
            // 主表格
            videoRecordData: [],
            videoTableLoading: false,
            videoDetailTableLoading: false,
            videoRecordRowIndex: 0,
            videoPage: {
                pageNo: 1,
                pageSize: 20,
                totalCount: 0,
                pageSizes: [20, 50, 100]
            },
            // 子表格
            videoDetail: []
        },
        created: function () {
            this.getVideoRecordList()
        },
        methods: {

            getVideoRecordList() {
                let queryData = {
                    pageSize: this.videoPage.pageSize,
                    pageNo: this.videoPage.pageNo,
                    recordDate: this.queryRecordDate
                }
                this.videoTableLoading = true;
                getVideoRecordList(queryData).then(res => {
                    this.videoRecordData = res.data.data.dataList;
                    this.videoPage.totalCount = res.data.data.totalCount;
                    this.videoTableLoading = false;
                    if (this.videoRecordData) {
                        this.$refs.videoRecordTableRef.setCurrentRow(this.videoRecordData[this.videoRecordRowIndex])
                        this.videoDetail = this.videoRecordData[this.videoRecordRowIndex].dailyDetails;
                    }
                }).catch(err => {
                    console.log(err)
                    this.videoTableLoading = false;
                })
            },

            /**
             * 主表格点击事件
             */
            handleClickDevicePollRow(record, index) {
                for (let i = 0; i < this.videoRecordData.length; i++) {
                    if (record.id === this.videoRecordData[i].id) {
                        this.videoRecordRowIndex = i
                    }
                }
                this.videoDetailTableLoading = true;
                this.videoDetail = record.dailyDetails;
                this.videoDetailTableLoading = false;
            },

            /**
             * 查询方法
             */
            searchDevicePollList() {
                this.videoRecordRowIndex = 0;
                this.videoDetail = []
                this.getVideoRecordList();
            },

            /**
             * 枚举类型转换
             */
            getDocStatusName({ recordingStatus }) {
                return getStatusType(recordingStatus)
            },

            /**
             * 分页
             */
            handleCurrentChange(pageNo) {
                this.videoPage.pageNo = pageNo;
                this.videoRecordRowIndex = 0;
                this.getVideoRecordList();
            },

            handleSizeChange(pageSize) {
                this.videoPage.pageSize = pageSize;
                this.getVideoRecordList();
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

    .tree-checkBox .el-checkbox__inner {
        display: inline-block;
        position: relative;
        margin-right: 5px;
        border: 1px solid #DCDFE6;
        border-radius: 2px;
        -webkit-box-sizing: border-box;
        box-sizing: border-box;
        width: 14px;
        height: 14px;
        background-color: #FFF;
        z-index: 1;
        -webkit-transition: border-color .25s cubic-bezier(.71, -.46, .29, 1.46), background-color .25s cubic-bezier(.71, -.46, .29, 1.46);
        transition: border-color .25s cubic-bezier(.71, -.46, .29, 1.46), background-color .25s cubic-bezier(.71, -.46, .29, 1.46);
    }

</style>
