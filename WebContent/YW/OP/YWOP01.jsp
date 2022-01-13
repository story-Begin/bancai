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
    <title>视频通道状态信息</title>
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
                    <el-button-group style="width:200px; float:right; margin-top: 8px;">
                        <el-button type="primary" size="mini" icon="el-icon-refresh"
                                   @click="getVideoAisleList" :loading="logining">手动更新
                        </el-button>
                    </el-button-group>
                </div>
            </div>
            <div style="height: calc(100% - 57px); width:100%; margin-top: 8px; float:left;" class="block-border">
                <%-- 数据列表 --%>
                <el-table
                        ref="devicePollTableRef"
                        v-loading="tableLoading"
                        :data="cameraAisleList.slice((page1.pageNo-1)*page1.pageSize,page1.pageNo*page1.pageSize)"
                        border
                        size="mini"
                        tooltip-effect="dark"
                        style="width: 100%;"
                        highlight-current-row
                        element-loading-text="拼命加载中"
                        element-loading-spinner="el-icon-loading"
                        element-loading-background="rgba(0, 0, 0, 0.8)"
                        height="calc(100% - 34px)"
                        :header-cell-style="{'text-align': 'center'}"
                >
                    <%--                    <el-table-column label="设备ID" prop="deviceId" show-overflow-tooltip--%>
                    <%--                                     align="center" min-width="100"></el-table-column>--%>
                    <el-table-column label="设备名称" prop="cameraName" show-overflow-tooltip
                                     align="center" min-width="160"></el-table-column>
                    <%--                    <el-table-column label="设备代码" prop="deviceCode" show-overflow-tooltip--%>
                    <%--                                     v-if="false" align="center" min-width="120"></el-table-column>--%>
                    <%--                    <el-table-column label="设备IP" prop="deviceIp" show-overflow-tooltip--%>
                    <%--                                     v-if="false" align="center" min-width="120"></el-table-column>--%>
                    <%--                    <el-table-column label="通道索引" prop="channelIndex" show-overflow-tooltip--%>
                    <%--                                     v-if="false" align="center" min-width="120"></el-table-column>--%>
                    <%--                    <el-table-column label="摄像机名称" prop="cameraName" show-overflow-tooltip--%>
                    <%--                                     v-if="false" align="center" min-width="120"></el-table-column>--%>
                    <%--                    <el-table-column label="摄像机IP" prop="cameraIp" show-overflow-tooltip--%>
                    <%--                                     v-if="false" align="center" min-width="120"></el-table-column>--%>
                    <%--                    <el-table-column label="相机状态时间" prop="cameraStatusTime" show-overflow-tooltip--%>
                    <%--                                     v-if="false" align="center" min-width="140"></el-table-column>--%>
                    <%--                    <el-table-column label="照片Url" prop="pictureUrl" show-overflow-tooltip--%>
                    <%--                                     v-if="false" align="center" min-width="120"></el-table-column>--%>
                        <%--                        <el-table-column label="诊断结果" prop="diagnoseResult" show-overflow-tooltip--%>
                        <%--                                          align="center" min-width="120"></el-table-column>--%>
                    <el-table-column label="诊断时间" prop="cameraStatusTime" show-overflow-tooltip
                                     align="center" min-width="140"></el-table-column>
                    <el-table-column label="亮度状态" prop="brightnessStatus" show-overflow-tooltip
                                     align="center" min-width="70">
                        <template slot-scope="scope">
                            <p v-if="scope.row.brightnessStatus=='异常'">
                                <span style="color: #A9A9A9">●</span>
                            </p>
                            <p v-else-if="scope.row.brightnessStatus=='正常'">
                                <span style="color: #00FF00">●</span>
                            </p>
                            <p v-else>
                                <span style="color: #ff751a">●</span>
                            </p>
                        </template>
                    </el-table-column>
                    <el-table-column label="杂音状态" prop="noiseStatus" show-overflow-tooltip
                                     align="center" min-width="70">
                        <template slot-scope="scope">
                            <p v-if="scope.row.noiseStatus=='异常'">
                                <span style="color: #A9A9A9">●</span>
                            </p>
                            <p v-else-if="scope.row.noiseStatus=='正常'">
                                <span style="color: #00FF00">●</span>
                            </p>
                            <p v-else>
                                <span style="color: #ff751a">●</span>
                            </p>
                        </template>
                    </el-table-column>
                    <el-table-column label="控制状态" prop="ctRunawayStatus" show-overflow-tooltip
                                     align="center" min-width="70">
                        <template slot-scope="scope">
                            <p v-if="scope.row.ctRunawayStatus=='异常'">
                                <span style="color: #A9A9A9">●</span>
                            </p>
                            <p v-else-if="scope.row.ctRunawayStatus=='正常'">
                                <span style="color: #00FF00">●</span>
                            </p>
                            <p v-else>
                                <span style="color: #ff751a">●</span>
                            </p>
                        </template>
                    </el-table-column>
                    <el-table-column label="场景变化状态" prop="scenechangeStatus" show-overflow-tooltip
                                     align="center" min-width="95">
                        <template slot-scope="scope">
                            <p v-if="scope.row.scenechangeStatus=='异常'">
                                <span style="color: #A9A9A9">●</span>
                            </p>
                            <p v-else-if="scope.row.scenechangeStatus=='正常'">
                                <span style="color: #00FF00">●</span>
                            </p>
                            <p v-else>
                                <span style="color: #ff751a">●</span>
                            </p>
                        </template>
                    </el-table-column>
                        <el-table-column label="遮挡状态" prop="coverStatus" show-overflow-tooltip
                                         align="center" min-width="70">
                        <template slot-scope="scope">
                            <p v-if="scope.row.coverStatus=='异常'">
                                <span style="color: #A9A9A9">●</span>
                            </p>
                            <p v-else-if="scope.row.coverStatus=='正常'">
                                <span style="color: #00FF00">●</span>
                            </p>
                            <p v-else>
                                <span style="color: #ff751a">●</span>
                            </p>
                        </template>
                    </el-table-column>
                        <el-table-column label="条纹状态" prop="striationStatus" show-overflow-tooltip
                                         align="center" min-width="70">
                        <template slot-scope="scope">
                            <p v-if="scope.row.striationStatus=='异常'">
                                <span style="color: #A9A9A9">●</span>
                            </p>
                            <p v-else-if="scope.row.striationStatus=='正常'">
                                <span style="color: #00FF00">●</span>
                            </p>
                            <p v-else>
                                <span style="color: #ff751a">●</span>
                            </p>
                        </template>
                    </el-table-column>
                    <el-table-column label="冻结状态" prop="frozenStatus" show-overflow-tooltip
                                     align="center" min-width="70">
                        <template slot-scope="scope">
                            <p v-if="scope.row.frozenStatus=='异常'">
                                <span style="color: #A9A9A9">●</span>
                            </p>
                            <p v-else-if="scope.row.frozenStatus=='正常'">
                                <span style="color: #00FF00">●</span>
                            </p>
                            <p v-else>
                                <span style="color: #ff751a">●</span>
                            </p>
                        </template>
                    </el-table-column>
                    <el-table-column label="摄像头状态" prop="cameraStatus" show-overflow-tooltip
                                     align="center" min-width="80">
                        <template slot-scope="scope">
                            <p v-if="scope.row.cameraStatus=='异常'">
                                <span style="color: #A9A9A9">●</span>
                            </p>
                            <p v-else-if="scope.row.cameraStatus=='正常'">
                                <span style="color: #00FF00">●</span>
                            </p>
                            <p v-else>
                                <span style="color: #ff751a">●</span>
                            </p>
                        </template>
                    </el-table-column>
                    <el-table-column label="图像状态" prop="bwImageStatus" show-overflow-tooltip
                                     align="center" min-width="70">
                        <template slot-scope="scope">
                            <p v-if="scope.row.bwImageStatus=='异常'">
                                <span style="color: #A9A9A9">●</span>
                            </p>
                            <p v-else-if="scope.row.bwImageStatus=='正常'">
                                <span style="color: #00FF00">●</span>
                            </p>
                            <p v-else>
                                <span style="color: #ff751a">●</span>
                            </p>
                        </template>
                    </el-table-column>
                        <el-table-column label="对比度" prop="contrastStatus" show-overflow-tooltip
                                         align="center" min-width="70">
                        <template slot-scope="scope">
                            <p v-if="scope.row.contrastStatus=='异常'">
                                <span style="color: #A9A9A9">●</span>
                            </p>
                            <p v-else-if="scope.row.contrastStatus=='正常'">
                                <span style="color: #00FF00">●</span>
                            </p>
                            <p v-else>
                                <span style="color: #ff751a">●</span>
                            </p>
                        </template>
                    </el-table-column>
                        <el-table-column label="偏色状态" prop="unbalanceStatus" show-overflow-tooltip
                                         align="center" min-width="80">
                        <template slot-scope="scope">
                            <p v-if="scope.row.unbalanceStatus=='异常'">
                                <span style="color: #A9A9A9">●</span>
                            </p>
                            <p v-else-if="scope.row.unbalanceStatus=='正常'">
                                <span style="color: #00FF00">●</span>
                            </p>
                            <p v-else>
                                <span style="color: #ff751a">●</span>
                            </p>
                        </template>
                    </el-table-column>
                        <el-table-column label="清晰度状" prop="blurStatus" show-overflow-tooltip
                                         align="center" min-width="70">
                        <template slot-scope="scope">
                            <p v-if="scope.row.blurStatus=='异常'">
                                <span style="color: #A9A9A9">●</span>
                            </p>
                            <p v-else-if="scope.row.blurStatus=='正常'">
                                <span style="color: #00FF00">●</span>
                            </p>
                            <p v-else>
                                <span style="color: #ff751a">●</span>
                            </p>
                        </template>
                    </el-table-column>
                        <el-table-column label="抖动状态" prop="ditherStatus" show-overflow-tooltip
                                         align="center" min-width="95">
                        <template slot-scope="scope">
                            <p v-if="scope.row.ditherStatus=='异常'">
                                <span style="color: #A9A9A9">●</span>
                            </p>
                            <p v-else-if="scope.row.ditherStatus=='正常'">
                                <span style="color: #00FF00">●</span>
                            </p>
                            <p v-else>
                                <span style="color: #ff751a">●</span>
                            </p>
                        </template>
                    </el-table-column>
                        <el-table-column label="丢失状态" prop="lossStatus" show-overflow-tooltip
                                         align="center" min-width="70">
                        <template slot-scope="scope">
                            <p v-if="scope.row.lossStatus=='异常'">
                                <span style="color: #A9A9A9">●</span>
                            </p>
                            <p v-else-if="scope.row.lossStatus=='正常'">
                                <span style="color: #00FF00">●</span>
                            </p>
                            <p v-else>
                                <span style="color: #ff751a">●</span>
                            </p>
                        </template>
                    </el-table-column>
                        <el-table-column label="视频剧变" prop="videoShakeUpStatus" show-overflow-tooltip
                                         align="center" min-width="95">
                        <template slot-scope="scope">
                            <p v-if="scope.row.videoShakeUpStatus=='异常'">
                                <span style="color: #A9A9A9">●</span>
                            </p>
                            <p v-else-if="scope.row.videoShakeUpStatus=='正常'">
                                <span style="color: #00FF00">●</span>
                            </p>
                            <p v-else>
                                <span style="color: #ff751a">●</span>
                            </p>
                        </template>
                    </el-table-column>
                        <el-table-column label="状态时长" prop="statusTimeStr" show-overflow-tooltip
                                         align="center" min-width="120"></el-table-column>
                        <el-table-column label="失败原因" prop="failedCause" show-overflow-tooltip
                                         align="center" min-width="120"></el-table-column>
                </el-table>
                <div style="text-align:center; height: 35px;">
                    <div style="float: left; height: 35px;line-height:35px;margin-left: 2%">
                        <span style="color: #00FF00;font-weight:bold">●</span>
                        <span style="color: white;font-size: 13px">在线&nbsp;</span>
                        <span style="color: #A9A9A9;font-weight:bold;">●</span>
                        <span style="color: white;font-size: 13px">离线&nbsp;</span>
                        <span style="color: #ff751a;font-weight:bold;">●</span>
                        <span style="color: white;font-size: 13px">未知</span>
                    </div>
                    <div style="float: left; height: 35px;margin-left: 26%">
                        <el-pagination
                                style="height: 90%; padding-top:2px;"
                                layout="total, sizes, prev, pager, next"
                                :total="cameraAisleList.length"
                                :pager-count="5"
                                :page-size="page1.pageSize"
                                :current-page="page1.pageNo"
                                :page-sizes="page1.pageSizes"
                                @current-change="handleCurrentChange"
                                @size-change="handleSizeChange"
                        />
                    </div>

                </div>
            </div>
        </div>

    </div>
</div>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/dahua/jquery.min.js"></script>
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
            logining: false,
            queryContent: null,
            cameraAisleList: [],
            cameraAisleListCopy:[],
            tableLoading: false,
            page: {
                pageNo: 1,
                pageSize: 20,
                totalCount: 0,
                pageSizes: [20, 50, 100]
            },
            page1: {
                pageNo: 1,
                pageSize: 20,
                totalCount: 0,
                pageSizes: [20, 50, 100]
            },
        },
        mounted(){
            this.getVideoAisleList();
        },
        methods: {

            getVideoAisleList() {
                let queryDTO = {
                    pageSize: this.page.pageSize,
                    pageNo: this.page.pageNo
                }
                this.logining = true;
                this.tableLoading = true;
                getVideoAisleList(queryDTO).then(res => {
                    this.page.totalCount = res.data.data.totalCount;
                    this.cameraAisleList = res.data.data.dataList;
                    this.cameraAisleListCopy =res.data.data.dataList;
                    this.tableLoading = false;
                    this.logining = false;

                }).catch(err => {
                    console.log(err);
                    this.tableLoading = false;
                    this.logining = false;
                })
            },

            /**
             * 查询方法
             */
            searchDevicePollList() {
                this.cameraAisleList = this.cameraAisleListCopy.filter((item) => {
                    if(item.cameraName.indexOf(this.queryContent)!==-1){
                        return item;
                    }
                });
                this.page1.pageNo=1;
            },

            /**
             * 分页
             */
            handleCurrentChange(pageNo) {
                this.page1.pageNo = pageNo;

            },

            handleSizeChange(pageSize) {
                this.page1.pageNo = 1;
                this.page1.pageSize = pageSize;
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
