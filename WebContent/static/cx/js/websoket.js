console.log(location.host);
var socketURL = "ws://" + location.host +ctx+ "/ws/asset/?alarm=1";
var socket;
if (typeof (WebSocket) == "undefined") {
    console.log("遗憾：您的浏览器不支持WebSocket");
} else {
    console.log("恭喜：您的浏览器支持WebSocket");
    //实现化WebSocket对象
    //指定要连接的服务器地址与端口建立连接，
    //无法使用wss，浏览器打开WebSocket时报错
    //ws对应http、wss对应https
    socket = new WebSocket(socketURL);
    //连接打开事件
    socket.onopen = function () {
        console.log("Socket 已打开");
    };
    //收到消息事件
    socket.onmessage = function (msg) {
        let count = msg.data.replace("\"","").replace("\"","");
        console.log(count);
        $("#alarmNum").html(count);

    };
    //连接关闭事件
    socket.onclose = function () {
        console.log("Socket已关闭");
    };
    //发生了错误事件
    socket.onerror = function () {
    }
    //窗口关闭时，关闭连接
    window.onbeforeunload = function () {
        socket.close();
    };
}