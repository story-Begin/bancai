<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/vue/index.css"/>
    <link href="${pageContext.request.contextPath}/static/cx/css/alarm.css" rel="stylesheet" type="text/css"/>

    <title>运维页面</title>
</head>
<body>
<div>
    <div id="app">
        <div id="search">
            <div style="height:45px; width: 100%; border:2px solid #DDDDDD;">
                <div style="line-height:40px; width: 100%; float:left;">
                    <el-input v-model="deviceQuery.description" clearable style="width:18%; padding-left:3%; margin-right: 15px"
                              size="mini"
                              placeholder="描述"></el-input>
                    <!--报警类型-->
                    <el-select v-model="deviceQuery.logType" clearable size="mini" style="width: 10%; margin-right: 15px"
                               placeholder="日志类型">
                        <el-option
                                v-for="item in logTypeList"
                                :key="item.logType"
                                :label="item.logTypeName"
                                :value="item.logType"
                        />
                    </el-select>
                    <!--日期筛选-->
                    <el-date-picker
                            style="width: 10%; margin-right: 15px"
                            clearable
                            v-model="deviceQuery.createStartTime"
                            size="mini"
                            type="date"
                            placeholder="起始时间">
                    </el-date-picker>
                    <el-date-picker
                            style="width: 10%; margin-right: 15px"
                            clearable
                            v-model="deviceQuery.createEndTime"
                            size="mini"
                            type="date"
                            placeholder="结束时间">
                    </el-date-picker>
                    <!--查询按钮-->
                    <el-button size="mini" type="primary" class="btn_search" icon="el-icon-search">
                        <!--@click=""-->
                        查询
                    </el-button>
                </div>
            </div>
        </div>
        <div id="list">
            <el-table
                    height="calc(100% - 40px)"
                    ref="deviceAlarmTableRef"
                    :data="deviceAlarmDataList"
                    border
                    size="mini"
                    tooltip-effect="dark"
                    style="width: 100%;height:calc(90% - 35px)"
                    highlight-current-row
                    :header-cell-style="{ 'background-color':'rgb(3,110,186,0.1)','color':'rgb(3,110,186)', 'text-align': 'center'}"

            >
                <el-table-column label="描述" prop="description" width="160"></el-table-column>
                <el-table-column label="日志类型" prop="logType" show-overflow-tooltip width="100">
                    <template scope="scope">
                        <p v-if="scope.row.logType=='0'">正常信息</p>
                        <p v-if="scope.row.logType=='1'">报错信息</p>
                    </template>
                </el-table-column>
                <el-table-column label="方法名" prop="method" show-overflow-tooltip width="300"></el-table-column>
                <el-table-column label="请求ip" prop="requestIp" width="120"></el-table-column>
                <el-table-column label="参数" prop="params" show-overflow-tooltip width="400"></el-table-column>
                <el-table-column label="异常状态码" prop="exceptionCode" show-overflow-tooltip width="100"></el-table-column>
                <el-table-column label="详情" prop="exceptionDetail" show-overflow-tooltip width="100"></el-table-column>
                <el-table-column label="操作用户" prop="createUser" show-overflow-tooltip width="100"></el-table-column>
                <el-table-column label="操作时间" prop="createDate" show-overflow-tooltip width="100"></el-table-column>
            </el-table>

            <div style="text-align:center;height: calc(10%); background: rgba(184,184,184,0.24)">
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
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/vue.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/element.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/axios.min.js"></script>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<script type="text/javascript" src="${pageContext.request.contextPath}/static/cx/js/echarts.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/cx/js/echartsData.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/cx/js/flexible.js"></script>

<script>
    var ctx = '${pageContext.request.contextPath}'
</script>
</body>
</html>
<script type="text/javascript">
    let vue = new Vue({
        el: '#app',
        data: {
            logTypeList: [{
                logType: 0,
                logTypeName: "正常信息"
            },{
                logType: 1,
                logTypeName: "报错信息"
            }],

            page: {
                pageNo: 1,
                pageSize: 20,
                totalCount: 0,
                pageSizes: [20, 50, 100]
            },

            deviceQuery: {
                id: "",
                description: "",
                logType: 0,
                method: "",
                requestIp: "",
                exceptionDetail: "",
                createUser: "",
                createStartDate: "",
                createEndDate: ""
            },

            deviceAlarmDataList: [{
                "id": "169add439be84a22a226254748b6d79c",
                "description": "编辑组织设备树",
                "logType": 0,
                "method": "com.baosight.controller.pz.DeviceOrganizationController.change().update操作",
                "requestIp": "0:0:0:0:0:0:0:1",
                "params": "[{\"id\":1,\"organizationName\":\"炼钢转炉\",\"organizationParentId\":0,\"organizationPath\":\"/0\",\"organizationPathName\":\"总厂/炼钢转炉\"}]",
                "exceptionDetail": "update操作",
                "createUser": "系统管理员",
                "createDate": "2020-08-26 13:20:09"
            },{
                "id": "169add439be84a22a226254748b6d79c",
                "description": "编辑组织设备树",
                "logType": 1,
                "method": "com.baosight.controller.pz.DeviceOrganizationController.change().update操作",
                "requestIp": "0:0:0:0:0:0:0:1",
                "params": "[{\"id\":1,\"organizationName\":\"炼钢转炉\",\"organizationParentId\":0,\"organizationPath\":\"/0\",\"organizationPathName\":\"总厂/炼钢转炉\"}]",
                "exceptionDetail": "update操作",
                "createUser": "系统管理员",
                "createDate": "2020-08-26 13:20:09"
            },{
                "id": "169add439be84a22a226254748b6d79c",
                "description": "编辑组织设备树",
                "logType": 0,
                "method": "com.baosight.controller.pz.DeviceOrganizationController.change().update操作",
                "requestIp": "0:0:0:0:0:0:0:1",
                "params": "[{\"id\":1,\"organizationName\":\"炼钢转炉\",\"organizationParentId\":0,\"organizationPath\":\"/0\",\"organizationPathName\":\"总厂/炼钢转炉\"}]",
                "exceptionDetail": "update操作",
                "createUser": "系统管理员",
                "createDate": "2020-08-26 13:20:09"
            }]
        },
        methods: {
            tableLoading () {
                return deviceAlarmDataList;
            },

            handleCurrentChange(pageNo) {
                this.page.pageNo = pageNo
            },

            handleSizeChange(pageSize) {
                this.page.pageSize = pageSize
            },
        }
    })
</script>

<style>
    #app {
        font-family: "Helvetica Neue", Helvetica, "PingFang SC", "Hiragino Sans GB", "Microsoft YaHei", "微软雅黑", Arial, sans-serif;
        color: #756C83;
    }

    #list {
        margin: 5px;
        margin-left: 20px;
        margin-right: 20px;
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
