<%--
  Created by IntelliJ IDEA.
  User: huang
  Date: 2020-07-08
  Time: 10:51
  To change this template use File | Settings | File Templates./*sfm*/
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <!-- import Vue before Element -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/vue/index.css"/>
    <%--    <link rel="stylesheet" src="${pageContext.request.contextPath}/static/js/vue/element.css">--%>

    <title>录像机信息管理</title>
</head>

<body style="background-color:#001F6B;">
<div id="app">
    <div style="height: calc(100% - 40px); width: calc(100% - 20px); position: absolute">
        <%--  操作区 --%>
        <div style="height:45px; width: 100%; border:2px solid #DDDDDD;">
            <div style="line-height:40px; width: 100%; float:left;">
                <el-input v-model="queryContent" clearable style="width:30%; padding-left:10%;"
                          size="mini"
                          placeholder="请输入录像机信息【名称】进行搜索"></el-input>
                <el-button size="mini" type="primary" class="btn_search" icon="el-icon-search"
                           @click="searchNvrDataList">
                    查询
                </el-button>
                <el-button-group style="width:200px; float:right; margin-top: 8px;">
                    <el-button type="primary" size="mini" icon="el-icon-plus" class="btn_dark_blue"
                               @click="saveOpenNvrDataDialog">添加
                    </el-button>
                    <el-button type="danger" size="mini" icon="el-icon-delete" class="btn_dark_black"
                               @click="removeNvrData">删除
                    </el-button>
                </el-button-group>
            </div>
        </div>
        <div style="height: calc(100% - 40px); width:100%; margin-top: 8px; float:left; border:2px solid #DDDDDD;">
            <%-- 数据列表 --%>
            <el-table
                    ref="nvrDataTableRef"
                    v-loading="tableLoading"
                    :data="nvrDataList"
                    border
                    size="mini"
                    tooltip-effect="dark"
                    style="width: 100%;"
                    highlight-current-row
                    height="calc(100% - 35px)"
                    element-loading-text="拼命加载中"
                    element-loading-spinner="el-icon-loading"
                    element-loading-background="rgba(0, 0, 0, 0.8)"
                    @row-click="handleClickNvrDataRow"
                    :header-cell-style="{ 'background-color':'rgb(3,110,186,0.1)','color':'rgb(3,110,186)', 'text-align': 'center'}"
                    @selection-change="handleSelectionChange"
            >
                <el-table-column align="center" width="40" type="selection" fixed="left"></el-table-column>
                <el-table-column label="编号" prop="nvrBh" width="60"></el-table-column>
                <el-table-column label="录像机名称" prop="nvrName" width="180" show-overflow-tooltip
                                 :render-header="renderHeader"></el-table-column>
                <el-table-column label="录像机型号" prop="nvrModel" width="120" show-overflow-tooltip></el-table-column>
                <el-table-column label="所挂IPC数量" prop="ipCnum" width="90"></el-table-column>
                <el-table-column label="安装位置" prop="nvrAddr" width="140" show-overflow-tooltip
                                 :render-header="renderHeader"></el-table-column>
                <el-table-column label="IP地址" prop="nvrIp" width="120" :render-header="renderHeader"></el-table-column>
                <el-table-column label="创建时间" prop="createTime" min-width=140"></el-table-column>
                <el-table-column width="140" label="操作" align="center" fixed="right">
                    <template slot-scope="scope">
                        <el-tooltip class="item" effect="dark" content="详情" placement="top-start">
                            <el-button size="mini" style="padding: 3px 15px"
                                       @click="detailOpenNvrDataDialog(scope.row)"
                            ><i class="el-icon-zoom-in"></i>
                            </el-button>
                        </el-tooltip>
                        <el-tooltip class="item" effect="dark" content="编辑" placement="top-start">
                            <el-button size="mini" style="padding: 3px 15px"
                                       @click="updateOpenNvrDataDialog(scope.row)"
                            ><i class="el-icon-edit"></i>
                            </el-button>
                        </el-tooltip>
                    </template>
                </el-table-column>
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


    <%--添加修改模态框--%>
    <el-dialog :title="nvrTitle?'录像机添加':'录像机编辑'" :visible.sync="dialogVisible" style="text-align:center;">
        <el-form
                :model="nvrForm"
                :rules="nvrFormRules"
                status-icon
                ref="nvrFormRef"
                label-width="120px"
                size="mini">
            <el-row>
                <el-col :span="11">
                    <el-form-item label="录像机编号:" prop="nvrBh">
                        <el-input v-model="nvrForm.nvrBh" type="number"></el-input>
                    </el-form-item>
                </el-col>
                <el-col :span="11">
                    <el-form-item label="录像机名称:" prop="nvrName">
                        <el-input v-model="nvrForm.nvrName"></el-input>
                    </el-form-item>
                </el-col>
            </el-row>

            <el-row>
                <el-col :span="11">
                    <el-form-item label="录像机型号:" prop="nvrModel">
                        <el-input v-model="nvrForm.nvrModel"></el-input>
                    </el-form-item>
                </el-col>
                <el-col :span="11">
                    <el-form-item label="所属厂区:" prop="nvrArea">
                        <el-input v-model="nvrForm.nvrArea"></el-input>
                    </el-form-item>
                </el-col>
            </el-row>

            <el-row>
                <el-col :span="11">
                    <el-form-item label="所属作业线:" prop="deviceOrganizationId">
                        <el-input type="number" v-model="nvrForm.deviceOrganizationId"></el-input>
                    </el-form-item>
                </el-col>
                <el-col :span="11">
                    <el-form-item label="安装位置:" prop="nvrAddr">
                        <el-input v-model="nvrForm.nvrAddr"></el-input>
                    </el-form-item>
                </el-col>
            </el-row>

            <el-row>
                <el-col :span="11">
                    <el-form-item label="所挂IPC数量:" prop="ipCnum">
                        <el-input v-model="nvrForm.ipCnum" type="number"></el-input>
                    </el-form-item>
                </el-col>
                <el-col :span="11">
                    <el-form-item label="IP地址:" prop="nvrIp">
                        <el-input v-model="nvrForm.nvrIp"></el-input>
                    </el-form-item>
                </el-col>
            </el-row>

            <el-row>
                <el-col :span="11">
                    <el-form-item label="端口:" prop="nvrPort">
                        <el-input v-model="nvrForm.nvrPort"></el-input>
                    </el-form-item>
                </el-col>
                <el-col :span="11">
                    <el-form-item label="通道口:" prop="channelNumber">
                        <el-input v-model="nvrForm.channelNumber" type="number"></el-input>
                    </el-form-item>
                </el-col>
            </el-row>

            <el-row>
                <el-col :span="11">
                    <el-form-item label="通道口名称:" prop="channelName">
                        <el-input v-model="nvrForm.channelName"></el-input>
                    </el-form-item>
                </el-col>
                <el-col :span="11">
                    <el-form-item label="用户名:" prop="user">
                        <el-input v-model="nvrForm.user"></el-input>
                    </el-form-item>
                </el-col>
            </el-row>

            <el-row>
                <el-col :span="11">
                    <el-form-item label="密码:" prop="pwd">
                        <el-input v-model="nvrForm.pwd"></el-input>
                    </el-form-item>
                </el-col>
                <el-col :span="11">
                    <el-form-item label="状态:" prop="status">
                        <el-select v-model="nvrForm.status" size="mini" style="width: 100%;"
                                   placeholder="请选择状态">
                            <el-option
                                    v-for="item in NVR_DATA_STATUS"
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
                    <el-form-item label="备注:" prop="remark">
                        <el-input v-model="nvrForm.remark"></el-input>
                    </el-form-item>
                </el-col>
            </el-row>

            <el-form-item style="margin: 15px 0px;" label-width="0px">
                <div style="width:100%; height:40px;">
                    <el-button type="success" size="small" style="width:80px" @click="submitForm()"
                               class="btn_commit">提交
                    </el-button>
                    <el-button @click="resetForm()" style="width:80px" size="small">重置</el-button>
                </div>
            </el-form-item>

        </el-form>
    </el-dialog>


    <%--详情模态框--%>
    <el-dialog title="录像机详情" :visible.sync="dialogVisibleDetail" style="text-align:center;">
        <el-form
                :model="nvrForm"
                status-icon
                label-width="120px"
                size="mini">
            <el-row>
                <el-col :span="11">
                    <el-form-item label="录像机编号:" prop="nvrBh">
                        <el-input v-model="nvrForm.nvrBh" :disabled="true"></el-input>
                    </el-form-item>
                </el-col>
                <el-col :span="11">
                    <el-form-item label="录像机名称:" prop="nvrName">
                        <el-input v-model="nvrForm.nvrName" :disabled="true"></el-input>
                    </el-form-item>
                </el-col>
            </el-row>

            <el-row>
                <el-col :span="11">
                    <el-form-item label="录像机型号:" prop="nvrModel">
                        <el-input v-model="nvrForm.nvrModel" :disabled="true"></el-input>
                    </el-form-item>
                </el-col>
                <el-col :span="11">
                    <el-form-item label="所属厂区:" prop="nvrArea">
                        <el-input v-model="nvrForm.nvrArea" :disabled="true"></el-input>
                    </el-form-item>
                </el-col>
            </el-row>

            <el-row>
                <el-col :span="11">
                    <el-form-item label="所属作业线:" prop="deviceOrganizationId">
                        <el-input v-model="nvrForm.deviceOrganizationId" :disabled="true"></el-input>
                    </el-form-item>
                </el-col>
                <el-col :span="11">
                    <el-form-item label="安装位置:" prop="nvrAddr">
                        <el-input v-model="nvrForm.nvrAddr" :disabled="true"></el-input>
                    </el-form-item>
                </el-col>
            </el-row>

            <el-row>
                <el-col :span="11">
                    <el-form-item label="所挂IPC数量:" prop="ipCnum">
                        <el-input v-model="nvrForm.ipCnum" :disabled="true"></el-input>
                    </el-form-item>
                </el-col>
                <el-col :span="11">
                    <el-form-item label="IP地址:" prop="nvrIp">
                        <el-input v-model="nvrForm.nvrIp" :disabled="true"></el-input>
                    </el-form-item>
                </el-col>
            </el-row>

            <el-row>
                <el-col :span="11">
                    <el-form-item label="端口:" prop="nvrPort">
                        <el-input v-model="nvrForm.nvrPort" :disabled="true"></el-input>
                    </el-form-item>
                </el-col>
                <el-col :span="11">
                    <el-form-item label="通道口:" prop="channelNumber">
                        <el-input v-model="nvrForm.channelNumber" :disabled="true"></el-input>
                    </el-form-item>
                </el-col>
            </el-row>

            <el-row>
                <el-col :span="11">
                    <el-form-item label="通道口名称:" prop="channelName">
                        <el-input v-model="nvrForm.channelName" :disabled="true"></el-input>
                    </el-form-item>
                </el-col>
                <el-col :span="11">
                    <el-form-item label="用户名:" prop="user">
                        <el-input v-model="nvrForm.user" :disabled="true"></el-input>
                    </el-form-item>
                </el-col>
            </el-row>

            <el-row>
                <el-col :span="11">
                    <el-form-item label="密码:" prop="pwd">
                        <el-input v-model="nvrForm.pwd" :disabled="true"></el-input>
                    </el-form-item>
                </el-col>
                <el-col :span="11">
                    <el-form-item label="状态:" prop="status">
                        <el-select v-model="nvrForm.status" size="mini" style="width: 100%;"
                                   placeholder="请选择状态" :disabled="true">
                            <el-option
                                    v-for="item in NVR_DATA_STATUS"
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
                    <el-form-item label="备注:" prop="remark">
                        <el-input v-model="nvrForm.remark" :disabled="true"></el-input>
                    </el-form-item>
                </el-col>
            </el-row>

        </el-form>
    </el-dialog>


</div
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/vue.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/element.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/axios.min.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/api/equipment/nvrDataApi.js"></script>
<%--引入menu的js文件--%>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/enum/equipment/NvrData/NvrDataStatusEnum.js"></script>
<%--获取文件当前路径--%>
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
            /*js定义状态的枚举*/
            NVR_DATA_STATUS,
            /*查询参数*/
            queryContent: null,
            /*列表信息*/
            nvrDataList: [],
            /*列表是否加载（默认：false）*/
            tableLoading: false,
            /*分页参数*/
            page: {
                pageNo: 1,
                pageSize: 20,
                totalCount: 0,
                pageSizes: [20, 50, 100]
            },
            /*模态框是否展示（默认为false）*/
            dialogVisible: false,
            //模态框名展示(true表示展示前面参数)
            nvrTitle: true,
            nvrForm: {
                id: null,
                nvrBh: null,
                nvrName: null,
                nvrModel: null,
                nvrArea: null,
                deviceOrganizationId: null,
                nvrAddr: null,
                ipCnum: null,
                nvrIp: null,
                nvrPort: null,
                channelNumber: null,
                channelName: null,
                user: null,
                pwd: null,
                status: null,
                remark: null
            },
            nvrDataRowIndex: -1,
            //修改
            nvrDataEdit: null,
            /*删除（数据区）*/
            checkNvrList: [],
            /*详情模态框（默认值为false）*/
            dialogVisibleDetail: false,
            nvrFormRules: {
                nvrName: [{required: true, trigger: ['blur', 'change'], message: '录像机名称不能为空'}],
                nvrArea: [{required: true, trigger: ['blur', 'change'], message: '所属厂区不能为空'}],
                deviceOrganizationId: [{required: true, trigger: ['blur', 'change'], message: '所属作业线不能为空'}],
                nvrAddr: [{required: true, trigger: ['blur', 'change'], message: '安装位置不能为空'}],
                nvrIp: [{required: true, trigger: ['blur', 'change'], message: 'IP地址不能为空'}],
            }
        },
        /*页面加载触发事件*/
        created: function () {
            this.getNvrDataList()
        },
        /*methods需要一定条件的触发执行事件*/
        methods: {
            /*查询列表*/
            getNvrDataList() {
                let queryData = {
                    pageNo: this.page.pageNo,
                    pageSize: this.page.pageSize,
                    nvrName: this.queryContent
                }
                this.loading = true
                getNvrDataPageList(queryData).then(res => {
                    this.tableLoading = false
                this.nvrDataList = res.data.data.dataList;
                this.page.totalCount = res.data.data.totalCount;
                this.$refs.nvrDataTableRef.setCurrentRow(this.nvrDataList[this.nvrDataRowIndex])
            }).catch(err => {
                    console.log(err)
                this.tableLoading = false
            })
            },

            handleClickNvrDataRow(record, index) {
                for (var i = 0; i < this.nvrDataList.length; i++) {
                    if (record.id === this.nvrDataList[i].id) {
                        this.nvrDataRowIndex = i
                    }
                }
            },


            /*搜索条件查询*/
            searchNvrDataList() {
                this.getNvrDataList()
            },
            /*点击添加弹出模态框*/
            saveOpenNvrDataDialog() {
                if (this.$refs.nvrFormRef) {
                    this.$refs.nvrFormRef.resetFields();
                }
                this.nvrForm.id = null
                this.nvrTitle = true;
                this.dialogVisible = true
            },
            /*点击修改按钮弹出修改模态框*/
            updateOpenNvrDataDialog(rowData) {
                console.log(rowData)
                this.nvrTitle = false
                this.dialogVisible = true
                const assignData = {}
                Object.assign(assignData, rowData)
                this.$nextTick(() => {
                    this.nvrForm = assignData
            })
                this.nvrDataEdit = rowData
            },
            /*点击详情按钮弹出详情模态框*/
            detailOpenNvrDataDialog(rowData) {
                console.log(this.nvrForm)
                this.nvrTitle = false
                this.dialogVisibleDetail = true
                const assignData = {}
                Object.assign(assignData, rowData)
                this.$nextTick(() => {
                    this.nvrForm = assignData
            })
                this.nvrDataEdit = rowData
            },
            /*点击提交按钮*/
            submitForm() {
                this.$refs.nvrFormRef.validate((valid) => {
                    if (valid) {
                        if (this.nvrForm.id) {
                            this.updateNvr()
                            return
                        }
                        this.saveNvr()
                    } else {
                        return false
                    }
                })
            },
            /*重置按钮*/
            resetForm() {
                if (this.nvrForm.id) {
                    const assignData = {}
                    Object.assign(assignData, this.nvrDataEdit)
                    this.nvrForm = assignData
                    return
                }
                this.$refs.nvrFormRef.resetFields();
            },
            /*添加*/
            saveNvr() {
                this.tableLoading = true;
                saveNvrData(this.nvrForm).then(res => {
                    this.getNvrDataList();
                this.$message({
                    message: res.data.data,
                    type: 'success'
                });
                this.dialogVisible = false;
                this.tableLoading = false;
            }).catch(err => {
                    this.$message({
                    message: "添加失败",
                    type: 'error'
                });
                this.tableLoading = false;
            })
            },
            //修改
            updateNvr() {
                console.log(this.nvrForm)
                this.tableLoading = true
                updateNvrData(this.nvrForm).then(res => {
                    this.getNvrDataList(this.nvrForm);
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
            /*点击删除按钮*/
            removeNvrData() {
                const listStr = this.checkNvrList.join(',')
                // const qs = require('qs');
                const ids = {
                    ids: listStr
                }
                deleteNvrData(ids).then(res => {
                    this.getNvrDataList();
                this.$message({
                    message: res.data.data,
                    type: 'success'
                });
            }).catch(err => {
                    console.log(err)
            }).catch(err => {
                    console.log(err)
                this.$message({
                    message: "删除失败",
                    type: 'error'
                });
            })
            },
            /*列表复选框*/
            handleSelectionChange(val) {
                this.checkNvrList = []
                val.forEach(item => {
                    this.checkNvrList.push(item.id)
            })
            },
            //    分页
            handleCurrentChange(pageNo) {
                this.page.pageNo = pageNo;
                this.nvrDataRowIndex = -1;
                this.getNvrDataList();
            },
            handleSizeChange(pageSize) {
                this.page.pageSize = pageSize
                this.getNvrDataList()
            },
            //必填列标识
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
