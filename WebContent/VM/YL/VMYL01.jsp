<%@ page import="com.baosight.iplat4j.core.web.threadlocal.UserSession" %><%--
  Created by IntelliJ IDEA.
  User: huang
  Date: 2020-07-08
  Time: 10:51
  To change this template use File | Settings | File Templates./*sfmsfm*/
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    UserSession.web2Service(request);
    String userName = UserSession.getLoginCName();
    String loginName = UserSession.getLoginName();
%>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <!-- import Vue before Element -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/vue/index.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/page-css.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/video/VMYL01.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/assets/icon/iconfont.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/business/css.css?time=3" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/plugins/webuploader/css/webuploader.css" />


    <%--引入tree组件--%>

    <c:set var="ctx" value="${pageContext.request.contextPath}"/>
    <script>
        var ctx = '${pageContext.request.contextPath}'
     </script>
<title>实时视频</title>
</head>
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
    .playWnd {
        margin: 0px 0 0 0px;
        width: 100%;                  /*播放容器的宽和高设定*/
        height:100%;
        border: 1px solid red;
    }
    .ytai-speed .ytai-rangebtn{
        left:50%;
    }
    .ytai-box{
        top:0px;
    }
    .side-right{
        left:330px;
    }
    .ytai-rbtnbox{
        width:120px;

    }
    .ytai-rbtnbox table{
        color:white;
    }
    .ytai-speed{
        position: absolute;
        margin-top:160px!important;
        color:white;
    }
    .right-btnbox{
        background-color: rgb(23, 48, 110);
    }
</style>

<body style="background-color: #001F6B;">
<div id="app">
    <div style="height: calc(100% - 10px); width: calc(100% - 10px); position: absolute">
        <%--左侧--%>

        <div style="height: calc(98% - 6px); width:320px; overflow-y: auto;overflow-x:hidden; float:left;">

            <%--上半部分--%>
            <div id="left-top" style="height:70%; width: 320px; border:1px solid #c4deff; overflow: auto;">
                <%--文字显示--%>
                <div style="width:320px; height: 35px;background: #17306e; margin-top:-5px;color:#EAE8C5;">
                    <p style="margin-left: 20px; margin-top: 5px; color: #3996f1;font-size:16px;">设备树
                        <%--<a  href="http://10.44.140.9:8080${pageContext.request.contextPath}/static/dahua/DHPlayerSetup.exe" download="DHPlayerSetup.exe"    style="color:#9a9595;cursor:pointer;line-height:14px;font-size:16px;font-weight:100;float:right;margin-top:5px;"><u>插件下载</u></a>--%>
                    </p>
                </div>
                <div v-loading="organizationTreeLoading"
                     style="width: 320px; height: calc(100% - 35px); overflow: auto; float:left; background: transparent;">
                    <%--树组件（先引入）--%>
                    <power-organization-equipment-tree
                            @organization-equipment-tree-click="handleOrganizationTreeClick"></power-organization-equipment-tree>
                </div>
            </div>
            <%--下半部分--%>
            <div id="left-bottom" style="height: 30%; width: 320px; border:1px solid #c4deff; margin-top: 9px;position: absolute">
                <div class="ytai-box" >
                    <div class="ytai-title" style="background-color: rgb(23, 48, 110);color:rgb(57, 150, 241);font-size:16px;"><span>云台控制</span>
                    </div>
                </div>
                <div class="ytai-cont" style="margin-top:65px;">
                    <div class="ytai-direct-box">
                        <button type="button" class="ytai-t" title="上" onmousedown="setControl(0,'UP');" onmouseup="setControl(1,'UP');"></button>
                        <button type="button" class="ytai-tr" title="右上" onmousedown="setControl(0,'RIGHT_UP');" onmouseup="setControl(1,'RIGHT_UP');"></button>
                        <button type="button" class="ytai-r" title="右" onmousedown="setControl(0,'RIGHT');" onmouseup="setControl(1,'RIGHT');"></button>
                        <button type="button" class="ytai-rb" title="右下" onmousedown="setControl(0,'RIGHT_DOWN');" onmouseup="setControl(1,'RIGHT_DOWN');"></button>
                        <button type="button" class="ytai-b" title="下" onmousedown="setControl(0,'DOWN');" onmouseup="setControl(1,'DOWN');"></button>
                        <button type="button" class="ytai-bl" title="左下" onmousedown="setControl(0,'LEFT_DOWN');" onmouseup="setControl(1,'LEFT_DOWN');"></button>
                        <button type="button" class="ytai-l" title="左" onmousedown="setControl(0,'LEFT');" onmouseup="setControl(1,'LEFT');"></button>
                        <button type="button" class="ytai-lt" title="左上" onmousedown="setControl(0,'LEFT_UP');" onmouseup="setControl(1,'LEFT_UP');"></button>
                        <button type="button" class="ytai-c" title="自动" onmousedown="setControl(0,'');" onmouseup="setControl(1,'');"></button>
                    </div>

                    <div class="ytai-rbtnbox">
                        <table cellpadding="0" cellspacing="0" class="count-table ytai-rbtn-table">
                            <tbody>
                            <tr><td>倍数：</td>
                                <td><button type="button" class="radius50 ytai-btnup" onmousedown="setControl(0,'FOCUS_NEAR');" onmouseup="setControl(1,'FOCUS_NEAR');"><img src="${pageContext.request.contextPath}/static/css/business/images/ytai-btn1.png" title="放大" /></button></td>
                                <td><button type="button" class="radius50 ytai-btndown" onmousedown="setControl(0,'FOCUS_FAR');" onmouseup="setControl(1,'FOCUS_FAR');"><img src="${pageContext.request.contextPath}/static/css/business/images/ytai-btn2.png" title="缩小" /></button></td>
                            </tr>
                            <tr>
                                <td>焦距：</td>
                                <td><button type="button" class="radius50 ytai-btnup" onmousedown="setControl(0,'ZOOM_IN');" onmouseup="setControl(1,'ZOOM_IN');"><img src="${pageContext.request.contextPath}/static/css/business/images/ytai-btn3.png" title="远" /></button></td>
                                <td><button type="button" class="radius50 ytai-btndown" onmousedown="setControl(0,'ZOOM_OUT');" onmouseup="setControl(1,'ZOOM_OUT');"><img src="${pageContext.request.contextPath}/static/css/business/images/ytai-btn4.png" title="近" /></button></td>
                            </tr>
                            <tr>
                                <td>光圈：</td>
                                <td><button type="button" class="radius50 ytai-btnup" onmousedown="setControl(0,'IRIS_ENLARGE');" onmouseup="setControl(1,'IRIS_ENLARGE');"><img src="${pageContext.request.contextPath}/static/css/business/images/ytai-btn5.png" title="大" /></button></td>
                                <td><button type="button" class="radius50 ytai-btndown" onmousedown="setControl(0,'IRIS_REDUCE');" onmouseup="setControl(1,'IRIS_REDUCE');"><img src="${pageContext.request.contextPath}/static/css/business/images/ytai-btn6.png" title="小" /></button></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="ytai-speed">
                        <span>速度：</span>
                        <span>慢</span><div class="ytai-rangebox"><span class="ytai-rangebtn" id="presetparam"></span></div><span>快</span>
                    </div>

                </div>
            </div>
        </div>
            <div class="side-right">
                <div class="right-videobox" >
                    <div id="playWnd" class="playWnd"  ></div>

                </div>

                <%--<div class="side-right">--%>
                <%--<div class="right-videobox" >--%>
                <%--&lt;%&ndash;<div id="playWnd" class="playWnd"  ></div>&ndash;%&gt;--%>
                <%--&lt;%&ndash;<object classid="clsid:9ECD2A40-1222-432E-A4D4-154C7CAB9DE3" id="spv"  width="100%" height="100%" hspace=0 vspace=0></object>&ndash;%&gt;--%>
                <%--</div>--%>
                <div class="right-btnbox">
                    <%--<u><a style="cursor:pointer;font-size:17px;line-height:70px;color:black;" id="browseperson_selBtn" >5分钟内浏览过视频的人员</a></u>--%>
                    <button type="button" class="button-btn" title="十六画面" onclick="setLayout('4x4');"><img src=" ${pageContext.request.contextPath}/static/css/business/images/video-btn8.png" /></button>
                    <button type="button" class="button-btn" title="九画面" onclick="setLayout('3x3');"><img src="${pageContext.request.contextPath}/static/css/business/images/video-btn7.png" /></button>
                    <button type="button" class="button-btn" title="四画面" onclick="setLayout('2x2');"><img src="${pageContext.request.contextPath}/static/css/business/images/video-btn6.png" /></button>
                    <button type="button" class="button-btn" title="单画面" onclick="setLayout('1x1');"><img src="${pageContext.request.contextPath}/static/css/business/images/video-btn5.png" /></button>

                    <button type="button" class="button-btn" title="停止所有预览" onclick="stopAllVideo();"><img src="${pageContext.request.contextPath}/static/css/business/images/video-btn3.png" /></button>
                    <%--<button type="button" class="button-btn" title="开始录像" onclick="StartRecord();"><img src=" ${pageContext.request.contextPath}/static/css/business/images/video-btn2.png" /></button>--%>
                    <%--<button type="button" class="button-btn" title="抓拍" onclick="SnapPic();"><img src="${pageContext.request.contextPath}/static/css/business/images/video-btn1.png" /></button>--%>
                    <button type="button" class="button-btn" title="抓拍" onclick="SnapPic();"><img src="${pageContext.request.contextPath}/static/css/business/images/video-btn1.png" /></button>
                    <%--<button type="button" class="button-btn" title="发现异常"  @click="addDialog()"><img src="${pageContext.request.contextPath}/static/css/business/images/video-btn4.png" /></button>--%>
                    <%--<button type="button" class="button-btn" title="打开图片"  onclick="openFileIIs('d://capture')"><img src="${pageContext.request.contextPath}/static/css/business/images/2.png" /></button>--%>
                    <%--<button type="button" class="button-btn" title="打开录像"  onclick="openFileIIs('d://RecordFile')"><img src="${pageContext.request.contextPath}/static/css/business/images/1.png" /></button>--%>

                </div>
            </div>
       <div style="width:596px;height:395px;border:2px solid  #6a9adc;display:none;" class="about" >
           <img src="" style="width:100%;height:100%;position:absolute;" />
           <button type="button" onclick="closeDiv()" style="position:absolute;bottom:0px;right:0px;background-color:#6175a7;border:0px;color:white;">关闭</button>
       </div>
    </div>

    <%--测试1--%>
    <el-dialog title="发现异常" :visible.sync="dialogVisible" width="45%" style="text-align: center;z-index: 99999">
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
                                style="width:100%;"
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
                                  style="width: 100%; "></el-input>
                    </el-form-item>
                </el-col>
            </el-row>
            <el-row>
                <el-col :span="11">
                    <el-form-item label="安装位置:" prop="areaAddr">
                        <el-input v-model="findForm.areaAddr" clearable
                                  style="width: 100%; "></el-input>
                    </el-form-item>
                </el-col>
            </el-row>
            <el-row>
                <el-col :span="9">
                    <el-form-item label="推送至:" prop="userInfo">
                        <el-input v-model="findForm.userInfo" clearable size="mini" style="width: 100%;"
                                  @focus="onInputFocus" placeholder="推送至名称"/>
                    </el-form-item>
                </el-col>
                <el-col :span="3">
                    <el-button type="primary" @click="loginUser()" size="mini"
                               style="float: left; margin-left: 10px;">
                        本人
                    </el-button>
                </el-col>
            </el-row>
            <el-row>
                <el-col :span="11">
                    <el-form-item label="预期完成时间:" prop="completionTime" >
                        <el-date-picker
                                style="width:100%;"
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
                <%--<el-image :src="findForm.picUrl"--%>
                          <%--style="width: 220px; height: 180px; margin-left: 350px; margin-top: -270px;">--%>
                    <%--<div slot="error" class="image-slot">--%>
                        <%--<i class="el-icon-picture-outline"></i>--%>
                    <%--</div>--%>
                <%--</el-image>--%>
                    <el-col :span="5">
                    <el-form-item label="抓拍图片:" style="margin: 5px 0px;">
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
                            <div>上传抓拍图片</div>
                        </el-upload>
                    </el-form-item>
                  </el-col>
            </el-row>
            <ei-row>
                <el-checkbox style="margin-top: -80px; margin-left: 240px;display:none; " checked
                <%--v-model="checked"--%>>同步手机短信提醒
                </el-checkbox>
            </ei-row>
            <el-row>
                <el-button type="primary" size="small"
                           style="margin-top: -87px; margin-left: 510px;padding:3px 15px; " @click="bigImg()"
                >放大
                </el-button>
            </el-row>
            <el-form-item style="margin: 15px 0px;" label-width="0px">
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


    <el-dialog title="选择接收人员" :visible.sync="tableDialogVisible" width="55%" style="text-align: center;">
        <div style="width: 100%; height: 300px; text-align: center;" class="block-border">
            <div style="line-height:40px; text-align: center; ">
                <el-input v-model="queryContent1" clearable style="width:25%;"
                          size="mini"
                          placeholder="【工号】搜索"></el-input>&nbsp;&nbsp;&nbsp;
                <el-input v-model="queryContent2" clearable style="width: 25%;"
                          size="mini"
                          placeholder="【姓名】搜索"></el-input>&nbsp;&nbsp;&nbsp;
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
                    height="calc(100% - 73px)"
                    :row-style="{height:'20px'}"
                    :cell-style="{padding:'0px'}"
                    @row-click="getRowData"
                    style="width: 100%; height: 100%;font-size: 10px;">
                <el-table-column prop="loginName" label="工号" min-width="180"></el-table-column>
                <el-table-column prop="userName" label="姓名" min-width="180"></el-table-column>
            </el-table>
            <div style="text-align:center;height: 35px;">
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
<script src="${pageContext.request.contextPath}/static/hk/video/divscroll.js"></script>
<script src="${pageContext.request.contextPath}/static/hk/video/pageopt.js?time=1"></script>
<script src="${pageContext.request.contextPath}/static/hk/video/video.js?time=2"></script>
<script src="${pageContext.request.contextPath}/static/hk/video/isc/iscvideo.js?time=1"></script>
<script src="${pageContext.request.contextPath}/static/hk/video/isc/jsencrypt.min.js"></script>
<script src="${pageContext.request.contextPath}/static/hk/video/isc/jsWebControl-1.0.0.min.js"></script>
<%--<script type="text/javascript" src="${pageContext.request.contextPath}/static/layer/3.0.2/layer.js"></script>--%>
</body>

</html>

<script type="text/javascript">
    var zp_img;

    let doit = new Vue({
        el: '#app',
        data: {
            //组织设备树初始化
            organizationTreeLoading: false,
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
                userInfo: null
            },

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
            imgUrl: null,
            /*分页参数*/
            page: {
                pageNo: 1,
                pageSize: 5,
                totalCount: 0,
                pageSizes: [5, 10]
            },
            treeClickCount:0
        },
        created: function () {

        },
        methods: {
            /*点击左侧树事件*/
            handleOrganizationTreeClick(node) {
                this.currentNode = node;
                this.cameraid = this.currentNode.cameraIndexCode;
//                $('#cameraId').val(this.currentNode.vedioCode);
//                this.findForm.organizationPath = this.currentNode.organizationPathName;
//                this.findForm.deviceOrganizationId = this.currentNode.id;
//                this.findForm.areaAddr = this.currentNode.areaAddr;
//                this.findForm.deviceCode = this.cameraid;
                // 计时器,计算300毫秒为单位
               this.treeClickCount++;
              setTimeout(() => {
               console.log(this.treeClickCount)
                  if (this.treeClickCount == 1) {
                      // this.saveVideoLog();
                      //把次数归零
                   this.treeClickCount = 0;
               } else if (this.treeClickCount > 1) {
                   //把次数归零
                   this.treeClickCount = 0;
                    //添加视频日志

                    //登录大华获取token
                   //loginSys();
                    startVideo(this.cameraid);
                   // //获取实时视频
                   // getRealmonitorRtsp();
                   // this.getPicUrl();
               }
              }, 300);
            },

            /*视频日志*/
            saveVideoLog() {
                axios.post(ctx + '/backstage/vm/thirOper/save?deviceCode=' + this.deviceCode)
                        .then(res => {
                    console.log(res.data.data);
            }).catch(err => {
                    console.log(err)
            })
            },
            /*突发事件点击事件*/
            addDialog() {
                $("#msg").text("");
                if (this.findForm.deviceCode == null) {
                    $("#msg").text("请选择设备，再进行操作 !");
                    return
                }
//                hide();
                this.dialogVisible = true;
                this.findForm.happenTime = null;
                this.findForm.completionTime = null;
                this.findForm.remark = null;
                this.findForm.organizationPath = this.currentNode.organizationPathName;
                this.findForm.areaAddr = this.currentNode.areaAddr;
                SnapPic2();
                this.findForm.picUrl =zp_img;
            },
            /*关闭dialog弹框*/
            closeForm() {
                /*this.dialogVisible = false;
                 show();*/
                this.$refs.ruleForm.resetFields();
//                show();
            },
            /*点击提交dialog弹框*/
            submitForm() {
                this.saveDeviceAccident();
                show();
            },
            /*获取抓拍图片路径*/
            getPicUrl() {
                var data = {
                    cameraIndexCode: this.deviceCode,
                    channelSeq:this.deviceCode1.split('$')[1]
                }
                axios.post('http://'+pt_ip+':8314/admin/rest/device/rest/getManualCaptureEx', data)
                        .then(res => {
                    //this.findForm.picUrl = res.data.data.picUrl;
                    zp_img=res.data.data.picUrl;
                console.log(res.data);
                console.log(this.findForm.picUrl);
                }).catch(err => {
                    console.log(err)
            })
            },
            bigImg() {
                this.imgsVisible = true;
            },
            /*input获取焦点事件*/
            onInputFocus() {
                this.tableDialogVisible = true;
                this.getUserList();
            },

            /*发送至本人*/
            loginUser() {
                this.findForm.userInfo = '<%=userName%>' + ' (' + '<%=loginName%>' + ')';
                this.findForm.accepterName = '<%=userName%>';
                this.findForm.accepterJob = '<%=loginName%>';
            },

            //搜索系统用户
            searchUserList() {
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
                axios.post(ctx + '/backstage/vm/historicalVideo/getPageList', queryData)
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
                this.findForm.userInfo = thisRowData.userName + "(" + thisRowData.loginName + ")";
                console.log(this.findForm.userInfo);
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
            closeOpenPath(){
                $("#pathdiv").fadeOut();
                show();
            },
            handleSizeChange(pageSize) {
                this.page.pageSize = pageSize;
                this.getUserList();
            },
            /*添加突发事件*/
            saveDeviceAccident() {
                $("#msg").text("");
                if (this.findForm.picUrl == null) {
                    $("#msg").text("图片不能为空!");
                    return
                }
                axios.post(ctx + '/backstage/vm/historicalVideo/save', this.findForm)
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
//                    this.$message({
//                        message: "添加失败",
//                        type: 'error'
//                    });
                $("#msg").text("添加失败！");
            })
                show();
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
            }
        },
    })

    $('.item').perfectScrollbar();
    var oWrapper = $(".wrapper");
    var oTreeBox = $(".tree-box");
    oTreeBox.height(oWrapper.height() - 285 );
    $('.right-videobox').height($('.side-right').height() - 70);
    //页面加载时创建播放实例初始化
    $(window).load(function () {
        initPlugin();
        getscreen();
    });
    $(function(){
        $(".el-dialog__headerbtn").click(function(){
            show();
        })
        $(".ytai-ctrlbtn-close").click(function(){
            $(".ytai-ctrlbtn").css({display:"none"});
        });
        $(".ytai-btn-a").click(function(){
            var oYTaiCtrlbtnDisplay = $(".ytai-ctrlbtn").css("display");
            if(oYTaiCtrlbtnDisplay === "none"){
                $(".ytai-ctrlbtn").css({display:"block"})
            }else{
                $(".ytai-ctrlbtn").css({display:"none"});
            }
        });
        $(window).resize( function(){
            oTreeBox.height(oWrapper.height() - 285 );
            $('.right-videobox').height($('.side-right').height() - 70);
        });
        // 声音拖动条
        var oYtaiRangebtn = $(".ytai-rangebtn");
        oYtaiRangebtn.each(function(index, item){
            dragFun(item);
        });
        function dragFun(item){
            var oDrag = $(item)[0];
            var num = "";
            oDrag.onmousedown=function(ev){
                var oEvt=ev||event;
                var disX=oEvt.clientX-oDrag.offsetLeft;
                document.onmousemove=function(ev){
                    var oEvt=ev||event;
                    var l=oEvt.clientX-disX;
                    l = l/$(item).parent()[0].clientWidth*100;
                    l=l < (-8)? -8:l;
                    l=l > 92? 92:l;
                    oDrag.style.left= l +'%';
                    // num 位1-10的数字
                    num = 9*(l+8)/100 + 1;
                    num = num.toFixed(2);
                    param=Math.floor(num);
                };
                document.onmouseup=function(){
                    document.onmousemove=document.onmouseup=null;
                    oDrag.releaseCapture && oDrag.releaseCapture();
                };
                oDrag.setCapture && oDrag.setCapture();
                return false;
            };
        }

    })



</script>


<style>
    #app {
        font-family: "Helvetica Neue", Helvetica, "PingFang SC", "Hiragino Sans GB", "Microsoft YaHei", "微软雅黑", Arial, sans-serif;
        color: #756C83;
    }

    .el-input__inner {
        border: 1px solid #EAE8C5;
        background-color: transparent;
        color: white;
    }


</style>

​
