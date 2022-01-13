<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta http-equiv=Content-Type content="text/html;charset=utf-8">
    <meta http-equiv=X-UA-Compatible content="IE=edge,chrome=1">
    <meta content=always name=referrer>
    <title>GIS地图</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/vue/index.css"/>
    <link href="${pageContext.request.contextPath}/static/mp/css/ol.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/assets/icon/iconfont.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/mp/css/page-css.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/hk/gis_video/css/video-js.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/mp/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/axios.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/api/equipment/cameraDataApi.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/vue.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/element.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/vue/axios.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/mp/js/ol.js"></script>
    <c:set var="ctx" value="${pageContext.request.contextPath}"/>
    <script>
        var ctx = '${pageContext.request.contextPath}'
    </script>
    <style type="text/css">
        *{
            margin: 0px;
            padding: 0px;
        }
        /* #map {
            cursor: pointer;
        } */
        .rotate{
            transform: rotateY(180deg);
        }

        .ol-attribution{
            display: none;
        }
        .el-form-item__label{
            color: #666666;
        }
        .el-button {

        }
        .el-input__inner {
            border: 1px solid #EAE8C5;
            background-color: transparent;
            color: #666666;
        }
        .form-device{
            z-index: 0;
            padding: 10px;
            width: 330px;
            background-color:#FFFFFF;
            border-radius: 30px;
            box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1)
        }
        .el-form-item{
            margin-bottom: 5px;
        }
        .el-card__body{
            padding: 10px 20px 20px;
        }
        .handle_button_grp{
            text-align: center;
        }
        #map{
            position: absolute;
        }
        .form{
            position: absolute;
            right: 40px;
            top: 100px;
        }
        .anchor{
            width: 25px;
            height: 25px;
            border-radius: 50%;
            position: absolute;
            cursor: pointer;
        }
        #monitoring_window{
            padding: 40px  10px 20px 10px;
            background-color: #FFFFFF;
            z-index: 1;
            position: absolute;
            border-radius: 9px;
            width: 360px;
            box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1)

        }
        #deviceName{
            padding: 5px 10px;
            border:1px solid azure ;
            position: relative;
            background-color: #4179cf;
            text-align: center;
            color: #eef700;
            z-index: 999999999999999;
            border-radius: 30px;
            box-shadow: 3px 5px 12px 0px rgb(255, 255, 255);
        }
        #DHVideoPlayer{
            border: 0px solid transparent;
            width: 100%;
            height: 81%;
            margin-bottom: 10px;
        }
        #triangle{
            position: absolute;
            bottom: -20px;
            left: 45%;
            height: 0;
            width: 0;
            border-left: 10px solid transparent;
            border-right: 10px solid transparent;
            border-top: 10px solid #FFFFFF;
            border-bottom: 10px solid transparent;
        }
        #serch{
            box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
            top: 60px;
            left: 90px;
            position: absolute;
        }
        .el-popover-1962{

            border: 1px solid #40b3ff;

        }
        .el-table__row{
            font-size: 12px;
        }
        [v-cloak] {
            display: none;
        }
        #areaName{
            font-size: 30px;
            position: absolute;
            margin-left: 40%;
            top: 30px;
            color: #8c8c8c;
        }
        #spaceChage{
            position: absolute;
            z-index: 999999;
            top: 250px;
            left:-180px;
            width: 220px;
            transition: all 0.5s 0s ease-out;
            padding: 10px;
            max-height: 400px;
            overflow: hidden;
        }
        #spaceChage:hover{
            left: -40px;
            overflow: auto;
        }
        #spaceChage::-webkit-scrollbar {
            width: 5px;
        }
        #spaceChage::-webkit-scrollbar-thumb {
            border-radius: 20px;
            box-shadow: inset 0 0 5px rgba(0, 0, 0, 0);
            background: rgba(0, 0, 0, 0.41);
        }
        #spaceChage::-webkit-scrollbar-track {
            box-shadow: inset 0 0 5px rgba(0,0,0,0.2);
            border-radius: 10px;
            background: rgba(237, 237, 237, 0);
        }
        #mapChanage{
            position: absolute;
            z-index: 999999;
            top: 30px;
            right:300px;
        }
        #mapChanage button{
            width: 150px;margin-top:20px ;margin-left: 10px;
        }
        #gund:before{

        }
        .icon-qiangji:before {
            content: "\e608";
            color: #FFFFFF;
        }
        .icon-qiangji2{
            content: "\e608";
            color: #FFFFFF;
        }
        .el-popover{
            background-color: #3a8ee600;
            border:0px;
            color:#EAE8C5!important;
        }
        .el-table__row{
            color:#EAE8C5!important;
        }
    </style>

    <title>GIS地图</title>
</head>
<body>

<%--<iframe id='iframebar' src="about:blank" frameBorder=0  marginHeight=0 marginWidth=0 style="position:absolute;visibility:inherit; top:0px;left:0px;height:560px;width:660px;border-radius:5px;z-index:-1;filter='progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)'"></iframe>--%>
<div id="map" style="width: 100%;height:100%;background-color:#001F6B;"></div>
<div id="app" v-cloak>
    <input type="hidden" id="cameraId"/>
    <img src="${pageContext.request.contextPath}/static/mp/img/icon_red.png" alt="" id="icon_red" style="width: 25px;position: absolute;" v-show="icon_show">
    <h1 id="areaName" >{{areaName}}</h1>
    <div id ="mapChanage">

        <el-button v-for="(item,index) in mapPathList"  :type="currentMap==index+1?'primary':''" @click="changeMapByAreaDevice(index+1)"  >{{HanziNumber[index]}}区图
        </el-button>
<%--        <el-button  :type="currentMap==2?'primary':''" @click="changeMapByAreaDevice(2)">二区图--%>
<%--        </el-button>--%>
<%--        <el-button  :type="currentMap==3?'primary':''" @click="changeMapByAreaDevice(3)" >三区图--%>
<%--        </el-button>--%>
<%--        <el-button  :type="currentMap==3?'primary':''" @click="changeMapByAreaDevice(3)" >三区图--%>
<%--        </el-button>--%>
    </div>
    <div id ="spaceChage">

        <el-button v-for="(item,index) in orginInfo" :type="currentSpace==item.id?'primary':''" @click="changeSpaceByAreaDevice(item)" style="width: 200px;margin-top:20px ;margin-left: 10px;border-radius:40px ">{{item.organName}}
        </el-button>


    </div>
    <div id="serch">
        <el-popover
                style="border: 1px "
                placement="bottom"
                width="400px"
                trigger="manual"
                v-model="table_visible">
            <label style="font-size: 16px;">设备列表</label>
            <el-tooltip class="item" effect="dark" content="点击添加设备" placement="top-start">
                <el-button type="primary" icon="el-icon-plus" circle size="mini" style="margin-left: 400px;" @click="addDevice"></el-button>
            </el-tooltip>
            <el-tooltip class="item" effect="dark" content="关闭列表" placement="top-start">
                <el-button type="danger" icon="el-icon-close" circle size="mini" style="margin-left: 15px;" @click="table_visible=!table_visible"></el-button>
            </el-tooltip>
            <el-table :data="tableData.slice((currentPage-1)*pageSize,currentPage*pageSize)" @row-click="show_camera">
                <el-table-column align="center" width="45" type="selection" fixed="left"></el-table-column>
                <el-table-column property="deviceCode" label="编号" min-width="150" show-overflow-tooltip></el-table-column>
                <el-table-column width="250" property="deviceName" label="名称"></el-table-column>
                <el-table-column width="60" property="deviceType" label="类型">
                    <template scope="scope">
                        <el-tooltip v-if="scope.row.deviceType==0 || scope.row.deviceType==3" class="item" effect="dark" content="摄像机" placement="top-start">
                            <img src="${pageContext.request.contextPath}/static/mp/img/gun.png" alt="" style="width: 20px;">
                        </el-tooltip>
                        <el-tooltip v-else class="item" effect="dark" content="录像机" placement="top-start">
                            <img src="${pageContext.request.contextPath}/static/mp/img/boot.png" alt="" style="width: 20px;">
                        </el-tooltip>
                    </template>
                </el-table-column>
                <el-table-column width="60" property="deviceStatus"  label="状态">
                    <template scope="scope">
                        <span v-if="scope.row.deviceStatus==1" style="color: green;">在线</span>
                        <span v-else style="color: #ff0600;">离线</span>
                    </template>
                </el-table-column>
                <el-table-column width="80" label="操作">
                    <template slot-scope="scope">
                        <el-button
                                size="mini"
                                @click="handleEdit(scope.$index,scope.row)">编辑</el-button>
                    </template>
                </el-table-column>
            </el-table>
            <el-button slot="reference" @click="table_visible=!table_visible" icon="el-icon-s-order"> </el-button>
            <div >
                <el-pagination
                        style="margin-top: 10px;text-align: center"
                        @size-change="handleSizeChange"
                        @current-change="handleCurrentChange"
                        :current-page="currentPage"
                        :page-size="pageSize"
                        :pager-count="7"
                        layout=" prev, pager, next,total,jumper"
                        :total="tableData.length">
                </el-pagination>
            </div>
        </el-popover>
        <el-input style="width: 300px;" v-model="deviceNameSerch" placeholder="请输入设备名称"  class="input-with-select">

            <el-button slot="append"  icon="el-icon-search" @click="serchDevices" style="background-color: #FFEBCD;"></el-button>
        </el-input>

    </div>
    <transition name="el-fade-in-linear">
        <%--<div id="playWnd" class="playWnd"  style="width:380px;height:260px;margin-bottom:10px;" ></div>--%>
        <%--<div id ="monitoring_window" >--%>
            <%--<el-button size="mini" circle icon = "el-icon-close" style="position: absolute;right: 10px; top: 10px;" @click="closeInfoWindows()"></el-button>--%>

            <%--<span style="font-size: 12px;margin-left: 60px;" id="device_name"></span>--%>
            <%--<el-button type="warning" size="mini" style="position: absolute;right: 30px; bottom: 10px;" @click="show_info_form">详细信息</el-button>--%>
            <%--<div id="triangle"></div>--%>
        <%--</div>--%>
            <%--<div id="playWnd" class="playWnd"  style="width:380px;height:260px;margin-bottom:10px;" ></div>--%>
        <div id ="monitoring_window" v-show="window_show" >
            <el-button size="mini" circle icon = "el-icon-close" style="position: absolute;right: 10px; top: 10px;" @click="closeInfoWindows()"></el-button>
            <%--<div id="DHVideoPlayer" style=""></div>--%>
            <%--http://10.1.155.185:83/openUrl/zer9iIE/live.m3u8--%>
            <video id="example-video" class="video-js" autoplay="autoplay" controls preload="auto" width="350" height="260" style="margin-bottom:10px;" >

            </video>
            <span style="font-size: 12px;margin-left: 60px;" id="device_name"></span>
            <el-button type="warning" size="mini" style="position: absolute;right: 30px; bottom: 10px;" @click="show_info_form">详细信息</el-button>
            <div id="triangle"></div>
        </div>
    </transition>
    <transition name="el-fade-in-linear">
        <p id ="deviceName" v-show="name_show"></p>
    </transition>
    <div @click="show_window($event)" v-on:mouseover="showDeviceName($event,item)" v-on:mouseout="name_show=false"  class='anchor' v-for="(item,i) in mapData" :id="item.deviceId">
        <i v-if="item.deviceType==0 && item.deviceStatus==1" style="background-color: #86BFF7;color: #FFFFFF;font-size: 22px;display: inline-block;border-radius: 50%;border:1px solid #86BFF7;" :class="['magang-font icon-qiangji',{'rotate':item.rotate == true}]"></i>
        <i v-if="item.deviceType==0 && item.deviceStatus==2" style="background-color:#909399;color: #FFFFFF;font-size: 22px;display: inline-block;border-radius: 50%;border: 1px solid #fff" :class="['magang-font icon-qiangji2',{'rotate':item.rotate == true}]"></i>

<%--        <i v-if="item.deviceType==1 && item.deviceStatus==1" id="gund" style="background-color: #86BFF7;color: #FFFFFF;font-size: 22px;display: inline-block;border-radius: 50%;border:1px solid #86BFF7;" :class="[magang-font icon-banqiuji',{'rotate':item.rotate == true}]"></i>--%>
<%--        <i v-if="item.deviceType==1 && item.deviceStatus==2" id="offgund" style="background-color:#909399;color: #FFFFFF;font-size: 22px;display: inline-block;border-radius: 50%;border: 1px solid #fff" :class="['magang-font icon-banqiuji2',{'rotate':item.rotate == true}]"></i>--%>
<%--        <i v-if="item.deviceType==2 && item.deviceStatus==1" style="background-color: #86BFF7;color: #FFFFFF;font-size: 22px;display: inline-block;border-radius: 50%;border:1px solid #86BFF7;" :class="[magang-font icon-banqiuji',{'rotate':item.rotate == true}]"></i>--%>
<%--        <i v-if="item.deviceType==2 && item.deviceStatus==2" style="background-color:#909399;color: #FFFFFF;font-size: 22px;display: inline-block;border-radius: 50%;border: 1px solid #fff" :class="['magang-font icon-banqiuji2',{'rotate':item.rotate == true}]"></i>--%>

        <i v-if="item.deviceType==2 && item.deviceStatus==1" style="background-color: #86BFF7;color: #FFFFFF;font-size: 25px; border-radius: 50%;border:1px solid #86BFF7;" :class="['magang-font icon-banqiuji',{'rotate':item.rotate == true}]"></i>
        <i v-if="item.deviceType==2 && item.deviceStatus==2" style="background-color: #9a6e3a;color: #FFFFFF;font-size: 25px;color:red;border-radius: 50%;border:1px solid red;" :class="['magang-font icon-banqiuji2',{'rotate':item.rotate == true}]"></i>
        <i v-if="item.deviceType==1 && item.deviceStatus==1" style="background-color: #86BFF7;color: #FFFFFF;font-size: 25px; border-radius: 50%;border:1px solid #86BFF7;" :class="['magang-font icon-banqiuji',{'rotate':item.rotate == true}]"></i>
        <i v-if="item.deviceType==1 && item.deviceStatus==2" style="background-color: #9a6e3a;color: #FFFFFF;font-size: 25px;color:red;border-radius: 50%;border:1px solid red;" :class="['magang-font icon-banqiuji2',{'rotate':item.rotate == true}]"></i>

        <i v-if="item.deviceType==3 && item.deviceStatus==1" style="background-color: #86BFF7;color: #FFFFFF;font-size: 22px;display: inline-block;border-radius: 50%;border:1px solid #86BFF7;" :class="['magang-font icon-qiangji',{'rotate':item.rotate == true}]"></i>
        <i v-if="item.deviceType==3 && item.deviceStatus==2" style="background-color:#909399;color: #FFFFFF;font-size: 22px;display: inline-block;border-radius: 50%;border: 1px solid #fff" :class="['magang-font icon-qiangji2',{'rotate':item.rotate == true}]"></i>
    </div>
    <el-row>
        <el-col :span="6">
            <transition name="el-fade-in-linear">
                <el-card class="box-card form-device form" v-show="show_form">
                    <div slot="header" class="clearfix">
                        <span style="color:blue;">设备信息</span>
                        <el-button style="float: right; padding: 3px 0;color: red" type="text" @click="closeDeviceForm">关闭</el-button>
                    </div>
                    <el-form  label-width="80px" ref="device" :model="device" label-position="right">
                        <el-form-item label="设备编码:">
                            <el-input v-model="device.deviceCode" size="mini" style="width: 200px;margin-top: 5px" :disabled="input_visible"></el-input>
                        </el-form-item>
                        <el-form-item label="设备IP:">
                            <el-input v-model="device.deviceIp" size="mini" style="width: 200px;margin-top: 5px" :disabled="input_visible"></el-input>
                        </el-form-item>
                        <el-form-item label="设备名称:">
                            <el-input v-model="device.deviceName" size="mini" style="width: 200px;margin-top: 5px" :disabled="input_visible"></el-input>
                        </el-form-item>
                        <el-form-item label="安装位置:">
                            <el-input v-model="device.deviceAddr" size="mini" style="width: 200px;margin-top: 5px" :disabled="input_visible"></el-input>
                        </el-form-item>
                            <el-form-item label="设备类型:">
                                <el-select v-model="device.deviceType" size="mini" :disabled="input_visible" clearable
                                           style="width: 200px;"
                                           placeholder="请选择设备类型">
                                    <el-option
                                            v-for="item in deviceTypeSelectList"
                                            :key="item.itemCode"
                                            :label="item.itemName"
                                            :value="item.itemCode"
                                    />
                                </el-select>
                            </el-form-item>
                        <div style="text-align: center;" v-show="point_input_visible">
                            <el-tooltip class="item" effect="dark" content="点击后在地图左键上选择坐标" placement="top-start">
                                <el-button @click="choicePoint" type="primary" size="mini" icon="el-icon-rank" circle></el-button>
                            </el-tooltip>
                            <label style="font-size: 12px;margin-left: 30px;color: green;">点击左侧按钮选择位置</label></div>
                        <el-form-item label="经度:" >
                            <el-input v-model="device.longitude" size="mini" style="width: 200px;margin-top: 5px" :disabled="true"></el-input>
                        </el-form-item>
                        <el-form-item label="纬度:" >
                            <el-input v-model="device.latitude" size="mini" style="width: 200px;margin-top: 5px" :disabled="true"></el-input>
                        </el-form-item>
                        <el-form-item><div>
                        </div>
                        </el-form-item>
                    </el-form>
                    <div class="handle_button_grp">
                        <el-button plain  type="success" ref="save" size="small" style="margin:10px 30px 10px 0px;" @click="deviceBodyPo">修改</el-button>
                        <el-button plain  type="warning" ref="delete" size="small"  @click="deleteDevice">删除</el-button>
                    </div>
                </el-card>
            </transition>
        </el-col>
    </el-row>
</div>


</body>

<%--<script src="${pageContext.request.contextPath}/static/hk/video/divscroll.js"></script>--%>
<%--<script src="${pageContext.request.contextPath}/static/hk/video/pageopt.js?time=1"></script>--%>
<%--<script src="${pageContext.request.contextPath}/static/hk/video/video.js?time=2"></script>--%>
<%--<script src="${pageContext.request.contextPath}/static/hk/video/isc/iscvideo_gis.js?time=1"></script>--%>
<%--<script src="${pageContext.request.contextPath}/static/hk/video/isc/jsencrypt.min.js"></script>--%>
<%--<script src="${pageContext.request.contextPath}/static/hk/video/isc/jsWebControl-1.0.0.min.js"></script>--%>
<script src="${pageContext.request.contextPath}/static/hk/gis_video/js/video.min.js"></script>
<script src="${pageContext.request.contextPath}/static/hk/gis_video/js/videojs-contrib-hls.js"></script>
<script></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/static/mp/js/map.js?time=5"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/mp/js/websoket.js?time=2"></script>

</html>
