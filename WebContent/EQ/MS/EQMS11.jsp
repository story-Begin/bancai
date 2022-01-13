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
    <%--    <link rel="stylesheet" src="${pageContext.request.contextPath}/static/js/vue/element.css">--%>
    <style>
        .el-table--enable-row-hover .el-table__body tr:hover>td{
            background-color:#2F87F1 !important;
        }
    </style>

    <title>用户组设备管理</title>
</head>
<body>
<div>
    <div id="app">
        <div style="height: calc(60% - 40px); width: calc(100% - 20px); position: absolute">
            <%--  操作区 --%>
            <div style="height:45px; width: 100%; border:2px solid #DDDDDD;">
                <div style="line-height:40px; width: 100%; float:left;">
                    <el-button type="text" style="width:5%; padding-left:2%;">用户组</el-button>
                    <el-input v-model="queryContent" clearable style="width:30%; padding-left:10%;"
                              size="mini"
                              placeholder="请输入群组中(英)文名进行搜索"></el-input>
                    <el-button size="mini" type="primary" class="btn_search" icon="el-icon-search"
                               @click="searchUserGroupList">
                        查询
                    </el-button>
                    <el-button-group style="width:200px; float:right; margin-top: 8px;">
                        <el-button type="primary" size="mini" icon="el-icon-plus" class="btn_dark_blue"
                                   @click="saveOpenDevicePollDialog">添加
                        </el-button>

                    </el-button-group>
                </div>
            </div>
            <div style="height: calc(100% - 40px); width:100%; margin-top: 8px; float:left; border:2px solid #DDDDDD;">
                <%-- 数据列表 --%>
                <el-table
                        ref="devicePollTableRef"
                        v-loading="tableLoading"
                        :data="userGroupDataList"
                        border
                        size="mini"
                        tooltip-effect="dark"
                        style="width: 100%;"
                        highlight-current-row
                        height="calc(100% - 35px)"
                        element-loading-text="拼命加载中"
                        element-loading-spinner="el-icon-loading"
                        element-loading-background="rgba(0, 0, 0, 0.8)"
                        :header-cell-style="{ 'background-color':'rgb(3,110,186,0.1)','color':'rgb(3,110,186)', 'text-align': 'center'}"
                        @selection-change="handleSelectionChange"
                        @row-click="clickUserGroup"
                >
                    <el-table-column label="用户群组ID" prop="id" show-overflow-tooltip
                                     width="180"></el-table-column>
                    <el-table-column label="群组中文名" prop="groupCname" show-overflow-tooltip width="150"
                                     :render-header="renderHeader"></el-table-column>
                    <el-table-column label="群组英文名" prop="groupEname" show-overflow-tooltip width="150"
                                     :render-header="renderHeader"></el-table-column>
                    <el-table-column label="群组类型" prop="groupType" show-overflow-tooltip width="180"
                                     :render-header="renderHeader"></el-table-column>
                    <el-table-column label="排序" prop="sortIndex" show-overflow-tooltip width="240"
                                     :render-header="renderHeader"></el-table-column>
                    <el-table-column label="创建人" prop="recCreator" min-width="140"></el-table-column>
                    <el-table-column label="创建时间" prop="recCreateTime" min-width="140"></el-table-column>
                    <el-table-column label="修改人" prop="recRevisor" min-width="140"></el-table-column>

                    <el-table-column label="修改时间" prop="recRevisorTime" min-width="140"></el-table-column>
                    <el-table-column label="归档标记" prop="archiveFlag" min-width="140"></el-table-column>
                    <el-table-column label="管辖组" prop="manageGroupEname" min-width="140"></el-table-column>

                </el-table>
                <div style="text-align:center;height: 35px; background: rgba(184,184,184,0.24)">
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
            <div>

                <div style="height: calc(60% - 40px); width: calc(100% - 20px)">
                    <div style="height:45px; width: 100%; border:2px solid #DDDDDD;">
                        <div style="line-height:40px; width: 100%; float:left;">
                            <el-button type="text" style="width:5%; padding-left:2%;">{{currentUserGroup}} 的权限设备</el-button>
                            <el-input v-model="queryContent" clearable style="width:30%; padding-left:10%;"
                                      size="mini"
                                      placeholder="请输入计划【名称】进行搜索"></el-input>
                            <el-button size="mini" type="primary" class="btn_search" icon="el-icon-search"
                                       @click="searchUserGroupList">
                                查询
                            </el-button>
                            <el-button-group style="width:200px; float:right; margin-top: 8px;">
                                <el-button type="danger" size="mini" icon="el-icon-delete" class="btn_dark_black"
                                           @click="removeDevicePoll">删除
                                </el-button>
                            </el-button-group>

                        </div>
                    </div>
                </div>

                <div style="height: calc(100% - 40px); width:100%; margin-top: 8px; float:left; border:2px solid #DDDDDD;">
                    <%-- 数据列表 --%>
                    <el-table
                            ref="cameraTableRef"
                            v-loading="loading"
                            :data="cameraDataList"
                            border
                            size="mini"
                            tooltip-effect="dark"
                            style="width: 100%;"
                            highlight-current-row
                            height="calc(100% - 35px)"
                            element-loading-text="拼命加载中"
                            element-loading-spinner="el-icon-loading"
                            element-loading-background="rgba(0, 0, 0, 0.8)"
                            :header-cell-style="{ 'background-color':'rgb(3,110,186,0.1)','color':'rgb(3,110,186)', 'text-align': 'center'}"
                            @selection-change="handleSelectionChange"
                    >

                        <el-table-column align="center" width="40" type="selection" fixed="left"></el-table-column>
                        <el-table-column label="编号" prop="deviceCode" width="60"></el-table-column>
                        <el-table-column label="设备名称" prop="deviceName" width="150"
                                         :render-header="renderHeader"></el-table-column>
                        <el-table-column label="设备类型" prop="deviceType" width="90"
                        ></el-table-column>
                        <el-table-column label="安装位置" prop="areaAddr" width="160"
                        ></el-table-column>
                        <el-table-column label="IP地址" prop="deviceIp" width="120"></el-table-column>
                        <el-table-column label="责任人" prop="dutyName" width="90"
                        ></el-table-column>
                        <el-table-column label="责任人工号" prop="dutyJob" width="90"
                        ></el-table-column>
                        <el-table-column label="责任人电话" prop="dutyPhone" width="100"
                        ></el-table-column>
                        <el-table-column label="创建时间" prop="createTime" min-width=140"></el-table-column>

                    </el-table>

                    <div style="text-align:center;height: 35px; background: rgba(184,184,184,0.24)">
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

            </div>
            <%-- 输入框 --%>
            <el-dialog :title="devicePollDialogTitle?'用户组设备管理配置':'用户组设备管理配置'" :visible.sync="dialogVisible"
                       style="text-align:center;">



            </el-dialog>
        </div>
    </div>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/vue.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/element.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/axios.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/api/equipment/userGroupApi.js"></script>
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
            queryContent: null,
            currentUserGroup: null,
            currentUserGroupId: null,
            devicePoll: {
                id: null,
                planName: null,
                pollPeriod: null,
                deviceCode: null,
                remark: null,
                callPoliceGrade: null
            },
            userGroupCheckList: [],
            devicePollEdit: null,
            devicePollDialogTitle: true,
            dialogVisible: false,
            dialogLoading: false,
            tableLoading: false,
            userGroupDataList: [],
            cameraDataList: [],
            page: {
                pageNo: 1,
                pageSize: 20,
                totalCount: 0,
                pageSizes: [20, 50, 100]
            },
            devicePollRules: {},
        },
        created: function () {
            this.getUserGroupList()
        },
        methods: {

            getUserGroupList() {
                let queryData = {
                    pageNo: this.page.pageNo,
                    pageSize: this.page.pageSize,
                    groupEname: this.queryContent,
                    groupCname: this.queryContent
                }
                this.loading = true
                getUserGroupPageList(queryData).then(res => {
                    // axios.post(ctx + "/backstage/equipment/usergroupDevice/getUserGroupList",queryData).then(res =>{
                    console.log(res.data)
                this.loading = false
                this.userGroupDataList= res.data.data.dataList;
                this.page.totalCount = res.data.data.totalCount;
            }).catch(err => {
                    console.log(err)
                this.loading = false
            })
            },


            //用户组行点击事件
            clickUserGroup(row){
                this.currentUserGroup = row.groupCname;
                this.currentUserGroupId = row.id;
                this.searchDeviceListByUserGroupId(this.currentUserGroupId);
            },

            searchDeviceListByUserGroupId(id){

                let queryData = {
                    pageNo: this.page.pageNo,
                    pageSize: this.page.pageSize,
                    id: this.currentUserGroupId
                }
                console.log(queryData)
                // searchDevicePageListByUserGroupId(queryData).then(res => {
                axios.post(ctx + "/backstage/equipment/usergroupDevice/getDeviceList", queryData).then(res =>{
                    this.loading = false
                this.cameraDataList= res.data.data.dataList;
                console.log(this.cameraDataList)
                this.page.totalCount = res.data.data.totalCount;
            }).catch(err => {
                    console.log(err)
                this.loading = false
            })
            },

            searchUserGroupList() {
                this.getUserGroupList()
            },

            handleSelectionChange(val) {
                console.log(val)
            },

            saveOpenDevicePollDialog() {
                if (this.$refs.devicePollDialogRef) {
                    this.$refs.devicePollDialogRef.resetFields()
                }
                this.devicePoll.id = null
                this.dialogVisible = true
                this.devicePollDialogTitle = true
            },

            updateOpenDevicePollDialog(rowData) {
                this.dialogVisible = true
                this.devicePollDialogTitle = false
                const assignData = {}
                Object.assign(assignData, rowData)
                this.$nextTick(() => {
                    this.devicePoll = assignData
            })
                this.devicePollEdit = rowData
            },

            /**
             * 新增
             */
            saveDevicePoll() {
                this.tableLoading = true
                saveDevicePoll(this.devicePoll).then(res => {
                    this.getDevicePollList();
                this.$message({
                    message: res.data.data,
                    type: 'success'
                });
                this.dialogVisible = false;
                this.tableLoading = false;
            }).catch(err => {
                    console.log(err)
                this.$message({
                    message: "添加失败",
                    type: 'error'
                });
                this.tableLoading = false
            })
            },

            /**
             * 修改
             */
            updateDevicePoll() {
                this.tableLoading = true
                updateDevicePoll(this.devicePoll).then(res => {
                    this.getDevicePollList();
                this.$message({
                    message: res.data.data,
                    type: 'success'
                });
                this.dialogVisible = false;
                this.tableLoading = false;
            }).catch(err => {
                    console.log(err)
                this.$message({
                    message: "修改失败",
                    type: 'error'
                });
                this.tableLoading = false
            })
            },

            handleCommit() {
                this.$refs.devicePollDialogRef.validate(val => {
                    if (val) {
                        if (this.devicePollDialogTitle) {
                            this.saveDevicePoll()
                            return
                        }
                        this.updateDevicePoll()
                    }
                })
            },

            /**
             * 删除
             */
            removeDevicePoll() {
                this.tableLoading = true
                const listStr = this.userGroupCheckList.join(',')
                const ids = {
                    ids: listStr
                }
                deleteDevicePoll(ids).then(res => {
                    this.getDevicePollList();
                this.$message({
                    message: res.data.data,
                    type: 'success'
                });
                this.dialogVisible = false;
                this.tableLoading = false;
            }).catch(err => {
                    console.log(err)
                this.$message({
                    message: "修改失败",
                    type: 'error'
                });
                this.tableLoading = false
            })
            },

            /**
             * 重置
             */
            resetDevicePoll() {
                if (!this.devicePollDialogTitle) {
                    const assignData = {}
                    Object.assign(assignData, this.devicePollEdit)
                    this.devicePoll = assignData
                    return
                }
                this.$refs.devicePollDialogRef.resetFields();
            },

            //    分页
            handleCurrentChange(pageNo) {
                this.page.pageNo = pageNo
                this.getUserGroupList()
            },

            handleSizeChange(pageSize) {
                this.page.pageSize = pageSize
                this.getUserGroupList()
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

</style>
