
var newdeviceList=[];
var mapId = getQueryVariable("mapId");
var areaId =getQueryVariable("areaId");
var spaceId = getQueryVariable("spaceId");
var organInfoList=[];
var mapPath = {};
var areaName1 ="";
var mapLightDeviceId =null;
var lightDeviceStatus = true;
console.log("-------",mapId);
if(typeof mapId=="undefined"||spaceId===""){
    mapId=1;
}

if(spaceId!==""&&typeof spaceId!="undefined"){
    organInfoList = getOrganInfo();
    console.log("-------------------",organInfoList)
    console.log("----------------------",mapPath);
    if(organInfoList.length==0){
        alert("当前产区没有对应的产线！");
    }
}
if(areaId!==""&&typeof areaId!="undefined"){
    areaName1 =getAreaName();
    mapPath = getMapPath();
    console.log(mapPath);
}

if((spaceId!==""&&typeof spaceId!="undefined")&&(areaId===""||typeof areaId=="undefined")){
    console.log("----------------------------------")
    var url = window.location.href;
    if (url.indexOf("?") != -1) {
        url = url.substring(0, url.indexOf("?"));
    }
    url = url + "?areaId=" +organInfoList[0].id + "&mapId=1";
    if(spaceId != ""&& typeof spaceId !="undefined"){
        url = url+"&spaceId="+spaceId;
    }
    window.location.href = url;
}

$.ajax(
    {
        type: "POST",
        async: false,
        url: ctx+"/backstage/gismap/devicelocation/getdeviceList/"+(typeof mapId==='undefined'?1:mapId)+"/"
            +(typeof areaId==='undefined'?1:areaId),
        success: function (msg) {
            newdeviceList=msg.data;
        },
        error: function (xmlR, status, e) {
        }
    });
for (let i = 0; i <newdeviceList.length ; i++) {

    newdeviceList[i].rotate = false;

}
for (let i = 0; i <newdeviceList.length ; i++) {

    for (let j = 0; j <newdeviceList.length ; j++) {

        if(i==j){
            continue
        }
        var calcNum =newdeviceList[i].longitude - newdeviceList[j].longitude;
        if(calcNum<6600 && calcNum>0&&newdeviceList[j].rotate==false){
            newdeviceList[i].rotate = true;
            break;
        }
    }
}
new Vue({
    el: '#app',
    data:{
        deviceNameSerch:null,//搜索内容
        tableData: newdeviceList,//搜索结果集列表
        mapData:Object.assign([], newdeviceList),//摄像头列表
        currentPage: 1, // 当前页码
        total: 20, // 总条数
        pageSize: 5, // 每页的数据条数
        window_show:true,//摄像头实时窗口是否显示
        show_form:false,//显示form表单
        input_visible:true,//输入框状态
        table_visible:false,//设备列表是否显示
        mapClick:null,//点击获取坐标事件
        point_input_visible:false,
        icon_show:false,
        chose_point:false,
        handleType:-1,
        deviceTypeSelectList: [],
        verifyDevice:null,
        device:{},//后端操作的对象
        cameraid:'1000001$0',
        areaName:areaName1,
        orginInfo:organInfoList,
        device_info_id:null,//控件显示的下标 要根据下标找到对应摄像头的经纬度
        currentSpace:areaId,
        currentMap:mapId,
        mapPathList:mapPath!=null?mapPath.pathList:[],
        HanziNumber:["一","二","三","四","五"],
        name_show:false,
        deviceFormRules:{
            deviceCode: [{required: true, trigger: ['blur', 'change'], message: '设备编号不能为空'}],
            deviceName: [{required: true, trigger: ['blur', 'change'], message: '设备名称不能为空'}],
            deviceArea: [{required: true, trigger: ['blur', 'change'], message: '设备产线不能为空'}],
            longitude: [{required: true, trigger: ['blur', 'change'], message: '设备经度不能为空'}],
            latitude: [{required: true, trigger: ['blur', 'change'], message: '设备纬度不能为空'}]
        },
    },
    created(){
        this.getDevCodeTypeValue();
        console.log("初始化");
    },
    methods:{
        show_camera(row){
            this.closeInfoWindows();
            console.log(row);
            console.log(row.deviceId === mapLightDeviceId);
            if(!(row.deviceId === mapLightDeviceId)){
                $("#"+mapLightDeviceId+">i").css("background-color","rgb(134, 191, 247)");
            }
            mapLightDeviceId = row.deviceId;
            for (let i=0; i< this.mapData.length; i++) {

                if(this.mapData[i].deviceId==row.deviceId){

                    var xy = [Number(this.mapData[i].longitude),Number(this.mapData[i].latitude)];

                    backWithAnim(xy);

                    return;
                }
            }
        },
        show_window(event){
            //destroy();
            // $("#monitoring_window").css("display","block");
            var id = $(event.currentTarget).attr("id");
            console.log(id);
            this.name_show=false;
            for (let i=0; i< this.mapData.length; i++) {
                if(this.mapData[i].deviceId==id){
                    var xy = [Number(this.mapData[i].longitude),Number(this.mapData[i].latitude)];
                    this.device_info_id=i;
                    // this.cameraid = this.mapData[i].deviceVedioCode;
                    this.cameraid = this.mapData[i].deviceCode
                    $('#cameraId').val(this.cameraid);
                    var dom = document.getElementById('monitoring_window');
                    var anchor = new ol.Overlay({
                        element:dom
                    });
                    anchor.setPosition(xy);
                    anchor.setOffset([-190,-345]);
                    map.addOverlay(anchor);
                    $("#device_name").html(this.mapData[i].deviceName);
                    this.window_show=true;
                    // startVideo(this.cameraid);
                    $.ajax({
                            type: "GET",
                            async: false,
                            url: ctx+"/api/camerasPreviewURLsInfo?cameraIndexCode="+this.cameraid+"&protocol=hls",
                            success: function (data) {
                                var path=$.parseJSON(data.data).data.url;
                                path=path.replace("10.1.155.185","10.1.155.184");
                                var str="<source src="+path+" type=\"application/x-mpegURL\">"
                                $("#example-video").append(str);
                                var player = videojs('example-video');
                                player.play();

                            },
                            error: function (xmlR, status, e) {
                            }
                        });
                    break;
                }
            }

            //show();
            // videoFuct();
            // loginSys();
            //获取实时视频
            // getRealmonitorRtsp();


        },
        show_info_form(){
            this.handleType=1;
            this.show_form=true;
            this.device=Object.assign({},this.mapData[this.device_info_id]);
            this.device.deviceType=String(this.device.deviceType);
            LocationTransformation(this.device,1);
            this.input_visible=true;
            this.icon_show=false;
            this.point_input_visible=false;
            this.deleteType=1;
            this.offchosePoint();
            this.mapClick=null;
            this.verifyDevice=Object.assign({},this.device);
            this.$refs.save.$el.innerText = "修改";
            this.$refs.delete.$el.innerText="删除";
        },
        handleSizeChange(val) {
            this.currentPage = 1;
            this.pageSize = val;
        },
        handleCurrentChange(val) {
            this.currentPage = val;
        },
        deviceBodyPo(){
            var code = this.handleType;
            if(code==1){
                this.handleType=2;
                this.point_input_visible=true;
                this.input_visible=false;
                this.deleteType=2;
                this.$refs.save.$el.innerText = "保存";
                this.$refs.delete.$el.innerText="取消";
            }else if(code==2){
                this.offchosePoint();
                this.mapClick=null;
                LocationTransformation(this.device,2);
                var result =  updateDeviceById(this.device);
                LocationTransformation(this.device,1);
                var message=result>0?"修改成功！":"修改失败！";
                var type=result>0?"success":"error";
                this.$message({
                    message:message,
                    type: type
                });
                if(result>0){
                    setTimeout(function () {
                        window.location.reload();
                    },1000);
                }

            }else if(code==0){
                this.offchosePoint();
                LocationTransformation(this.device,2);
                var result =  insertDeviceInfo(this.device);
                LocationTransformation(this.device,1);
                var message=result>0?"添加成功！":"添加失败！";
                var type=result>0?"success":"error";
                this.$message({
                    message:message,
                    type: type
                });
            }else{
                cosole.log("操作有误！");
            }
        },
        closeDeviceForm(){
            this.show_form=!this.show_form;
            this.input_visible=true;
            this.point_input_visible=false;
            this.icon_show=false;
            this.offchosePoint();
            this.mapClick=null;
        },
        //注销经纬度选择事件 隐藏选择按钮
        offchosePoint(){
            map.unByKey(this.mapClick);
        },
        //根据名称搜索设备
        serchDevices(){
            this.table_visible=true;
            var serchBody={
                deviceName:this.deviceNameSerch,
                mapId:mapId,
                areaId:areaId
                //deviceArea:id
            };
            axios
                .post(ctx+'/backstage/gismap/devicelocation/byName',serchBody)
                .then(response => (this.tableData=response.data.data)

                )
                .catch(function (error) {
                    // 请求失败处理
                });
        },
        //添加设备
        addDevice(){
            this.handleType=0;
            this.show_form=true;
            this.input_visible=false;
            this.offchosePoint();
            this.mapClick=null;
            this.point_input_visible=true;
            this.deleteType=2;
            this.icon_show=false;
            this.device={
                longitude:"",
                latitude:"",
                createTime:getNowDate()
            }
            this.$refs.save.$el.innerText = "添加";
            this.$refs.delete.$el.innerText="取消";
        },
        //选择坐标
        choicePoint(){
            var vue1=this;
            if(this.mapClick==null){
                this.mapClick =map.on("click",function(event){

                    var coordinate =event.coordinate;
                    vue1.device.longitude=coordinate[0];
                    vue1.device.latitude=coordinate[1];
                    LocationTransformation(vue1.device,1);
                    var anchor = new ol.Overlay({
                        element: document.getElementById('icon_red')
                    });
                    console.log(coordinate);
                    anchor.setPosition(coordinate);
                    anchor.setOffset([-8,-20]);
                    map.addOverlay(anchor);
                    vue1.icon_show=true;
                })
            }
        },
        deleteDevice(){
            if(this.deleteType==1){
                var id = this.device.deviceId;
                this.open(id);
            }else{
                this.closeDeviceForm();
            }
        },
        open(id) {
            this.$confirm('此操作将删除该摄像头信息, 是否继续?','提示',{
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                var result =  deleteDeviceById(id);
                var message=result>0?"删除成功！":"删除失败！";
                var type=result>0?"success":"error";
                this.$message({
                    type: type,
                    message: message
                });
            }).catch(() => {
                this.$message({
                    type: 'info',
                    message: '已取消删除'
                });
            });
        },
        handleEdit(index,row){
            var device_id = row.deviceId;
            for (let i=0; i< this.mapData.length; i++) {
                if(this.mapData[i].deviceId==device_id){
                    this.device_info_id=i;
                    this.show_info_form();
                    return;
                }
            }
        },
        closeInfoWindows(){
            f();
            // videoFuct();
            //hide();
            //this.window_show=false;
            // stopAllVideo();
        },
        changeMapByAreaDevice(mapId) {

            var url = window.location.href;
            if (url.indexOf("?") != -1) {
                url = url.substring(0, url.indexOf("?"));
            }
            url = url + "?areaId=" + areaId + "&mapId=" + mapId;
            if(spaceId != ""&& typeof spaceId !="undefined"){
                url = url+"&spaceId="+spaceId;
            }
            window.location.href = url;

        },
        getDevCodeTypeValue() {
            selectCodeTypeValue().then(res => {
                this.deviceTypeSelectList = res.data.data;
            }).catch(err => {
                console.log("设备类型下拉列表展示出错！");
            })
        },
        changeSpaceByAreaDevice(item){

            var url = window.location.href;
            if (url.indexOf("?") != -1) {
                url = url.substring(0, url.indexOf("?"));
            }
            url = url + "?areaId=" + item.id + "&mapId=1";
            if(spaceId != ""&& typeof spaceId !="undefined"){
                url = url+"&spaceId="+spaceId;
            }
            window.location.href = url;
        },
        showDeviceName(event,item){
            var id = $(event.currentTarget).attr("id");
            if(this.window_show&&this.cameraid===item.deviceVedioCode){
                return;
            }
            this.name_show=true;
                    var xy = [Number(item.longitude),Number(item.latitude)];
                    var dom = document.getElementById('deviceName');
                    var anchor = new ol.Overlay({
                        element:dom
                    });
                    anchor.setPosition(xy);
                    anchor.setOffset([5,5]);
                    map.addOverlay(anchor);
                    $("#deviceName").html(item.deviceName);
            },

    }
})
//地图设置中心
var center = ol.proj.transform([104.06667, 30.66667], 'EPSG:4326', 'EPSG:3857');
//计算静态地图映射到地图上的范围。保持比例的情况下，把分辨率放大一些
var extent = [
    center[0] - 550 * 1050 / 2,
    center[1] - 344 * 1050 / 2,
    center[0] + 550 * 1050 / 2,
    center[1] + 344 * 1050 / 2
];
// 创建地图
var  mapList = mapPath.pathList;
var mapType = mapId;
// console.log(mapType);
// if(typeof mapType=='undefined'){
//     mapType=1;
// }
var map = new ol.Map({
    // 设置地图图层
    layers: [
        // 创建一个使用Open Street Map地图源的瓦片图层
        new ol.layer.Image({
            source: new ol.source.ImageStatic({
                url: ctx+'/static/mp/img/'+mapPath.pathPre+'/'+mapList[mapType-1], // 静态地图路径
                imageExtent: extent //映射到地图的范围
            })
        })
    ],
    // 设置显示地图的视图
    view: new ol.View({
        center: center,//首次显示地图的位置
        zoom: 8.9,//图层大小
        minZoom: 7, //图层缩小最小值
        maxZoom: 14 //图层缩小最大值
    }),
    // 让id为map的div作为地图的容器
    target: 'map'
});
console.log(center[0]- 550*1000/2 + 390 * 1000, center[1]-344*1000/2 + (344 - 145) * 1000);
map.on("pointerdrag",function () {
    //videoFuct();
})
map.on("change:resolution",function () {
    // videoFuct();
});
map.on("moveend",function () {

    console.log(mapLightDeviceId);
    if(lightDeviceStatus){
        $("#"+mapLightDeviceId+">i").css("background-color","rgb(0,46,247)");
    }else{
        $("#"+mapLightDeviceId+">i").css("background-color","rgb(247,0,15)");
    }


})
var view=map.getView();
view.on('change:center',function(e){
    // videoFuct();
});
//从html中获取dom并且设置位置
setImagePoint(newdeviceList.length);
//将每个摄像头点位渲染到地图上 point_count 为摄像头数量
function setImagePoint(point_count){
    for (let i=0; i<point_count; i++) {
        var dom = document.getElementsByClassName('anchor')[i];
        var anchor = new ol.Overlay({
            element:dom
        });
        var point=[newdeviceList[i].longitude,newdeviceList[i].latitude];
        anchor.setPosition(point);
        anchor.setOffset([-15,-20]);
        map.addOverlay(anchor);
    }
}
//地图移动动画
function backWithAnim(point) {
    var pan = ol.animation.pan({
        duration: 2000,
        source: map.getView().getCenter(),
        easing: ol.easing.easeOut    // 设置对应选择的动画
    });
    map.beforeRender(pan);
    map.getView().setCenter(point);
}
//根据id删除摄像头
function  deleteDeviceById(id) {
    var result = -1;
    $.ajax(
        {
            type: "GET",
            async: false,
            url: ctx+"/backstage/gismap/devicelocation/delete/"+id,
            success: function (msg) {
                result=msg.data;
            },
            error: function (xmlR, status, e) {
            }
        });
    return result;
}

//更新摄像头信息
function  updateDeviceById(device){
    var result = -1;
    $.ajax(
        {
            type: "POST",
            async: false,
            contentType: "application/json",
            data:JSON.stringify(device),
            url: ctx+"/backstage/gismap/devicelocation/update",
            success: function (msg) {
                result=msg.data;
            },
            error: function (xmlR, status, e) {
            }
        });
    return result;
}

function  insertDeviceInfo(device){
    var result = -1;
    $.ajax(
        {
            type: "POST",
            async: false,
            contentType: "application/json",
            data:JSON.stringify(device),
            url: ctx+"/backstage/gismap/devicelocation/insert/"+(typeof mapId==='undefined'?1:mapId),
            success: function (msg) {
                result=msg.data;
            },
            error: function (xmlR, status, e) {
                alert("AJAX请求异常，添加失败！");
            }
        });
    return result;
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
//坐标转换
function LocationTransformation(device,type) {
    var condition = [device.longitude,device.latitude];
    if(type==1){
        condition =ol.proj.transform(condition, 'EPSG:3857', 'EPSG:4326');//地理坐标转世界坐标
    }else{
        condition =ol.proj.transform(condition,  'EPSG:4326','EPSG:3857');//世界坐标转地理坐标
    }
    device.longitude = condition[0];
    device.latitude = condition[1];
}
function getQueryVariable(variable) {
    var query = window.location.search.substring(1);
    var vars = query.split("&");
    for (var i = 0; i < vars.length; i++) {
        var pair = vars[i].split("=");
        if (pair[0] === variable) {
            return pair[1];
        }
    }
};

function getOrganInfo() {
    let result = [];
    $.ajax(
        {
            type: "GET",
            async: false,
            url: ctx+"/backstage/gismap/devicelocation/getPrgan/"+spaceId,
            success: function (msg) {
                result =  msg.data;
            },
            error: function (xmlR, status, e) {
                console.log("初始化失败！");
            }
        });
    return result;
}

function getAreaName() {
    let result = '';
    $.ajax(
        {
            type: "GET",
            async: false,
            url: ctx+"/backstage/gismap/devicelocation/getAreaName/"+areaId,
            success: function (msg) {
                result =  msg.data;
            },
            error: function (xmlR, status, e) {
                console.log("初始化失败！");
            }
        });
    return result;
}

function getMapPath() {
    let result = {};
    $.ajax(
        {
            type: "GET",
            async: false,
            url: ctx+"/backstage/gismap/devicelocation/getMapPath/"+areaId,
            success: function (msg) {
                result =  msg.data;
            },
            error: function (xmlR, status, e) {
                console.log("初始化失败！");
            }
        });
    return result;
}

function f() {
    if(mapPath!=null){
        console.log(mapPath);
        console.log("正在创建");
        //create();
        var point =  [9330076.353142684, 1837339.257845657];
        var dom = document.getElementById('monitoring_window');
        var anchor = new ol.Overlay({
            element:dom
        });
        anchor.setPosition(point);
        anchor.setOffset([-190,-345]);
        map.addOverlay(anchor);
    }else{
        var dom = document.getElementById('monitoring_window');
        dom.style.display='none';
    }

}
f();
window.onbeforeunload=function () {
    destroy();
}