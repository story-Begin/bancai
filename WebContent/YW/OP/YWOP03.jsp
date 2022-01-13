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
    <title>磁盘状态信息</title>
</head>
<body style="background-color:#001F6B;">
<div>
    <div id="app">
        <div style="height: calc(100% - 20px); width: calc(100% - 20px); position: absolute;">
            <%--  操作区 --%>
            <div style="height:45px; width: 100%;" class="block-border">
                <div style="line-height:40px; width: 100%; float:left;">
                    <el-input v-model="queryContent" clearable style="width:30%; padding-left:10%;"
                              size="mini"
                              placeholder="请输入设备【名称】进行搜索"></el-input>
                    <el-button size="mini" type="primary" class="btn_search" icon="el-icon-search"
                               @click="searchDevicePollList">
                        查询
                    </el-button>
                </div>
            </div>
                <div style="height: calc(52% - 40px); width:100%; margin-top: 8px; float:left;" class="block-border">
                <%-- 数据列表 --%>
                <el-table
                        ref="deviceDiskTableRef"
                        v-loading="deviceDiskTableLoading"
                        :data="deviceDiskDataList.slice((currentPage-1)*pageSize,currentPage*pageSize)"
                        border
                        size="mini"
                        tooltip-effect="dark"
                        style="width: 100%;"
                        highlight-current-row
                        height="calc(100% - 34px)"
                        element-loading-text="拼命加载中"
                        element-loading-spinner="el-icon-loading"
                        element-loading-background="rgba(0, 0, 0, 0.8)"
                        @row-click="handleClickDeviceDiskRow"
                        :header-cell-style="{'text-align': 'left'}"
                >
                    <%--                    <el-table-column label="设备编号" prop="deviceId" show-overflow-tooltip--%>
                    <%--                                     min-width="180"></el-table-column>--%>
                    <el-table-column label="设备名称" prop="deviceName" show-overflow-tooltip
                                     min-width="180"></el-table-column>
                    <el-table-column label="设备类型" prop="deviceType" show-overflow-tooltip
                                     min-width="180"></el-table-column>
                    <el-table-column label="工作时长" prop="statusTimeStr" show-overflow-tooltip
                                     min-width="180"></el-table-column>
                    <el-table-column label="在线状态" show-overflow-tooltip
                                     min-width="180">
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
                </el-table>
                <div style="text-align:center; height: 35px;">
                    <el-pagination
                            style="height: 90%; padding-top:2px;"
                            layout="total, sizes, prev, pager, next"
                            :total="deviceDiskDataList.length"
                            :pager-count="5"
                            :page-size="pageSize"
                            :current-page="currentPage"
                            :page-sizes="pageSizes"
                            @current-change="handleCurrentChange"
                            @size-change="handleSizeChange"
                    />
                </div>
            </div>
                <div style="height: calc(50% - 30px); width:100%; margin-top: 8px; float:left;" class="block-border">
                <el-table
                        :data="diskDetailDataList"
                        border
                        size="mini"
                        tooltip-effect="dark"
                        style="width: 100%;"
                        highlight-current-row
                        height="100%"
                        element-loading-text="拼命加载中"
                        element-loading-spinner="el-icon-loading"
                        element-loading-background="rgba(0, 0, 0, 0.8)"
                        :header-cell-style="{'text-align': 'left'}"
                >
                    <el-table-column label="硬盘序号" min-width="120" prop="diskIndex"></el-table-column>
                    <el-table-column label="硬盘容量" min-width="160" >
                        <template slot-scope="scope">
                            <el-progress :text-inside="true" :stroke-width="17"
                                         :percentage="setItemNumb(scope.row)"
                                         :format="setItemText(scope.row)">
                            </el-progress>
                        </template>
                    </el-table-column>
                    <el-table-column label="硬盘容量" prop="diskCapacity" show-overflow-tooltip
                                     min-width="200"></el-table-column>
                    <el-table-column label="剩余容量" prop="diskRemain" show-overflow-tooltip
                                     min-width="160"></el-table-column>
                    <el-table-column label="故障时间" prop="diskStatusTimeStr" show-overflow-tooltip
                                     min-width="160"></el-table-column>
                    <el-table-column label="磁盘状态" show-overflow-tooltip
                                     min-width="160">
                        <template slot-scope="scope">
                            <p v-if="scope.row.diskStatus=='0'">
                                <span style="color: #A9A9A9">●</span>
                                <span>离线</span>
                            </p>
                            <p v-if="scope.row.diskStatus=='1'">
                                <span style="color: #00FF00">●</span>
                                <span>在线</span>
                            </p>
                        </template>
                    </el-table-column>
                </el-table>
            </div>
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
<script type="text/javascript">

    let doit = new Vue({
        el: '#app',
        data: {
            queryContent: "",
            devicePollRowIndex: 0,
            // 主表格
            deviceDiskDataList: [],
            deviceDiskDataListCopy: [],
            devicePollCurrentRow: {},
            deviceDiskTableLoading: false,
            videoRecordRowIndex: 0,
            deviceDiskPage: {
                pageNo: 1,
                pageSize: 20,
                totalCount: 0,
                pageSizes: [20, 50, 100]
            },
            // 子表格
            currentPage:1,
            pageSize:20,
            pageSizes:[20, 50, 100],
            diskDetailDataList: [],
            cameraDataTableLoading: false,
        },
        created: function () {
            this.getDeviceDiskList()
        },
        methods: {

            getDeviceDiskList() {
                let queryData = {
                    pageSize: this.deviceDiskPage.pageSize,
                    pageNo: this.deviceDiskPage.pageNo
                }
                this.deviceDiskTableLoading = true;
                getDeviceDiskList(queryData).then(res => {
                    this.deviceDiskDataList = res.data.data.dataList;
                    this.deviceDiskDataListCopy = res.data.data.dataList;
                    if (this.deviceDiskDataList) {
                        this.$refs.deviceDiskTableRef.setCurrentRow(this.deviceDiskDataList[this.videoRecordRowIndex])
                        this.diskDetailDataList = this.deviceDiskDataList[this.videoRecordRowIndex].diskList;
                    }
                    this.deviceDiskTableLoading = false;
                }).catch(err => {
                    this.deviceDiskTableLoading = false;
                    console.log(err)
                })
            },

            handleClickDeviceDiskRow(row) {
                this.diskDetailDataList = row.diskList
            },

            /**
             * 自定义进度条文字
             */
            setItemText(row) {
                return () => {
                    return row.diskRemain + '/' + row.diskCapacity
                }
            },
            /**
             * 自定义进度条百分比
             */
            setItemNumb(row) {
                return Math.round(row.diskRemain / row.diskCapacity * 100)
            },

            /**
             * 主表格点击事件
             */
            handleClickDevicePollRow(record, index) {
                this.devicePollCurrentRow = record
            },

            /**
             * 查询方法
             */
            searchDevicePollList() {
                this.deviceDiskDataList = this.deviceDiskDataListCopy.filter((item)=>{
                    if(item.deviceName.indexOf(this.queryContent)!==-1){
                        return item;
                    }
                })

            },

            /**
             * 分页
             */
            handleCurrentChange(pageNo) {
                this.pageNo = pageNo;
            },

            handleSizeChange(pageSize) {
                this.page1.pageNo = 1;
                this.pageSize = pageSize;
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
<style scoped>
    .el-progress-bar__outer {
        border-radius: 0px;
    }
    .el-progress-bar__inner {
        border-radius: 0px;
    }
</style>
