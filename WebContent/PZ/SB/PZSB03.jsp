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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/page-css.css"/>
    <%--    <link rel="stylesheet" src="${pageContext.request.contextPath}/static/js/vue/element.css">--%>


    <title>设备权限配置</title>
</head>
<body>
<div>
    <div id="app">
        <div style="height: calc(100% - 10px); width: calc(100% - 20px); position: absolute">
            <%--  操作区 --%>
            <div style="height:45px; width: calc(100% - 5px); margin-left:5px;" class="block-border">
                <div style="line-height:40px; width: 100%; float:left;">
                    <el-input v-model="queryContent" clearable style="width:30%; padding-left:10%;"
                              size="mini" :placeholder="searchContent"></el-input>
                    <el-button size="mini" type="primary" style="margin-left: 5px;" icon="el-icon-search"
                               @click="searchUserGroupList">
                        查询
                    </el-button>
                    <el-button-group style="width:200px;float:right; margin-top: 8px;">
                        <el-button type="primary" size="mini" icon="el-icon-plus" class="btn_dark_blue"
                                   @click="openDialog">设备授权
                        </el-button>
                        <el-button type="danger" size="mini" icon="el-icon-delete" class="btn_dark_black"
                                   @click="removeUserGroupDevice">删除
                        </el-button>
                    </el-button-group>
                </div>
            </div>
            <div style="height: calc(50% - 44px); width:calc(100% - 5px); margin-top: 8px; float:left;"
                 :class="{'dev-inactive-table': !userGroupActive, 'userGroup-active-table': userGroupActive}"
                 @click="handleUserGroupActive" class="block-border">
                <el-table
                        class="disabledCheckBox"
                        ref="userGroupTableRef"
                        v-loading="userGroupTableLoading"
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
                        @row-click="handleClickUserGroupRow"
                        :header-cell-style="{'text-align': 'left'}"
                >
                    <%--                    <el-table-column width="50" align="center" prop="checked" label="选择">--%>
                    <%--                        <template slot-scope="scope">--%>
                    <%--                            <el-checkbox v-model="scope.row.checked"--%>
                    <%--                                         @change="changeCurrentRow( $event, scope.$index, scope.row )">--%>
                    <%--                            </el-checkbox>--%>
                    <%--                        </template>--%>
                    <%--                    </el-table-column>--%>
                        <el-table-column align="center" width="40" type="selection" fixed="left"
                                         :selectable='selectInit'></el-table-column>
                    <el-table-column label="群组中文名" prop="groupCname" show-overflow-tooltip
                                     min-width="200"
                                     :render-header="renderHeader"></el-table-column>
                    <el-table-column label="群组英文名" prop="groupEname" show-overflow-tooltip
                                     min-width="200"
                                     :render-header="renderHeader"></el-table-column>
                    <%--                    <el-table-column label="用户群组类型" prop="groupType" show-overflow-tooltip width="180"--%>
                    <%--                                     :render-header="renderHeader">--%>
                    <%--                    </el-table-column>--%>
                    <%--  <el-table-column label="创建时间" prop="recCreateTime" min-width="140"></el-table-column>--%>
                </el-table>
                <div style="text-align:center;height: 35px;">
                    <el-pagination
                            style="height: 90%; padding-top:3px;"
                            layout="total, sizes, prev, pager, next"
                            :total="userGroupPage.totalCount"
                            :pager-count="5"
                            :page-size="userGroupPage.pageSize"
                            :current-page="userGroupPage.pageNo"
                            :page-sizes="userGroupPage.pageSizes"
                            @current-change="handleUserGroupPageNo"
                            @size-change="handleUserGroupPageSize"
                    />
                </div>
            </div>
            <div>

                <div style="height: calc(51% - 45px); width:calc(100% - 5px); margin-top: 8px; float:left;"
                     :class="{'dev-inactive-table': !deviceActive, 'userGroup-active-table': deviceActive}"
                     @click="handleDeviceActive" class="block-border">
                    <el-table
                            ref="cameraTableRef"
                            v-loading="cameraTableLoading"
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
                            @selection-change="handleSelectionCameraDataList"
                    >
                        <el-table-column align="center" width="40" type="selection" fixed="left"></el-table-column>
                        <el-table-column label="设备名称" prop="cameraName" min-width="230" show-overflow-tooltip
                                         :render-header="renderHeader"></el-table-column>
                        <el-table-column label="摄像头类型" prop="cameraType" width="100" show-overflow-tooltip
                                         :render-header="renderHeader"></el-table-column>
                        <el-table-column label="国际标准码" prop="gbIndexCode" show-overflow-tooltip min-width="160"></el-table-column>
                        <el-table-column label="创建时间" prop="createTime" min-width=140"
                                         show-overflow-tooltip></el-table-column>
                    </el-table>
                    <div style="text-align:center;height: 35px;">
                        <el-pagination
                                style="height: 90%; padding-top:3px;"
                                layout="total, sizes, prev, pager, next"
                                :total="cameraDataPage.totalCount"
                                :pager-count="5"
                                :page-size="cameraDataPage.pageSize"
                                :current-page="cameraDataPage.pageNo"
                                :page-sizes="cameraDataPage.pageSizes"
                                @current-change="handleCameraDataPageNo"
                                @size-change="handleCameraDataPageSize"
                        />
                    </div>
                </div>
            </div>
            <el-dialog :title="userGroupDeviceDialogTitle?'用户组设备添加':'用户组设备编辑'" width="80%" :visible.sync="dialogVisible"
                       style="text-align:center;width: 100%;height: 100%;">
                <el-form
                        ref="organizationDialogRef"
                        v-loading="dialogLoading"
                        :model="userGroupDevice"
                        label-width="120px"
                        element-loading-text="正在提交中......"
                        element-loading-spinner="el-icon-loading"
                >
                    <div style="height:40px; width: 98%; margin-left: 5px;" class="block-border">
                        <div style="height:40px; width: 30%; float:left;">
                            <select-organization-tree
                                    v-model="deviceOrganizationId"
                                    style="padding: 7px 0px 7px 20%; width:80%;float: left;"
                                    @func="clearHandle"
                                    @organization-tree-click="selectOrganizationTreeClick">
                            </select-organization-tree>
                        </div>
                        <div style="line-height:40px; width: 69%; float:left;">
                            <el-input v-model="dialogQueryContent" clearable style="width:50%; "
                                      size="mini" :placeholder="dialogSearchContent"></el-input>
                            &nbsp;
                            <el-button size="mini" type="primary" icon="el-icon-search"
                                       @click="dialogSearchUserGroupList">
                                查询
                            </el-button>
                            <el-button type="success" size="mini" style="width:80px" @click="handleCommit()" >提交</el-button>
                        </div>
                    </div>
                    <div style="height: 40%;  margin-top: 8px;" class="block-border">
                        <el-row>
                            <el-col :span="24">
                                <el-table
                                        ref="cameraDataQueryListTableRef"
                                        v-loading="dialogCameraDataLoading"
                                        :data="dialogCameraDataTableList"
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
                                        @selection-change="handleSelectionDialogCameraData"
                                >
                                    <el-table-column align="center" width="40" type="selection"
                                                     fixed="left"></el-table-column>
                                    <el-table-column label="设备名" prop="cameraName" show-overflow-tooltip width="230"
                                                     :render-header="renderHeader"></el-table-column>
                                    <el-table-column label="创建时间" prop="createTime" show-overflow-tooltip
                                                     min-width="150"
                                                     :render-header="renderHeader"></el-table-column>
                                </el-table>
                                <div style="text-align:center;height: 35px;">
                                    <el-pagination
                                            style="height: 90%; padding-top:3px;"
                                            layout="total, sizes, prev, pager, next"
                                            :total="dialogCameraDataPage.totalCount"
                                            :pager-count="5"
                                            :page-size="dialogCameraDataPage.pageSize"
                                            :current-page="dialogCameraDataPage.pageNo"
                                            :page-sizes="dialogCameraDataPage.pageSizes"
                                            @current-change="handleDialogCameraDataPageNo"
                                            @size-change="handleDialogCameraDataPageSize"
                                    />
                                </div>
                            </el-col>
                        </el-row>
                    </div>
                </el-form>
            </el-dialog>
        </div>
    </div>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/vue.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/element.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/axios.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/api/pz/userGroupApi.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/api/equipment/cameraDataApi.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/components/equipment/selectOrganizationTree.js"></script>
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
            value: '',
            queryContent: null,
            searchContent: '请输入群组中文【名称】进行搜索',
            dialogQueryContent: null,
            dialogSearchContent: '请输入设备名称进行搜索',
            // 用户组
            userGroupTableLoading: false,
            userGroupDataList: [],
            userGroupRowIndex: 0,
            currentUserGroupRow: null,
            dialogCheckUserGroupId: null,
            deviceOrganizationId: null,
            userGroupPage: {
                pageNo: 1,
                pageSize: 20,
                totalCount: 0,
                pageSizes: [20, 50, 100]
            },
            // 设备
            cameraDataList: [],
            cameraTableLoading: false,
            checkDeviceList: [],
            cameraDataPage: {
                pageNo: 1,
                pageSize: 20,
                totalCount: 0,
                pageSizes: [20, 50, 100]
            },
            // dialog设备
            dialogVisible: false,
            dialogLoading: false,
            userGroupDeviceDialogTitle: true,
            dialogCameraDataLoading: false,
            dialogCheckCameraDataList: [],
            dialogCameraDataTableList: [],
            dialogCameraDataPage: {
                pageNo: 1,
                pageSize: 100,
                totalCount: 0,
                pageSizes: [100, 500, 1000]
            },
            // 用户组和设备
            userGroupDevice: {
                userGroupId: null,
                DeviceId: null,
                option: null
            },
            userGroupActive: true,
            deviceActive: false,
        },
        created: function () {
            this.getUserGroupData()
        },
        methods: {

            /**
             * 禁用复选框
             */
            selectInit(row, index) {
                return false;
            },

            /**
             * 弹框内用户组列表
             */
            getUserGroupData() {
                let queryData = {
                    pageNo: this.userGroupPage.pageNo,
                    pageSize: this.userGroupPage.pageSize,
                    groupCname: this.queryContent
                }
                this.userGroupTableLoading = true
                getUserGroupAllList(queryData).then(res => {
                    this.userGroupTableLoading = false
                    for (let index in res.data.data.dataList) {
                        res.data.data.dataList[index].checked = false
                    }
                    this.userGroupDataList = res.data.data.dataList;
                    this.userGroupPage.totalCount = res.data.data.totalCount;
                    if (this.userGroupDataList) {
                        this.cameraDataList = [];
                        this.cameraDataPage.totalCount = 0;
                        this.$refs.userGroupTableRef.setCurrentRow(this.userGroupDataList[this.userGroupRowIndex])
                        this.currentUserGroupRow = this.userGroupDataList[this.userGroupRowIndex]
                        this.getDeviceListByUserGroupId();
                    }
                }).catch(err => {
                    this.userGroupTableLoading = false;
                    console.log(err)
                    }
                )
            },

            /**
             * 搜索框
             */
            searchUserGroupList() {
                if (this.userGroupActive) {
                    this.userGroupRowIndex = 0;
                    this.getUserGroupData()
                } else {
                    // 设备查询
                    this.cameraDataPage.pageNo = 0
                    this.getDeviceListByUserGroupId();
                }
            },

            /**
             * 用户组行点击事件
             */
            handleClickUserGroupRow(record, index) {
                for (let i = 0; i < this.userGroupDataList.length; i++) {
                    if (record.id === this.userGroupDataList[i].id) {
                        this.userGroupRowIndex = i
                    }
                }
                this.cameraDataPage.pageNo = 1;
                this.currentUserGroupRow = this.userGroupDataList[this.userGroupRowIndex]
                this.getDeviceListByUserGroupId();
            },

            /**
             * 设备列表
             */
            getDeviceListByUserGroupId() {
                let queryData = {
                    pageNo: this.cameraDataPage.pageNo,
                    pageSize: this.cameraDataPage.pageSize,
                    id: this.currentUserGroupRow.id,
                    mdeviceName: null
                }
                if (!this.userGroupActive) {
                    queryData.mdeviceName = this.queryContent
                }
                this.cameraTableLoading = true
                searchDevicePageListByUserGroupId(queryData).then(res => {
                    this.cameraTableLoading = false;
                    this.cameraDataList = res.data.data.dataList;
                    this.cameraDataPage.totalCount = res.data.data.totalCount;
                }).catch(err => {
                        console.log(err)
                        this.cameraTableLoading = false
                    }
                )
            },

            /**
             * 设备复选框
             */
            handleSelectionCameraDataList(val) {
                this.checkDeviceList = []
                val.forEach(item => {
                        this.checkDeviceList.push(item.id)
                    }
                )
            },

            /**
             * 弹框设备复选框
             */
            handleSelectionDialogCameraData(val) {
                console.log(val)
                this.dialogCheckCameraDataList = []
                val.forEach(item => {
                        this.dialogCheckCameraDataList.push(item.id)
                    }
                )
            },

            // /**
            //  * 用户组单选框
            //  */
            // changeCurrentRow(val, rowIndex, row) {
            //     this.dialogCheckUserGroupId = null
            //     if (!val) {
            //         return
            //     }
            //     const data = this.userGroupDataList
            //     for (let index in data) {
            //         if (index == rowIndex) {
            //             data[index].checked = val
            //         } else {
            //             data[index].checked = false
            //         }
            //     }
            //     this.userGroupDataList = data
            //     this.dialogCheckUserGroupId = row.id
            // },

            /**
             * dialog搜索框
             */
            dialogSearchUserGroupList() {
                this.dialogCameraDataPage.pageNo = 1;
                this.getDialogCameraData()
            },

            selectOrganizationTreeClick(node) {
                this.dialogOrgCurrentNode = node;
                this.getDialogCameraData();
            },

            clearHandle(val) {
                this.deviceOrganizationId = null;
                this.dialogOrgCurrentNode = null;
                this.getDialogCameraData();
            },

            /**
             * 弹框内设备列表
             */
            getDialogCameraData() {
                let queryData = {
                    pageNo: this.dialogCameraDataPage.pageNo,
                    pageSize: this.dialogCameraDataPage.pageSize,
                    mdeviceName: this.dialogQueryContent,
                    deviceOrganizationId: null,
                    userGroupId: null
                }
                if (this.currentUserGroupRow) {
                    queryData.userGroupId = this.currentUserGroupRow.id
                }
                if (this.dialogOrgCurrentNode) {
                    queryData.deviceOrganizationId = this.dialogOrgCurrentNode.id;
                }
                this.dialogCameraDataLoading = true
                getCameraDataPageList(queryData).then(res => {
                    console.log('=================')
                    console.log(res)
                    this.dialogCameraDataLoading = false;
                    this.dialogCameraDataTableList = res.data.data.dataList
                    this.dialogCameraDataPage.totalCount = res.data.data.totalCount;
                }).catch(err => {
                        console.log(err);
                        this.dialogCameraDataLoading = false;
                    }
                )
            },

            /**
             * 打开dialog弹框
             */
            openDialog() {
                if (this.currentUserGroupRow == null || this.userGroupDataList.length === 0) {
                    this.$message({
                        message: '请选择用户组和设备再进行添加！',
                        type: 'error'
                    });
                    return
                }
                this.dialogCameraDataPage.pageNo = 1;
                this.getDialogCameraData();
                this.dialogVisible = true;
            },

            /**
             * 新增
             */
            handleCommit() {
                let data = {
                    usergroupId: this.currentUserGroupRow.id,
                    deviceId: this.dialogCheckCameraDataList
                }
                console.log(this.dialogCheckCameraDataList)
                this.dialogLoading = true;
                saveUserGroup(data).then(res => {
                    this.getDeviceListByUserGroupId()
                    this.$message({
                        message: res.data.data,
                        type: 'success'
                    });
                    this.dialogLoading = false;
                    this.dialogVisible = false;
                    this.loading = false;
                }).catch(err => {
                    console.log(err)
                    this.$message({
                        message: "新增失败",
                        type: 'error'
                    });
                    this.dialogLoading = false;
                    this.loading = false
                })
            },

            /**
             * 删除按钮
             */
            removeUserGroupDevice() {
                if (this.checkDeviceList.length == 0) {
                    this.$message({
                        message: "请选择设备数据，再进行删除！",
                        type: 'error'
                    });
                    return
                }
                const listStr = this.checkDeviceList.join(',')
                const ids = {
                    ids: listStr
                }
                deleteUserGroup(ids).then(res => {
                    this.getDeviceListByUserGroupId();
                    this.$message({
                        message: res.data.data,
                        type: 'success'
                    });
                    this.cameraDataList = []
                }).catch(err => {
                    console.log(err)
                    this.$message({
                        message: "删除失败",
                        type: 'error'
                    });
                })
            },

            /**
             * 用户组分页
             */
            handleUserGroupPageNo(pageNo) {
                this.userGroupRowIndex = 0;
                this.userGroupPage.pageNo = pageNo;
                this.getUserGroupData();
            },
            handleUserGroupPageSize(pageSize) {
                this.userGroupPage.pageNo = 1;
                this.userGroupPage.pageSize = pageSize;
                this.getUserGroupData();
            },

            /**
             * 设备分页
             */
            handleCameraDataPageNo(pageNo) {
                this.cameraDataPage.pageNo = pageNo;
                this.getDeviceListByUserGroupId();
            },
            handleCameraDataPageSize(pageSize) {
                this.cameraDataPage.pageSize = pageSize;
                this.getDeviceListByUserGroupId();
            },

            /**
             * 弹框内设备分页
             */
            handleDialogCameraDataPageNo(pageNo) {
                this.dialogCameraDataPage.pageNo = pageNo;
                this.getDialogCameraData();
            },
            handleDialogCameraDataPageSize(pageSize) {
                this.dialogCameraDataPage.pageNo = 1;
                this.dialogCameraDataPage.pageSize = pageSize;
                this.getDialogCameraData();
            },

            /**
             * 群组区域高亮
             */
            handleUserGroupActive() {
                this.searchContent = '请输入群组中文【名称】进行搜索';
                this.userGroupActive = true
                this.deviceActive = false
            },

            /**
             * 设备区域高亮
             */
            handleDeviceActive() {
                this.searchContent = '请输入设备【名称】进行搜索';
                this.userGroupActive = false
                this.deviceActive = true
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

    .userGroup-active-table {
        margin: 5px;
        box-shadow: 0 0 5px 0px #015eff;
    }

    .dev-inactive-table {
        margin: 5px;
        box-shadow: 0 0 5px 0px rgba(1, 94, 255, 0.05);
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
