var oVideoControl = null
var initCount = 0;
var rtsp_url="";
var token = "";
var  hisarr=null;
var winIndex = 0;
var flag=0;

$(function() {
  if(typeof pt_ip != "undefined"){
    $('#host').val(pt_ip);
  }
  // initPlayer();

  $('#host').blur(function() {
    initZtree()
  })
})

function initPlayer() {
  oVideoControl = new videoPlayer({
    videoClassName: 'DHVideoPlayer', //视频id
    width: 950,
    height: 540,
    connectSuccess: function() {
     // alert('初始化成功')
       create();
    },
    connectClose: function() {
      oVideoControl = null
    }
  })
  // init();
}

function init() {
  oVideoControl.init()
}

//获取版本
function version() {
  oVideoControl.event.version()
}

//视频窗口变大
function resizeBig() {
  $('#DHVideoPlayer').css({ width: '1000px', height: '700px' })
  oVideoControl.event.destroy()
  create()
}

//视频窗口变小
function resizeSmall() {
  $('#DHVideoPlayer').css({ width: '400px', height: '200px' })
  oVideoControl.event.destroy()
  create()
}

//增加滚动
function addRoll() {
  $('body').css({ width: '120%', height: '150%' })
}

//移除滚动
function removeRoll() {
  $('body').css({ width: 'calc(100% - 10px)', height: '100%' })
}

//创建窗口
function create() {
  oVideoControl.event.create({
    ismount: true,
    mount: true,
    windowType: "1",
    recordType:"1",
    num:4
  })
}

//销毁窗口
function destroy() {
  oVideoControl.event.destroy()
}

//窗口显示
function show() {
  oVideoControl.event.show()
}

//窗口隐藏
function hide() {
  oVideoControl.event.hide()
}

//实时预览
function realmonitor() {
  if (rtsp_url=== '') {
    return
  }else {
    getWindowState();
  }
}


//录像回放
function playback() {
    if (rtsp_url=== '') {
      return
    }else {
      getWindowState();
    }
}

//视频遮挡
function WindowShield(event) {
  var className = $(event)
    .eq(0)
    .find('ul')
    .attr('class')
  if (className == null || className == '') {
    return
  }
  oVideoControl &&
    oVideoControl.event.windowShield({
      shieldClass: [className]
    })
}

function getWindowState() {
  oVideoControl.event.getWindowState({
  },function(data){
    var res=data.data.windowState;
    if(flag==-1)flag=0;
    if(flag<res.length) winIndex=flag;

    oVideoControl.event.playback({
      snum: winIndex % res.length,
      path: rtsp_url,
      records: hisarr
    })
    flag=res.length;
    if (winIndex == res.length - 1)
      winIndex = 0;
    else
      winIndex++;
  })
}

function initZtree() {
  // regionNIvsEncoderChnTree:"01;00_1,00_5,00_6,00_7;01",//显示除智能设备的其它设备的编码通道的监控区域树
  //视频通道
  var host = $('#host').val() || '10.35.81.209'
  var url = 'http://' + host + ':8314/admin/ztree.action'
  var encoderSetting = {
    async: {
      otherParam: {
        type: '01;00_1,00_5,00_6,00_7;01'
      }
    },
    check: {
      enable: false
    },
    data: {
      simpleData: {
        enable: true
      }
    },
    view: {
      showIcon: true,
      fontCss: { color: '#000' },
      dblClickExpand: false
    },
    other: {
      openRoot: false,
      treeDivId: 'encoderTreeDiv',
      url: url
    },
    callback: {
      //      onAsyncSuccess :encoderTreeOnExpand,
      //      onCheck : encoderTreeOnCheck,
      //      beforeCheck:encoderTreeBeforeCheck,
      onDblClick: encoderTreeOnClick
    }
  }
  var encoderTree = $.fn.deviceTree.init(encoderSetting).zTree
}

function encoderTreeOnClick(event, treeId, treeNode) {
  console.log(treeNode)
  if (treeNode.isParent) {
    alert('请双击选择前端设备！')
  } else {
    console.log(treeNode.id)
    var channelId = treeNode.id.split('$')
    var finalId = channelId[0] + '$' + channelId[3] //拼接摄像头id
    console.log(finalId)
    $('#cameraId').val(finalId)
  }
}


// 调用java接口获取录像的rtsp 的xml字符串
function getYt() {
  var host = $('#host').val() || '10.35.81.209'
  var url = 'http://' + host + ':8314/face/cloud/control?token=98cbbcf56a7b004efc917c9870ad19fe';
  var params = {
    cameraId:"1000000",
    direct:1,
    stop:0
  }
  // 请求获取实时视频的xml字符串
  $.ajax({
    dataType: 'json',
    url: url,
    type: 'post',
    contentType: 'application/json',
    data: JSON.stringify(params),
    success: function(data) {
      if (data.success) {
        console.log(data.data)

      }
    }
  })
}
function getRAS(){
var host = $('#host').val() || '10.35.81.209'
  var url = 'http://' + host + ':8314/WPMS/getCryptKey';
  var params = {
    "loginName": "system"
  }
  // 请求获取实时视频的xml字符串
  $.ajax({
    dataType: 'json',
    urcheckboxl: url,
    type: 'post',
    contentType: 'application/json',
    data: JSON.stringify(params),
    success: function(data) {
      if (data.success) {
        console.log(data.data)
        var publicKey="YWRtaW4xMjM0NTY3ODkzN2MwYWVmY2VkZDdlOTIzOTE0YzQ4ZmMxNzdhODA3Zg==";
         loginSys(publicKey);
      }
    }
  })

}

function createXml(str) {
  if (document.all) {
    //IE浏览器
    var xmlDoc = new ActiveXObject('Microsoft.XMLDOM')
    xmlDoc.async = false
    xmlDoc.loadXML(str)
    return xmlDoc
  } else {
    //非IE浏览器
    return new DOMParser().parseFromString(str, 'text/xml')
  }
}







/*获取项目路径*/
function getRootPath(){
  var curWwwPath=window.document.location.href;
  var pathName=window.document.location.pathname;
  var pos=curWwwPath.indexOf(pathName);
  var localhostPaht=curWwwPath.substring(0,pos);
  var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
  var projectPath = localhostPaht+projectName;
  return projectPath;
}

/*获取大华token*/
function loginSys(){
  var projectPath = getRootPath();
  var url = projectPath+'/backstage/vm/realtimeVideo/getToken';
  // 请求获取token
  $.ajax({
    dataType: 'json',
    url: url,
    type: 'post',
    contentType: 'application/json',
    success: function(data) {
      if (data.code=="200") {
        token = data.data;
        console.log("token:"+token);

      }
    }
  })
}

// 调用java接口获取实时视频的rtsp 的xml字符串
function getRealmonitorRtsp() {
  var host = $('#host').val() || '10.35.81.209'
  var url = 'http://' + host + ':8314/admin/rest/VideoStream/realVideo';
  var params = {
    cameraid: $('#cameraId').val()
  }
  // 请求获取实时视频的xml字符串
  $.ajax({
    dataType: 'json',
    url: url,
    type: 'post',
    contentType: 'application/json',
    data: JSON.stringify(params),
    success: function(data) {
      if (data.success) {
        console.log(data.data)
        var xml = createXml(data.data)
        var rtsp = xml.getElementsByTagName("url")
        var token = xml.getElementsByTagName("token")
        console.log(rtsp[0]);
        var path=rtsp[0].innerHTML;
        var path2=path.split("|")[0];
        rtsp_url=path2+ "?token=" + token[0].innerHTML;
        // $("#videoInput").val(path2+ "?token=" + token[0].innerHTML);
        realmonitor();
      }
    }
  })
}

/*云台接口*/
function ptzControl(direct,stop) {
  var host = $('#host').val() || '10.35.81.209'
  var url = 'http://' + host + ':8314/face/cloud/control?token='+token;
  var cameraIndexCode;
  if ($('#cameraId').val()) {
    cameraIndexCode = $('#cameraId').val().split('$')[0];
  } else {
    $("#msg").text("请选择设备！");
    return;
  }
  var params = {
    deviceCode:cameraIndexCode,
    direct:direct,
    stop:stop
  }
  // 请求获取实时视频的xml字符串
  $.ajax({
    dataType: 'json',
    url: url,
    type: 'post',
    contentType: 'application/json',
    data: JSON.stringify(params),
    success: function(data) {
      if (data.errMsg=="success") {
        console.log(data)
      }
    }
  })
}

/*云台设置接口（变倍）*/
function ptzMultiple(type,stop) {
  var host = $('#host').val() || '10.35.81.209'
  var url = 'http://' + host + ':8314/face/cloud/zoom?token='+token;
  var cameraIndexCode;
  if ($('#cameraId').val()) {
    cameraIndexCode = $('#cameraId').val().split('$')[0];
  } else {
    $("#msg").text("请选择设备！");
    return;
  }
  var params = {
    deviceCode:cameraIndexCode,
    type:type,
    stop:stop
  }
  // 请求获取实时视频的xml字符串
  $.ajax({
    dataType: 'json',
    url: url,
    type: 'post',
    contentType: 'application/json',
    data: JSON.stringify(params),
    success: function(data) {
      console.log(data);
    }
  })
}

/*云台设置接口（聚焦）*/
function ptzFocalLength(type,stop) {
  var host = $('#host').val() || '10.35.81.209'
  var url = 'http://' + host + ':8314/face/cloud/focus?token='+token;
  var cameraIndexCode;
  if ($('#cameraId').val()) {
    cameraIndexCode = $('#cameraId').val().split('$')[0];
  } else {
    $("#msg").text("请选择设备！");
    return;
  }
  var params = {
    deviceCode:cameraIndexCode,
    type:type,
    stop:stop
  }
  // 请求获取实时视频的xml字符串
  $.ajax({
    dataType: 'json',
    url: url,
    type: 'post',
    contentType: 'application/json',
    data: JSON.stringify(params),
    success: function(data) {
      console.log(data);
    }
  })
}

/*云台设置接口（光圈）*/
function ptzAperture(type,stop) {
  var host = $('#host').val() || '10.35.81.209'
  var url = 'http://' + host + ':8314/face/cloud/aperture?token='+token;
  var cameraIndexCode;
  if ($('#cameraId').val()) {
    cameraIndexCode = $('#cameraId').val().split('$')[0];
  } else {
    $("#msg").text("请选择设备！");
    return;
  }
  var params = {
    deviceCode:cameraIndexCode,
    type:type,
    stop:stop
  }
  // 请求获取实时视频的xml字符串
  $.ajax({
    dataType: 'json',
    url: url,
    type: 'post',
    contentType: 'application/json',
    data: JSON.stringify(params),
    success: function(data) {
      console.log(data);
    }
  })
}

/*抓拍*/
function captureBtn() {
  var projectPath = getRootPath();
  var host = $('#host').val() || '10.35.81.209'
  var cameraIndexCode;
  var channelSeq;
  if ($('#cameraId').val()) {
    cameraIndexCode = $('#cameraId').val().split('$')[0];
    channelSeq=$('#cameraId').val().split('$')[1];
  } else {
    $("#msg").text("请选择设备！");
    return;
  }
  // var url = projectPath+'/backstage/vm/realtimeVideo/getCapturePic?cameraIndexCode='+cameraIndexCode;
  // var url = projectPath+'/backstage/vm/realtimeVideo/getCapturePic';
  var url = 'http://' + host + ':8314/admin/rest/device/rest/getManualCaptureEx';
  var params = {
    cameraIndexCode:cameraIndexCode,
    channelSeq:channelSeq
  }
  // 请求获取信息
  $.ajax({
    dataType: 'json',
    url: url,
    type: 'post',
    contentType: 'application/json',
    data: JSON.stringify(params),
    success: function(data) {
      console.log(data);

      // var winurl=data.data.picUrl;
      // var pageName="poppanel"+eval(parseInt(10000*Math.random()));
      // var iWidth=800;
      // var iHeight=600;
      // var iTop=(window.screen.availHeight-30-iHeight)/2;
      // var iLeft=(window.screen.availWidth-10-iWidth)/2;
      // // console.log(data.data);
      // window.open(winurl,pageName,"height="+iHeight+",width="+iWidth+",top="+iTop+",left="+iLeft+",location=no,toolbar=no,menubar=no,scrollbars=no,status=no,resizable=yes",false);
      // $("#msg").text("抓拍成功！");
      if(data) {
        $("#msg").text("抓拍成功！")
        $(".about").css("display", "block");
        $("img").attr("src", data.data.picUrl);
        oVideoControl &&
        oVideoControl.event.windowShield({
          shieldClass: ["about"]
        })
      }
     }
  })
}
function closeDiv(){
  $(".about").css("display","none");
  oVideoControl &&
  oVideoControl.event.windowShield({
    shieldClass: ["about"]
  })
}
/*打开文件*/
function openFileIIs() {
  hide();
  $("#pathdiv").fadeToggle();
  var Url2=document.getElementById("path").innerText;
  var oInput = document.createElement('input');
  oInput.value = Url2;
  document.body.appendChild(oInput);
  oInput.select(); // 选择对象
  document.execCommand("Copy"); // 执行浏览器复制命令
  oInput.className = 'oInput';
  oInput.style.display='none';
  //var a = window.open("http://localhost:8080/video/","抓拍信息");
  //var a = window.location.href("http://localhost:8089/video/");

}

function aaa() {
  var a = $("#queryStartTime").html();
  var b = $("#queryEndTime").text();
  var c = (new Date(a).getTime())/1000;
  console.log('HTML:'+a);
  console.log('HTML:'+b);
  console.log('秒:'+c);
}

// 调用录像的rtsp 的xml字符串
function getPlaybackRtsp() {
  var host = $('#host').val() || '10.35.81.209'
  var url = 'http://' + host + ':8314/admin/rest/VideoStream/playBack'
  var params = {
    cameraid: $('#cameraId').val(),
    begintime: (new Date($("#queryStartTime").text()).getTime())/1000, // 时间是s
    endtime: (new Date($("#queryEndTime").text()).getTime())/1000
  }
  // 请求获取录像视频的xml字符串
  $.ajax({
    dataType: 'json',
    url: url,
    type: 'post',
    contentType: 'application/json',
    data: JSON.stringify(params),
    success: function(data) {
      if (data.success) {
        var xml = createXml(data.data)
        var rtsp = xml.getElementsByTagName("url")
        var token = xml.getElementsByTagName("token")
        var path=rtsp[0].innerHTML;
        var path2=path.split("|")[0];
        rtsp_url=path2+ "?token=" + token[0].innerHTML;
        hisarr=[
          {
            startTime:(new Date($("#queryStartTime").text()).getTime())/1000,
            endTime: (new Date($("#queryStartTime").text()).getTime())/1000,
            recordName: 'video_file',
            fileLength: '50'
          }
        ]
        playback();
      }
    }
  })
}
function downVideo(){
  var host = $('#host').val() || '10.35.81.209'
  var url = 'http://' + host + ':8314/admin/rest/VideoStream/videoUrl'
  var params = {
      startTime:$("#queryStartTime").text(),
      endTime:$("#queryEndTime").text(),
      channelCode:$("#device_code").val()
}
  $("#msg").text("开始下载，请稍等...");
  $.ajax({
    dataType: 'json',
    url: url,
    type: 'post',
    contentType: 'application/json',
    data: JSON.stringify(params),
    success: function(data) {
      if (data.data) {
        var winurl=data.data.videoPath;
        var iWidth=700;
        var iHeight=450;
        var iTop=(window.screen.availHeight-30-iHeight)/2;
        var iLeft=(window.screen.availWidth-10-iWidth)/2;
        console.log("历史视频地址"+winurl);
        var name = winurl.substring((winurl.indexOf("/video/")+"/video/".length));
        downLoadVideo(name);
         //var win=window.open(winurl," ","height="+iHeight+",width="+iWidth+",top="+iTop+",left="+iLeft+",location=no,toolbar=no,menubar=no,scrollbars=no,status=no,resizable=yes,titlebar=no",false);
        $("#msg").text("下载成功");
      }
    }
  })
}