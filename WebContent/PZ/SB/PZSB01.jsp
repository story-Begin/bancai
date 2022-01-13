<%--
  Created by IntelliJ IDEA.
  User: huang
  Date: 2020-07-08
  Time: 10:51
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


    <title>组织机构</title>
</head>

<body>

<div id="app">
    <div style="height: calc(100% - 10px); width: calc(100% - 10px); position: absolute">
        <div v-loading="organizationTreeLoading"
             style="height: calc(98% - 10px); width:300px;  overflow: auto; float:left;" class="block-border">
            <el-tree
                    ref="organizationTreeRef"
                    style="height: 100%; font-size: 13px;"
                    class="tree"
                    lazy
                    :highlight-current="highlight"
                    :load="getOrganizationTree"
                    node-key="id"
                    :props="defaultProps"
                    :default-expanded-keys="defaultExpandedKeys"
                    @node-click="handleOrganizationTreeClick">
                <span class="custom-tree-node" slot-scope="{ node, data }">
                    <span>
                        <i :class="data.icon" style="color: #86BFF7;"></i> {{ data.organizationName }}
                    </span>
                </span>
            </el-tree>
        </div>
        <div style="height: calc(98% - 10px); margin-left: 8px; width:calc(100% - 320px); float:left;">
            <%--  操作区 --%>
            <div style="height:45px; width: 100%;" class="block-border">
                <div style="line-height:40px; width: 100%; float:left;">
                    <el-input v-model="queryContent" clearable style="width:30%; padding-left:10%;"
                              size="mini"
                              placeholder="请输入组织机构【名称】进行搜索"></el-input>
                    <el-button size="mini" type="primary" class="btn_search" icon="el-icon-search"
                               @click="searchOrganizationList">
                        查询
                    </el-button>
                    <el-button-group style="width:200px; float:right; margin-top: 8px;">
                        <el-button type="primary" size="mini" icon="el-icon-plus" class="btn_dark_blue"
                                   @click="openOrganizationDialog">添加
                        </el-button>
                        <el-button type="danger" size="mini" icon="el-icon-delete" class="btn_dark_black"
                                   @click="removeOrganization">删除
                        </el-button>
                    </el-button-group>
                </div>
            </div>
            <div style="height: calc(100% - 57px); width:100%; margin-top: 8px; float:left;" class="block-border">
                <%-- 数据列表 --%>
                <el-table
                        ref="organizationTableRef"
                        v-loading="loading"
                        :data="organizationDataList"
                        border
                        size="mini"
                        tooltip-effect="dark"
                        style="width: 100%;"
                        highlight-current-row
                        height="calc(100% - 35px)"
                        element-loading-text="拼命加载中"
                        element-loading-spinner="el-icon-loading"
                        element-loading-background="rgba(0, 0, 0, 0.8)"
                        @row-click="organizationRowClick"
                        :header-cell-style="{'text-align': 'left'}"
                        @selection-change="handleSelectionChange"
                >
                    <el-table-column align="center" width="40" type="selection" fixed="left"></el-table-column>
                    <el-table-column label="机构名称" prop="organizationName" show-overflow-tooltip width="200"
                                     :render-header="renderHeader"></el-table-column>
                    <el-table-column label="机构目录" prop="organizationPathName" show-overflow-tooltip width="280"
                                     :render-header="renderHeader"></el-table-column>
                    <el-table-column label="图标" prop="createTime" min-width="60">
                        <template slot-scope="scope">
                            <i :class="scope.row.icon"></i>
                        </template>
                    </el-table-column>
                    <el-table-column label="创建时间" prop="createTime" min-width="140"></el-table-column>
                    <el-table-column width="70" label="操作" align="center" fixed="right">
                        <template slot-scope="scope">
                            <el-tooltip class="item" effect="dark" content="编辑" placement="top-start">
                                <el-button size="mini" style="padding: 3px 15px"
                                           @click="openUpdateCommit(scope.row)"><i class="el-icon-edit"></i>
                                </el-button>
                            </el-tooltip>
                        </template>
                    </el-table-column>
                </el-table>
                <%-- 分页 --%>
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
    <%-- 输入框 --%>
    <el-dialog :title="organizationDialogTitle?'组织机构添加':'组织机构编辑'" :visible.sync="dialogVisible"
               style="text-align:center;">
        <el-form
                ref="organizationDialogRef"
                v-loading="dialogLoading"
                :model="deviceOrganization"
                :rules="organizationRules"
                label-width="120px"
                element-loading-text="正在提交中......"
                element-loading-spinner="el-icon-loading"
        >
            <el-form-item label="机构名称:" prop="organizationName" style="margin: 8px 0px;">
                <el-col :span="21">
                    <el-input v-model="deviceOrganization.organizationName" maxlength="25" clearable size="mini"
                              placeholder="请输入机构名称"/>
                </el-col>
            </el-form-item>
            <el-form-item label="图标:" prop="icon" style="margin: 8px 0px; text-align: left;">
                <el-col :span="21">
                    <el-radio v-model="deviceOrganization.icon" label="magang-font icon-changfang">
                        <i class="magang-font icon-changfang"></i>
                    </el-radio>
                    <el-radio v-model="deviceOrganization.icon" label="magang-font icon-fangzi">
                        <i class="magang-font icon-fangzi"></i>
                    </el-radio>
                    <el-radio v-model="deviceOrganization.icon" label="magang-font icon-quyu">
                        <i class="magang-font icon-quyu"></i>
                    </el-radio>
                    <el-radio v-model="deviceOrganization.icon" label="magang-font icon-zuoyexian">
                        <i class="magang-font icon-zuoyexian"></i>
                    </el-radio>
                </el-col>
            </el-form-item>
            <%--            <el-form-item label="机构目录:" prop="organizationPath" :show-message="false" style="margin: 5px 0px;">--%>
            <%--                <el-col :span="21">--%>
            <%--                    <el-input v-model="deviceOrganization.organizationPath" disabled clearable size="mini"--%>
            <%--                              placeholder="请输入机构目录"/>--%>
            <%--                </el-col>--%>
            <%--            </el-form-item>--%>
            <el-form-item label="机构目录:" prop="organizationPathName" :show-message="false" style="margin: 5px 0px;">
                <el-col :span="21">
                    <el-input v-model="deviceOrganization.organizationPathName" clearable size="mini"
                              placeholder="请输入机构目录"/>
                </el-col>
            </el-form-item>
            <el-form-item style="margin: 15px 0px;" label-width="0px">
                <div style="width:100%; height:40px;">
                    <el-button type="success" size="small" style="width:80px" @click="handleCommit()">提交</el-button>
                    <el-button @click="resetOrganization()" style="width:80px" size="small">重置</el-button>
                </div>
            </el-form-item>
        </el-form>
    </el-dialog>
</div>
<%--    <link rel="stylesheet" src="${pageContext.request.contextPath}/static/vue/element.css">--%>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/vue.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/element.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/axios.min.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/api/pz/deviceOrganizationApi.js"></script>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script>
    var ctx = '${pageContext.request.contextPath}'
</script>
</body>

</html>

<script type="text/javascript">

    // Vue实例化
    let doit = new Vue({
        el: '#app',
        data: {
            defaultProps: {
                label: 'organizationName',
                children: 'children',
                isLeaf: function (data, node) {
                    if (data && data.leaf) {
                        return true
                    }
                    return false
                }
            },
            isInit: false,
            highlight: true,
            defaultExpandedKeys: [],
            organizationTreeLoading: false,
            queryContent: '',
            queryContentOnDevice: '',
            rootNode: {
                id: 0,
                organizationName: '马钢（合肥）板材',
                isLeaf: false,
                icon: 'magang-font icon-changfang'
            },
            loading: false,
            currentKey: null,
            //  数据区
            organizationDataList: [],
            checkOrganizationList: [],
            page: {
                pageNo: 1,
                pageSize: 20,
                totalCount: 0,
                pageSizes: [20, 50, 100]
            },
            //  dialog
            deviceOrganization: {
                id: null,
                organizationName: null,
                organizationPathName: null,
                organizationPath: null,
                organizationParentId: null,
                icon: null
            },
            organizationRowIndex: -1,
            organizationPathEdit: null,
            organizationPathNameEdit: null,
            deviceOrganizationEdit: null,
            organizationDialogTitle: true,
            dialogVisible: false,
            dialogLoading: false,
            organizationRules: {
                organizationName: [{required: true, trigger: ['blur', 'change'], message: '组织名称不能为空'}],
            },

        },
        methods: {

            /**
             * 机构树
             */
            getOrganizationTree(node, resolve) {
                const queryData = {}
                if (node.level == 0) {
                    this.defaultExpandedKeys.push(this.rootNode.id)
                    return resolve([this.rootNode]);
                    this.organizationTreeLoading = true
                } else {
                    queryData.id = node.data.id
                }
                getOrganizationTreeList(queryData).then(res => {
                    resolve(res.data.data)
                    this.initCurrentKey(res.data.data, res.data.data)
                    this.organizationTreeLoading = false
                }).catch(err => {
                    console.log(err)
                    this.organizationTreeLoading = false
                })
            },

            initCurrentKey(data, node) {
                if (!this.isInit) {
                    this.isInit = true
                    if (node && node.length > 0) {
                        this.$nextTick(() => {
                            this.$refs.organizationTreeRef.setCurrentKey(node[0].id);
                        });
                        this.currentKey = node[0]
                        this.defaultExpandedKeys.push(node[0])
                        this.deviceOrganization.organizationParentId = node[0].id
                        this.organizationPathEdit = "0/" + node[0].id
                        this.organizationPathNameEdit = "/总厂/" + node[0].organizationName
                        this.initOrganizationTreeClick()
                    }
                }
            },

            initOrganizationTreeClick() {
                this.getOrganizationList()
            },

            handleOrganizationTreeClick(data, node) {
                if (node.data.id !== this.currentKey.id) {
                    this.currentKey = node.data;
                    this.organizationRowIndex = -1;
                    this.deviceOrganization.organizationParentId = node.data.id;
                    this.organizationPathEdit = "/" + node.data.id;
                    this.organizationPathNameEdit = "/" + node.data.organizationName;
                    this.getOrganizationList();
                    this.parentNodesChange(node);
                }
            },

            /**
             * 递归获取菜单父级及祖级id
             */
            parentNodesChange(node) {
                if (node.parent.parent) {
                    this.organizationPathEdit = "/" + node.parent.key + this.organizationPathEdit
                    this.organizationPathNameEdit = "/" + node.parent.data.organizationName + this.organizationPathNameEdit
                    this.parentNodesChange(node.parent)
                }
            },

            searchOrganizationList() {
                this.getOrganizationList()
            },

            organizationRowClick(row, index) {
                for (var i = 0; i < this.organizationDataList.length; i++) {
                    if (row.id === this.organizationDataList[i].id) {
                        this.organizationRowIndex = i
                    }
                }
            },

            /**
             * 机构列表
             */
            getOrganizationList() {
                let queryData = {
                    pageNo: this.page.pageNo,
                    pageSize: this.page.pageSize,
                    organizationName: this.queryContent,
                    organizationParentId: this.currentKey.id
                }
                this.loading = true
                getOrganizationList(queryData).then(res => {
                    this.loading = false
                    this.organizationDataList = res.data.data.dataList;
                    this.page.totalCount = res.data.data.totalCount;
                    this.$refs.organizationTableRef.setCurrentRow(this.organizationDataList[this.organizationRowIndex])
                }).catch(err => {
                    console.log(err)
                    this.loading = false
                })
            },

            /**
             * 添加
             */
            openOrganizationDialog() {
                if (this.$refs.organizationDialogRef) {
                    this.$refs.organizationDialogRef.resetFields();
                }
                this.deviceOrganization.id = null
                this.deviceOrganization.organizationPath = this.organizationPathEdit
                this.deviceOrganization.organizationPathName = this.organizationPathNameEdit
                this.organizationDialogTitle = true
                this.dialogVisible = true
            },

            /**
             * 修改
             */
            openUpdateCommit(rowData) {
                this.organizationDialogTitle = false
                this.dialogVisible = true
                const assignData = {}
                Object.assign(assignData, rowData)
                this.$nextTick(() => {
                    this.deviceOrganization = assignData
                })
                this.deviceOrganizationEdit = rowData
            },

            /**
             * 新增
             */
            saveOrganization() {
                this.dialogLoading = true;
                this.deviceOrganization.organizationPathName = this.deviceOrganization.organizationPathName + '/' + this.deviceOrganization.organizationName
                saveOrganization(this.deviceOrganization).then(res => {
                    // 追加节点再次加载
                    const node = this.$refs.organizationTreeRef.getNode(this.currentKey.id);
                    node.loaded = false;
                    node.expand();
                    this.getOrganizationList();
                    this.$message({
                        message: res.data.data,
                        type: 'success'
                    });
                    this.dialogVisible = false
                    this.dialogLoading = false;
                }).catch(err => {
                    console.log(err)
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
            updateOrganization() {
                this.dialogLoading = true
                this.deviceOrganization.organizationPathName = this.organizationPathNameEdit + '/' + this.deviceOrganization.organizationName
                updateOrganization(this.deviceOrganization).then(res => {
                    this.getOrganizationList(this.deviceOrganization)
                    const node = this.$refs.organizationTreeRef.getNode(this.deviceOrganization.id)
                    node.data.organizationName = this.deviceOrganization.organizationName
                    node.data.id = this.deviceOrganization.id
                    node.data.icon = this.deviceOrganization.icon
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
             * 提交
             */
            handleCommit() {
                this.$refs.organizationDialogRef.validate((valid) => {
                    if (valid) {
                        if (this.deviceOrganization.id) {
                            this.updateOrganization()
                            return
                        }
                        this.saveOrganization()
                    } else {
                        return false
                    }
                })
            },

            /**
             * 重置
             */
            resetOrganization() {
                if (this.deviceOrganization.id) {
                    const assignData = {}
                    Object.assign(assignData, this.deviceOrganizationEdit)
                    this.deviceOrganization = assignData
                    return
                }
                this.$refs.organizationDialogRef.resetFields();
            },

            /**
             * 删除
             */
            removeOrganization() {
                const deleteDTO = {
                    idList: this.checkOrganizationList
                }
                deleteOrganization(deleteDTO).then(res => {
                    this.handleRemoveNode()
                    this.getOrganizationList();
                    this.organizationTreeLoading = false
                    this.$message({
                        message: res.data.data,
                        type: 'success'
                    });
                }).catch(err => {
                    console.log(err)
                    this.organizationTreeLoading = false
                }).catch(err => {
                    console.log(err)
                    this.$message({
                        message: "删除失败",
                        type: 'error'
                    });
                })
            },


            handleSelectionChange(val) {
                this.checkOrganizationList = []
                val.forEach(item => {
                    this.checkOrganizationList.push(item.id)
                })
            },

            handleRemoveNode() {
                this.checkOrganizationList.forEach(item => {
                    const node = this.$refs.organizationTreeRef.getNode(item)
                    if (node) {
                        this.$refs.organizationTreeRef.remove(node)
                    }
                })
            },

            //    分页
            handleCurrentChange(pageNo) {
                this.page.pageNo = pageNo;
                this.organizationRowIndex = -1;
                this.getOrganizationList();
            },

            handleSizeChange(pageSize) {
                this.page.pageSize = pageSize
                this.getOrganizationList()
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

</style>

​
