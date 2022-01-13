<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta http-equiv=Content-Type content="text/html;charset=utf-8">
    <meta http-equiv=X-UA-Compatible content="IE=edge,chrome=1">
    <meta content=always name=referrer>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/vue/index.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/page-css.css"/>

    <title>实时报警</title>
    <style>
        .el-pagination__jump{
            color: #FFFFFF;
        }

        .el-table--enable-row-hover .el-table__body tr:hover>td{
            background-color:#2F87F1 !important;
        }

    </style>
</head>

<body style="background-color:#001F6B;">
<div id="app">
    <div class="content" style="margin: 10px;">
        <div id="top" style="padding: 10px 10px;border-radius: 5px;background-color:transparent" class="block-border">
            <template>
                <span style="font-size: 14px;color:#EAE8C5;margin-left: 100px;" >报警类型:</span>
                <el-select clearable  v-model="type" placeholder="请选择" size="small">
                    <el-option

                            v-for="item in alarmType"
                            :key="item.itemCode"
                            :label="item.itemName"
                            :value="item.itemCode">
                    </el-option>
                </el-select>
                <span style="font-size: 14px;color:#EAE8C5; margin-left: 30px;">报警等级:</span>
                <el-select clearable v-model="level"   placeholder="请选择" size="small">
                    <el-option

                            v-for="item in alarmLevel"
                            :key="item.itemCode"
                            :label="item.itemName"
                            :value="item.itemCode">
                    </el-option>
                </el-select>
            </template>
<%--            <el-button slot="append" type="primary" size="small" style="margin-left: 30px;margin-right: 200px;float: right;">导出</el-button>--%>
            <el-input placeholder="关键字" size="small" style="width: 200px;float: right;margin-right: 90px" v-model="search">
                <el-button style="background-color:rgba(255,255,255,0.5);" slot="append" icon="el-icon-search" size="small" @click="filtererData"></el-button>
            </el-input>
        </div>
        <div id="table" style="margin-top: 20px;box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1)"  class="block-border">
            <template>
                <el-table
                        <%--border--%>
                        <%--:data="tableData2.slice((currentPage-1)*pageSize,currentPage*pageSize)"--%>
                        <%--:header-cell-style="{'text-align': 'center'}"--%>
                        <%--style="width: 100%;">--%>
<%--                    height="calc(100% - 40px)"--%>
                        height="calc(100% - 150px)"
                        :data="tableData2.slice((currentPage-1)*pageSize,currentPage*pageSize)"
                        border
                        size="mini"
                        tooltip-effect="dark"
                        style="width: 100%;height:calc(100% - 35%)"
                        highlight-current-row
                        element-loading-text="拼命加载中"
                        element-loading-spinner="el-icon-loading"
                        element-loading-background="rgba(0, 0, 0, 0.8)"
                        :header-cell-style="{'text-align': 'center'}">

                    <el-table-column
                            align="center"
                            label="编号"
                            width="60"
                            type="index"
                            :index="getIndex">
                    </el-table-column>
                    <el-table-column
                            align="center"
                            prop="equipmentName"
                            label="报警设备"
                            width="250">
                    </el-table-column>
                    <el-table-column
                            align="center"
                            prop="callPoliceType"
                            label="报警类型"
                            width="250">
                    </el-table-column>
                    <el-table-column
                            align="center"
                            prop="callPoliceGradeName"
                            label="报警等级"
                            width="150">
                    </el-table-column>
                    <el-table-column
                            align="center"
                            min-width
                            prop="alarmMsg"
                            label="报警内容"
                            min-width
                    >
                    </el-table-column>
                    <el-table-column
                            align="center"
                            prop="happenTime"
                            label="报警时间"
                            width="300">
                    </el-table-column>
                </el-table>
            </template>
            <div style="background-color: #2C447D;padding: 10px;margin-top: 20px;color:#666666">
                <el-pagination
                        style="text-align: center;"
                        @size-change="handleSizeChange"
                        @current-change="handleCurrentChange"
                        :current-page="currentPage"
                        :page-size="pageSize"
                        :page-sizes="[10,20,40]"
                        layout="total, prev, pager, next,jumper,sizes"
                        :total="tableData2.length">
                </el-pagination>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/dahua/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/vue.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/element.js"></script>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script>
    var ctx = '${pageContext.request.contextPath}'
</script>
</body>
<script>
var dataList = [];
var dataLevel = [];
var dataType  = [];
    $.ajax(
        {
            type: "GET",
            async: false,
            url: ctx+"/backstage/cx/deviceAlarm/getRealTimeAlarmData",
            success: function (msg) {
                let respData = msg.data;
                dataList =  respData.dataList;
                dataType = respData.codeList.codeGrade;
                dataLevel = respData.codeList.codeLevel;
                console.log(dataList,dataLevel,dataType);
                // var alarmdocument =  window.parent.document.getElementById("alarmNum");
                // $(alarmdocument).html("0");

            },
            error: function (xmlR, status, e) {
                console.log("初始化失败！",xmlR,status,e);
            }
        });


</script>
<script>
    new Vue({
        el:"#app",
        data:{
            currentPage: 1, // 当前页码
            total: null, // 总条数
            pageSize: 20, // 每页的数据条数
            alarmType:dataType,
            alarmLevel:dataLevel,
            tableData2:dataList,
            type:'',
            level:'',
            search:'',
            alarmMsg:'',
            tableData3:[],
        }
        ,
        mounted(){
            //初始化
            this.tableData3 = Object.assign([],this.tableData2)
            for (let i = 0; i <this.tableData3.length ; i++) {
                for (let j = 0; j <dataType.length ;j++) {
                    if(this.tableData3[i].callPoliceType==dataType[j].itemName){
                        this.tableData3[i].alarmType=dataType[j].itemCode;
                    }
                }
                for (let j = 0; j <dataLevel.length ;j++) {
                    if(this.tableData3[i].callPoliceGradeName==dataLevel[j].itemName){
                        this.tableData3[i].alarmLevel=dataLevel[j].itemCode;
                    }
                }

            }
            console.log(this.tableData3);
        }
        ,
        methods:{
            handleSizeChange(val) {
                this.currentPage = 1;
                this.pageSize = val;
            },
            handleCurrentChange(val) {
                this.currentPage = val;
            },
            filtererData(){
                let searchMsg = this.search;
                let level = this.level;
                let type = this.type;
                this.tableData2= this.tableData3.filter((item) => {
                    let msgFlag = true,levelFlag = true,typeFlag = true;
                    msgFlag = searchMsg !== ""?item.alarmMsg != null ? item.alarmMsg.indexOf(searchMsg) !== -1 : false:msgFlag;
                    levelFlag =level !== ""?item.alarmLevel !== "undefined" ? item.alarmLevel === level : false:levelFlag;
                    typeFlag = type !== ""?item.alarmType !== "undefined" ? item.alarmType === type : false:typeFlag;
                    return msgFlag && levelFlag && typeFlag ? item : null;

                });
            },
            getIndex(index){
                return this.currentPage === 1 ?index+1: index + (this.currentPage-1)*this.pageSize+1;
            }

        }
    })

</script>
</html>
