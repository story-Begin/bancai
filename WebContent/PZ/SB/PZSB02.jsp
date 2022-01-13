<%--
  Created by IntelliJ IDEA.
  User: huang
  Date: 2020-08-18
  Time: 10:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <!-- import Vue before Element -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/vue/index.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/assets/icon/iconfont.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/page-css.css"/>
    <%--    <link rel="stylesheet" src="${pageContext.request.contextPath}/static/js/vue/element.css">--%>


    <title>设备分组配置</title>
</head>

<body>

<div id="app">
    <div style="height: calc(100% - 10px); width: calc(100% - 10px); position: absolute">
        <div style="height: calc(100% - 10px); margin-left: 8px; width:calc(100% - 20px); float:left;">
            <%--  操作区 --%>
            <div style="height:45px; width: 100%;" class="block-border">
                <div style="line-height:40px; width: 100%; float:left;">
                    <div style="float: left; margin-top:8px; margin-left: 10px;">
                        <el-select v-model="cameraType" size="mini" style="width: 95px;margin-left: 15px;"
                                   placeholder="设备类型" clearable @change="changeDeviceType">
                            <el-option
                                    v-for="item in CAMERA_TYPE"
                                    :key="item.value"
                                    :label="item.label"
                                    :value="item.value"
                            />
                        </el-select>
                        <select-organization-tree
                                v-model="deviceOrganizationId"
                                :organizationNam="organizationName"
                                style="padding: 0 0px;width:150px;float: left;"
                                @func="clearHandle"
                                @organization-tree-click="selectOrganizationTreeClick">
                        </select-organization-tree>
                    </div>
                    <div style="float: left; width: 35%;">
                        <el-input v-model="queryContent" clearable style="width:60%; margin-left: 20px;" size="mini"
                                  placeholder="请输入设备【名称】进行搜索"></el-input>&nbsp;
                        <el-button size="mini" type="primary" class="btn_search" icon="el-icon-search"
                                   @click="searchCameraList">
                            查询
                        </el-button>
                    </div>
                    <el-button-group style="float: right; margin-right: 10px; margin-top:8px;">
                        <el-button type="primary" size="mini" icon="el-icon-sort" class="btn_dark_blue"
                                   @click="openInsertCommit">切换组织
                        </el-button>
                        <%--                        <el-button type="danger" size="mini" icon="el-icon-delete" class="btn_dark_black"--%>
                        <%--                                   @click="deleteGroup(noneGroup)">批量离组--%>
                        <%--                        </el-button>--%>
                    </el-button-group>

                </div>
            </div>
            <div style="height: calc(100% - 57px); width:100%; margin-top: 8px; float:left;" class="block-border">
                <%-- 数据列表 --%>
                <el-table
                        ref="cameraTableRef"
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
                    <el-table-column align="center" width="40" type="selection" fixed="left"></el-table-column>
                    <el-table-column label="设备名称" prop="cameraName" width="350" show-overflow-tooltip
                                     :render-header="renderHeader"></el-table-column>
                    <el-table-column label="所属组织" prop="orgPath" width="260" show-overflow-tooltip
                                     :render-header="renderHeader"></el-table-column>
                    <el-table-column label="创建时间" prop="createTime" min-width=140"></el-table-column>
                </el-table>
                <div style="text-align:center;height: 35px;">
                    <el-pagination
                            style="height: 90%; padding-top:3px;"
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
    </div>

    <el-dialog :title="cameraDialogTitle?'选择组织':'TODO'" :visible.sync="dialogVisible" style="text-align:center; ">
        <el-form
                status-icon
                ref="cameraFormRef"
                label-width="120px"
                size="mini"
                style="height: 60%;"
        >
            <el-row>
                <el-col :span="22">
                    <organization_tree @organization-click="handleOrganizationTreeClick"></organization_tree>
                </el-col>
            </el-row>
            <el-form-item style="margin: 10px 0px;" label-width="0px">
                <div style="width:100%; height:40px;">
                    <el-button type="success" size="small" style="width:80px" @click="updateCamera()"
                               class="btn_commit">提交
                    </el-button>
                    <el-button @click="resetOrganization()" style="width:80px" size="small">重置</el-button>
                </div>
            </el-form-item>
        </el-form>
    </el-dialog>

</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/vue.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/element.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/axios.min.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/api/equipment/cameraDataApi.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/components/equipment/DeviceOrganizationTree.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/components/equipment/selectOrganizationTree.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/enum/equipment/cameraData/cameraType.js"></script>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script>
    var ctx = '${pageContext.request.contextPath}'
</script>
</body>

</html>

<script type="text/javascript">
    // Vue实例化
    var doit = new Vue({
        el: '#app',
        //data用于存放数据或者变量
        data: {
            CAMERA_TYPE,
            deviceTypeSelectList: [],
            cameraType: null,
            deviceOrganizationId: -1,
            deviceOrganizationName: null,
            queryContent: null,
            // 数据区
            cameraDataList: [],
            checkCameraList: [],
            cameraDataTableLoading: false,
            cameraForm: {},
            page: {
                pageNo: 1,
                pageSize: 20,
                totalCount: 0,
                pageSizes: [20, 50, 100]
            },

            // dialog
            organizationTreeLoading: false,
            dialogVisible: false,
            cameraDialogTitle: true,
            currentNode: null,
        },
        created: function () {
            this.getCameraOrgList();
            // this.getDevCodeTypeValue();
        },
        methods: {

            /**
             * 设备类型
             */
            changeDeviceType(type) {
                this.cameraType = type;
                this.getCameraOrgList();
            },

            selectOrganizationTreeClick(node) {
                this.deviceOrganizationId = node.id
                this.deviceOrganizationName = node.organizationName
                this.searchCameraList();
            },

            clearHandle(val) {
                this.deviceOrganizationId = null
            },

            /**
             * dialog框树点击
             */
            handleOrganizationTreeClick(node) {
                this.currentNode = node

            },

            /**
             * 搜索
             */
            searchCameraList() {
                this.page.pageNo = 1;
                this.getCameraOrgList();
            },

            /**
             * 获取设备信息列表
             */
            getCameraOrgList() {
                let queryData = {
                    cameraType: this.cameraType,
                    deviceOrganizationId: this.deviceOrganizationId,
                    queryContent: this.queryContent,
                    pageNo: this.page.pageNo,
                    pageSize: this.page.pageSize,
                    cameraName: this.queryContent
                }
                this.cameraDataTableLoading = true
                getPageDevOrganization(queryData).then(res => {
                    this.cameraDataTableLoading = false;
                    this.cameraDataList = res.data.data.dataList;
                    this.page.totalCount = res.data.data.totalCount;
                }).catch(err => {
                        console.log(err)
                        this.cameraDataTableLoading = false
                    }
                )
            },

            /**
             * 设备类型下拉列表
             */
            getDevCodeTypeValue() {
                selectCodeTypeValue().then(res => {
                    this.deviceTypeSelectList = res.data.data
                }).catch(err => {
                    console.log("设备类型下拉列表展示出错！");
                })
            },

            /**
             * 打开添加模态框
             */
            openInsertCommit() {
                if (this.checkCameraList.length > 0) {
                    this.cameraDialogTitle = true;
                    this.dialogVisible = true
                    return
                }
                this.$message({
                    message: "请选择【未分组】数据,再进行操作！",
                    type: 'error'
                });
            },

            /**
             * 修改
             */
            updateCamera() {
                const updateData = {
                    deviceOrganizationId: this.currentNode.id,
                    organizationPathNamePath: this.currentNode.organizationPathName,
                    cameraDataIdList: this.checkCameraList
                }
                this.cameraDataTableLoading = true
                updatePageDevOrganization(updateData).then(res => {
                    this.getCameraOrgList();
                    this.$message({
                        message: res.data.data,
                        type: 'success'
                    });
                    this.dialogVisible = false;
                    this.cameraDataTableLoading = false;
                }).catch(err => {
                    console.log(err)
                    this.$message({
                        message: "修改失败",
                        type: 'error'
                    });
                    this.cameraDataTableLoading = false
                })
            },


            /**
             * dialog提交
             */
            submitForm() {
                this.updateCamera()
            },

            /**
             * 重置
             */
            resetForm() {

            },

            /**
             * 复选框
             * @param val
             */
            handleSelectionChange(val) {
                this.checkCameraList = []
                val.forEach(item => {
                        this.checkCameraList.push(item.id)
                    }
                )
            },

            /**
             * 分页
             * @param pageNo
             */
            handleCurrentChange(pageNo) {
                this.page.pageNo = pageNo
                this.getCameraOrgList()
            },
            handleSizeChange(pageSize) {
                this.page.pageSize = pageSize
                this.getCameraOrgList()
            },

            /**
             * 必填列标识
             * @param h
             * @param column
             * @param $index
             * @returns {*}
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
             * 设备类型展示（枚举转换）
             * @param val
             * @returns {string}
             */
            getDeviceType(val) {
                return getDeviceTypeName(val.cameraType)
            },

        },
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

    .el-dialog__body {
        padding: 20px 20px 50px;
        color: #606266;
        font-size: 14px;
        word-break: break-all;
    }


</style>

