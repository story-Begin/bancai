<%@ page import="com.baosight.iplat4j.core.web.threadlocal.UserSession" %><%--
  Created by IntelliJ IDEA.
  User: huang
  Date: 2020-07-13
  Time: 11:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    UserSession.web2Service(request);
    String userName = UserSession.getLoginCName();
    String loginName = UserSession.getLoginName();
%>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/vue/index.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/assets/icon/iconfont.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/page-css.css"/>
    <%--    <link rel="stylesheet" src="${pageContext.request.contextPath}/static/js/vue/element.css">--%>


    <title>突发事件处理</title>
</head>
<body style="background-color:#001F6B;">
<div>
    <div id="app">
        <div style="height: calc(100% - 20px); width: calc(100% - 20px); position: absolute;">
            <%--  操作区 --%>
            <div style="height:135px; width: 100%;" class="block-border">
                <el-form ref="queryForm" label-width="120px" size="mini" :model="queryDTO">
                    <el-row>
                        <el-col :span="8">
                            <el-form-item label="组织树:" prop="deviceOrganizationId" style="margin: 10px 0px;">
                                <select-organization-tree
                                        v-model="queryDTO.deviceOrganizationId"
                                        style="padding: 0 0px;width:80%;float: left;"
                                        @func="clearHandle"
                                        @organization-tree-click="selectOrganizationTreeClick">
                                </select-organization-tree>
                            </el-form-item>
                        </el-col>
                        <el-col :span="8">
                            <el-form-item label="发现人工号:" prop="finderJob" style="margin: 10px 0px;">
                                <el-input v-model="queryDTO.finderJob" clearable style="width: 80%;"
                                          :disabled="inputDisabled"
                                          placeholder="请输入【发现人工号】"></el-input>
                            </el-form-item>
                        </el-col>
                        <el-col :span="8">
                            <el-form-item label="被推送人工号:" prop="accepterJob" style="margin: 10px 0px;">
                                <el-input v-model="queryDTO.accepterJob" clearable :disabled="accepterJobDisabled"
                                          size="mini" style="width: 80%;"
                                          placeholder="请输入【被推送人工号】"></el-input>
                            </el-form-item>
                        </el-col>
                    </el-row>
                    <el-row>
                        <el-col :span="8">
                            <el-form-item label="起始日期:" prop="timeData" style="margin: 10px 0px;">
                                <el-date-picker
                                        style="width: 100%"
                                        clearable
                                        v-model="timeData"
                                        type="daterange"
                                        range-separator="至"
                                        :default-time="['00:00:00', '23:59:59']"
                                        start-placeholder="开始日期"
                                        end-placeholder="结束日期">
                                </el-date-picker>
                            </el-form-item>
                        </el-col>
                        <el-col :span="8">
                            <el-form-item label="处理状态:" prop="status" style="margin: 10px 0px;">
                                <el-radio v-model="queryDTO.status" label="0" @change="changStatus">未处理</el-radio>
                                <el-radio v-model="queryDTO.status" label="1" @change="processedRadio">已处理
                                </el-radio>
                            </el-form-item>
                        </el-col>

                    </el-row>

                    <el-row>
                        <el-col :span="14" style="text-align: right;">
                            <el-button size="mini" type="primary" icon="el-icon-search"
                                       @click="searchDeviceAccidentList">
                                查询
                            </el-button>
                            <el-button size="mini" plain icon="el-icon-refresh" @click="resetQueryForm">
                                重置
                            </el-button>
                        </el-col>
                        <el-col :span="4">&nbsp;</el-col>
                        <el-col :span="6">
                            <el-button-group style="width:200px; float:right;">
                                <el-button type="primary" size="mini" icon="el-icon-plus" class="btn_dark_blue"
                                           @click="saveOpenDeviceAccidentDialog">添加
                                </el-button>
                                <el-button type="danger" size="mini" icon="el-icon-delete" class="btn_dark_black"
                                           @click="removeDeviceAccident">删除
                                </el-button>
                            </el-button-group>
                        </el-col>
                    </el-row>
                </el-form>
            </div>
            <div style="height: calc(100% - 150px); width:100%; margin-top: 8px; float:left;" class="block-border">
                <el-tabs v-model="defaultTabsValue" type="card" @tab-click="handleTabClick"
                         style="height: 100%;">
                    <el-tab-pane label="推送给本人的事件" name="first">
                        <el-table
                                ref="deviceAccidentTableRef"
                                v-loading="tableLoading"
                                :data="deviceAccidentDataList"
                                border
                                size="mini"
                                tooltip-effect="dark"
                                style="width: 100%;"
                                highlight-current-row
                                height="calc(100% - 80px)"
                                element-loading-text="拼命加载中"
                                element-loading-spinner="el-icon-loading"
                                element-loading-background="rgba(0, 0, 0, 0.8)"
                                @row-click="handleClickDeviceAccidentRow"
                                :header-cell-style="{'text-align': 'center'}"
                                @selection-change="handleSelectionChange"
                        >
                            <el-table-column align="center" width="40" type="selection" fixed="left"></el-table-column>
                            <%--                    <el-table-column label="事件名称" prop="eventName" show-overflow-tooltip--%>
                            <%--                                     width="180"></el-table-column>--%>
                            <el-table-column label="发生时间" prop="happenTime" show-overflow-tooltip width="150"
                                             :render-header="renderHeader"></el-table-column>
                            <%--                            <el-table-column label="预计完成时间" prop="completionTime" show-overflow-tooltip--%>
                            <%--                                             width="140"></el-table-column>--%>
                            <%--                            <el-table-column label="设备编号" prop="deviceCode" show-overflow-tooltip width="120"--%>
                            <%--                                             :render-header="renderHeader"></el-table-column>--%>
                            <el-table-column label="设备路径" prop="organizationPath" show-overflow-tooltip width="200"
                                             :render-header="renderHeader"></el-table-column>
                            <el-table-column label="安装地址" prop="areaAddr" show-overflow-tooltip width="180"
                                             :render-header="renderHeader"></el-table-column>
                            <el-table-column label="事件图片" prop="picUrl" align="center" show-overflow-tooltip width="90"
                                             :render-header="renderHeader">
                                <template slot-scope="scope">
                                    <el-tooltip class="item" effect="dark" content="点击展示突发事件图片" placement="top-start">
                                        <a @click="cancelDialog(scope.row)" style="cursor:pointer">
                                            <i class="el-icon-picture" style="height: 100%"></i>
                                        </a>
                                    </el-tooltip>
                                </template>
                            </el-table-column>
                            <el-table-column label="被推人工号" prop="accepterJob" show-overflow-tooltip width="100"
                                             :render-header="renderHeader"></el-table-column>
                            <el-table-column label="被推人名称" prop="accepterName" show-overflow-tooltip width="100"
                                             :render-header="renderHeader"></el-table-column>
                            <el-table-column label="发现人工号" prop="finderJob" show-overflow-tooltip width="100"
                                             :render-header="renderHeader"></el-table-column>
                            <el-table-column label="发现人名称" prop="finderName" show-overflow-tooltip width="100"
                                             :render-header="renderHeader"></el-table-column>
                            <el-table-column label="处理状态" prop="status" align="center" show-overflow-tooltip width="80"
                                             :render-header="renderHeader"
                                             :formatter="getDeviceAccidentStatus"></el-table-column>
                            <el-table-column label="描述" prop="disposerRemark" align="center"
                                             show-overflow-tooltip min-width="180"></el-table-column>
                            <el-table-column label="创建时间" prop="createTime" fixed="right" show-overflow-tooltip
                                             min-width="150"></el-table-column>
                            <el-table-column width="70" label="操作" align="center" fixed="right">
                                <template slot-scope="scope">
                                    <el-tooltip class="item" effect="dark" content="审批" placement="top-start">
                                        <el-button size="mini" style="padding: 3px 15px" :disabled="applyDisabled"
                                                   @click="openDisposerRemark(scope.row)">
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
                    </el-tab-pane>
                    <el-tab-pane label="本人发现事件" name="second">
                        <el-table
                                ref="deviceAccidentTableRef"
                                v-loading="tableLoading"
                                :data="deviceAccidentDataList"
                                border
                                size="mini"
                                tooltip-effect="dark"
                                style="width: 100%;"
                                highlight-current-row
                                height="calc(100% - 80px)"
                                element-loading-text="拼命加载中"
                                element-loading-spinner="el-icon-loading"
                                element-loading-background="rgba(0, 0, 0, 0.8)"
                                @row-click="handleClickDeviceAccidentRow"
                                :header-cell-style="{'text-align': 'center'}"
                                @selection-change="handleSelectionChange"
                        >
                            <el-table-column align="center" width="40" type="selection" fixed="left"></el-table-column>
                            <%--                    <el-table-column label="事件名称" prop="eventName" show-overflow-tooltip--%>
                            <%--                                     width="180"></el-table-column>--%>
                            <el-table-column label="发生时间" prop="happenTime" show-overflow-tooltip width="150"
                                             :render-header="renderHeader"></el-table-column>
                            <%--                            <el-table-column label="预计完成时间" prop="completionTime" show-overflow-tooltip--%>
                            <%--                                             width="140"></el-table-column>--%>
                            <%--                            <el-table-column label="设备编号" prop="deviceCode" show-overflow-tooltip width="120"--%>
                            <%--                                             :render-header="renderHeader"></el-table-column>--%>
                            <el-table-column label="设备路径" prop="organizationPath" show-overflow-tooltip width="200"
                                             :render-header="renderHeader"></el-table-column>
                            <el-table-column label="安装地址" prop="areaAddr" show-overflow-tooltip width="180"
                                             :render-header="renderHeader"></el-table-column>
                            <el-table-column label="事件图片" prop="picUrl" align="center" show-overflow-tooltip width="90"
                                             :render-header="renderHeader">
                                <template slot-scope="scope">
                                    <el-tooltip class="item" effect="dark" content="点击展示突发事件图片" placement="top-start">
                                        <a @click="cancelDialog(scope.row)" style="cursor:pointer">
                                            <i class="el-icon-picture" style="height: 100%"></i>
                                        </a>
                                    </el-tooltip>
                                </template>
                            </el-table-column>
                            <el-table-column label="被推人工号" prop="accepterJob" show-overflow-tooltip width="100"
                                             :render-header="renderHeader"></el-table-column>
                            <el-table-column label="被推人名称" prop="accepterName" show-overflow-tooltip width="100"
                                             :render-header="renderHeader"></el-table-column>
                            <el-table-column label="发现人工号" prop="finderJob" show-overflow-tooltip width="100"
                                             :render-header="renderHeader"></el-table-column>
                            <el-table-column label="发现人名称" prop="finderName" show-overflow-tooltip width="100"
                                             :render-header="renderHeader"></el-table-column>
                            <el-table-column label="处理状态" prop="status" align="center" show-overflow-tooltip width="80"
                                             :render-header="renderHeader"
                                             :formatter="getDeviceAccidentStatus"></el-table-column>
                            <el-table-column label="描述" prop="disposerRemark" align="center"
                                             show-overflow-tooltip min-width="180"></el-table-column>
                            <el-table-column label="创建时间" prop="createTime" fixed="right" show-overflow-tooltip
                                             min-width="140"></el-table-column>
                            <el-table-column width="70" label="操作" align="center" fixed="right">
                                <template slot-scope="scope">
                                    <el-tooltip class="item" effect="dark" content="审批" placement="top-start">
                                        <el-button size="mini" style="padding: 3px 15px" :disabled="applyDisabled"
                                                   @click="openDisposerRemark(scope.row)">
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
                    </el-tab-pane>
                </el-tabs>
            </div>
        </div>

        <el-dialog :title="deviceAccidentDialogTitle?'突发事件添加':'突发事件编辑'"
                   :visible.sync="dialogVisible" style="text-align:center;">
            <el-form
                    ref="devicePollDialogRef"
                    v-loading="dialogLoading"
                    :model="deviceAccident"
                    :rules="devicePollRules"
                    label-width="120px"
                    element-loading-text="正在提交中......"
                    element-loading-spinner="el-icon-loading"
            >
                <el-row>
                    <el-col :span="11">
                        <el-form-item label="发生时间:" prop="happenTime" style="margin: 5px 0px;">
                            <el-date-picker
                                    style="width: 100%;"
                                    size="mini"
                                    clearable
                                    v-model="deviceAccident.happenTime"
                                    type="datetime"
                                    placeholder="请选择发生日期">
                            </el-date-picker>
                        </el-form-item>
                    </el-col>
                    <el-col :span="11">
                        <el-form-item label="预计完成时间:" prop="completionTime" style="margin: 5px 0px;">
                            <el-date-picker
                                    size="mini"
                                    clearable
                                    style="width: 100%;"
                                    v-model="deviceAccident.completionTime"
                                    type="datetime"
                                    placeholder="请选择预计完成日期">
                            </el-date-picker>
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-row>
                    <el-col :span="22">
                        <el-form-item label="安装地址:" prop="areaAddr" style="margin: 5px 0px;">
                            <el-input v-model="deviceAccident.areaAddr" clearable size="mini"
                                      placeholder="请输入事件名称"/>
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-row>
                    <el-col :span="13">
                        <el-form-item label="推送至:" prop="userInfo">
                            <el-input v-model="deviceAccident.userInfo" clearable size="mini" style="width: 100%;"
                                      @focus="onInputFocus" placeholder="请输入被推人名称"/>
                        </el-form-item>
                    </el-col>
                    <el-col :span="11">
                        <el-button type="primary" @click="loginUser()" size="mini"
                                   style="float: left; margin-left: 10px;">
                            推送到本人
                        </el-button>
                    </el-col>
                </el-row>
                <el-row>
                    <el-col :span="22">
                        <el-form-item label="设备编号:" style="margin: 5px 0px;">
                            <select-recursive-check-tree
                                    style="height:180px; overflow: auto;
                        background-color:#fff; padding: 0 0px; width:100%; height:180px; float: left;"
                            <%--                                    :expand-all="true"--%>
                                    @organization-equipment-tree-click="equipmentTreeClick"
                            >
                            </select-recursive-check-tree>
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-row>
                    <el-col :span="22">
                        <el-form-item label="报警图片:" style="margin: 5px 0px;">
                            <el-upload
                                    style="float: left"
                                    action=""
                                    ref="insertUpload"
                                    list-type="picture-card"
                                    :limit="1"
                                    :auto-upload="false"
                                    :before-upload="beforeUploadForm"
                            <%-- :http-request="imageChange"--%>
                                    :on-change="imageChange"
                            >
                                <div>上传事件图片</div>
                            </el-upload>
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-form-item style="margin: 15px 0px;" label-width="0px">
                    <div style="width:100%; height:40px;">
                        <el-button type="success" size="small" style="width:80px" @click="handleCommit()">提交
                        </el-button>
                        <el-button @click="resetDevicePoll()" style="width:80px" size="small">重置</el-button>
                    </div>
                </el-form-item>
            </el-form>
        </el-dialog>

        <el-dialog title="选择接收人员" :visible.sync="UsersDialogVisible" width="65%" style="text-align: center;">
            <div style="width: 100%; height: 300px; text-align: center;" class="block-border">
                <div style="line-height:40px; text-align: center; ">
                    <el-input v-model="dialogSearchContent1" clearable style="width:25%; "
                              size="mini"
                              placeholder="【工号】搜索"></el-input>&nbsp;&nbsp;&nbsp;
                    <el-input v-model="dialogSearchContent2" clearable style="width: 25%;  "
                              size="mini"
                              placeholder="【姓名】搜索"></el-input>&nbsp;&nbsp;&nbsp;
                    <el-button size="mini" type="primary" class="btn_search" icon="el-icon-search"
                               @click="searchUserList">
                        查询
                    </el-button>
                </div>
                <el-table
                        :data="usersDialogTableData"
                        v-loading="usersDialogLoading"
                        border
                        size="mini"
                        tooltip-effect="dark"
                        highlight-current-row
                        border
                        height="calc(100% - 75px)"
                        :row-style="{height:'20px'}"
                        :cell-style="{padding:'0px'}"
                        @row-click="getUsersRowData"
                        style="width: 100%; height: 240px;font-size: 10px;">
                    <el-table-column prop="loginName" label="工号" min-width="180"></el-table-column>
                    <el-table-column prop="userName" label="姓名" min-width="180"></el-table-column>
                </el-table>
                <div style="text-align:center;height: 35px;" class="el-pagination">
                    <el-pagination
                            layout="total, sizes, prev, pager, next"
                            :total="dialogPage.totalCount"
                            :pager-count="5"
                            :page-size="dialogPage.pageSize"
                            :current-page="dialogPage.pageNo"
                            :page-sizes="dialogPage.pageSizes"
                            @current-change="handleDialogCurrentChange"
                            @size-change="handleDialogSizeChange"
                    />

                </div>
            </div>
        </el-dialog>

        <el-dialog title="图片展示"
                   :visible.sync="picUrlDialogVisible" style="text-align:center;">
            <img :src="picUrl" style="width:100%;height: 360px;vertical-align: middle;" alt=""></img>

            <%--            <img :src="require(''+picUrl+'')"--%>
            <%--                 style="width:100%;height: 430px;vertical-align: middle;" alt=""></img>--%>

        </el-dialog>

        <el-dialog :title="deviceAccidentDialogTitle?'突发事件处理报告':''"
                   :visible.sync="disposerRemarkDialogVisible" style="text-align:center;">
            <el-form
                    ref="disposerRemarkDialogRef"
                    v-loading="disposerRemarkDialogLoading"
                    :model="deviceAccident"
                    :rules="devicePollRules"
                    label-width="120px"
                    element-loading-text="正在提交中......"
                    element-loading-spinner="el-icon-loading"
            >
                <el-row>
                    <el-col :span="22">
                        <el-form-item label="处理报告:" prop="disposerRemark" style="margin: 5px 0px;">
                            <el-input
                                    type="textarea" clearable size="mini"
                                    :autosize="{ minRows: 2, maxRows: 4}"
                                    placeholder="请输入处理报告"
                                    v-model="deviceAccident.disposerRemark">
                            </el-input>
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-row>
                    <el-col :span="22">
                        <el-form-item label="报警图片:" style="margin: 5px 0px;">
                            <el-upload
                                    style="float: left"
                                    action=""
                                    ref="updateUpload"
                                    list-type="picture-card"
                                    :limit="1"
                                    :auto-upload="false"
                                    :before-upload="beforeUploadForm"
                                    :on-change="imageChange"
                            >
                                <div>上传事件图片</div>
                            </el-upload>
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-form-item style="margin: 15px 0px;" label-width="0px">
                    <div style="width:100%; height:40px;">
                        <el-button type="success" size="small" style="width:80px" @click="startActivity()">提交
                        </el-button>
                        <el-button @click="resetDisposerRemark()" style="width:80px" size="small">重置</el-button>
                    </div>
                </el-form-item>
            </el-form>
        </el-dialog>
    </div>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/vue.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/element.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/axios.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/api/vm/devicePollApi.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/api/cx/deviceAccidentApi.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/components/equipment/selectRecursiveOrganizationEquipmentTree.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/enum/cx/deviceAccidentStatus/accidentStatus.js"></script>
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
            timeData: '',
            tabIndex: '0',
            queryDTO: {
                deviceOrganizationId: null,
                finderJob: null,
                accepterJob: null,
                beginTime: null,
                endTime: null,
                status: '0'
            },
            applyDisabled: false,
            inputDisabled: false,
            accepterJobDisabled: true,
            file: null,
            queryContent: null,
            defaultTabsValue: 'first',
            deviceAccidentDataList: [],
            deviceAccident: {
                processId: null,
                happenTime: null,
                completionTime: null,
                deviceCode: null,
                deviceOrganizationId: null,
                organizationPath: null,
                areaAddr: null,
                picUrl: null,
                accepterJob: null,
                accepterName: null,
                finderJob: null,
                finderName: null,
                disposerRemark: null,
                disposerPicUrl: null,
                status: null,
                remark: null,
                userInfo: null,
            },
            deviceAccidentRowIndex: -1,
            deviceAccidentCheckList: [],
            deviceAccidentEdit: null,
            deviceAccidentDialogTitle: true,
            dialogVisible: false,
            dialogLoading: false,
            tableLoading: false,
            showCheckBox: true,
            usersDialogLoading: false,
            UsersDialogVisible: false,
            usersDialogTableData: [],

            dialogSearchContent1: null,
            dialogSearchContent2: null,
            page: {
                pageNo: 1,
                pageSize: 20,
                totalCount: 0,
                pageSizes: [20, 50, 100]
            },
            dialogPage: {
                pageNo: 1,
                pageSize: 20,
                totalCount: 0,
                pageSizes: [20, 50, 100]
            },
            devicePollRules: {
                happenTime: [{required: true, trigger: ['blur', 'change'], message: '发生事件不能为空'}],
                completionTime: [{required: true, trigger: ['blur', 'change'], message: '预计完成时间不能为空'}],
                areaAddr: [{required: true, trigger: ['blur', 'change'], message: '安装地址不能为空'}],
                userInfo: [{required: true, trigger: ['blur', 'change'], message: '被推人信息不能为空'}]
                // accepterJob: [{required: true, trigger: ['blur', 'change'], message: '被推人工号不能为空'}],
                // finderName: [{required: true, trigger: ['blur', 'change'], message: '发现人名称不能为空'}],
                // finderJob: [{required: true, trigger: ['blur', 'change'], message: '发现人工号不能为空'}],
            },
            picUrl: null,
            picUrlDialogVisible: false,
            deviceAccidentDialogTitle: true,
            disposerRemarkDialogVisible: false,
            disposerRemarkDialogLoading: false,
        },
        created: function () {
            this.querySelfActivity();
        },
        methods: {

            /**
             * Tab点击事件
             */
            handleTabClick(tab, event) {
                this.deviceAccidentDataList = [];
                this.tabIndex = tab.index;
                this.page.pageNo = 0;
                if (tab.index == 0) {
                    this.inputDisabled = false;
                    this.accepterJobDisabled = true;
                    this.querySelfActivity();
                    return
                }
                this.queryDTO.finderJob = null;
                this.inputDisabled = true;
                this.accepterJobDisabled = false;
                this.getDeviceAccidentList();
            },

            /**
             * 下拉框树清除事件
             */
            clearHandle(val) {
                this.queryDTO.deviceOrganizationId = null
            },

            /**
             * 下拉框树点击事件
             */
            selectOrganizationTreeClick(node) {
                this.queryDTO.deviceOrganizationId = node.id
            },

            /**
             * 搜索框清除事件
             */
            resetQueryForm() {
                const val = {}
                this.clearHandle(val);
                this.timeData = null;
                this.queryDTO.deviceOrganizationId = null;
                this.$refs.queryForm.resetFields();
            },

            /**
             * 搜索事件
             */
            searchDeviceAccidentList() {
                if (this.timeData) {
                    this.queryDTO.beginTime = this.timeData[0]
                    this.queryDTO.endTime = this.timeData[1]
                }
                if (this.tabIndex === '0') {
                    this.querySelfActivity();
                } else if (this.tabIndex === '1') {
                    this.getDeviceAccidentList();
                }
                this.queryDTO.beginTime = null
                this.queryDTO.endTime = null
            },

            /**
             * 单选框未处理点击事件
             */
            changStatus(label) {
                this.applyDisabled = false;
                this.queryDTO.status = label;
                if (this.tabIndex === '0') {
                    this.querySelfActivity();
                } else if (this.tabIndex === '1') {
                    this.getDeviceAccidentList();
                }
            },

            /**
             * 单选框已处理点击事件
             */
            processedRadio() {
                this.applyDisabled = true;
                this.getDeviceAccidentList();
            },

            /**
             * 突发事件列表
             */
            getDeviceAccidentList() {
                let queryData = {
                    pageNo: this.page.pageNo,
                    pageSize: this.page.pageSize,
                    finderJob: this.queryDTO.finderJob,
                    accepterJob: this.queryDTO.accepterJob,
                    beginTime: this.queryDTO.beginTime,
                    endTime: this.queryDTO.endTime,
                    status: this.queryDTO.status,
                    indexStatus: this.tabIndex,
                    organizationId: this.queryDTO.deviceOrganizationId
                }
                this.tableLoading = true
                getAccidentPageList(queryData).then(res => {
                    this.tableLoading = false
                    this.deviceAccidentDataList = res.data.data.dataList;
                    this.page.totalCount = res.data.data.totalCount;
                    this.$refs.deviceAccidentTableRef.setCurrentRow(this.deviceAccidentDataList[this.deviceAccidentRowIndex])
                }).catch(err => {
                    console.log(err)
                    this.tableLoading = false
                })
            },

            querySelfActivity() {
                let queryData = {
                    pageNo: this.page.pageNo,
                    pageSize: this.page.pageSize,
                    finderJob: this.queryDTO.finderJob,
                    accepterJob: this.queryDTO.accepterJob,
                    beginTime: this.queryDTO.beginTime,
                    endTime: this.queryDTO.endTime,
                    status: this.queryDTO.status,
                    indexStatus: this.tabIndex,
                    organizationId: this.queryDTO.deviceOrganizationId
                }
                this.tableLoading = true;
                querySelfActivity(queryData).then(res => {
                    this.tableLoading = false
                    this.deviceAccidentDataList = res.data.data.dataList;
                    this.page.totalCount = res.data.data.totalCount;
                    this.$refs.deviceAccidentTableRef.setCurrentRow(this.deviceAccidentDataList[this.deviceAccidentRowIndex])
                }).catch(err => {
                    console.log(err)
                    this.tableLoading = false
                })
            },

            handleClickDeviceAccidentRow(record, index) {
                for (let i = 0; i < this.deviceAccidentDataList.length; i++) {
                    if (record.id === this.deviceAccidentDataList[i].id) {
                        this.deviceAccidentRowIndex = i
                    }
                }
                this.currentNode = record;
            },

            cancelDialog(row) {
                this.picUrlDialogVisible = true;
                this.picUrl = row.picUrl
            },

            onInputFocus() {
                this.UsersDialogVisible = true;
                this.getUserList();
            },

            searchUserList() {
                this.getUserList();
            },

            /**
             * 获取系统用户列表
             */
            getUserList() {
                let queryData = {
                    pageNo: this.dialogPage.pageNo,
                    pageSize: this.dialogPage.pageSize,
                    loginName: this.dialogSearchContent1,
                    userName: this.dialogSearchContent2
                }
                this.loading = true
                axios.post(ctx + '/backstage/vm/historicalVideo/getPageList', queryData)
                    .then(res => {
                        this.loading = false
                        this.usersDialogTableData = res.data.data.dataList;
                        this.dialogPage.totalCount = res.data.data.totalCount;
                    }).catch(err => {
                    console.log(err)
                    this.loading = false
                })
            },

            getUsersRowData(row) {
                this.deviceAccident.userInfo = row.userName + ' (' + row.loginName + ')';
                this.deviceAccident.accepterName = row.userName;
                this.deviceAccident.accepterJob = row.loginName;
                this.UsersDialogVisible = false;
            },

            loginUser() {
                this.deviceAccident.userInfo = '<%=userName%>' + ' (' + '<%=loginName%>' + ')';
                this.deviceAccident.accepterName = '<%=userName%>';
                this.deviceAccident.accepterJob = '<%=loginName%>';
            },

            /**
             * 验证文件类型
             */
            beforeUploadForm(file) {
                let msg = file.name.substring(file.name.lastIndexOf('.') + 1);
                const extension = msg === 'jpg' || msg === 'png' || msg === 'gif';
                if (!extension) {
                    this.$message({
                        message: '上传文件只能是jpg/png/gif格式!',
                        duration: 1000,
                        showClose: true,
                        type: 'warning'
                    })
                }
                return extension
            },

            imageChange(param, type) {
                this.file = param.raw;
            },

            /**
             * 提交图片
             */
            startActivity() {
                this.disposerRemarkDialogLoading = true;
                let formData = new FormData();
                formData.append('file', this.file);
                let jsonStr = JSON.stringify(this.deviceAccident);
                formData.append("jsonReqDTO", jsonStr) // 额外参数
                axios.post(ctx + '/cx/accident/examineActivity', formData).then(res => {
                    this.$message({
                        message: res.data.data,
                        type: 'success'
                    });
                    if (this.tabIndex === '0') {
                        this.querySelfActivity();
                    } else if (this.tabIndex === '1') {
                        this.getDeviceAccidentList();
                    }
                    this.deviceAccidentRowIndex = 0;
                    this.disposerRemarkDialogVisible = false;
                    this.disposerRemarkDialogLoading = false;
                }).catch(err => {
                    this.dialogLoading = false;
                    this.$message({
                        message: "审批失败，请联系管理员！",
                        type: 'error'
                    });
                    console.log(err)
                })
            },

            openDisposerRemark(row) {
                this.disposerRemarkDialogVisible = true;
                if (this.$refs.updateUpload) {
                    this.$refs.updateUpload.clearFiles();
                }
                const assignData = {}
                Object.assign(assignData, row)
                this.$nextTick(() => {
                    this.deviceAccident = assignData
                    let happenTime = new Date(this.deviceAccident.happenTime);
                    this.deviceAccident.happenTime = happenTime;
                    let completionTime = new Date(this.deviceAccident.completionTime);
                    this.deviceAccident.completionTime = completionTime;
                    let createTime = new Date(this.deviceAccident.createTime);
                    this.deviceAccident.createTime = createTime;
                    this.deviceAccident.disposerRemark = row.disposerRemark;
                })
            },

            resetDisposerRemark() {
                this.$refs.updateUpload.clearFiles();
                this.$refs.disposerRemarkDialogRef.resetFields();
            },

            commitDeviceAccident() {
                this.dialogLoading = true;
                let formData = new FormData();
                formData.append('file', this.file);
                let jsonStr = JSON.stringify(this.deviceAccident);
                formData.append("jsonReqDTO", jsonStr) // 额外参数
                axios.post(ctx + '/cx/accident/fileUpload', formData).then(res => {
                    this.$message({
                        message: res.data.data,
                        type: 'success'
                    });
                    if (this.tabIndex === '0') {
                        this.querySelfActivity();
                    } else if (this.tabIndex === '1') {
                        this.getDeviceAccidentList();
                    }
                    this.deviceAccidentRowIndex = 0;
                    this.dialogVisible = false;
                    this.dialogLoading = false;
                }).catch(err => {
                    this.dialogLoading = false;
                    this.$message({
                        message: "添加失败，请联系管理员！",
                        type: 'error'
                    });
                    console.log(err)
                })
            },

            handleSelectionChange(val) {
                this.deviceAccidentCheckList = []
                val.forEach(item => {
                    this.deviceAccidentCheckList.push(item.id);
                })
            },

            saveOpenDeviceAccidentDialog() {
                if (this.$refs.devicePollDialogRef) {
                    this.$refs.devicePollDialogRef.resetFields();
                }
                if (this.$refs.insertUpload) {
                    this.$refs.insertUpload.clearFiles();
                }
                this.clearDeviceAccident();
                this.dialogVisible = true;
                this.deviceAccidentDialogTitle = true;
            },

            clearDeviceAccident() {
                this.deviceAccident.id = null;
                this.deviceAccident.deviceOrganizationId = null;
                this.deviceAccident.organizationPath = null;
                this.deviceAccident.deviceCode = null;
                this.deviceAccident.processId = null;
                this.deviceAccident.happenTime = null;
                this.deviceAccident.completionTime = null;
                this.deviceAccident.areaAddr = null;
                this.deviceAccident.picUrl = null;
                this.deviceAccident.accepterJob = null;
                this.deviceAccident.accepterName = null;
                this.deviceAccident.userInfo = null;
                this.deviceAccident.finderJob = null;
                this.deviceAccident.finderName = null;
                this.deviceAccident.disposerRemark = null;
                this.deviceAccident.disposerPicUrl = null;
                this.deviceAccident.status = null;
                this.deviceAccident.remark = null;
            },

            /**
             * 组织树事件
             */
            equipmentTreeClick(node) {
                console.log(node)
                this.deviceAccident.deviceOrganizationId = node.id;
                this.deviceAccident.organizationPath = node.organizationPathName;
                this.deviceAccident.deviceCode = node.cameraIndexCode;
            },

            /**
             * 提交
             */
            handleCommit() {
                if (this.deviceAccident.deviceOrganizationId === null || this.deviceAccident.deviceCode === null) {
                    this.$message({
                        message: "请选择组织设备，再进行添加！",
                        type: 'error'
                    });
                    return
                }
                if (!this.file) {
                    this.$message({
                        message: "请选择突发事件图片，再进行添加！",
                        type: 'error'
                    });
                    return;
                }
                this.$refs.devicePollDialogRef.validate(val => {
                    if (val) {
                        if (this.deviceAccidentDialogTitle) {
                            this.commitDeviceAccident()
                            return
                        }
                        // this.updateDevicePoll()
                    }
                })
            },

            /**
             * 删除
             */
            removeDeviceAccident() {
                if (this.deviceAccidentCheckList.length < 1) {
                    this.$message({
                        message: "请选择要删除的数据，再进行操作！",
                        type: 'error'
                    });
                    return
                }
                this.tableLoading = true
                const deleteDTO = {
                    idList: this.deviceAccidentCheckList
                }
                deleteAccident(deleteDTO).then(res => {
                    if (this.tabIndex === '0') {
                        this.querySelfActivity();
                    } else if (this.tabIndex === '1') {
                        this.getDeviceAccidentList();
                    }
                    this.$message({
                        message: res.data.data,
                        type: 'success'
                    });
                    this.tableLoading = false;
                }).catch(err => {
                    console.log(err)
                    this.$message({
                        message: "删除失败",
                        type: 'error'
                    });
                    this.tableLoading = false;
                })
            },

            /**
             * 重置
             */
            resetDevicePoll() {
                if (!this.deviceAccidentDialogTitle) {
                    const assignData = {}
                    Object.assign(assignData, this.deviceAccidentEdit)
                    this.deviceAccident = assignData
                    return
                }
                this.deviceAccident.userInfo = null;
                this.$refs.insertUpload.clearFiles();
                this.$refs.devicePollDialogRef.resetFields();
            },

            /**
             * 分页
             */
            handleCurrentChange(pageNo) {
                this.page.pageNo = pageNo;
                this.deviceAccidentRowIndex = -1;
                if (this.tabIndex === '0') {
                    this.querySelfActivity();
                } else if (this.tabIndex === '1') {
                    this.getDeviceAccidentList();
                }

            },

            handleSizeChange(pageSize) {
                this.page.pageSize = pageSize;
                if (this.tabIndex === '0') {
                    this.querySelfActivity();
                } else if (this.tabIndex === '1') {
                    this.getDeviceAccidentList();
                }

            },

            getDeviceAccidentStatus(obj) {
                return getDeviceAccidentStatusName(obj.status);
            },

            /**
             * dialog
             */
            handleDialogCurrentChange(pageNo) {
                this.dialogPage.pageNo = pageNo;
                this.getUserList();
            },
            handleDialogSizeChange(pageSize) {
                this.dialogPage.pageSize = pageSize;
                this.getUserList();
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

    .el-tabs__item {
        padding: 0 20px;
        height: 30px;
        -webkit-box-sizing: border-box;
        box-sizing: border-box;
        line-height: 30px;
        display: inline-block;
        list-style: none;
        font-size: 12px;
        font-weight: 500;
        color: white;
        position: relative;
    }

    .el-tabs__nav-scroll {
        height: 30px;
        overflow: hidden;
    }

</style>
