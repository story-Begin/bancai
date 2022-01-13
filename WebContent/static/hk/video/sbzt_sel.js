var bjlx=[];
var arr_data=[];
var state=0;
$(function () {
    selbaseList(1);

    //增加回车事件
    //$("#baseForm").keydown(function(e){
    //    keycode = e.which || e.keyCode;
    //    if (keycode==13) {
    //        getbaseList(1);
    //    }
    //});
    $("#sheet-table").delegate(".onLine","click",function(){
        var value=$(this).text()||"";
        if(value!="") {
            $("#depid-input").val(value.split("|")[1]);
        }
        state="1";
        getbaseList(1);
    })
    $("#sheet-table").delegate(".offLine","click",function(){
        var value=$(this).text()||"";
         if(value!="") {
            $("#depid-input").val(value.split("|")[1]);
        }
        state="5";
        getbaseList(1);
    })
    $(".valert-close").click(function(){
        $("#auDiv").css("display","none");
    })
    $(".cancel").click(function(){
        $("#treeDiv1").addClass("hide");
    })
})

function selbaseList(init){

    JY.Model.loading();

    JY.Ajax.doRequest(null,jypath +'/backstage/bgwbhy/video/findVideoCountsByStatus',null,function(data) {
        $("#sheet-table tbody").empty();
        var arr_objs=data.obj;
        for(var j=0;j<arr_objs.length;j++) {
            arr_data.push(arr_objs[j]);
        }
        if(arr_data!=null&&arr_data.length>0) {
            html="";
            for (var i = 0; i < arr_data.length; i++) {
                var nodeId = arr_data[i].depid;
                var name = arr_data[i].depname == "宝钢股份" ? "宝钢股份" : "宝钢股份/" + arr_data[i].depname;
                html+="<tr class='sheet-tr'>";
                html+="<td class='center hidden-480'>"+(i+1)+"</td>";
                html+="<td class='center'>"+name+"</td>";
                var numstr="";
                // if(nodeId!=""&&nodeId!=undefined) numstr=getNum(nodeId);
                html+="<td class='center'><div class='onLine'><a style='cursor:pointer' >"+arr_data[i].online_count +"</a><span style='display:none;'>|"+nodeId+"</span></div></td>";
                html+="<td class='center'><div class='offLine'><a style='cursor:pointer' >"+arr_data[i].offline_count +"</a><span style='display:none;'>|"+nodeId+"</span></div></td>";
                html+="</tr>";
            }
            $("#sheet-table tbody").append(html);
        }else{
            html+="<tr><td colspan='5' class='center'>没有相关数据</td></tr>";
            $("#sheet-table tbody").append(html);
        }
        JY.Model.loadingClose();
    })

}
// function getNum(nodeId){
//     var str="";
//     JY.Ajax.doRequest(null,jypath +'/backstage/bgwbhy/video/findByPage',{depid:nodeId},function(data) {
//         var obj=data.obj;
//         str=obj.online_num+"|"+obj.offline_num;
//     },false);
//     return str;
// }
function resetControl(control){
    if(control==null)
        $("input").val("");
    else
        $(control).parent().find("input").val("");
}

function getbaseList(init) {
    //JY.Model.layer("auDiv", "", function () {}, "700px");
    $("input[name=depname]").val("")
    $("#auDiv").css("display","block");
    $("#treeDiv1").addClass("hide");
    if (init == 1)$("#baseForm .pageNum").val(1);
    JY.Model.loading();
    $("#baseForm input[name=depid]").val($("#depid-input").val());
    JY.Ajax.doRequest("baseForm", jypath + '/backstage/bgwbhy/video/findByPage', {state:state}, function (data) {
        $("#custom-table tbody").empty();
        var obj = data.obj;
        var list = obj.list;
        var results = list.results;
        var pageNum = list.pageNum, pageSize = list.pageSize, totalRecord = list.totalRecord;
        var html = "";
        if (results != null && results.length > 0) {
            var leng = (pageNum - 1) * pageSize;//计算序号
            for (var i = 0; i < results.length; i++) {
                var l = results[i];

                html += "<tr class='sheet-tr'>";
                html += "<td class='center'>" + (i + leng + 1) + "</td>";
                html += "<td class='center'>" + JY.Object.notEmpty(l.device_depname)+ "</td>";
                html += "<td class='center'>" + JY.Object.notEmpty(l.device_bh) + "</td>";
                html += "<td class='center'>" + JY.Object.notEmpty(l.device_type) + "</td>";
                html += "<td class='center'>" + JY.Object.notEmpty(l.device_location) + "</td>";
                html += "<td class='center'>" + JY.Object.notEmpty(l.device_conn_ip) + "</td>";
                html += "<td class='center'>" + JY.Object.notEmpty(l.device_caption) + "</td>";
                html += "</tr>";

            }
            $("#custom-table tbody").append(html);
            JY.Page.setPage("baseForm", "pageing", pageSize, pageNum, totalRecord, "getbaseList");
        } else {
            html += "<tr><td colspan='8' class='center'>没有相关数据</td></tr>";
            $("#custom-table tbody").append(html);
            $("#pageing ul").empty();//清空分页
        }
        JY.Model.loadingClose();
    });

}

function getOrgName(depid){
    var name="";
    JY.Ajax.doRequest(null,jypath +'/backstage/org/role/getPreOrgTree',null,function(data) {
        var treeObj_arr=data.obj;
        for (var i = 0; i < treeObj_arr.length; i++) {
            var nodeId = treeObj_arr[i].id;
            if (nodeId == depid) {
                name = treeObj_arr[i].name;
                break;
            }
        }
    },false);
    return name;
}

function loadOrgTree(flag){
    JY.Ajax.doRequest(null,jypath +'/backstage/bgwbhy/video/getPreOrgTree',null,function(data){
        var res=data.obj;
        var newTree=[];
        newTree.splice(0,newTree.length);
        var depid=$("#depid-input").val();
        $.each(res,function(i,obj){
            // if(depid=="1")  newTree.push(obj);
            // else {
            //     if ((obj.id).substr(0, 3) == depid || obj.pId == "0")
                newTree.push(obj);
            // }
        })
        $("#treeDiv"+flag).removeClass("hide");

        $.fn.zTree.init($("#orgTree"+flag), {
            view: {selectedMulti: false, fontCss: {color: "#393939"}},
            data: {simpleData: {enable: true}},
            callback: {onClick: clickOrg}
        }, newTree);
        var treeObj = $.fn.zTree.getZTreeObj("orgTree"+flag);
        var nodes = treeObj.getNodes();
        if(nodes.length>0){
            //默认选中第一个
            treeObj.selectNode(nodes[0]);
        }

    });
}
function clickOrg(event,treeId,treeNode) {
    $("#baseForm input[name$='depname']").val(treeNode.name);
    $("#baseForm input[name$='depid']").val(treeNode.id);
    $("#treeDiv1").removeClass("hide");
}