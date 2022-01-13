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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/assets/icon/iconfont.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/page-css.css"/>
    <%--    <link rel="stylesheet" src="${pageContext.request.contextPath}/static/js/vue/element.css">--%>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/vue.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/element.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/axios.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/api/vm/devicePollApi.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/api/equipment/cameraDataApi.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/components/equipment/selectRecursiveOrganizationEquipmentTree.js"></script>
    <c:set var="ctx" value="${pageContext.request.contextPath}"/>
    <script>
        var ctx = '${pageContext.request.contextPath}'
    </script>

    <title>轮询管理</title>
</head>
<body>
<div>
    <div id="app">
        <div style="height: calc(100% - 20px); width: calc(100% - 20px); position: absolute;">
            <%--  操作区 --%>
            <div style="height:45px; width: 100%;" class="block-border">
                <div style="line-height:40px; width: 100%; float:left;">
                    <el-input v-model="queryContent" clearable style="width:30%; padding-left:10%;"
                              size="mini"
                              placeholder="请输入计划【名称】进行搜索"></el-input>
                    <el-button size="mini" type="primary" class="btn_search" icon="el-icon-search"
                               @click="searchDevicePollList">
                        查询
                    </el-button>
                    <el-button-group style="width:200px; float:right; margin-top: 8px;">
                        <el-button type="primary" size="mini" icon="el-icon-plus" class="btn_dark_blue"
                                   @click="saveOpenDevicePollDialog">添加
                        </el-button>
                        <el-button type="danger" size="mini" icon="el-icon-delete" class="btn_dark_black"
                                   @click="removeDevicePoll">删除
                        </el-button>
                    </el-button-group>
                </div>
            </div>
            <div style="height: calc(50% - 40px); width:100%; margin-top: 8px; float:left;" class="block-border">
                <%-- 数据列表 --%>
                <el-table
                        ref="devicePollTableRef"
                        v-loading="tableLoading"
                        :data="devicePollDataList"
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
                        @selection-change="handleSelectionChange"
                >
                    <el-table-column align="center" width="40" type="selection" fixed="left"></el-table-column>
                    <el-table-column label="计划名称" prop="planName" show-overflow-tooltip
                                     width="180"></el-table-column>
                    <el-table-column label="轮询周期" prop="pollPeriod" show-overflow-tooltip width="150"
                                     :render-header="renderHeader"></el-table-column>
                    <%--                    <el-table-column label="设备编号" prop="deviceCode" show-overflow-tooltip width="180"--%>
                    <%--                                     :render-header="renderHeader"></el-table-column>--%>
                    <el-table-column label="备注" prop="remark" show-overflow-tooltip width="240"
                                     :render-header="renderHeader"></el-table-column>
                    <el-table-column label="创建时间" prop="createTime" min-width="140"></el-table-column>
                    <el-table-column width="70" label="操作" align="center" fixed="right">
                        <template slot-scope="scope">
                            <el-tooltip class="item" effect="dark" content="编辑" placement="top-start">
                                <el-button size="mini" style="padding: 3px 15px"
                                           @click="updateOpenDevicePollDialog(scope.row)">
                                    <i class="el-icon-edit"></i>
                                </el-button>
                            </el-tooltip>
                        </template>
                    </el-table-column>
                </el-table>
                <div style="text-align:center; height: 35px;">
                    <el-pagination
                            style="height: 90%; padding-top:2px;"
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
            <div style="height: calc(50% - 40px); width:100%; margin-top: 8px; float:left;" class="block-border">
                <el-table
                        class="disabledCheckBox"
                        ref="cameraDataTableRef"
                        v-loading="cameraDataTableLoading"
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
                        :header-cell-style="{'text-align': 'left'}"
                        @selection-change="handleSelectionChange"
                >
                    <el-table-column align="center" width="40" type="selection" fixed="left"
                                     :selectable='selectInit'></el-table-column>
                    <el-table-column label="设备名称" prop="cameraName" width="150" show-overflow-tooltip
                                     :render-header="renderHeader"></el-table-column>
                    <el-table-column label="摄像头类型" prop="cameraType" width="100" show-overflow-tooltip
                                     :render-header="renderHeader"></el-table-column>
                    <el-table-column label="国际标准码" prop="gbIndexCode" show-overflow-tooltip min-width="160"></el-table-column>
                    <el-table-column label="创建时间" prop="createTime" min-width="140"></el-table-column>
                </el-table>
                <div style="text-align:center; height: 35px;">
                    <el-pagination
                            style="height: 90%; padding-top:3px;"
                            layout="total, sizes, prev, pager, next"
                            :total="devPage.totalCount"
                            :pager-count="5"
                            :page-size="devPage.pageSize"
                            :current-page="devPage.pageNo"
                            :page-sizes="devPage.pageSizes"
                            @current-change="handleCurrentDevChange"
                            @size-change="handleDevSizeChange"
                    />
                </div>
            </div>
        </div>

        <el-dialog :title="devicePollDialogTitle?'视频轮询配置添加':'视频轮询配置编辑'"
                   :visible.sync="dialogVisible" style="text-align:center;">
            <el-form
                    ref="devicePollDialogRef"
                    v-loading="dialogLoading"
                    :model="devicePoll"
                    :rules="devicePollRules"
                    label-width="120px"
                    element-loading-text="正在提交中......"
                    element-loading-spinner="el-icon-loading"
            >
                <el-form-item label="计划名称:" prop="planName" style="margin: 5px 0px;">
                    <el-col :span="21">
                        <el-input v-model="devicePoll.planName" clearable size="mini"
                                  placeholder="请输入计划名称"/>
                    </el-col>
                </el-form-item>
                <el-form-item label="轮询周期:" prop="pollPeriod" style="margin: 5px 0px;">
                    <el-col :span="21">
                        <el-input v-model="devicePoll.pollPeriod" type="number" clearable size="mini" maxlength="5"
                                  placeholder="请输入轮询周期"/>
                    </el-col>
                </el-form-item>
                <el-form-item label="设备组织树:" style="margin: 5px 0px;">
                    <el-col :span="21" class="tree-checkBox">
                        <select-recursive-check-tree
                                style="height:180px; overflow: auto;
                        background-color:#fff; padding: 0 0px; width:100%; height:180px; float: left;"
<%--                                :expand-all="true"--%>
                                :show-check-box="showCheckBox"
                                :default-keys="defaultNodeKeys"
                                @checkbox-data="getCheckNode">
                        </select-recursive-check-tree>
                    </el-col>
                </el-form-item>
                <%--                <el-form-item label="设备编号:" prop="organizationNameListStr" :show-message="false"--%>
                <%--                              style="margin: 5px 0px;">--%>
                <%--                    <el-col :span="21">--%>
                <%--                        <el-input--%>
                <%--                                type="textarea"--%>
                <%--                                :autosize="{ minRows: 2, maxRows: 10}"--%>
                <%--                                placeholder="设备编号"--%>
                <%--                                v-model="organizationNameListStr">--%>
                <%--                        </el-input>--%>
                <%--                    </el-col>--%>
                <%--                </el-form-item>--%>
                <el-form-item label="备注:" prop="remark" :show-message="false" style="margin: 5px 0px;">
                    <el-col :span="21">
                        <el-input v-model="devicePoll.remark" clearable clearable size="mini"
                                  placeholder="请输入备注"/>
                    </el-col>
                    </el-col>
                </el-form-item>
                <el-form-item style="margin: 15px 0px;" label-width="0px">
                    <div style="width:100%; height:40px;">
                        <el-button type="success" size="small" style="width:80px" @click="handleCommit()"
                                   class="btn_commit">提交
                        </el-button>
                        <el-button @click="resetDevicePoll()" style="width:80px" size="small">重置</el-button>
                    </div>
                </el-form-item>
            </el-form>
        </el-dialog>
    </div>
</div>

</body>
</html>
<script type="text/javascript">

    let doit = new Vue({
        el: '#app',
        data: {
            queryContent: null,
            devicePoll: {
                id: null,
                planName: null,
                pollPeriod: null,
                deviceCode: null,
                orgId: null,
                remark: null,
                callPoliceGrade: null
            },
            devicePollRowIndex: 0,
            devicePollCheckList: [],
            devicePollEdit: null,
            devicePollDialogTitle: true,
            dialogVisible: false,
            dialogLoading: false,
            tableLoading: false,
            devicePollDataList: [],
            page: {
                pageNo: 1,
                pageSize: 20,
                totalCount: 0,
                pageSizes: [20, 50, 100]
            },
            devicePollRules: {
                planName: [{required: true, trigger: ['blur', 'change'], message: '计划名称不能为空'}],
                pollPeriod: [{required: true, trigger: ['blur', 'change'], message: '轮询周期不能为空'}],
            },
            showCheckBox: true,
            organizationNameListStr: null,
            defaultNodeKeys: [],
            // 设备
            cameraDataList: [],
            cameraDataTableLoading: false,
            devPage: {
                pageNo: 1,
                pageSize: 20,
                totalCount: 0,
                pageSizes: [20, 50, 100]
            },
        },
        created: function () {
            this.getDevicePollList()
        },
        methods: {

            /**
             * 禁用复选框
             */
            selectInit(row, index) {
                return false;
            },

            getDevicePollList() {
                let queryData = {
                    pageNo: this.page.pageNo,
                    pageSize: this.page.pageSize,
                    planName: this.queryContent
                }
                this.loading = true
                getDevicePollPageList(queryData).then(res => {
                    this.loading = false
                    this.devicePollDataList = res.data.data.dataList;
                    this.page.totalCount = res.data.data.totalCount;
                    this.$refs.devicePollTableRef.setCurrentRow(this.devicePollDataList[this.devicePollRowIndex])
                    this.currentNode = this.devicePollDataList[this.devicePollRowIndex];
                    this.cameraDataList = [];
                    this.getCameraList();
                }).catch(err => {
                    console.log(err)
                    this.loading = false
                })
            },

            handleClickDevicePollRow(record, index) {
                for (let i = 0; i < this.devicePollDataList.length; i++) {
                    if (record.id === this.devicePollDataList[i].id) {
                        this.devicePollRowIndex = i
                    }
                }
                this.currentNode = record;
                this.getCameraList()
            },

            /**
             * 获取设备信息列表
             */
            getCameraList() {
                let queryData = {
                    pageNo: this.page.pageNo,
                    pageSize: this.page.pageSize,
                    deviceName: this.queryContent,
                    idList: this.currentNode.orgId.split(",")
                }
                this.loading = true
                getCameraDataPageList(queryData).then(res => {
                    this.loading = false
                    this.cameraDataList = res.data.data.dataList;
                    this.devPage.totalCount = res.data.data.totalCount;
                }).catch(err => {
                    console.log(err)
                    this.loading = false
                })
            },

            searchDevicePollList() {
                this.getDevicePollList()
            },

            handleSelectionChange(val) {
                this.devicePollCheckList = []
                val.forEach(item => {
                    this.devicePollCheckList.push(item.id)
                })
            },

            saveOpenDevicePollDialog() {
                if (this.$refs.devicePollDialogRef) {
                    this.$refs.devicePollDialogRef.resetFields()
                }
                this.devicePoll.id = null
                this.dialogVisible = true
                this.devicePollDialogTitle = true
                this.defaultNodeKeys = []
            },

            updateOpenDevicePollDialog(rowData) {
                this.dialogVisible = true
                this.devicePollDialogTitle = false
                const assignData = {}
                Object.assign(assignData, rowData)
                this.$nextTick(() => {
                    this.devicePoll = assignData
                    this.defaultNodeKeys = data
                })
                const data = []
                rowData.orgId.split(',').forEach(it => {
                    data.push(parseInt(it));
                })
                this.devicePollEdit = rowData
            },

            getCheckNode(node) {
                let nodeIds = node.map(function (val) {
                    return val.id
                });
                let organizationNameList = node.map(function (val) {
                    return "【" + val.organizationName + "】"
                });
                let nodeIdListStr = nodeIds.join(',');
                this.organizationNameListStr = organizationNameList.join(',')
                this.devicePoll.orgId = nodeIdListStr;
                // this.devicePoll.deviceCode = videoCodes.join(',');
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

            /**
             * 提交
             */
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
                const listStr = this.devicePollCheckList.join(',')
                const ids = {
                    ids: listStr
                }
                deleteDevicePoll(ids).then(res => {
                    this.getDevicePollList();
                    this.$message({
                        message: res.data.data,
                        type: 'success'
                    });
                    this.devicePollRowIndex = 0;
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
                    const data = []
                    this.devicePoll.orgId.split(',').forEach(it => {
                        data.push(parseInt(it));
                    })
                    this.defaultNodeKeys = data
                    return
                }
                this.defaultNodeKeys = []
                this.$refs.devicePollDialogRef.resetFields();
            },

            /**
             * 分页
             */
            handleCurrentChange(pageNo) {
                this.page.pageNo = pageNo;
                this.devicePollRowIndex = 0;
                this.getDevicePollList();
            },

            handleSizeChange(pageSize) {
                this.page.pageSize = pageSize;
                this.getDevicePollList();
            },

            handleCurrentDevChange(pageNo) {
                this.devPage.pageNo = pageNo
                this.getCameraList();
            },
            handleDevSizeChange() {
                this.devPage.pageSize = pageNo
                this.getCameraList();
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

    .disabledCheckBox .el-checkbox__inner {
        background-color: transparent !important;
        border-color: transparent !important;
        display: inline-block;
        position: relative;
        box-sizing: border-box;
        width: 14px;
        height: 14px;
        z-index: 1;
        border-width: 1px;
        border-style: solid;
        border-image: initial;
        border-radius: 2px;
        transition: border-color 0.25s cubic-bezier(0.71, -0.46, 0.29, 1.46) 0s, background-color 0.25s cubic-bezier(0.71, -0.46, 0.29, 1.46) 0s;
    }

</style>
