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
    <%--    <link rel="stylesheet" src="${pageContext.request.contextPath}/static/js/vue/element.css">--%>

    <title>报警管理</title>
</head>
<body style="background-color:#001F6B;">
<div>
    <div id="app">
        <div style="height: calc(100% - 40px); width: calc(100% - 20px); position: absolute">
            <%--  操作区 --%>
            <div style="height:45px; width: 100%;" class="block-border">
                <div style="line-height:40px; width: 100%; float:left;">
                    <el-input v-model="queryContent" clearable style="width:18%; padding-left:3%; margin-right: 15px"
                              size="mini"
                              placeholder="请输入报警信息【名称】"></el-input>
                    <%--报警类型--%>
                    <el-select v-model="queryCallPoliceType" clearable size="mini" style="width: 10%; margin-right: 15px"
                               placeholder="报警类型">
                        <el-option
                                v-for="item in callPoliceTypeList"
                                :key="item.itemCode"
                                :label="item.itemName"
                                :value="item.itemCode"
                        />
                    </el-select>
                    <%--日期筛选--%>
                    <el-date-picker
                            style="width: 15%; margin-right: 15px"
                            clearable
                            v-model="queryStartTime"
                            size="mini"
                            type="date"
                            placeholder="起始时间">
                    </el-date-picker>
                    <el-date-picker
                            style="width: 15%; margin-right: 15px"
                            clearable
                            v-model="queryEndTime"
                            size="mini"
                            type="date"
                            placeholder="结束时间">
                    </el-date-picker>
                    <%--查询按钮--%>
                    <el-button
                            size="mini" type="primary" class="btn_search" icon="el-icon-search"
                            @click="searchDeviceAlarmList">
                        查询
                    </el-button>
                    <el-button-group style="width:200px; float:right; margin-top: 8px;">
                        <el-button type="primary" size="mini" class="btn_dark_blue" icon="el-icon-download" @click="downloads">导出
                        </el-button>
                    </el-button-group>
                    <%-- <el-button-group style="width:200px; float:right; margin-top: 8px;">
                         <el-button type="primary" size="mini" icon="el-icon-plus" class="btn_dark_blue"
                                    @click="saveOpenDeviceAlarmDialog">添加
                         </el-button>
                         <el-button type="danger" size="mini" icon="el-icon-delete" class="btn_dark_black"
                                    @click="removeDeviceAlarm">删除
                         </el-button>
                         </el-button-group>--%>
                </div>
            </div>

            <el-tabs type="border-card" style="margin-top: 10px;height:calc(100% - 40px)" @tab-click="handleClick"
                     class="block-border">
                <el-tab-pane>
                    <span slot="label"><i class="el-icon-date"> </i> 报警列表</span>
                    <div style="width:100%; margin-top: 8px; float:left;height: 90%">
                        <%-- 数据列表 --%>
                        <el-table
                                height="calc(100% - 40px)"
                                ref="deviceAlarmTableRef"
                                v-loading="tableLoading"
                                :data="deviceAlarmDataList"
                                border
                                size="mini"
                                tooltip-effect="dark"
                                style="width: 100%;height:calc(100% - 35px);"
                                highlight-current-row
                                element-loading-text="拼命加载中"
                                element-loading-spinner="el-icon-loading"
                                element-loading-background="rgba(0, 0, 0, 0.8)"
                                :header-cell-style="{'text-align': 'center'}"
                                @selection-change="handleSelectionChange"
                        >
                            <el-table-column align="center" label="报警设备" prop="equipmentName" show-overflow-tooltip width="200"
                                             :render-header="renderHeader"></el-table-column>
                            <el-table-column align="center" label="报警类型" prop="callPoliceTypeName" show-overflow-tooltip width="160"></el-table-column>
                            <el-table-column align="center" label="报警级别" prop="callPoliceGradeName" show-overflow-tooltip width="160"
                                             :render-header="renderHeader"></el-table-column>
                            <el-table-column align="center" label="创建时间" prop="createTime" width="200"></el-table-column>
                            <el-table-column align="center" width="40" type="selection" fixed="left"></el-table-column>
                            <el-table-column align="center" label="设备编号" prop="equipmentNum" show-overflow-tooltip
                                             width="160"></el-table-column>
                            <el-table-column align="center" label="通道名称" width="160" prop="portName"></el-table-column>
                            <el-table-column align="center" label="通道号" width="160" prop="portCode"></el-table-column>
                            <el-table-column align="center" label="处理时间" prop="happenTime" width="160"
                                             :render-header="renderHeader"></el-table-column>
                            <el-table-column align="center" min-width="160" label="操作" align="center" fixed="right">
                                <template slot-scope="scope">
                                    <el-tooltip class="item" effect="dark" content="查看" placement="top-start">
                                        <el-button size="mini" style="padding: 3px 15px"
                                                   @click="updateOpenDeviceAlarmDialog(scope.row)"><i class="el-icon-info"></i>
                                        </el-button>
                                    </el-tooltip>
                                </template>
                            </el-table-column>
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
                    <span slot="label"><i class="el-icon-s-data"> </i> 报警统计</span>
                    <el-row style="width: 100%;height: 90%;">
                        <el-col :span="12"><div id="pie" style="height: 80%;width: 80%;margin-top: 30px;margin-right: 30px;margin-left: 80px;padding: 10px;border: 1px solid #ccc"></div></el-col>
                        <el-col :span="12"><div id="bar" style="height: 80%;width: 80%;margin-top: 30px;;padding: 10px;border: 1px solid #ccc"></div></el-col>
                    </el-row>
                </el-tab-pane>
            </el-tabs>
        </div>
    </div>
</div>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/dahua/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/vue.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/element.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/axios.min.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/api/cx/deviceAlarmApi.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/enum/cx/devicePoll/callPoliceGradeEnum.js"></script>
<%--    <script type="text/javascript"--%>
<%--            src="${pageContext.request.contextPath}/enum/cx/devicePoll/callPoliceTypeEnum.js"></script>--%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script>
    var ctx = '${pageContext.request.contextPath}'
</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/cx/js/flexible.js"></script>
</body>
</html>
<script type="text/javascript">

    let doit = new Vue({
        el: '#app',
        data: {
            callPoliceTypeList: [],
            //查询条件
            queryContent: null,
            queryCallPoliceType: null,
            queryStartTime: null,
            queryEndTime: null,
            dealStartTime:null,
            dealendTime:null,
            deviceAlarm: {
                id: null,
                equipmentNum: null,
                equipmentName: null,
                callPoliceType: null,
                happenTime: null,
                callPoliceGrade: null,
                portName:null,
                portCode:null,
                status:null
            },
            deviceAlarmList: [],
            deviceAlarmEdit: null,
            dialogVisible: false,
            dialogLoading: false,
            tableLoading: false,
            deviceAlarmDataList: [],
            page: {
                pageNo: 1,
                pageSize: 20,
                totalCount: 0,
                pageSizes: [20, 50, 100]
            }
        },
        created: function () {
            this.getDeviceAlarmList();
            this.getCallPoliceType();
        },
        methods: {

            getDeviceAlarmList() {
                let queryData = {
                    pageNo: this.page.pageNo,
                    pageSize: this.page.pageSize,
                    equipmentName: this.queryContent,
                    callPoliceType: this.queryCallPoliceType,
                    startTime: this.queryStartTime,
                    endTime: this.queryEndTime,
                    dealStartTime:this.dealStartTime,
                    dealEndTime:this.dealEndTime
                }
                this.loading = true
                getDeviceAlarmPageList(queryData).then(res => {
                    this.loading = false
                    this.deviceAlarmDataList = res.data.data.dataList
                    console.log(res.data.data.dataList);
                    this.page.totalCount = res.data.data.totalCount;
                }).catch(err => {
                    console.log(err)
                    this.loading = false
                })
            },

            /**
             * 报警类型下拉列表
             */
            getCallPoliceType() {
                selectCallPoliceType().then(res => {
                    this.callPoliceTypeList = res.data.data
                }).catch(err => {
                    console.log(err)
                })
            },


            searchDeviceAlarmList() {
                this.getDeviceAlarmList()
            },

            handleSelectionChange(val) {
                this.deviceAlarmList = []
                val.forEach(item => {
                    this.deviceAlarmList.push(item.id)
                })
            },

            saveOpenDeviceAlarmDialog() {
                if (this.$refs.deviceAlarmDialogRef) {
                    this.$refs.deviceAlarmDialogRef.resetFields()
                }
                this.deviceAlarm.id = null
                this.dialogVisible = true
                this.deviceAlarmDialogTitle = true
            },

            updateOpenDeviceAlarmDialog(rowData) {
                this.dialogVisible = true
                this.deviceAlarmDialogTitle = false
                const assignData = {}
                Object.assign(assignData, rowData)
                this.$nextTick(() => {
                    this.deviceAlarm = assignData
                })
                this.deviceAlarmEdit = rowData
            },
            //
            // /**
            //  * 新增
            //  */
            // saveDeviceAlarm() {
            //     this.tableLoading = true
            //     saveDeviceAlarm(this.deviceAlarm).then(res => {
            //         this.getDeviceAlarmList();
            //         this.$message({
            //             message: res.data.data,
            //             type: 'success'
            //         });
            //         this.dialogVisible = false;
            //         this.tableLoading = false;
            //     }).catch(err => {
            //         console.log(err)
            //         this.$message({
            //             message: "添加失败",
            //             type: 'error'
            //         });
            //         this.tableLoading = false
            //     })
            // },
            //
            // /**
            //  * 修改
            //  */
            // updateDeviceAlarm() {
            //     this.tableLoading = true
            //     updateDeviceAlarm(this.deviceAlarm).then(res => {
            //         this.getDeviceAlarmList();
            //         this.$message({
            //             message: res.data.data,
            //             type: 'success'
            //         });
            //         this.dialogVisible = false;
            //         this.tableLoading = false;
            //     }).catch(err => {
            //         console.log(err)
            //         this.$message({
            //             message: "修改失败",
            //             type: 'error'
            //         });
            //         this.tableLoading = false
            //     })
            // },

            handleCommit() {
                this.$refs.deviceAlarmDialogRef.validate(val => {
                    if (val) {
                        if (this.deviceAlarmDialogTitle) {
                            this.saveDeviceAlarm()
                            return
                        }
                        this.updateDeviceAlarm()
                    }
                })
            },
            //
            // /**
            //  * 删除
            //  */
            // removeDeviceAlarm() {
            //     this.tableLoading = true
            //     const listStr = this.deviceAlarmList.join(',')
            //     const ids = {
            //         ids: listStr
            //     }
            //     deleteDeviceAlarm(ids).then(res => {
            //         this.getDeviceAlarmList();
            //         this.$message({
            //             message: res.data.data,
            //             type: 'success'
            //         });
            //         this.dialogVisible = false;
            //         this.tableLoading = false;
            //     }).catch(err => {
            //         console.log(err)
            //         this.$message({
            //             message: "修改失败",
            //             type: 'error'
            //         });
            //         this.tableLoading = false
            //     })
            // },

            downloads() {
                console.log('开始下载-------1------')
                this.loading = true
                downloadExcel().then(res => {
                    console.log(res);
                    const fileName = '报警信息.xls';
                    if ('download' in document.createElement('a')) {
                        const blob = new Blob([res.data], {type: 'application/ms-excel'});
                        const elink = document.createElement('a');
                        elink.download = fileName;
                        elink.style.display = 'none';
                        elink.href = URL.createObjectURL(blob);
                        document.body.appendChild(elink);
                        elink.click();
                        URL.revokeObjectURL(elink.href); // 释放URL 对象
                        document.body.removeChild(elink);
                    }
                    this.loading = false
                    this.$message({
                        message: '下载成功',
                        type: 'success'
                    });
                }).catch(err => {
                    console.log(err)
                    this.loading = false
                    this.$message({
                        message: "下载失败",
                        type: 'error'
                    });
                })
            },

            // /**
            //  * 重置
            //  */
            // resetDeviceAlarm() {
            //     if (!this.deviceAlarmDialogTitle) {
            //         const assignData = {}
            //         Object.assign(assignData, this.deviceAlarmEdit)
            //         this.deviceAlarm = assignData
            //         return
            //     }
            //     this.$refs.deviceAlarmDialogRef.resetFields();
            // },

            //    分页
            handleCurrentChange(pageNo) {
                this.page.pageNo = pageNo
                this.getDeviceAlarmList()
            },

            handleSizeChange(pageSize) {
                this.page.pageSize = pageSize
                this.getDeviceAlarmList()
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

            /**
             * 报警级别
             * @param val
             * @returns {string}
             */
            getCallPoliceGrade(val) {
                return getCallPoliceGradeName(val.callPoliceGrade)
            },

            handleClick(){
                setTimeout(function () {
                    initEchartsData();
                });
            }
        }
    })
</script>

<script type="text/javascript" src="${pageContext.request.contextPath}/static/cx/js/echarts.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/cx/js/echartsData.js"></script>
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
