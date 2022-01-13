//0啟動，1關閉
var isstart=0;
var tsxxLayer=0;
var fxwzLayer=0;
var cqyyLayer=0;
var user=top.user;
//初始化ocx
function getInitData() {
    var data = {
        buttons: [0, 1, 2, 3, 4,5,6,7,8,9],
        menus:[19,18,4,45,16,5,17,3,27]// [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        //buttons: [],
        //menus: []
    };

    var diskplaninfo = {};
    diskplaninfo.diskpolicytype = 3; //磁盘策略
    diskplaninfo.disklist = "D";     //磁盘列表
    diskplaninfo.diskdeltype = -1;   //删除类型
    var otherinfo = {};
    otherinfo.packtime = 1800;   //录像打包时长
    otherinfo.downloadPath = "D:\\DownLoadRecord\\";     //下载路径
    otherinfo.capture = "D:\\Capture\\";    //抓拍路径
    var info = {};
    info.username = "admin";
    info.password = "1111";
    info.client_sup_id = "devcms";
    info.dev_sup_id = "devcms";
    info.client_sup_ip = "10.1.128.46";
    info.client_sup_port = "8000";
    info.OcxType = 0;
    info.buttons = data.buttons;
    info.menus = data.menus;
    info.diskplaninfo = diskplaninfo;
    info.otherinfo = otherinfo;
    info.authority = 1;

    return info;
}


var param = '5';	//设置速度
var param2 = '0';	//设置预置位
var flag = '1';	//设置启停，默认时启动
var flagPreset = false;
function setParam1(paramValue) {
    param = document.getElementById("presetparam").value;
}
function setParam2() {
    // param2 = document.getElementById("setParam").value;

}

//开始预览视频方法
//参数：caption：通道1，dev_id：15，username：admin,password:1111,
//client_sup_id:dev1,dev_sup_id:dev1,client_sup_ip:220.220.220.66,client_sup_port:8000,ch:0,data_type:0
function startVideo() {

    //获取接口需设置参数
    var info = getGisVideoParam();

    var ret = document.getElementById("Video").StartVideo(info);

    if (ret != 0) {
        alert("ret != 0,视频连接失败！");
    }
    else {
        //添加查看视频日志
        JY.Ajax.doRequest(null, jypath + '/backstage/video/video_log/watchVideoes', {dev_id: objId}, function (data) {
            //alert("1");
        });
    }
}

//停止预览
function stopVideo() {

    var ret = document.getElementById("Video").StopVideo();
    //document.getElementById("showControl").style.display="none";
    if (ret != 0) {
        alert("停止预览失败！", ret);
    }
}
function ptzControl_2(cmd, start, power) { //cmd:控制码；param:速度；start:1开始，0停止; power:默认用户级别0(可以不传该字段)

    if(isstart==0){
        if (cmd == 8 || cmd == 9 || cmd == 39) {
            //setParam2();
            //alert(param2);
            "{\"cmd\":0,\"param\":0,\"start\":0,\"power\":0}"
            var paramInfo = "{\"cmd\":" + cmd + ",\"param\":" + param2 + ",\"start\":" + start + ",\"power\":" + power + "}";
            var ret = document.getElementById("Video").PtzControl(paramInfo);
            if (ret != 0) {
                alert("PTZ控制失败！", ret);
            }
            isstart=1;
        }
        else {
            //alert(param);
            "{\"cmd\":0,\"param\":0,\"start\":0,\"power\":0}"
            var paramInfo = "{\"cmd\":" + cmd + ",\"param\":" + param + ",\"start\":" + start + ",\"power\":" + power + "}";
            var ret = document.getElementById("Video").PtzControl(paramInfo);
            if (ret != 0) {
                alert("PTZ控制失败！", ret);
            }
            isstart=1;
        }
    }
    if(isstart==1){
        setTimeout(function(){
            "{\"cmd\":0,\"param\":0,\"start\":0,\"power\":0}"
            var paramInfo = "{\"cmd\":" + cmd + ",\"param\":" + param + ",\"start\":" + 0 + ",\"power\":" + power + "}";
            var ret = document.getElementById("Video").PtzControl(paramInfo);
            if (ret != 0) {
                alert("PTZ控制失败！", ret);
            }
            isstart=0;
        },1000)
    }


}

//设置预置位的调用方法
function  ptzControl_setyzw(cmd, start, power) {
    //首先先弹出确认提示框；确认之后，进行预置位设置；设置成功后，改变下拉框里面的内容
    var info1="";
    var info2="预置位"+param2;
    var dev_id=document.getElementById("Video").GetCurCameraObjId();
    if(dev_id=="-1" ) alert("请选择摄像头！");
    else {
        if(param2=="0")  alert("请选择预置位！");
        else {
            JY.Ajax.doRequest(null, jypath + '/backstage/yzw/yzwlog/find', {
                dev_id: dev_id,
                yzwinfo: info2
            }, function (data) {
                var result = data.obj;
                if (result != null) {
                    info1 = info2 + "目前预置位由：" + result.loginname + "于：" + JY.Date.Default(result.createtime) + "进行了设置，你确实要重新设置此预置位吗？"

                    if (window.confirm(info1)) {
                        ptzcontrol_2(cmd, start, power);
                        return true;
                    }
                    else {
                        //alert("取消");
                        return false;
                    }

                }
                else {
                    ptzcontrol_2(cmd, start, power);
                }
            });
        }
    }
}

//预置位设置事件
function  ptzcontrol_2(cmd,start,power) {
    if(param2=="0")  alert("请选择预置位！");
    else {
        var paramInfo = "{\"cmd\":" + cmd + ",\"param\":" + param2 + ",\"start\":" + start + ",\"power\":" + power + "}";
        var ret = document.getElementById("Video").PtzControl(paramInfo);
        if (ret != 0) {
            alert("PTZ控制失败！", ret);
        }
        else{
            if(cmd=="8"){   alert("预置位设置成功！");}

            var deviceid =document.getElementById("Video").GetCurCameraObjId();// document.getElementById("Video").GetCurCameraObjId();
            var a="";// device_id,yzw1,yzw2
            var sl=$("#setparam");
            var ops=sl.find("option");
            if(param2=="1")
            {
                JY.Ajax.doRequest(null, jypath + '/backstage/yzw/yzwinfo/update', {device_id: deviceid,yzw1:"1"}, function (data) {
                    var res = data.obj;
                    ops.eq(1).text("预置位1（已设置）");
                });
            }
            else if(param2=="2")
            {
                JY.Ajax.doRequest(null, jypath + '/backstage/yzw/yzwinfo/update', {device_id: deviceid,yzw2:"1"}, function (data) {
                    var res = data.obj;
                    ops.eq(2).text("预置位2（已设置）");
                });
            }

            else if(param2=="3")  {
                JY.Ajax.doRequest(null, jypath + '/backstage/yzw/yzwinfo/update', {device_id: deviceid,yzw3:"1"}, function (data) {
                    var res = data.obj;
                    ops.eq(3).text("预置位3（已设置）");
                });
            }

            else if(param2=="4")  {
                JY.Ajax.doRequest(null, jypath + '/backstage/yzw/yzwinfo/update', {device_id: deviceid,yzw4:"1"}, function (data) {
                    var res = data.obj;
                    ops.eq(4).text("预置位4（已设置）");
                });
            }

            else if(param2=="5")  {
                JY.Ajax.doRequest(null, jypath + '/backstage/yzw/yzwinfo/update', {device_id: deviceid,yzw5:"1"}, function (data) {
                    var res = data.obj;
                    ops.eq(5).text("预置位5（已设置）");
                });
            }

            else if(param2=="6")  {
                JY.Ajax.doRequest(null, jypath + '/backstage/yzw/yzwinfo/update', {device_id: deviceid,yzw6:"1"}, function (data) {
                    var res = data.obj;
                    ops.eq(6).text("预置位6（已设置）");
                });
            }

            else if(param2=="7")  {
                JY.Ajax.doRequest(null, jypath + '/backstage/yzw/yzwinfo/update', {device_id: deviceid,yzw7:"1"}, function (data) {
                    var res = data.obj;
                    ops.eq(7).text("预置位7（已设置）");
                });
            }

            else if(param2=="8")   {
                JY.Ajax.doRequest(null, jypath + '/backstage/yzw/yzwinfo/update', {device_id: deviceid,yzw8:"1"}, function (data) {
                    var res = data.obj;
                    ops.eq(8).text("预置位8（已设置）");
                });
            }


        }
    }
}
//云台控制
function  ptzControl(cmd,start,power){
    var res= document.getElementById("Video").GetCurCameraObjId();
    if(res=="-1"){
        alert("请先选择摄像头！");

    }
    else {
        if (!(cmd == 8 || cmd == 9 || cmd == 39)) //注意此处加了！，表示预置位设置除外
        {

            var paramInfo = "{\"cmd\":" + cmd + ",\"param\":" + param + ",\"start\":" + start + ",\"power\":" + power + "}";
            var ret = document.getElementById("Video").PtzControl(paramInfo);
            if (ret != 0) {
                alert("PTZ控制失败！", ret);
            }

        } else {
            if (param2 == "0"||param2 == "无") alert("请选择预置位！");
            else
            {
                var paramInfo = "{\"cmd\":" + cmd + ",\"param\":" + param2 + ",\"start\":" + start + ",\"power\":" + power + "}";
                var ret = document.getElementById("Video").PtzControl(paramInfo);
                if (ret != 0) {
                    alert("PTZ控制失败！", ret);
                }
            }
        }
    }
}

function ptz_1204(obj) {
    var ret = document.getElementById("Video").GetCurCameraObjId();
    if(ret=="-1"){
        alert("请先选择摄像头！");

    }
    else {
        if(obj.value=="开启激光"){
            ptzControl(1204,1);
            obj.value="关闭激光";
        }
        else if(obj.value=="关闭激光"){
            ptzControl(1204,0);
            obj.value="开启激光";
        }
    }
}
//分屏
function SetScreen(x, y, z) {
    var ret = document.getElementById("Video").SetScreenStyle(x, y, z);
    if (ret != 0) {
        alert("分屏失败！", ret);
    }
}

//全部抓拍
function CaptureAll(path) {
    var ret = document.getElementById("Video").CaptureAll(path);

    if (ret != 0) {
        alert("抓拍失败！", ret);
    }
    else { alert("抓拍成功，保存位置为：D://capture！"); }
}
//单个抓拍
function Capture(path){
    var ret1 = document.getElementById("Video").GetCurCameraObjId();
    if(ret1=="-1"){
        alert("请先选择摄像头！");
    }
    else
    {
        var ret = document.getElementById("Video").Capture(path);
        if (ret != 0) {
            alert("抓拍失败！", ret);
        }
        else { alert("抓拍成功，保存位置为：D://capture！"); }
    }
}

function StartRecord() {

    var ret = document.getElementById("Video").GetCurCameraObjId();
    if(ret=="-1"){
        alert("请先选择摄像头！");

    }
    else {
        var ret = document.getElementById("Video").StartRecord();
        if (ret != 0) {
            alert("开始录像！", ret);
        }
    }
}

function StopRecord() {
    var ret = document.getElementById("Video").StopRecord();
    if (ret != 0) {
        alert("开始录像！", ret);
    }
}
function StartAllRecord() {
    var ret = document.getElementById("Video").StartAllRecord();
    if (ret != 0) {
        alert("全部开始录像！", ret);
    }
}

function StopSwitchTemplate() {
    if(document.getElementById("Video").GetCurCameraObjId()!="-1") {
        var ret = document.getElementById("Video").Capture("D://capture");
        if (ret != 0) {
            alert("抓拍失败！", ret);
        }
        else {
            alert("抓拍成功");
        }
        //加载疑似违章
        fxwzLayer= JY.Model.layer("auDiv","",function() {},"630px");
        //清空控件数据，设置默认值，根据deviceID查询
        $("#auForm input").val("");
        $("#auForm textarea").val("");
        $("#xctp").attr("src","")
        selFXWZ();
    }
    else{
        alert("请选择摄像头");
    }

}
function selFXWZ(){
    JY.Ajax.doRequest(null, jypath + '/backstage/bsi/devicemanage/find', {dev_id: getCurCameraObjId()}, function (data) {
        var res=data.obj;
        //加载抓拍图片路径
        var now=(new Date()).Format("yyyy-MM-dd hh:mm:ss");
        $("#auForm input[name=wzdate]").val(now);
        $(".yqend").val(addDay(4,new Date())+" 23:59:59");
        $("#ip_addressForm input[name=ip_address]").val(res.conn_ip);
        JY.Ajax.doRequest("ip_addressForm", jypath + '/backstage/wz/wz/screenshot',null, function (imgurl) {
            $("#auForm input[name=picurl]").val(imgurl.obj);
        },false);
        //根据组织机构编号加载组织机构名称
        var depid=res.depid;
        var zTree = $.fn.zTree.getZTreeObj("tree_project");
        var orgUrl = "宝钢股份/" + zTree.getNodesByParam("id",depid.substr(0, 3), null)[0].name;
        if(zTree.getNodesByParam("id",depid.substr(0, 3), null)[0].name!="电厂") {
            orgUrl += "/" + zTree.getNodesByParam("id", depid.substr(0, 5), null)[0].name;
        }
        orgUrl+="/" + zTree.getNodesByParam("id",depid.substr(0,7), null)[0].name;
        //orgUrl+="/" + res.device_bh;
        $("#auForm input[name=company]").val(orgUrl);
        //加载安装位置
        $("#auForm input[name=location]").val(res.location);
        var url= $("input[name=picurl]").val();
        //显示抓拍缩略图
        $("#xctp").attr("src",jypath+url);
        //如果相关设备中有负责人直接显示，没有从用户表查询
        if(res.duty_name!=""&&res.duty_name!=undefined) {
            $("#pushperson").val(res.duty_name + "(" + res.duty_num + ")");
            $("#auForm input[name=pushperson]").val(res.duty_num);
        }
        else {
            tsxx_Search(1);
        }
    });
}
function SetCustomize() {

    var info = {
        "Buttons":
            [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
        "Menus":
            [0, 1, 2, 15],
    };
    var ret = document.getElementById("Video").SetCustomize(info);
    if (ret != 0) {
        alert("格式化成功！", ret);
    }
    else {
        alert("格式化失败！", ret);
    }


}

function  getCurCameraObjId() {
    var ret = document.getElementById("Video").GetCurCameraObjId();
    return ret;
}

$(function(){
    //$("#tsxx_BackBtn").click(function(){
    //    layer.close(tsxxLayer);
    //    $("#tsxxDiv").addClass("hide");
    //})
    //推送至弹出框
    $(".tsz-input").click(function(){
        $("#tsxxForm input[name$='depname']").val("");
        $("#tsxxForm input[name$='depid']").val("");
        tsxxLayer=JY.Model.layer("tsxxDiv","",function() {},"630px");
        tsxx_Search(1);
    })
    //推送站内信
    $("#tsxx-table").delegate("tr","click",function() {
        var jobno=$(this).find("td:eq(1)").text();
        var name=$(this).find("td:eq(2)").text();
        $("#pushperson").val(name+"("+jobno+")");
        $("#auForm input[name=pushperson]").val(jobno);
        layer.close(tsxxLayer);
        $("#tsxxDiv").addClass('hide');
    })
    //$("#tsxx_ComfirmBtn").click(function(){
    //    var name="";hiddenjob="";
    //    $("#tsxxForm input[type='checkbox']").each(function(i){
    //        if($(this).is(':checked')){
    //            var tr= $(this).parent().parent().parent();
    //            name += $(tr).find("td:eq(3)")[0].innerText+"("+$(tr).find("td:eq(2)")[0].innerText+")；";
    //            hiddenjob +=$(tr).find("td:eq(2)")[0].innerText+"；";
    //        }
    //    })
    //    $("#pushperson").val(name.substr(0,name.length-1));
    //    $("#auForm input[name=pushperson]").val(hiddenjob.substr(0,hiddenjob.length-1));
    //    layer.close(tsxxLayer);
    //    $("#tsxxDiv").addClass('hide');
    //})
    $(".button-f1").click(function() {
        var ret=getCurCameraObjId();
        if(ret!=-1) {
            var reason=$("#auForm input[name=delayReason]").val()||"";
            var now=(new Date()).Format("yyyy-MM-dd");//开始日期
            var end=$(".yqend").val();
            var days=DateDiff(now,end.split(" ")[0]);
            if(days>4&&days<=10&&reason=="") {
               $("#auForm input[name=delayReason]").val("");
                cqyyLayer=JY.Model.layer("cqyyDiv","",function() {},"430px");
                return;
            }
            //if(days>10)  {
            //    JY.Model.info("预期完成日期不能超过10天", function () {});
            //    return;
            //}
            if (JY.Validate.form("auForm")) {
                var imgpath=jypath+'/static/images/img-bk.png';
                var obj = {"wzdate": $("input[name=wzdate]").val(), "info1": ret};
                JY.Ajax.doRequest(null, jypath + '/backstage/wz/wz/check', obj, function (data) {
                    var wzinfos = data.obj;
                    if(wzinfos.length>0){
                        JY.Model.layer("imgValidation", "", function () {
                        }, "1065px");
                        if(wzinfos.length==1){
                            $("#yjtp_more").addClass("hide");
                            $("#yjtp_single").removeClass("hide");
                            $("#yjtp_single img").attr("src",wzinfos[0].picurl==""?imgpath:wzinfos[0].picurl);
                            $("#yjtp_single span:eq(1)").text(wzinfos[0].finder);
                            $("#yjtp_single span:eq(3)").text(JY.Date.Default(wzinfos[0].createtime));
                            $("#yjtp_single span:eq(5)").text(wzinfos[0].pushpersonName);
                          //$("#yjtp_single img").attr("src", jypath + '/static/images/hua.jpg');
                        }
                        else {
                            $("#yjtp_single").addClass("hide");
                            $("#yjtp_more").removeClass("hide");
                            $("#yjtp_more div").remove();
                            var str="";
                            $.each(wzinfos,function(i,obj){
                                if(i > 3) return true;
                                var picurl=obj.picurl==""?imgpath:obj.picurl;
                                str+='<div class="col-lg-6" ><div style="border:1px solid black;width:338px;margin-bottom:3px;" >'
                                    +'<img src="'+picurl+'" style="width:335px;height: auto;"><div style="background-color: rgba(227, 227, 227, 0.5);">'
                                    +'<span>发现人：</span><span>'+obj.finder+'</span>&nbsp;&nbsp;<span>抓拍时间：</span>'+obj.finder+'<span></span>&nbsp;&nbsp;'
                                    +'<span>推送至：</span><span>'+obj.pushpersonName+'</span></div></div></div>';
                            })
                            var length=$(str).length;
                            if(length==2) {
                                str += '<div class="col-lg-6" ><div style="border:1px solid black;width:338px;margin-bottom:3px;" >'
                                    + '<img src="'+imgpath+'" style="width:335px;height: auto;"><div style="background-color: rgba(227, 227, 227, 0.5);">'
                                    + '<span>发现人：</span><span></span>&nbsp;&nbsp;<span>抓拍时间：</span><span></span>&nbsp;&nbsp;'
                                    + '<span>推送至：</span><span></span></div></div></div>';
                                str += '<div class="col-lg-6" ><div style="border:1px solid black;width:338px;margin-bottom:3px;" >'
                                    + '<img src="'+imgpath+'" style="width:335px;height: auto;"><div style="background-color: rgba(227, 227, 227, 0.5);">'
                                    + '<span>发现人：</span><span></span>&nbsp;&nbsp;<span>抓拍时间：</span><span></span>&nbsp;&nbsp;'
                                    + '<span>推送至：</span><span></span></div></div></div>';
                            }
                            if(length==3) {
                                str += '<div class="col-lg-6" ><div style="border:1px solid black;width:338px;margin-bottom:3px;" >'
                                    + '<img src="'+imgpath+'" style="width:335px;height: auto;"><div style="background-color: rgba(227, 227, 227, 0.5);">'
                                    + '<span>发现人：</span><span></span>&nbsp;&nbsp;<span>抓拍时间：</span><span></span>&nbsp;&nbsp;'
                                    + '<span>推送至：</span><span></span></div></div></div>';
                            }
                            $("#yjtp_more").append(str);
                        }
                         $("#newImg").attr("src",$("#xctp").attr("src")==""?imgpath:$("#xctp").attr("src"));
                        // $("#newImg").attr("src", jypath + '/static/images/hua1.jpg');
                        $("#newimg-block span:eq(1)").text(wzinfos[0].finder);
                        $("#newimg-block span:eq(3)").text(JY.Date.Default(wzinfos[0].createtime));
                        $("#newimg-block span:eq(5)").text(wzinfos[0].pushpersonName);
                    }else {
                        $("#auForm input[name=status]").val("0");
                        if($("#phone-check").is(":checked"))
                            $("#auForm input[name=phoneWarning]").val("1");
                        else
                            $("#auForm input[name=phoneWarning]").val("0");
                        $("#auForm input[name=info1]").val(ret);
                        JY.Ajax.doRequest("auForm", jypath + '/backstage/wz/wz/add',"", function (data) {
                            layer.closeAll();
                            $("#auDiv").addClass('hide');
                            JY.Model.info("属于新的违章事件，提交成功！", function () {});
                        });
                    }
                })
            }
        }else{
            JY.Model.info("请选择已开启的视频！", function () {
            });
        }
    })
    $("#bcftjBtn").click(function(){
        var ret=getCurCameraObjId();
        if(ret!=-1) {
            $("#auForm input[name=status]").val("1");
            if($("#phone-check").is(":checked"))
                $("#auForm input[name=phoneWarning]").val("1");
            else
                $("#auForm input[name=phoneWarning]").val("0");
            $("#auForm input[name=info3]").val("4");
            $("#auForm input[name=info1]").val(ret);
            JY.Ajax.doRequest("auForm", jypath + '/backstage/wz/wz/add', "", function (data) {
                JY.Model.info("属于同一违章事件，不再重复提交！", function () {});
                layer.closeAll();
                $("#imgValidation").addClass('hide');
            });
        }else{
            JY.Model.info("请选择已开启的视频！", function () {
            });
        }
    })
    $("#rrtjBtn").click(function(){
        var ret=getCurCameraObjId();
        if(ret!=-1) {
            $("#auForm input[name=status]").val("0");
            if($("#phone-check").is(":checked"))
                $("#auForm input[name=phoneWarning]").val("1");
            else
                $("#auForm input[name=phoneWarning]").val("0");

            $("#auForm input[name=info1]").val(ret);
            JY.Ajax.doRequest("auForm", jypath + '/backstage/wz/wz/add',"", function (data) {
                JY.Model.info("属于新的违章事件，提交成功！", function () {});
                layer.closeAll();
                $("#imgValidation").addClass('hide');
            });
        }else{
            JY.Model.info("请选择已开启的视频！", function () {
            });
        }
    })
})
function tsxx_Search(init) {
    if(init==1)$("#tsxxForm .pageNum").val(1);
    JY.Model.loading();

    JY.Ajax.doRequest("tsxxForm",jypath +'/backstage/account/findPushAcountByPage', {"dev_id":getCurCameraObjId()},function(data) {
        $("#tsxx-table tbody").empty();
        var obj=data.obj;
        var list=obj.list;
        var results=list.results;
        var pageNum=list.pageNum,pageSize=list.pageSize,totalRecord=list.totalRecord;
        var html="";
        if(results!=null&&results.length>0){
            $("#pushperson").val(results[0].name+"("+ results[0].loginName+")");
            $("#auForm input[name=pushperson]").val(results[0].loginName);
            var leng=(pageNum-1)*pageSize;//计算序号
            for(var i = 0;i<results.length;i++){
                var l=results[i];
                html += "<tr class='sheet-tr'>";
                //html += "<td class='center'><label> <input type='checkbox' name='ids'  class='ace' /> <span class='lbl'></span></label></td>";
                html += "<td class='center hidden-480'>" + (i+leng+1) + "</td>";
                html += "<td class='center'>" + JY.Object.notEmpty(l.loginName) + "</td>";
                html += "<td class='center'>" + JY.Object.notEmpty(l.name) + "</td>";
                html += "<td class='center'>" + JY.Object.notEmpty(l.depname) + "<span style='display:none;'>"+ l.depid+"</span></td>";
                html += "<td class='center'>" + JY.Object.notEmpty(l.title) + "</td>";
                html += "</tr>";
            }

            $("#tsxx-table tbody").append(html);
            JY.Page.setPage("tsxxForm","tsxx_pageing",pageSize,pageNum,totalRecord,"tsxx_Search");

        } else {
            html += "<tr><td colspan='5' class='center'>没有相关数据</td></tr>";
            $("#tsxx-table tbody").append(html);
        }
        JY.Model.loadingClose();
    });

}
function openImg(){
    var url= $("input[name=picurl]").val();
    $("#loadImg img").attr("src",jypath+url);
    JY.Model.layer("loadImg","",function() {},"680px");
    //layer.open({
    //    type: 1,
    //    title:"违章照片",
    //    area: ['700px', '500px'],
    //    fixed: true,
    //    //maxmin: true,
    //    content: $("#loadImg")
    //    //content:jypath +"/upload/img/20180411ae0509c6745c4078bb259a133e858429.jpg"
    //});
    //$(".layui-layer-title").css("display","none");
    //$(".layui-layer iframe").css("height","500px");
    //$("#auDiv iframe img").css("width","100%");
    //$("#auDiv iframe img").css("height","auto");
}
function getbaseList(init){
    if(init==1)$("#yzwForm .pageNum").val(1);
    JY.Model.loading();
    JY.Ajax.doRequest("yzwForm", jypath + '/backstage/yzw/yzwlog/findByPage',{dev_id:document.getElementById("Video").GetCurCameraObjId()}, function (data) {
        $("#yzw-table tbody").empty();
        var obj = data.obj;
        var list = obj.list;
        var results = list.results;
        var permitBtn = obj.permitBtn;
        var pageNum = list.pageNum, pageSize = list.pageSize, totalRecord = list.totalRecord;
        var html = "";
        if (results != null && results.length > 0) {
            var leng = (pageNum - 1) * pageSize;//计算序号
            for (var a = 0; a < results.length; a++) {
                var l = results[a];
                html += "<tr class='sheet-tr'>";
                html += "<td class='center hidden-480'>" + (a + leng + 1) + "</td>";
                var zTree = $.fn.zTree.getZTreeObj("tree_project");
                var devive_name= zTree.getNodesByParam("id", l.dev_id, null)[0].name;
                html += "<td class='center'>"+devive_name+"</td>";
                html += "<td class='center'>"+JY.Object.notEmpty(l.yzwinfo)+"</td>";
                html += "<td class='center'>"+JY.Date.Default(l.createtime)+"</td>";
                html += "<td class='center'>"+JY.Object.notEmpty(l.loginname)+"</td>";
                html += "</tr>";
            }
            $("#yzw-table tbody").append(html);
            JY.Page.setPage("yzwForm", "pageing", pageSize, pageNum, totalRecord, "getbaseList");
        } else {
            html += "<tr><td colspan='7' class='center'>没有相关数据</td></tr>";
            $("#yzw-table tbody").append(html);
            $("#pageing ul").empty();//清空分页
        }
        JY.Model.loadingClose();
    });
}
function selYZW(){
    var ret1 = document.getElementById("Video").GetCurCameraObjId();
    if(ret1=="-1"){
        alert("请先选择摄像头！");
    }
    else{
        getbaseList();
        JY.Model.layer("yzwDiv","",function() {},"630px");
    }
}
function DateDiff(sDate1, sDate2) {  //sDate1和sDate2是yyyy-MM-dd格式

    var aDate, oDate1, oDate2, iDays;
    aDate = sDate1.split("-");
    oDate1 = new Date(aDate[1] + '-' + aDate[2] + '-' + aDate[0]);  //转换为yyyy-MM-dd格式
    aDate = sDate2.split("-");
    oDate2 = new Date(aDate[1] + '-' + aDate[2] + '-' + aDate[0]);
    iDays = parseInt(Math.abs(oDate1 - oDate2) / 1000 / 60 / 60 / 24); //把相差的毫秒数转换为天数

    return iDays;  //返回相差天数
}
function addDay(dayNumber, date) {
    var ms = dayNumber * (1000 * 60 * 60 * 24);
    var newDate = new Date(date.getTime() + ms).Format("yyyy-MM-dd");
    return newDate;
}
$(function(){
    $("#setparam").change(function (){
        param2=$("#setparam option:selected").val();
    })
})
//function loadOrgTree(flag){
//    $("#treeDiv"+flag).removeClass("hide");
//    JY.Ajax.doRequest(null,jypath +'/backstage/org/role/getPreOrgTree',null,function(data){
//        var res=data.obj;
//        var newTree=[];
//        newTree.splice(0,newTree.length);
//        $.each(res,function(i,obj){
//            newTree.push(obj);
//        })
//        $("#treeDiv"+flag).removeClass("hide");
//
//        $.fn.zTree.init($("#orgTree"+flag), {
//            view: {selectedMulti: false, fontCss: {color: "#393939"}},
//            data: {simpleData: {enable: true}},
//            callback: {onClick: clickOrg}
//        }, newTree);
//        var treeObj = $.fn.zTree.getZTreeObj("orgTree"+flag);
//        var nodes = treeObj.getNodes();
//        if(nodes.length>0){
//            //默认选中第一个
//            treeObj.selectNode(nodes[0]);
//        }
//
//    });
//}
//function clickOrg(e, treeId, treeNode) {
//    $("#tsxxForm input[name$='depname']").val(treeNode.name);
//    $("#tsxxForm input[name$='depid']").val(treeNode.id);
//    $(".div-tree").addClass("hide");
//}
function sureCqyy(){
    var reason=$("#reason").val()||"";
    if(reason!="") {
        reason =user + "在" + (new Date()).Format("yyyy-MM-dd hh:mm:ss") +"填写超出4天原因"+reason;
    }
   $("#auForm input[name=delayReason]").val(reason);
    layer.close(cqyyLayer);
    $("#cqyyDiv").addClass("hide");
}
function cancelCqyy(){
   $("#auForm input[name=delayReason]").val("");
    layer.close(cqyyLayer);
    $("#cqyyDiv").addClass("hide");
}
//推送到本人
function tsdbr(){
    JY.Ajax.doRequest(null,jypath +'/backstage/account/find',{"loginName":user},function(data) {
        var res = data.obj;
        $("#pushperson").val(res.name+"("+user+")");
        $("#auDiv input[name=pushperson]").val(user);
    })
}