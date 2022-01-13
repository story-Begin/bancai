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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/page-css.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/video/VMYL02.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/assets/icon/iconfont.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/business/css.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/spjdt/index.css?time=1" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/webuploader/css/webuploader.css" />


    <c:set var="ctx" value="${pageContext.request.contextPath}"/>
    <script>
        var ctx = '${pageContext.request.contextPath}'
    </script>
    <style>
        .el-date-picker{width:260px!important;}
        .el-date-picker .el-picker-panel__content{width:250px!important;}
    </style>
    <title>历史视频</title>
    <style type="text/css">
        #pathdiv{
            padding: 30px;
            width: 800px;height: 325px;background-color: #edeff3;
            position: absolute;
            left: 20%;
            top: 20%;
            z-index: 30;
            /*box-shadow: #0d258c 0px 0px 10px;*/
            display: none;
        }
        #butn{
            position:  absolute;
            right: 30px;
        }

        .irs-with-grid {
            width: 92%;
            margin: 0px 46px;
        }

        .irs-grid-text {
            color: #a6c9e2;
        }
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
        .el-tree--highlight-current .el-tree-node.is-current>.el-tree-node__content{
            background-color: transparent!important;
        }
        .el-input__inner{
            color:#EAE8C5!important;
        }

        .right-bottom-btn{
            background-color: transparent;
        }
        .circle{
            width:36px;
            height:36px;
            border-radius:50%;
            font-size:25px;
            color:#000;
            line-height: 50px;
            text-align:center;
            background:#ffffff4f
        }
        .circle:hover{
            background:#ffffffb3
        }
        .about{
            position:absolute;
            top:50%;
            left:50%;
            margin-left:-300px;
            margin-top:-200px;
        }
        .irs-with-grid{
            width:66%;
            margin:0px;
            margin-left:56px;
        }
        .irs--square .irs-grid-text{
            display:none;
        }
        .irs--square .irs-from, .irs--square .irs-to, .irs--square .irs-single{
            font-size:12px;color:#409effde;background-color:transparent;
        }
        .playWnd {
            margin: 0px 0 0 0px;
            width: 100%;                   /*播放容器的宽和高设定*/
            height:100%;
            border: 1px solid red;
        }

    </style>
</head>

<body style="background-color: #001F6B;">
<div id="app">
    <input type="hidden" id="device_code"/>
    <div style="height: calc(100% - 10px); width: calc(100% - 10px); position: absolute">
        <%--左侧--%>
        <div style="height: calc(100% - 6px); width:300px; overflow: hidden; float:left;">
            <%--上半部分--%>
            <div id="left-top" style="height: 82%; width: 295px; border:1px solid #c4deff; ">
                <%--文字显示--%>
                <div style="width:295px; height: 35px; background-color: #17306e ">
                    <p style="margin-left: 20px; margin-top: -1px;color: #3996f1;font-size:16px;">设备树
                        <%--<a  href="http://10.44.140.9:8080${pageContext.request.contextPath}/static/dahua/DHPlayerSetup.exe" download="DHPlayerSetup.exe"    style="color:#9a9595;cursor:pointer;line-height:14px;font-size:16px;font-weight:100;float:right;margin-top:5px;"><u>插件下载</u></a>--%>

                    </p>
                </div>
                <div v-loading="organizationTreeLoading"
                     style="width: 295px; height: calc(100% - 55px); overflow: auto; float:left; background: transparent; margin-top: 15px;">
                    <%--树组件（先引入）--%>
                    <power-organization-equipment-tree
                            @organization-equipment-tree-click="handleOrganizationTreeClick"></power-organization-equipment-tree>
                </div>
            </div>
            <%--下半部分--%>
            <div id="left-bottom" style="height: 16.33%; width: 295px; border:1px solid #c4deff; margin-top: 9px">
                <%--文字显示--%>
                <div style="width:295px; height: 18%; background-color: #17306e">
                    <p style="margin-left: 20px; margin-top: 1px; color: #3996f1;font-size:16px;">查询</p>
                </div>
                <%--日期框--%>
                    <div>
                <div id="dateQuery" style="background: transparent;height:30%;">
                    <div style="display: none;"
                         id="queryStartTime" name="queryStartTime" type="hidden">{{ queryStartTime }}</div>
                    <el-date-picker
                            style="padding-left: 5px; width: 95%; margin-top: 10px;"
                            clearable
                            v-model="queryStartTime"
                            size="mini"
                            type="datetime"
                            format="yyyy-MM-dd HH:mm:ss"
                            value-format="yyyy-MM-dd HH:mm:ss"
                            placeholder="起始时间">
                    </el-date-picker>
                    <div style="display: none;"
                         id="queryEndTime" name="queryEndTime" type="hidden">{{ queryEndTime }}</div>
                    <el-date-picker
                            style="margin-top: 5px; padding-left: 5px; width: 95%"
                            clearable
                            v-model="queryEndTime"
                            size="mini"
                            type="datetime"
                            format="yyyy-MM-dd HH:mm:ss"
                            value-format="yyyy-MM-dd HH:mm:ss"
                            placeholder="结束时间">
                    </el-date-picker>
                </div>
                <div id="queryBtn" style="height:52%;">
                    <el-button-group style="float:right;margin-top:38px;margin-right:10px;">
                        <el-button type="primary" plain size="mini" icon="el-icon-search" class="btn_dark_blue"
                                   @click="openVideo">查询
                        </el-button>
                        <el-button plain size="mini" icon="el-icon-refresh" @click="delData">重置</el-button>
                    </el-button-group>
                </div>
               </div>
            </div>

        </div>

        <%--右侧展示--%>
        <div style="height: calc(100% - 10px); margin-left: 8px; width:calc(100% - 320px); float:left; border:1px solid #c4deff;">
            <div class="side-right" style="left:300px;">
                <div class="right-videobox" style="height:98%;">
                    <div id="playWnd" class="playWnd" style="left: 109px; top: 133px;"></div>
                </div>
            </div>
        </div>
    </div>


    <%--测试1--%>
    <el-dialog title="突发事件登记" :visible.sync="dialogVisible" width="45%" style="text-align: center;">
        <el-form
                :model="findForm"
                ref="ruleForm"
                status-icon
                label-width="120px"
                size="mini">
            <el-input v-model="findForm.deviceOrganizationId" type="hidden"></el-input>
            <el-row>
                <el-col :span="11">
                    <el-form-item label="发生时间:" prop="happenTime">
                        <el-date-picker
                                v-model="findForm.happenTime"
                                type="datetime"
                                clearable
                                placeholder="选择日期时间">
                        </el-date-picker>
                    </el-form-item>
                </el-col>
            </el-row>
            <el-row>
                <el-col :span="11">
                    <el-form-item label="厂区名称:" prop="organizationPath">
                        <el-input v-model="findForm.organizationPath" clearable
                                  style="width: 220px; "></el-input>
                    </el-form-item>
                </el-col>
            </el-row>
            <el-row>
                <el-col :span="11">
                    <el-form-item label="安装位置:" prop="areaAddr">
                        <el-input v-model="findForm.areaAddr" clearable
                                  style="width: 220px; "></el-input>
                    </el-form-item>
                </el-col>
            </el-row>
            <el-row>
                <el-col :span="11">
                    <el-form-item label="推送至:" prop="remark">
                        <el-input v-model="userInfo" clearable
                                  @focus="onInputFocus"
                        ></el-input>
                        <el-button type="primary" style="width: 80px;float:right;margin-right:-80px;" @click="loginUser()">推送到本人</el-button>
                    </el-form-item>
                </el-col>
            </el-row>
            <el-row>
                <el-col :span="11">
                    <el-form-item label="预期完成时间:" prop="completionTime" style="display: none;">
                        <el-date-picker
                                v-model="findForm.completionTime"
                                type="datetime"
                                clearable
                                placeholder="选择日期时间">
                        </el-date-picker>
                    </el-form-item>
                </el-col>
            </el-row>
            <el-row>
                <el-col :span="11">
                    <el-form-item label="事件描述:" prop="remark">
                        <el-input type="textarea"
                                  placeholder="请输入内容"
                                  clearable
                                  :autosize="{ minRows: 2, maxRows: 4}"
                                  style="width: 450px; height: 20px;"
                                  v-model="findForm.remark"></el-input>
                    </el-form-item>
                </el-col>
            </el-row>
            <el-row>
                <el-image :src="findForm.picUrl"
                          style="width: 220px; height: 160px; margin-left: 350px; margin-top: -230px;">
                    <div slot="error" class="image-slot">
                        <i class="el-icon-picture-outline"></i>
                    </div>
                </el-image>
            </el-row>
            <ei-row>
                <el-checkbox style="margin-top: -80px; margin-left:240px;display:none; " checked
                <%--v-model="checked"--%>>同步手机短信提醒</el-checkbox>
            </ei-row>
            <el-row>
                <el-button type="primary" size="small"
                           style="margin-top: -67px; margin-left: 510px;padding:3px 15px; " @click="bigImg()"
                >放大</el-button>
            </el-row>
            <el-form-item style="margin: 15px 0px;" label-width="0px" >
                <div style="width:100%; height:40px;">
                    <el-button type="success" size="small" style="width:80px" @click="submitForm()"
                               class="btn_commit">提交
                    </el-button>
                    <el-button @click="closeForm()" style="width:80px" size="small">重置</el-button>
                </div>
            </el-form-item>

        </el-form>
    </el-dialog>

    <%--图片预览--%>
    <el-dialog title="图片预览" :visible.sync="imgsVisible" width="50%">
        <div style=" display: flex;justify-content: center; height: 450px;">
            <el-image :src="findForm.picUrl" fit="scale-down" lazy <%--style="margin: 20px auto;"--%>>
                <div slot="error" class="image-slot">
                    <i class="el-icon-picture-outline"></i>
                </div>
            </el-image>
        </div>
        <%--<div style=" display: flex;justify-content: center;">
            <el-button  @click="imgsVisible = false" type="primary" style="width: 6vw; ">关闭</el-button>
        </div>--%>
    </el-dialog>


    <el-dialog title="选择接收人员" :visible.sync="tableDialogVisible" width="35%" style="text-align: center;">
        <div style="width: 100%; height: 300px; text-align: center;">
            <div style="line-height:40px; text-align: center; ">
                <el-input v-model="queryContent1" clearable style="width:120px;  "
                          size="mini"
                          placeholder="【工号】搜索"></el-input>
                <el-input v-model="queryContent2" clearable style="width: 120px;  "
                          size="mini"
                          placeholder="【姓名】搜索"></el-input>
                <el-button size="mini" type="primary" class="btn_search" icon="el-icon-search"
                           @click="searchUserList">
                    查询
                </el-button>
            </div>
            <el-table
                    :data="tableData"
                    v-loading="loading"
                    border
                    size="mini"
                    tooltip-effect="dark"
                    highlight-current-row
                    border
                    :row-style="{height:'20px'}"
                    :cell-style="{padding:'0px'}"
                    @row-click="getRowData"
                    style="width: 500px; height: 240px;font-size: 10px;">
                <%--<el-table-column
                        prop="userId"
                        label="用户id"
                        width="180">
                </el-table-column>--%>
                <el-table-column
                        prop="loginName"
                        label="工号"
                        width="180">
                </el-table-column>
                <el-table-column
                        prop="userName"
                        label="姓名">
                </el-table-column>
            </el-table>
            <%-- 分页 --%>
            <div style="text-align:center;height: 35px; background: rgba(184,184,184,0.24)" class="el-pagination">
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

    </el-dialog>

</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/vue.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/element.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/axios.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/components/equipment/powerDeviceOrganization.js"></script>
<script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/static/hk/public_method.js"></script>
<script src="${pageContext.request.contextPath}/static/plugins/laydate/laydate.js"></script>
<script src="${pageContext.request.contextPath}/static/plugins/webuploader/js/webuploader.nolog.min.js"></script>
<script src="${pageContext.request.contextPath}/static/plugins/spjdt/js/index.js?time=3"></script>
<script src="${pageContext.request.contextPath}/static/hk/video/hisvideo.js?time=2"></script>
<script src="${pageContext.request.contextPath}/static/hk/video/isc/jsencrypt.min.js"></script>
<script src="${pageContext.request.contextPath}/static/hk/video/isc/jsWebControl-1.0.0.min.js"></script>
</body>

</html>

<script type="text/javascript">
    var zp_img;
    var flag = -1;

    // Vue实例化
    let doit = new Vue({
        el: '#app',
        data: {
            //组织设备树初始化
            organizationTreeLoading:false,
            queryStartTime: null,
            queryEndTime: null,
            //视频播放设备编号
            cameraid: null,
            dialogVisible: false,
            vedioCode: null,
            deviceCode1: null,
            deviceCode: null,
            dialogVisible: false, //弹出框
            /*违章form表单*/
            findForm: {
                id: null,
                deviceOrganizationId: null,
                happenTime: null,
                completionTime: null,
                organizationPath: null,
                areaAddr: null,
                remark: null,
                picUrl: null,
                accepterJob: null,
                accepterName: null,
                deviceCode: null,
            },
            userInfo: null,
            /*organizationPathName: null,//组织机构路径名称
             organizationId: null,//组织机构id
             cameraAreaAddr: null,//设备地址*/
            imgsVisible: false,
            value1: null,
            value2: null,
            tableDialogVisible: false,//接收人员弹框
            tableData: [],
            loading: false,
            queryContent1: null,
            queryContent2: null,
            /*分页参数*/
            page: {
                pageNo: 1,
                pageSize: 5,
                totalCount: 0,
                pageSizes: [5, 10]
            },
            treeClickCount: 0
        },
        created: function () {
            this.startTime();
            this.endTime();
        },
        methods: {

            /**
             * 默认开始日期
             */
            startTime() {
                let startDate = new Date();
                startDate.setMinutes(startDate.getMinutes() - 30);
                this.queryStartTime = this.timestampToTime(startDate);
            },

            /**
             * 默认结束日期
             */
            endTime() {
                let endDate = new Date();
                endDate.setMinutes(endDate.getMinutes());
                this.queryEndTime = this.timestampToTime(endDate);
            },

            /**
             * 时间戳转换
             */
            timestampToTime(timestamp) {
                let date = new Date(timestamp);//时间戳为10位需*1000，时间戳为13位的话不需乘1000
                let Y = date.getFullYear() + '-';
                let M = (date.getMonth() + 1 < 10 ? '0' + (date.getMonth() + 1) : date.getMonth() + 1) + '-';
                let D = (date.getDate() < 10 ? '0' + date.getDate() : date.getDate()) + ' ';
                let h = (date.getHours() < 10 ? '0' + date.getHours() : date.getHours()) + ':';
                let m = (date.getMinutes() < 10 ? '0' + date.getMinutes() : date.getMinutes()) + ':';
                let s = (date.getSeconds() < 10 ? '0' + date.getSeconds() : date.getSeconds());
                let strDate = Y + M + D + h + m + s;
                return strDate;
            },

            handleOrganizationTreeClick(node) {
                this.currentNode = node;
                this.cameraid = this.currentNode.cameraIndexCode;
                // 计时器,计算300毫秒为单位
                this.treeClickCount++;
                setTimeout(() => {
                    console.log(this.treeClickCount)
						if (this.treeClickCount == 1) {
                    //把次数归零
                    this.treeClickCount = 0;
                } else if (this.treeClickCount > 1) {
                    //把次数归零
                    this.treeClickCount = 0;
					startPlayback(this.cameraid);
                    //添加视频日志
                    this.saveVideoLog();
				

                }
             }, 300);
            },


            closeOpenPath(){
                $("#pathdiv").fadeOut();
                show();
            },
            openVideo(){
                startPlayback(this.cameraid);

            },
            delData() {
                this.queryEndTime = null;
                this.queryStartTime = null;
                // $("#queryStartTime").text("");
                // $("#queryEndTime").text("");
            },
            /*视频日志*/
            saveVideoLog(){
                axios.post(ctx+'/backstage/vm/thirOper/save?deviceCode='+this.deviceCode)
                        .then(res => {
                    console.log(res.data.data);
            }).catch(err => {
                    console.log(err)
            })
            },
            /*突发事件点击事件*/
            addDialog(){
                $("#msg").text("");
                if (this.findForm.deviceCode == null) {
                    $("#msg").text("请选择设备!");
                    return
                }
                hide();

                this.dialogVisible = true;
                this.findForm.happenTime = null;
                this.findForm.completionTime = null;
                this.findForm.remark = null;
                this.findForm.organizationPath = this.currentNode.organizationPathName;
                this.findForm.areaAddr = this.currentNode.areaAddr;
                this.findForm.picUrl =   zp_img;
            },
            /*关闭dialog弹框*/
            closeForm(){
                /*this.dialogVisible = false;
                 show();*/
                this.$refs.ruleForm.resetFields();
            },
            /*点击提交dialog弹框*/
            submitForm(){
                this.saveDeviceAccident();
                show();
            },
            /*获取抓拍图片路径*/
            getPicUrl(){
                var data = {
                    cameraIndexCode: this.deviceCode,
                    channelSeq:this.deviceCode1.split('$')[1]
                }
                axios.post('http://'+pt_ip+':8314/admin/rest/device/rest/getManualCaptureEx',data)
                        .then(res => {
                    zp_img=res.data.data.picUrl;
//                        this.findForm.picUrl = res.data.data.picUrl;
                /*this.findForm.areaAddr = res.data.data.picUrl;*/
                console.log(res.data);
                console.log(this.findForm.picUrl);
            }).catch(err => {
                    console.log(err)
            })
            },
            bigImg(){
                this.imgsVisible = true;
            },
            /*input获取焦点事件*/
            onInputFocus(){
                this.tableDialogVisible = true;
                this.getUserList();
            },
            /*发送至本人*/
            loginUser(){
                this.getUserInfo();
            },
            //搜索系统用户
            searchUserList(){
                this.getUserList();
            },
            //获取系统用户列表
            getUserList() {
                var queryData = {
                    pageNo: this.page.pageNo,
                    pageSize: this.page.pageSize,
                    loginName: this.queryContent1,
                    userName: this.queryContent2
                }
                this.loading = true
                axios.post(ctx+'/backstage/vm/historicalVideo/getPageList',queryData)
                        .then(res => {
                    this.loading = false
                this.tableData = res.data.data.dataList;
                this.page.totalCount = res.data.data.totalCount;
            }).catch(err => {
                    console.log(err)
                this.loading = false
            })
            },
            //获取当前选中行
            getRowData(val) {
                let thisRowData = this;
                thisRowData = val;
                this.findForm.accepterJob = thisRowData.loginName;
                this.findForm.accepterName = thisRowData.userName;
                this.userInfo = thisRowData.userName + "(" + thisRowData.loginName + ")";
                console.log(this.userInfo);
                this.tableDialogVisible = false;
            },
            /**
             * 分页
             * @param pageNo
             */
            handleCurrentChange(pageNo) {
                this.page.pageNo = pageNo;
                this.cameraDataRowIndex = -1;
                this.getUserList();
            },
            handleSizeChange(pageSize) {
                this.page.pageSize = pageSize;
                this.getUserList();
            },
            /*添加突发事件*/
            saveDeviceAccident(){
                $("#msg").text("");
                if (this.findForm.picUrl == null) {
                    $("#msg").text("图片不能为空!");
                    return
                }
                axios.post(ctx+'/backstage/vm/historicalVideo/save',this.findForm)
                        .then(res => {
                    this.dialogVisible = false;
//                        this.$message({
//                            message: res.data.data,
//                            type: 'success'
//                        });
                $("#msg").text("添加成功！");
            }).catch(err => {
                    console.log(err)
                this.dialogVisible = true;
                //              this.$message({
//                        message: "添加失败",
//                        type: 'error'
//                    });
                $("#msg").text("添加失败！");
            })
            },
            getUserInfo(){
                axios.post(ctx + '/backstage/vm/historicalVideo/getUserInfo')
                        .then(res => {
                    this.userInfo = res.data.data;
                console.log(res.data.data);
                var myinfo = res.data.data;
                var name= myinfo.substring(0,myinfo.indexOf("("));
                var numberJob = myinfo.substring(myinfo.indexOf("(")+1,myinfo.indexOf(")"));
                console.log(numberJob);
                console.log(name);
                this.findForm.accepterJob = numberJob;
                this.findForm.accepterName = name;

            }).catch(err => {
                    console.log(err)
            })
            },
        }
    })

    function downLoadVideo(url){
        loadVideo(url).then(res=>{
            console.log(res);
            if ('download' in document.createElement('a')) {
                const blob = new Blob([res.data]);
                const elink = document.createElement('a');
                let videoName = getNowDate();
                elink.download = videoName+".mp4";
                elink.style.display = 'none';
                elink.href = URL.createObjectURL(blob);
                document.body.appendChild(elink);
                elink.click();
                URL.revokeObjectURL(elink.href); // 释放URL 对象
                document.body.removeChild(elink);
            }
        })
    }
    async function loadVideo(url) {
        return await axios.get(ctx+"/backstage/cx/deviceAlarm/getFile/"+url,{responseType:'blob'});
    }

    function getNowDate(){
        var t=new Date();//row 表示一行数据, updateTime 表示要格式化的字段名称
        var year=t.getFullYear(),
            month=t.getMonth()+1,
            day=t.getDate(),
            hour=t.getHours(),
            min=t.getMinutes(),
            sec=t.getSeconds();
        return year + '-' +
            (month < 10 ? '0' + month : month) + '-' +
            (day < 10 ? '0' + day : day) + ' ' +
            (hour < 10 ? '0' + hour : hour) + ':' +
            (min < 10 ? '0' + min : min) + ':' +
            (sec < 10 ? '0' + sec : sec);
    }

    $(function() {
        //页面加载时创建播放实例初始化
        $(window).load(function () {
            initPlugin();
            getscreen();
        });
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

    .el-input__inner {
        color: white;
    }


</style>

​
