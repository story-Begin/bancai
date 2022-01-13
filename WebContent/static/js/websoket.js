console.log(location.host);
var socketURLV2 = "ws://" + location.host +ctx+ "/ws/asset/alarm/";
var socketV2;
if (typeof (WebSocket) == "undefined") {
    console.log("遗憾：您的浏览器不支持WebSocketV2");
} else {
    console.log("恭喜：您的浏览器支持WebSocketV2");
    //实现化WebSocket对象
    //指定要连接的服务器地址与端口建立连接，
    //无法使用wss，浏览器打开WebSocket时报错
    //ws对应http、wss对应https
    socketV2 = new WebSocket(socketURLV2);
    //连接打开事件
    socketV2.onopen = function () {
        console.log("Socket 已打开");
    };
    //收到消息事件
    socketV2.onmessage = function (msg) {
        let dataList = JSON.parse(msg.data);
        $("#alarmContent").animate({"bottom":"0px"},1000,function () {
            $("#H1content").text(dataList.H1content);
            $("#divItem").text(dataList.divItem);
        });


    };
    //连接关闭事件
    socketV2.onclose = function () {
        console.log("Socket已关闭");
    };
    //发生了错误事件
    socketV2.onerror = function () {
    }
    //窗口关闭时，关闭连接
    window.onbeforeunload = function () {
        socketV2.close();
    };
}