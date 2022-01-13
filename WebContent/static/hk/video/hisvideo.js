var selectedVal="";
var setting = {
    data: {
        simpleData: {
            enable: true
        }
    },
    check: {
        enable: false
    },
    view: {
        dblClickExpand: false,
        showLine: true,
        selectedMulti: true,
        fontCss: setFontCss
    },
    callback: {
        beforeAsync: function () {

        },
        beforeClick: function (treeId, treeNode) {
            var zTree = $.fn.zTree.getZTreeObj("tree_project");
            if (treeNode.isParent) {
                zTree.expandNode(treeNode);
                return false;
            } else {

                return true;
            }
        },
        onDblClick: zTreeOnDblClick,
        onClick:zTreeOnClick

    }
};

 Date.prototype.format = function(fmt) {
    var o = {
        "M+": this.getMonth() + 1, //月份
        "d+": this.getDate(), //日
        "h+": this.getHours() % 12 == 0 ? 12 : this.getHours() % 12, //小时
        "H+": this.getHours(), //小时
        "m+": this.getMinutes(), //分
        "s+": this.getSeconds(), //秒
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度
        "S": this.getMilliseconds() //毫秒
    };
    var week = {
        "0": "\u65e5",
        "1": "\u4e00",
        "2": "\u4e8c",
        "3": "\u4e09",
        "4": "\u56db",
        "5": "\u4e94",
        "6": "\u516d"
    };
    if (/(y+)/.test(fmt)) {
        fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    }
    if (/(E+)/.test(fmt)) {
        fmt = fmt.replace(RegExp.$1, ((RegExp.$1.length > 1) ? (RegExp.$1.length > 2 ? "\u661f\u671f" : "\u5468") : "") + week[this.getDay() + ""]);
    }

    for (var k in o) {
        if (new RegExp("(" + k + ")").test(fmt)) {
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        }
    }
    return fmt;
};
function setFontCss(treeId, treeNode) {
	return treeNode.status == 0 ? {color:"#746f6f"} : {color:"white"};
};
function onlodtree_online() {

    JY.Ajax.doRequest(null,jypath +'/backstage/bgwbhy/video/findVideoTreeByAuthority',null,function(data){

        if(data.res>=1){
            allnum=0;
            onlinenum=0;
            unlinenum=0;
            treenode= treenode_iconSkin(data.obj);
            var t = $("#tree_project");
            t = $.fn.zTree.init(t, setting, treenode);

            var nodes =  t.getNodes(); //可以获取所有的父节点
            for (var i = 0; i < nodes.length; i++) { //设置节点展开
                t.expandNode(nodes[i], true, false, true);
            }
            var nodesSysAll = t.transformToArray(nodes); //获取树所有节点
            var nodes0=t.getNodesByFilter(filter0);
            var nodes1=t.getNodesByFilter(filter1);
            var nodes2=t.getNodesByFilter(filter2);
            function filter2(node) {
                return (node.level == 2);
            }
            function filter1(node) {
                return (node.level == 1);
            }
            function filter0(node) {
                return (node.level == 0);
            }


            for(var m=0;m<nodes2.length;m++){
                if(nodes2[m].info3==null){
                nodes2[m].dev_count= nodes2[m].children.length;
                nodes2[m].name=nodes2[m].name+" ["+nodes2[m].dev_count+"]";
                }
            }
            for(var n=0;n<nodes1.length;n++) {
                var childcode=nodes1[n].children;
                var len = childcode.length;
                for (var k = 0; k < len; k++) {
                    nodes1[n].dev_count = parseInt(nodes1[n].dev_count ) +parseInt(childcode[k].dev_count) ;
                }
                nodes1[n].name= nodes1[n].name+" ["+nodes1[n].dev_count+"]";
                t.updateNode(nodes1[n]);
            }
            var childcode1=nodes0[0].children;
            for(var l=0;l<childcode1.length;l++) {
                nodes0[0].dev_count = parseInt(nodes0[0].dev_count ) +parseInt(childcode1[l].dev_count) ;
            }
            nodes0[0].name= nodes0[0].name+" ["+nodes0[0].dev_count+"]";
            t.updateNode(nodes0[0]);


        }
        else {
            alert(data.resMsg);
        }});

}

function findNodes(treeNode)
{
    var count;
    /*判断是不是父节点,是的话找出子节点个数，加一是为了给新增节点*/
    if(treeNode.isParent) {
        count = treeNode.children.length + 1 ;
    } else {
        /*如果不是父节点,说明没有子节点,设置为1*/
        count = 1;
    }
    return count;
};



//查询事件
function  btnSearchVideo() {
    var checkinfo  =$('#tbxsearch').val();
    JY.Ajax.doRequest(null,jypath +'/backstage/bgwbhy/video/findVideoByZnodes', {device_bh: checkinfo},function(data){
        if(data.res==0){
            alert(data.resMsg);
        }
        else{
            var t = $("#tree_project");
            var treenode=treenode_iconSkin(data.obj);
            t = $.fn.zTree.init(t, setting, treenode);
        }
    });

};

function playview(){
    startPlayback(selectedVal);
};
// function backPlay( ) {
//    var startTime = $("#queryStartTime")[0].value;
//    var endTime = $("#queryEndTime")[0].value;
//     var spbOcx = document.getElementById("mpb");
//     var ab= compareTime(startTime,endTime);
//
//     if(ab==true){
//               $.ajax({
//             async:true,
//             type: "POST",
//             url:"http://10.1.8.182:9999/bgvideo/getHistoryParametersByUUid",
//             data: "cameraUuid=" + selectedVal,
//             dataType:"text",
//             success: function (data) {
//                 if(data==null||data==''){
//                     alert("未获取到返回参数");
//                 }
//                 else{
//                     var xml=data;
//                     var ret = spbOcx.MPB_StartPlayBack(xml, startTime, endTime);
//                     if (ret != 0) {
//                         alert("回放失败!" );
//                     }
//                 }
//
//             }
//         })
//    }
//
// }
function zTreeOnDblClick(event, treeId, treeNode) {
    selectedVal=treeNode.info3;}

function zTreeOnClick(event, treeId, treeNode) {
    selectedVal=treeNode.info3;}
//树加载内容添加iconSkin
function  treenode_iconSkin(treenode) {

    for(var i=0;i<treenode.length;i++){
        if(treenode[i].type==""||treenode[i].type==null)
            treenode[i].iconSkin="icon03";
        else if(treenode[i].type.indexOf("球机")>=0){
            treenode[i].iconSkin="icon01";
        }
        else if(treenode[i].type.indexOf("枪机")>=0||treenode[i].type.indexOf("筒机")>=0||treenode[i].type.indexOf("半球")>=0)
        {
            treenode[i].iconSkin="icon02";
        }
        else
        { treenode[i].iconSkin="icon02";}

    }
    return treenode;
}

function compareTime(startDate, endDate) {
    if (startDate.length > 0 && endDate.length > 0) {

        if(new Date(startDate.replace(/-/g,'/'))>=new Date(endDate.replace(/-/g,'/'))){
            alert("开始时间不能大于结束时间，不能通过");
            return false;
        } else {
            //alert("startTime小于endTime，所以通过了");
            return true;
        }
    } else {
        alert("时间不能为空");
        return false;
    }
}

/**/

//声明公用变量
var initCount = 0;
var pubKey = '';
var hightVideo=0; //插件高度
var widthtVideo=0;//插件宽度
var oWebControl=null;
// 创建WebControl实例与启动插件
function initPlugin () {
    oWebControl = new WebControl({
        szPluginContainer: "playWnd",                       //指定容器id
        iServicePortStart: 15900,                           //指定起止端口号，建议使用该值
        iServicePortEnd: 15909,
		szClassId:"23BF3B0A-2C56-4D97-9C03-0CB103AA8F11",   // 用于IE10使用ActiveX的clsid
        cbConnectSuccess: function () {
            // setCallbacks();
            //实例创建成功后需要启动服务
            oWebControl.JS_StartService("window", {
                dllPath: "./VideoPluginConnect.dll"
            }).then(function () {
                oWebControl.JS_CreateWnd("playWnd", widthtVideo, hightVideo).then(function () {         //JS_CreateWnd创建视频播放窗口，宽高可设定
                    console.log("JS_CreateWnd success");
                    init();                                 //创建播放实例成功后初始化
                });
            }, function () {

            });
        },
        cbConnectError: function () {
            console.log("cbConnectError");
            oWebControl = null;
            $("#playWnd").html("插件未启动，正在尝试启动，请稍候...");
            WebControl.JS_WakeUp("VideoWebPlugin://");        //程序未启动时执行error函数，采用wakeup来启动程序
            initCount ++;
            if (initCount < 3) {
                setTimeout(function () {
                    initPlugin();
                }, 3000)
            } else {
                $("#playWnd").html("插件启动失败，请检查插件是否安装！");
            }
        },
        cbConnectClose: function () {
            console.log("cbConnectClose");
            oWebControl = null;
        }
    });

}

//初始化
function init()
{
    getPubKey(function () {

        ////////////////////////////////// 请自行修改以下变量值	////////////////////////////////////
       var appkey = "20751516";                           //综合安防管理平台提供的appkey，必填
        var secret = setEncrypt("8Ub8ANS58Q2xpKuFGCJT");   //综合安防管理平台提供的secret，必填
        var ip = "192.168.24.20";
        var playMode = 1;                                  //初始播放模式：0-预览，1-回放
        var port = 443;                                    //综合安防管理平台端口，若启用HTTPS协议，默认443
        var snapDir = "D:\\SnapDir";                       //抓图存储路径
        var videoDir = "D:\\VideoDir";                     //紧急录像或录像剪辑存储路径
        var layout = "1x1";                                //playMode指定模式的布局
        var enableHTTPS = 1;                               //是否启用HTTPS协议与综合安防管理平台交互，是为1，否为0
        var encryptedFields = 'secret';					   //加密字段，默认加密领域为secret
        var showToolbar = 1;                               //是否显示工具栏，0-不显示，非0-显示
        var showSmart = 1;                                 //是否显示智能信息（如配置移动侦测后画面上的线框），0-不显示，非0-显示
        var buttonIDs = "0,16,256,257,258,259,260,512,513,514,515,516,517,768,769";  //自定义工具条按钮
        ////////////////////////////////// 请自行修改以上变量值	////////////////////////////////////

        oWebControl.JS_RequestInterface({
            funcName: "init",
            argument: JSON.stringify({
                appkey: appkey,                            //API网关提供的appkey
                secret: secret,                            //API网关提供的secret
                ip: ip,                                    //API网关IP地址
                playMode: playMode,                        //播放模式（决定显示预览还是回放界面）
                port: port,                                //端口
                snapDir: snapDir,                          //抓图存储路径
                videoDir: videoDir,                        //紧急录像或录像剪辑存储路径
                layout: layout,                            //布局
                enableHTTPS: enableHTTPS,                  //是否启用HTTPS协议
                encryptedFields: encryptedFields,          //加密字段
                showToolbar: showToolbar,                  //是否显示工具栏
                showSmart: showSmart,                      //是否显示智能信息
                buttonIDs: buttonIDs                       //自定义工具条按钮
            })
        }).then(function (oData) {
            oWebControl.JS_Resize(widthtVideo, hightVideo);  // 初始化后resize一次，规避firefox下首次显示窗口后插件窗口未与DIV窗口重合问题
        });
    });
}

// 获取公钥
function getPubKey (callback) {
    oWebControl.JS_RequestInterface({
        funcName: "getRSAPubKey",
        argument: JSON.stringify({
            keyLength: 1024
        })
    }).then(function (oData) {
        console.log(oData);
        if (oData.responseMsg.data) {
            pubKey = oData.responseMsg.data;
            callback()
        }
    })
}

// RSA加密
function setEncrypt (value) {
    var encrypt = new JSEncrypt();
    encrypt.setPublicKey(pubKey);
    return encrypt.encrypt(value);
}

// 监听resize事件，使插件窗口尺寸跟随DIV窗口变化
$(window).resize(function () {
    if (oWebControl != null) {
        oWebControl.JS_Resize(widthtVideo, hightVideo);
        setWndCover();
    }
});

// 监听滚动条scroll事件，使插件窗口跟随浏览器滚动而移动
$(window).scroll(function () {
    if (oWebControl != null) {
        oWebControl.JS_Resize(widthtVideo, hightVideo);
        setWndCover();
    }
});


// 设置窗口裁剪，当因滚动条滚动导致窗口需要被遮住的情况下需要JS_CuttingPartWindow部分窗口
function setWndCover() {
    var iWidth = $(window).width();
    var iHeight = $(window).height();
    var oDivRect = $("#playWnd").get(0).getBoundingClientRect();

    var iCoverLeft = (oDivRect.left < 0) ? Math.abs(oDivRect.left): 0;
    var iCoverTop = (oDivRect.top < 0) ? Math.abs(oDivRect.top): 0;
    var iCoverRight = (oDivRect.right - iWidth > 0) ? Math.round(oDivRect.right - iWidth) : 0;
    var iCoverBottom = (oDivRect.bottom - iHeight > 0) ? Math.round(oDivRect.bottom - iHeight) : 0;

    iCoverLeft = (iCoverLeft > widthtVideo) ? widthtVideo : iCoverLeft;
    iCoverTop = (iCoverTop > hightVideo) ? hightVideo : iCoverTop;
    iCoverRight = (iCoverRight > widthtVideo) ? widthtVideo : iCoverRight;
    iCoverBottom = (iCoverBottom > hightVideo) ? hightVideo : iCoverBottom;

    oWebControl.JS_RepairPartWindow(0, 0, widthtVideo+1, hightVideo);   // 多1个像素点防止还原后边界缺失一个像素条
    if (iCoverLeft != 0) {
        oWebControl.JS_CuttingPartWindow(0, 0, iCoverLeft, hightVideo);
    }
    if (iCoverTop != 0) {
        oWebControl.JS_CuttingPartWindow(0, 0, widthtVideo+1, iCoverTop);  // 多剪掉一个像素条，防止出现剪掉一部分窗口后出现一个像素条
    }
    if (iCoverRight != 0) {
        oWebControl.JS_CuttingPartWindow(widthtVideo - iCoverRight, 0, iCoverRight, hightVideo);
    }
    if (iCoverBottom != 0) {
        oWebControl.JS_CuttingPartWindow(0, hightVideo - iCoverBottom, widthtVideo, iCoverBottom);
    }
}


//录像回放功能
function startPlayback(cameraIndexCode) {

   // var cameraIndexCode  = $("#cameraIndexCode").val();         //获取输入的监控点编号值，必填
    var startTimeStamp = new Date( $("#queryStartTime").text().replace('-', '/').replace('-', '/')).getTime();    //回放开始时间戳，必填
    var endTimeStamp = new Date($("#queryEndTime").text().replace('-', '/').replace('-', '/')).getTime();        //回放结束时间戳，必填
    var recordLocation = 0;                                     //录像存储位置：0-中心存储，1-设备存储
    var transMode = 1;                                          //传输协议：0-UDP，1-TCP
    var gpuMode = 0;                                            //是否启用GPU硬解，0-不启用，1-启用
    var wndId = -1;                                             //播放窗口序号（在2x2以上布局下可指定播放窗口）


	oWebControl.JS_RequestInterface({
	funcName: "startPlayback",
	argument: JSON.stringify({
		cameraIndexCode: cameraIndexCode,
		startTimeStamp: Math.floor(startTimeStamp / 1000).toString(),
		endTimeStamp: Math.floor(endTimeStamp / 1000).toString(),
		recordLocation: recordLocation,
		transMode: transMode,
		gpuMode: gpuMode,
		wndId: wndId
	})
  })
};

// 停止回放
function stopAllPlayback () {
    oWebControl.JS_RequestInterface({
        funcName: "stopAllPlayback"
    })
};

//设置录像回放时间的默认值
var endTime = dateFormat(new Date(), "yyyy-MM-dd 23:59:59");
var startTime = dateFormat(new Date(), "yyyy-MM-dd 00:00:00");
$("#queryStartTime").text(startTime);
$("#queryEndTime").text(endTime);

// 格式化时间
function dateFormat(oDate, fmt) {
    var o = {
        "M+": oDate.getMonth() + 1, //月份
        "d+": oDate.getDate(), //日
        "h+": oDate.getHours(), //小时
        "m+": oDate.getMinutes(), //分
        "s+": oDate.getSeconds(), //秒
        "q+": Math.floor((oDate.getMonth() + 3) / 3), //季度
        "S": oDate.getMilliseconds()//毫秒
    };
    if (/(y+)/.test(fmt)) {
        fmt = fmt.replace(RegExp.$1, (oDate.getFullYear() + "").substr(4 - RegExp.$1.length));
    }
    for (var k in o) {
        if (new RegExp("(" + k + ")").test(fmt)) {
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        }
    }
    return fmt;
}

// 标签关闭
$(window).unload(function () {
    if (oWebControl != null){
        oWebControl.JS_HideWnd();   // 先让窗口隐藏，规避插件窗口滞后于浏览器消失问题
        oWebControl.JS_Disconnect().then(function(){}, function() {});
    }
});

function  getscreen() {
    // var s = "";
    // s += " 网页可见区域宽："+ document.body.clientWidth+"<br />";
    // s += " 网页可见区域高："+ document.body.clientHeight+"<br />";
    // s += " 网页可见区域宽："+ document.body.offsetWidth + " (包括边线和滚动条的宽)"+"<br />";
    // s += " 网页可见区域高："+ document.body.offsetHeight + " (包括边线的宽)"+"<br />";
    // s += " 网页正文全文宽："+ document.body.scrollWidth+"<br />";
    // s += " 网页正文全文高："+ document.body.scrollHeight+"<br />";
    // s += " 网页被卷去的高(ff)："+ document.body.scrollTop+"<br />";
    // s += " 网页被卷去的高(ie)："+ document.documentElement.scrollTop+"<br />";
    // s += " 网页被卷去的左："+ document.body.scrollLeft+"<br />";
    // s += " 网页正文部分上："+ window.screenTop+"<br />";
    // s += " 网页正文部分左："+ window.screenLeft+"<br />";
    // s += " 屏幕分辨率的高："+ window.screen.height+"<br />";
    // s += " 屏幕分辨率的宽："+ window.screen.width+"<br />";
    // s += " 屏幕可用工作区高度："+ window.screen.availHeight+"<br />";
    // s += " 屏幕可用工作区宽度："+ window.screen.availWidth+"<br />";
    // s += " 你的屏幕设置是 "+ window.screen.colorDepth +" 位彩色"+"<br />";
    // s += " 你的屏幕设置 "+ window.screen.deviceXDPI +" 像素/英寸"+"<br />";
    // console.log(s);
    //插件高度：屏幕可用工作区高度-网页正文部分上-50-50
    // hightVideo=window.screen.availHeight- window.screenTop-100;
    //插件宽度：屏幕可用工作区宽度-网页正文部分左-320-32
    // widthtVideo=document.body.clientWidth-window.screenLeft-352;

    //获取高度
    hightVideo = document.getElementById('playWnd').clientHeight;
    //获取宽度
    widthtVideo= document.getElementById('playWnd').clientWidth;
}
/**/