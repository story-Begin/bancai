
var param = '4';	//设置速度;//速度

var btnFlag=0;
function setParam1(paramValue) {
    param = document.getElementById("presetparam").value;
}


function openImg(){
    var url= $("input[name=picurl]").val();
    $("#loadImg img").attr("src",jypath+url);
    JY.Model.layer("loadImg","",function() {},"680px");
    }
function selVideoData(cameraCode,loginname){
    var fxwzLayer= JY.Model.layer("auDiv","",function() {},"630px");
    JY.Ajax.doRequest(null, jypath + '/backstage/bgwbhy/video/find', {info3: cameraCode}, function (data) {
        var res = data.obj;
        var now = (new Date()).Format("yyyy-MM-dd hh:mm:ss");
        $("#auForm input[name=tfdate]").val(now);
        $("#auForm input[name=dev_id]").val(cameraCode);
        $("#auForm input[name=status]").val('0');
        $("#auForm input[name=location]").val(res.device_location);
        // JY.Ajax.doRequest(null, jypath + '/backstage/wz/wz/screenshot', {dev_id: getCurCameraObjId()}, function (imgurl) {
        //     $("#auForm input[name=picurl]").val(imgurl.obj);
        // }, false);
        //根据组织机构编号加载组织机构名称
        var depid = res.device_depid;
        var zTree = $.fn.zTree.getZTreeObj("tree_project");
        var orgUrl = "宝钢股份/" + zTree.getNodesByParam("id", depid.substr(0, 8), null)[0].name;
        orgUrl += "/" + zTree.getNodesByParam("id", depid, null)[0].name;
        $("#auForm input[name=workinfo_id]").val(res.device_depid);
        $("#auForm input[name=workinfo_name]").val(orgUrl);
        logininfo(loginname);
        // var url = $("input[name=picurl]").val();
        // //显示抓拍缩略图
        // $("#xctp").attr("src", jypath + url);

    })
}
//获取登录人员信息发现人
function logininfo(loginname){
    JY.Ajax.doRequest(null,jypath +'/backstage/account/find',{"loginName":loginname},function(data) {
        var res = data.obj;
        $("#auDiv input[name=finder]").val(res.name+"("+loginname+")");
    })
}
//推送到本人
function tsdbr(loginname){
    JY.Ajax.doRequest(null,jypath +'/backstage/account/find',{"loginName":loginname},function(data) {
        var res = data.obj;
        $("#auDiv input[name=pushperson]").val(res.name+"("+loginname+")");
    })
}
function tsxx_Search(init) {
    if(init==1)$("#tsxxForm .pageNum").val(1);
    JY.Model.loading();
    JY.Ajax.doRequest("tsxxForm",jypath +'/backstage/account/findByPage',null,function(data) {
        $("#tsxx-table tbody").empty();
        var obj=data.obj;
        var list=obj.list;
        var results=list.results;
        var pageNum=list.pageNum,pageSize=list.pageSize,totalRecord=list.totalRecord;
        var html="";
        if(results!=null&&results.length>0){
            // $("#pushperson").val(results[0].name+"("+ results[0].loginName+")");
            // $("#auForm input[name=pushperson]").val(results[0].loginName);
            var leng=(pageNum-1)*pageSize;//计算序号
            for(var i = 0;i<results.length;i++){
                var l=results[i];
                html += "<tr class='sheet-tr'>";
                //html += "<td class='center'><label> <input type='checkbox' name='ids'  class='ace' /> <span class='lbl'></span></label></td>";
                html += "<td class='center hidden-480'>" + (i+leng+1) + "</td>";
                html += "<td class='center'>" + JY.Object.notEmpty(l.loginName) + "</td>";
                html += "<td class='center'>" + JY.Object.notEmpty(l.name) + "</td>";
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
//开始云台控制
//向上转-21;向下-22；向左-23；向右-24；向左上角-25；向右下角-26；向左下角-27；向右下角-28；自动扫描-29
//镜头拉近-11;镜头拉远-12;焦距调大-13;焦距后调-14;光圈扩大-15;光圈缩小-16;云台锁定-200；3D放大-99
function StartPtzCtrl(vCommand){
    var ocxObj = document.getElementById("spv");
    // var vCommand = $('#PtzCommand option:selected').val();
    //  var vSpeed = $('#PtzSpeed option:selected').val();
    var ret = ocxObj.MPV_PTZCtrl(-1, 0, parseInt(vCommand, 10), parseInt(param, 10));
    if (ret != 0){
        alert("选中窗口开始云台控制失败！");
    }
}
//停止云台控制
//MPV_PTZCtrl(LONG lWndIndex, LONG lAction, LONG lCommond, LONG lSpeed)
function StopPtzCtrl(vCommand){
    // $('#selectPosition option:selected').val()
    var ocxObj = document.getElementById("spv");
    // var vCommand = $('#PtzCommand option:selected').val();
    //  var vSpeed = $('#PtzSpeed option:selected').val();
    var ret = ocxObj.MPV_PTZCtrl(-1, 1, parseInt(vCommand, 10), parseInt(param, 10));
    if (ret != 0){
        alert("选中窗口停止云台控制失败");
    }
}

//设置对接设备的参数
function SetDeviceParam(){
    var ocxObj = document.getElementById("spv");
    var xml = '<?xml version="1.0" encoding="UTF-8"?> ' +
        '<localParam> ' +
        '<deviceUUid>e60b2bc04e87480ea4785256e9e0ee70</deviceUUid>' +
        '</localParam>';
    var ret = ocxObj.MPV_SetLocalParam(xml);
    if (ret != 0) {
        alert("设置设备参数失败");
    }
}


//设置分屏数
function SetScreen(lPlayWndCount) {
    var ocxObj = document.getElementById("spv");
    var ret = ocxObj.MPV_SetPlayWndCount(lPlayWndCount);
    if (ret != 0){
        alert("分屏失败！");
    }
}

