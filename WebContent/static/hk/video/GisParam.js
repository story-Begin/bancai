var dev_id='';
var username='';
var password='';
var client_sup_id='';
var dev_sup_id='';
var client_sup_ip='';
var client_sup_port='';
var ch='';
var caption='';
var data_type='';

//设置视频浏览需要的参数
function getGisVideoParam(){
    dev_id = document.getElementById("dev_id").value;
    if(dev_id==null||dev_id==""){
        alert("设备ID不能为空！");
        document.getElementById("dev_id").focus();
        return;
    }
    username = document.getElementById("username").value;
    password = document.getElementById("password").value;
    client_sup_id = document.getElementById("client_sup_id").value;
    if(client_sup_id==null||client_sup_id==""){
        alert("客户端接入服务器ID不能为空！");
        document.getElementById("client_sup_id").focus();
        return;
    }
    dev_sup_id = document.getElementById("dev_sup_id").value;
    if(dev_sup_id==null||dev_sup_id==""){
        alert("设备端接入服务器ID不能为空！");
        document.getElementById("dev_sup_id").focus();
        return;
    }
    client_sup_ip = document.getElementById("client_sup_ip").value;
    if(client_sup_ip==null||client_sup_ip==""){
        alert("客户端接入服务器IP不能为空！");
        document.getElementById("client_sup_ip").focus();
        return;
    }
    client_sup_port = document.getElementById("client_sup_port").value;
    if(client_sup_port==null||client_sup_port==""){
        alert("客户端接入服务器端口不能为空！");
        document.getElementById("client_sup_port").focus();
        return;
    }
    ch = document.getElementById("ch").value;
    if(ch==null||ch==""){
        alert("通道号不能为空！");
        document.getElementById("ch").focus();
        return;
    }
    caption = document.getElementById("caption").value;
    //if(caption==null||caption==""){
    //	alert("通道名不能为空！");
    //	document.getElementById("caption").focus();
    //	return;
    //}
    data_type = document.getElementById("data_type").value;
    //document.getElementById("showControl").style.display="";
    var GisVideoInfo = {
        "caption":caption,
        "dev_id":dev_id,
        "username":username,
        "password":password,
        "client_sup_id":client_sup_id,
        "dev_sup_id":dev_sup_id,
        "client_sup_ip":client_sup_ip,
        "client_sup_port":client_sup_port,
        "ch":ch,
        "data_type":data_type
    };
    var GisVideoInfoObject = eval(GisVideoInfo);
    var Jsontext = JSON2.stringify(GisVideoInfoObject);
    return Jsontext;
}