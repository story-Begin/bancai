<%@ page import="com.baosight.iplat4j.core.web.threadlocal.UserSession" %>
<%--
  Created by IntelliJ IDEA.
  User: huang
  Date: 2020-07-08
  Time: 10:51
  To change this template use File | Settings | File Templates./*sfm*/
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">

<%
    String userName = UserSession.getLoginName();
    boolean flag = false;
    if (userName.equals("admin")) {
        flag = true;
    }
%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <!-- import Vue before Element -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/vue/index.css"/>
    <%--    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/element-ui/2.11.0/theme-chalk/index.css"/>--%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/assets/icon/iconfont.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/page-css.css"/>
    <%--    <link rel="stylesheet" src="${pageContext.request.contextPath}/static/js/vue/element.css">--%>


    <title>设备信息管理</title>
</head>

<body style="background-color:#001F6B;">

<div id="app">
    <div style="height: calc(100% - 10px); width: calc(100% - 10px); position: absolute">
        <div v-loading="organizationTreeLoading"
             style="height: calc(98% - 10px); width:300px;  overflow: auto; float:left;" class="block-border">
            <%--树组件（先引入）--%>
            <organization_tree @organization-click="handleOrganizationTreeClick"></organization_tree>
        </div>
        <div style="height: calc(98% - 10px); margin-left: 8px; width:calc(100% - 320px); float:left;">
            <%--  操作区 --%>
            <div style="height:45px; width: 100%; " class="block-border">
                <div style="line-height:40px; width: 100%; float:left;">
                    <el-input v-model="queryContent" clearable style="width:30%; padding-left:5%;"
                              size="mini" placeholder="请输入【设备名称】"></el-input>
                    <el-button size="mini" type="primary" icon="el-icon-search" style="margin-left: 10px;"
                               @click="searchCameraList">
                        查询
                    </el-button>
                    <el-button-group style="width:200px; float:right; margin-top: 8px;">
                        <el-button type="primary" size="mini" icon="el-icon-refresh" class="btn_dark_blue"
                                   @click="flashCameraDataList" :loading="logining">手动更新
                        </el-button>
                        <%--                        <el-button type="danger" size="mini" icon="el-icon-delete" class="btn_dark_black"--%>
                        <%--                                   @click="removeCamera">删除--%>
                        <%--                        </el-button>--%>
                    </el-button-group>
                </div>
            </div>
            <div style="height: calc(100% - 57px); width:100%; margin-top: 8px; float:left; " class="block-border">
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
                        :header-cell-style="{'text-align': 'left'}"
                        element-loading-text="拼命加载中"
                        element-loading-spinner="el-icon-loading"
                        element-loading-background="rgba(0, 0, 0, 0.4)"
                        @row-click="handleClickCameraDataRow"
                        @selection-change="handleSelectionChange"
                >
                    <el-table-column align="center" width="40" type="selection" fixed="left"></el-table-column>
                    <el-table-column label="设备名称" prop="cameraName" width="150" show-overflow-tooltip
                                     :render-header="renderHeader"></el-table-column>
                    <el-table-column label="摄像头类型" prop="cameraType" width="100" show-overflow-tooltip
                                     :render-header="renderHeader" :formatter="getCameraTypeName"></el-table-column>
                    <el-table-column label="国际标准码" prop="gbIndexCode" show-overflow-tooltip min-width="160"></el-table-column>
                    <el-table-column label="创建时间" prop="createTime" min-width=140"></el-table-column>
                    <el-table-column width="80" label="操作" align="center" fixed="right">
                        <template slot-scope="scope">
<%--                            <el-tooltip class="item" effect="dark" content="详情" placement="top-start">--%>
<%--                                <el-button size="mini" style="padding: 3px 15px"--%>
<%--                                           @click="openDetailCommit(scope.row)"><i class="el-icon-zoom-in"></i>--%>
<%--                                </el-button>--%>
<%--                            </el-tooltip>--%>
                            <el-tooltip class="item" effect="dark" content="编辑" placement="top-start">
                                <el-button size="mini" style="padding: 3px 15px"
                                           @click="openUpdateCommit(scope.row)"><i class="el-icon-edit"></i>
                                </el-button>
                            </el-tooltip>
                        </template>
                    </el-table-column>
                </el-table>
                <%-- 分页 --%>
                <div style="text-align:center;height: 35px; background: rgba(184,184,184,0.24)" class="el-pagination">
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

    <%--添加修改模态框--%>
    <el-dialog :title="cameraTitle?'设备添加':'设备编辑'" :visible.sync="dialogVisible"
               style="text-align:center;">
        <el-form
                :model="cameraDTO"
                ref="cameraFormRef"
                :rules="cameraFormRules"
                label-width="120px"
                v-loading="dialogLoading"
                element-loading-text="正在提交中......"
                size="mini"
        >
            <el-row>
                <el-col :span="11">
                    <el-form-item label="设备名称:" prop="cameraName">
                        <el-input v-model="cameraDTO.cameraName" clearable></el-input>
                    </el-form-item>
                </el-col>
                <el-col :span="11">
                    <el-form-item label="设备类型:" prop="cameraType">
                        <el-select v-model="cameraDTO.cameraType" size="mini" clearable style="width: 100%;"
                                   placeholder="请选择设备类型">
                            <el-option
                                    v-for="item in CAMERA_TYPE"
                                    :key="item.value"
                                    :label="item.label"
                                    :value="item.value"
                            />
                        </el-select>
                    </el-form-item>
                </el-col>
            </el-row>
<%--            <el-row>--%>
<%--                <el-col :span="22">--%>
<%--                    <el-form-item label="安装位置:" prop="channelNo">--%>
<%--                        <el-input v-model="cameraDTO.channelNo" clearable></el-input>--%>
<%--                    </el-form-item>--%>
<%--                </el-col>--%>
<%--            </el-row>--%>
            <el-row>
                <el-col :span="11">
                    <el-form-item label="设备组织:">
                        <select-organization-tree
                                v-model="deviceOrganizationName"
                                style="width:100%; text-align:left;"
                                :current-node="currentDeviceOrganizationId"
                                :organization-name="deviceOrganizationName"
                                :expand-all="expandAll"
                                @func="clearHandle"
                                @organization-tree-click="selectOrganizationTreeClick">
                        </select-organization-tree>
                    </el-form-item>
                </el-col>
                <el-col :span="11">
                    <el-form-item label="国际标准码:" prop="gbIndexCode">
                        <el-input v-model="cameraDTO.gbIndexCode" clearable></el-input>
                    </el-form-item>
                </el-col>
            </el-row>
            <el-row>
                <el-form-item style="margin: 15px 0px;" label-width="0px">
                    <div style="width:100%; height:40px;">
                        <el-button type="success" size="small" style="width:80px" @click="submitForm()">提交</el-button>
                        <el-button @click="resetForm()" style="width:80px" size="small">重置</el-button>
                    </div>
                </el-form-item>
            </el-row>
        </el-form>
    </el-dialog>


    <%--详情模态框--%>
    <el-dialog title="设备详情" :visible.sync="dialogVisibleDetail" style="text-align:center;">
        <el-form
                :model="cameraDTO"
                status-icon
                ref="cameraFormRef"
                label-width="120px"
                size="mini">
            <el-row>
                <el-col :span="11">
                    <el-form-item label="设备名称:" prop="cameraName">
                        <el-input v-model="cameraDTO.cameraName" :disabled="true" clearable></el-input>
                    </el-form-item>
                </el-col>
                <el-col :span="11">
                    <el-form-item label="IP地址:" prop="remark2">
                        <el-input v-model="cameraDTO.remark2" :disabled="true" clearable></el-input>
                    </el-form-item>
                </el-col>
            </el-row>
            <el-row>
                <el-col :span="22">
                    <el-form-item label="安装位置:" prop="areaAddr">
                        <el-input v-model="cameraDTO.areaAddr" :disabled="true" clearable></el-input>
                    </el-form-item>
                </el-col>
            </el-row>
            <el-row>
                <el-col :span="11">
                    <el-form-item label="设备组织:">
                        <select-organization-tree
                                :disabled="true"
                                v-model="deviceOrganizationName"
                                style="width:100%; text-align:left;"
                                :current-node="currentDeviceOrganizationId"
                                :organization-name="deviceOrganizationName"
                                :expand-all="expandAll"
                                @func="clearHandle"
                                @organization-tree-click="selectOrganizationTreeClick">
                        </select-organization-tree>
                    </el-form-item>
                </el-col>
                <el-col :span="11">
                    <el-form-item label="设备类型:" prop="deviceType">
                        <el-select v-model="cameraDTO.deviceType" size="mini" :disabled="true" clearable
                                   style="width: 100%;"
                                   placeholder="请选择设备类型">
                            <el-option
                                    v-for="item in CAMERA_TYPE"
                                    :key="item.value"
                                    :label="item.label"
                                    :value="item.value"
                            />
                        </el-select>
                    </el-form-item>
                </el-col>
            </el-row>
            <el-row>
                <el-col :span="11">
                    <el-form-item label="状态:" prop="status">
                        <el-select v-model="cameraDTO.status" size="mini" :disabled="true" clearable
                                   style="width: 100%;"
                                   placeholder="请选择设备状态">
                            <el-option
                                    v-for="item in deviceTypeStatusSelectList"
                                    :key="item.itemCode"
                                    :label="item.itemName"
                                    :value="item.itemCode"
                            />
                        </el-select>
                    </el-form-item>
                </el-col>
            </el-row>
            <el-row>
                <el-col :span="22">
                    <el-form-item label="备注:" prop="remark">
                        <el-input v-model="cameraDTO.remark" :disabled="true" clearable></el-input>
                    </el-form-item>
                </el-col>
            </el-row>

        </el-form>
    </el-dialog>


</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/vue.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/element.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/axios.min.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/api/equipment/cameraDataApi.js"></script>
<%--引入tree组件--%>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/components/equipment/DeviceOrganizationTree.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/components/equipment/selectOrganizationTree.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/enum/equipment/cameraData/cameraType.js"></script>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script>
    var ctx = '${pageContext.request.contextPath}'
    <%--let authority = <%=flag%>;--%>
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
            logining: false,
            // flag: authority,
            deviceTypeSelectList: [],
            deviceTypeStatusSelectList: [],
            organizationTreeLoading: false,
            queryContent: '',
            deviceIp: null,
            cameraDataList: [],
            page: {
                pageNo: 1,
                pageSize: 20,
                totalCount: 0,
                pageSizes: [20, 50, 100]
            },
            deviceOrganizationName: '',
            currentDeviceOrganizationId: null,
            queryContent: '',
            /*删除（数据区）*/
            checkCameraList: [],
            loading: false,
            /*模态框是否展示（默认为false）*/
            dialogVisible: false,
            dialogLoading: false,
            /*详情模态框是否展示（默认为false）*/
            dialogVisibleDetail: false,
            //模态框名展示
            cameraTitle: true,
            expandAll: true,
            checkbox: true,
            //修改
            cameraDataEdit: null,
            cameraDTO: {
                id: null,
                cameraName: null,
                gbIndexCode: null,
                cameraType: null,
                channelNo: null
            },
            init: true,
            currentNode: null,
            cameraDataRowIndex: -1,
            //添加输入框验证
            cameraFormRules: {
                cameraName: [{required: true, trigger: ['blur', 'change'], message: '设备名称不能为空'}],
                cameraType: [{required: true, trigger: ['blur', 'change'], message: '设备类型不能为空'}]
            }
        },
        methods: {

            /**
             * 树点击左侧树事件
             */
            handleOrganizationTreeClick(node) {

                if (this.init) {
                    this.init = false;
                    this.currentNode = node[0]
                } else {
                    this.currentNode = node;
                }
                this.cameraDataRowIndex = -1;
                this.page.pageNo=1;
                this.getCameraList();
            },

            /**
             * 搜索
             */
            searchCameraList() {
                this.getCameraList()
            },

            /**
             * 获取设备信息列表
             */
            getCameraList() {
                let queryData = {
                    pageNo: this.page.pageNo,
                    pageSize: this.page.pageSize,
                    cameraName: this.queryContent,
                    deviceOrganizationIds: []
                }
                if (this.currentNode !== null) {
                    queryData.deviceOrganizationIds.push(this.currentNode.id);
                }
                this.loading = true;
                getCameraDataPageList(queryData).then(res => {
                    console.log(res)
                    this.loading = false
                    this.cameraDataList = res.data.data.dataList;
                    this.page.totalCount = res.data.data.totalCount;
                    this.$refs.cameraTableRef.setCurrentRow(this.cameraDataList[this.cameraDataRowIndex])
                }).catch(err => {
                        console.log(err)
                    this.loading = false
                })
            },

            handleClickCameraDataRow(record, index) {
                for (var i = 0; i < this.cameraDataList.length; i++) {
                    if (record.id === this.cameraDataList[i].id) {
                        this.cameraDataRowIndex = i
                    }
                }
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
             * 设备类型状态下拉列表
             */
            getDevStatusCodeTypeValue() {
                selectDevStatusCodeTypeValue().then(res => {
                    this.deviceTypeStatusSelectList = res.data.data
                }).catch(err => {
                        console.log("设备类型状态下拉列表展示出错！");
                })
            },

            /**
             * 打开添加模态框
             */
            openInsertCommit() {
                if (this.$refs.cameraFormRef) {
                    this.$refs.cameraFormRef.resetFields();
                }
                this.cameraDTO.id = null;
                this.cameraTitle = true;
                this.dialogVisible = true;
                // this.getDevCodeTypeValue();
                // this.getDevStatusCodeTypeValue();
                setTimeout(() => {
                        this.currentDeviceOrganizationId = this.currentNode.id
                    this.deviceOrganizationName = this.currentNode.organizationName
                }, 300);
            },

            /**
             * 打开修改模态框
             * @param rowData
             */
            openUpdateCommit(rowData) {
                this.cameraTitle = false
                this.dialogVisible = true
                const assignData = {}
                Object.assign(assignData, rowData)
                this.$nextTick(() => {
                    this.cameraDTO = assignData
                })
                this.cameraDataEdit = rowData
                // this.getDevCodeTypeValue();
                // this.getDevStatusCodeTypeValue();
                setTimeout(() => {
                    this.currentDeviceOrganizationId = this.currentNode.id
                    this.deviceOrganizationName = this.currentNode.organizationName
                }, 300);
            },

            clearHandle(val) {
                this.cameraDTO.deviceOrganizationId = null
                this.currentDeviceOrganizationId = this.currentNode.id
                this.deviceOrganizationName = this.currentNode.organizationName
            },

            selectOrganizationTreeClick(node) {
                this.cameraDTO.deviceOrganizationId = node.id
            },

            /**
             * 打开详情查看
             * @param rowData
             */
            openDetailCommit(rowData) {
                this.dialogVisibleDetail = true
                const assignData = {}
                Object.assign(assignData, rowData)
                this.$nextTick(() => {
                    this.cameraDTO = assignData
                })
                this.getDevCodeTypeValue();
                this.getDevStatusCodeTypeValue();
                setTimeout(() => {
                    this.currentDeviceOrganizationId = this.currentNode.id
                    this.deviceOrganizationName = this.currentNode.organizationName
                }, 300);
            },

            /**
             * 添加
             */
            saveCamera() {
                this.dialogLoading = true;
                this.cameraDTO.orgId = this.currentNode.id
                saveCameraData(this.cameraDTO).then(res => {
                    this.$message({
                    message: res.data.data,
                    type: 'success'
                });
                this.getCameraList();
                this.dialogVisible = false;
                this.dialogLoading = false;
            }).catch(err => {
                    this.$message({
                    message: "添加失败",
                    type: 'error'
                });
                this.dialogLoading = false;
            })
            },

            /**
             * 修改
             */
            updateCamera() {
                this.dialogLoading = true
                updateCameraData(this.cameraDTO).then(res => {
                    this.getCameraList();
                this.$message({
                    message: res.data.data,
                    type: 'success'
                });
                this.dialogVisible = false;
                this.dialogLoading = false;
            }).catch(err => {
                    console.log(err)
                this.$message({
                    message: "修改失败",
                    type: 'error'
                });
                this.dialogLoading = false
            })
            },

            /**
             * 点击提交
             */
            submitForm() {
                this.$refs.cameraFormRef.validate((valid) => {
                    if (valid) {
                        if (this.cameraDTO.id) {
                            this.updateCamera()
                            return
                        }
                        this.saveCamera()
                    } else {
                        return false
                    }
                })
            },

            /**
             * 重置
             */
            resetForm() {
                if (this.cameraDTO.id) {
                    const assignData = {}
                    Object.assign(assignData, this.cameraDataEdit)
                    this.cameraDTO = assignData
                    return
                }
                this.$refs.cameraFormRef.resetFields();
            },

            /**
             * 删除
             */
            removeCamera() {
                const deleteDTO = {
                    idList: this.checkCameraList
                }
                deleteCameraData(deleteDTO).then(res => {
                    this.getCameraList();
                this.$message({
                    message: res.data.data,
                    type: 'success'
                });
            }).catch(err => {
                    console.log(err)
                this.$message({
                    message: "删除失败",
                    type: 'error'
                });
            })
            },

            /**
             * 更新数据
             */
            flashCameraDataList() {
                this.logining = true;
                flashCameraData().then(res => {
                    this.getCameraList();
                    this.logining = false;
                    this.$message({
                        message: res.data.data,
                        type: 'success'
                    });
                }).catch(err => {
                        console.log(err)
                    this.logining = false;
                    this.$message({
                        message: "更新失败！",
                        type: 'error'
                    });
                })
            },
            handleSelectionChange(val) {
                this.checkCameraList = []
                val.forEach(item => {
                    this.checkCameraList.push(item.id)
            })
            },

            /**
             * 分页
             * @param pageNo
             */
            handleCurrentChange(pageNo) {
                this.page.pageNo = pageNo;
                this.cameraDataRowIndex = -1;
                this.getCameraList();
            },
            handleSizeChange(pageSize) {
                this.page.pageSize = pageSize;
                this.getCameraList();
            },

            getCameraTypeName(val) {
                return getCameraTypeName(val.cameraType);
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

    .el-form-item__error {
        color: #F56C6C;
        font-size: 12px;
        line-height: 1;
        padding-top: 0px;
        position: absolute;
        top: 100%;
        left: 0;
    }

    .el-form-item--mini .el-form-item__error {
        padding-top: 2px;
    }

    /*.el-input__inner{
        border: none;
        background-color: transparent;
    }*/

</style>
