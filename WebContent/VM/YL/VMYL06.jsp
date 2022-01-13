<%--
  Created by IntelliJ IDEA.
  User: huang
  Date: 2020-07-08
  Time: 10:51
  To change this template use File | Settings | File Templates./*sfmsfm*/
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <!-- import Vue before Element -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/vue/index.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/video/VMYL02.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/assets/icon/iconfont.css"/>
    <%--    <link rel="stylesheet" src="${pageContext.request.contextPath}/static/vue/element.css">--%>

    <script type="text/javascript" src="${pageContext.request.contextPath}/static/dahua/global_ip.js"></script>


    <c:set var="ctx" value="${pageContext.request.contextPath}"/>
    <script>
        var ctx = '${pageContext.request.contextPath}'
    </script>

    <title>视频轮询</title>
    <style>
        .el-tree{
            background-color: transparent;
            color:#EAE8C5;
        }
        .el-input__inner{
            border:1px solid #EAE8C5;
            background-color: transparent;
        }
        .el-tree-node__content:hover{
            color:skyblue!important;
            background-color: transparent;

        }
        .el-table{
            background-color: transparent;
        }
        .el-table .cell.el-tooltip{
            color:#17306e
        }
        .el-table .cell.el-tooltip{
            color:#EAE8C5;
        }
        .el-button--primary.is-plain{
            background-color:#17306e;
            color:#b3d8ff;
        }
    </style>
</head>

<body style="background-color: #001F6B;">

<div id="app">
    <div style="height: calc(100% - 10px); width: calc(100% - 10px); position: absolute">
        <%--左侧--%>
        <div style="height: calc(100% - 10px); width:260px; overflow: auto; float:left; border:1px solid #c4deff;">
            <%--文字显示--%>
            <%--<div style="width:260px; height: 25px;background: #dbefff; margin-top: -5px;">
                <p style="margin-left: 20px; margin-top: 5px; color: #3996f1;">请选择轮询计划</p>
            </div>--%>
            <%--轮询名称--%>
                <a  href="http://10.44.140.9:8080${pageContext.request.contextPath}/static/dahua/DHPlayerSetup.exe" download="DHPlayerSetup.exe"    style="color:#9a9595;cursor:pointer;line-height:14px;font-size:16px;font-weight:100;margin-top:12px;position:absolute;margin-left:190px;z-index:999999;"><u>插件下载</u></a>

                <div style="width: 260px; height: 95%; background: transparent; ">
                <el-table
                        class="customer-table"
                        v-loading="tableLoading"
                        :data="tableData"
                        size="mini"
                <%--tooltip-effect="dark"--%>
                        style="width: 100%;/*margin-left: 20px;*/"
                        highlight-current-row
                        height="100%"
                        element-loading-text="拼命加载中"
                        element-loading-spinner="el-icon-loading"
                        element-loading-background="rgba(0, 0, 0, 0.8)"
                        :header-cell-style="{backgroundColor:'#17306e',color:'#EAE8C5',fontSize:'14px'}"
                        :row-style="{color: 'black',backgroundColor:'transparent',fontSize:'13px'}"
                        @row-click="getRowData"
                >
                    <%-- <el-table-column align="center" width="40" type="selection" fixed="left"></el-table-column>--%>
                    <el-table-column label="轮询计划列表" prop="planName" show-overflow-tooltip style="background-color: #17306e"
                                     width="260"></el-table-column>

                </el-table>

            </div>
            <%--操作按钮--%>
            <div id="videoBtn" style=" margin-top: 5px;position:absolute;bottom:20px;">
                <%--<el-button
                        style="width:65px; margin-left: 15px;"
                        type="primary" plain size="mini" class="btn_dark_blue" onclick="create()"
                >创建窗口
                </el-button>--%>
                <el-button
                        style="width:260px; "
                        type="primary" plain size="mini" class="btn_dark_blue" @click="startVideo()"
                >开始轮询
                </el-button>
                <div></div>
                <el-button
                        style="width:260px; "
                        type="primary" plain size="mini" class="btn_dark_blue" @click="endVideo();"
                        onclick="destroy()"
                >结束轮询
                </el-button>
            </div>
        </div>
        <%--右侧展示--%>
        <div style="height: calc(100% - 12px); margin-left: 8px; width:calc(100% - 290px); float:left; border:1px solid #c4deff;">
            <input id="host" name="host" type="hidden" value=""/>
            <el-input id="cameraId" name="cameraId" type="hidden" v-model="cameraid"></el-input>
            <%--视频展示--%>
            <div style="position:relative;width:100%;height:98%;">
                <div id="DHVideoPlayer">

                </div>
            </div>

        </div>
    </div>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/vue.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/element.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/axios.min.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/dahua/jquery-1.9.1.min.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/api/vm/devicePollApi.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/dahua/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/dahua/jquery.ztree.device-3.0.js"></script>

<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/dahua/json.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/dahua/playJs_lx.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/dahua/videoPlayer.js"></script>
</body>

</html>

<script type="text/javascript">
    initPlayer();
    init();
    var arr_devs = new Array();
    arr_devs.splice(0, arr_devs.length);
    // Vue实例化
    let doit = new Vue({
        el: '#app',
        data: {
            tableLoading: false,
            tableData: [],
            devicePollCheckList: [],
            //视频轮询的设备编号
            deviceCode: null,
            deviceCodeOne: null,
            //实时视频设备编号
            cameraid: null,
            //视频循环周期
            pollPeriod: null,
            //周期转换为毫秒
            interval: null,
            //
            pollFlag: null,
            tArray: [],

        },
        created: function () {
            this.getDevicePollNameList();
        },
        methods: {
            /*获取轮询名称*/
            getDevicePollNameList() {
                this.tableLoading = true;
                getDevicePollNamesList().then(res => {
                    this.tableLoading = false;
                this.tableData = res.data.data;
                console.log(res.data.data);
            }).catch(err => {
                    this.tableLoading = true;
                console.log(err);
            })
            },
            //获取当前行信息
            getRowData(val) {

                console.log(val);
                let thisRowData = this;
                thisRowData = val;
                this.deviceCode = thisRowData.deviceCode;
                console.log(thisRowData.deviceCode);
                this.pollPeriod = thisRowData.pollPeriod;
                this.interval = parseInt(this.pollPeriod) * 1000;
                //截取设备字符串
                this.tArray = this.deviceCode.split(",");
                //tArray=["1000032$0","1000038$0"];
                //var tArray = this.changearray(arr_devs);
                console.log(this.pollPeriod+"--------------33333333333333------------------");
            },
            //开始轮询
            startVideo() {
                //定时器
                let n = 0;
                let this1 = this;
                console.log("----------------------------")
                console.log(this.tArray)

                this1.play_poll(this.tArray[0]);
                this.pollFlag = setInterval(() => {
                            console.log(this.tArray.length)
                if (n == this.tArray.length - 1)
                    n = 0;
                else
                    n++;
                this1.play_poll(this.tArray[n]);
            }, this.interval);
            },
            //结束轮询
            endVideo() {
                clearInterval(this.pollFlag);
                console.log('video end!');
            },


            play_poll(data) {
                $("#cameraId").val(data);
                getRealmonitorRtsp();
            },


        }
    })

</script>


<style>
    #app {
        font-family: "Helvetica Neue", Helvetica, "PingFang SC", "Hiragino Sans GB", "Microsoft YaHei", "微软雅黑", Arial, sans-serif;
        color: #756C83;
    }

    /*去掉表格单元格边框*/
    .customer-table th {
        border: none;
    }

    .customer-table td, .customer-table th.is-leaf {
        border: none;
    }

    /*表格有滚动时表格头边框*/
    /*   .el-table--border th.gutter:last-of-type {
         border: 1px solid #EBEEF5;
         border-left: none;
     }*/

    /*设置按钮样式*/
    .el-button--primary.is-plain {
        padding-left: 6px;
    }
</style>

​
