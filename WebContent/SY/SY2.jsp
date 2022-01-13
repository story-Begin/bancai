<%--
  Created by IntelliJ IDEA.
  User: huang
  Date: 2020-07-13
  Time: 11:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/element-ui/2.11.0/theme-chalk/index.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/sy/sy.css"/>

    <style>

        * {
            margin: 0;
            padding: 0
        }

        html, body {
            padding: 0px;
            margin: 0px;
            height: 100%;
        }

        body {
            background: url(${pageContext.request.contextPath}/static/img/main/homepage.gif);
            background-size: 100% 100%;
            background-repeat: no-repeat;
        }

        .parent_div {
            width: 100%;
            height: 100%;
            position: absolute;
        }

        .top_div {
            height: 11%;
        }


        #slide {
            position: relative;
            top: 45%;
            left: 12%;
            height: 80px;
            width: 160px;
            color: #FA8E93;
            overflow: hidden;
            /*border: 1px solid #ccc*/
        }

        #slide p {
            height: 34px;
            font-size: 12px;
            text-align: center;
            line-height: 15px;
            overflow: hidden
        }

        #slide span {
            float: left;
            padding-left: 5px;
            padding-top: 1px;
        }

        #police-span {
            padding-left: 5px;
        }

        .call-police-span {
            text-align: center;
            display: block;
            float: left;
            width: 50%;
        }

        .call-police-p {
            padding-top: 10px;
            color: white;
            font-size: 12px;
        }

        .north {
            position: relative;
            width: 70%;
            height: 26%;
            top: 25%;
            left:10%;
            /*border: 1px solid red;*/
            -webkit-transform: rotate(22deg);
            -moz-transform: rotate(22deg);
            -o-transform: rotate(22deg);
            -ms-transform: rotate(22deg);
            transform: rotate(22deg);
        }

        .north:hover::after {
            content: attr(title);
            display: inline-block;
            padding: 10px 14px;
            background-color:#00d0ff24;
            border-radius: 15px;
            position: absolute;
            width: 90%;
            height: 90%;
            color: white;
            font-size: 26px;
            text-align: center;
        }

        .south {
            position: relative;
            width: 100%;
            height: 25%;
            top: 30%;
        }

        .south:hover::after {
            content: attr(title);
            display: inline-block;
            padding: 10px 14px;
            /*border: 1px solid #5ac0de;*/
            background-color:#00d0ff24;
            border-radius: 15px;
            position: absolute;
            height: 90%;
            width: 60%;
            left: 24%;
            color: white;
            font-size: 26px;
            text-align: center;
        }
        table td{border:1px dotted #2b1a1a;}


    </style>

</head>

<body style="overflow-y:hidden;">
<div class="parent_div">
    <div class="left_div">
        <div style="position:relative;width:100%;height:100%;">
        <div class="left_div_top">
            <div style="position:relative;width:100%;height:100%;">
                <span style="font-size:14px;float:left;padding:0px 24px;color:#00dcff;">接入设备总数</span>
                <p id="sumCameraData" style="position:absolute;margin-left:10px;"></p>
            </div>
        </div>
        <div class="left_div_center">
            <span style="font-size:14px;float:left;margin:14px;color:#00dcff;">设备报警统计</span>
            <div id="callPoliceRate" style="height: 75%;width: 100%;"></div>
        </div>
        <div class="left_div_bottom">
            <table style="width:100%;font-size:14px;" border="0" cellspacing="0">
                <tr style="color:#4fb1f9;text-align: center;">
                <td style="line-height:40px;"><span>报警总数</span></td>
                <td style="line-height:40px;"><span>已处理数</span></td>
                </tr>
                <tr style="text-align: center;color:white;font-weight:800;">
                <td style="line-height:40px;"><span id="sumNum"></span></td>
                <td style="line-height:40px;"><span id="disposeNum"></span></td>
                </tr>
            </table>
        </div>
        </div>
    </div>
    <div class="center_div">
        <div class="north" title="冷轧北区" onclick="northClick()"></div>
        <div class="south" title="冷轧南区" onclick="southClick()"></div>
    </div>
    <div class="right_div">
        <div style="position:relative;width:100%;height:100%;">
            <div class="right_div_top">
                <span style="font-size:14px;float:right;margin-right:52px;color:#00dcff;margin-top:-3px;">运行状态统计</span>
                <div id="onLineRate" style="height: 100%;width:100%;border-radius:5px!important;margin-bottom:5px;"></div>
                <div id="imageRate" style="height:  45%;;width:100%;;border-radius:5px!important;margin-bottom:5px;"></div>
            </div>
            <div class="right_div_center">
                <span style="font-size:14px;float:left;color:#00dcff;margin-left:25px;margin-top:15px;">视频调用统计</span>
                <div  style="height:75%;width:100%;position:relative;">
                    <div id="videoStatistics"  style="height:90%;width:100%;position: absolute;margin-top:38px;"></div>
                </div>
            </div>
            <div class="right_div_bottom">

                <div style="height:22%;width:100%;position:relative;">
                    <table style="width:100%;font-size:12px;" border="0" cellspacing="0">
                        <tr style="color:#4fb1f9;">
                            <td><span>（平台）当日调用</span></td>
                            <td><span>（第三方）当日调用</span></td>
                        </tr>
                        <tr style="text-align: center;color:white;font-weight:800;">
                            <td><span id="platform_day_sum">1</span></td>
                            <td><span id="without_day_sum">2</span></td>
                        </tr>
                        <tr style="color:#4fb1f9;">
                            <td><span>（平台）累计调用</span></td>
                            <td><span>（第三方）累计调用</span></td>
                        </tr>
                        <tr style="text-align: center;color:white;font-weight:800;">
                            <td><span id="platform_add_sum">1</span></td>
                            <td><span id="without_add_sum">2</span></td>
                        </tr>
                    </table>
                </div>



            </div>
        </div>
    </div>
    <%--<div class="top_div"></div>--%>
    <%--<div class="left_div">--%>
        <%--<div class="left_div_top">--%>
            <%--<span style="font-size:12px;font-weight:800;color:white;float:left;margin-top:-20px;">接入设备数量</span>--%>
            <%--<p id="sumCameraData"--%>
               <%--style="color:#32c5e9; position:relative; top: 52%; left:15%;width: 40%; font-size: 46px;"></p>--%>
            <%--&lt;%&ndash;            <div id="slide">&ndash;%&gt;--%>
            <%--&lt;%&ndash;                <div id="slide1"></div>&ndash;%&gt;--%>
            <%--&lt;%&ndash;                <div id=slide2></div>&ndash;%&gt;--%>
            <%--&lt;%&ndash;            </div>&ndash;%&gt;--%>
        <%--</div>--%>
        <%--<div style="width: 65%;height: 50%;  margin:10px 20px;float:left; background-color:#1133426b;">--%>
            <%--<span style="font-size:12px;font-weight:800;color:white;">报警统计</span>--%>
            <%--<table style="width:100%;font-size:12px;margin-bottom:20px;" border="1">--%>
                <%--<tr style="color:#4fb1f9;text-align: center;">--%>
                    <%--<td><span class="call-police-span">报警总数</span></td>--%>
                    <%--<td><span class="call-police-span">已处理数</span></td>--%>
                <%--</tr>--%>
                <%--<tr style="text-align: center;color:white;font-weight:800;">--%>
                    <%--<td><span id="sumNum"></span></td>--%>
                    <%--<td><span id="disposeNum"></span></td>--%>
                <%--</tr>--%>
            <%--</table>--%>
            <%--<div class="left_div_bottom">--%>
                <%--<div id="callPoliceRate" style="height: 150px;width: 68%;padding-left:20px;margin-top:20px;"></div>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</div>--%>
    <%--<div class="center_div">--%>
    <%--<div class="north" title="冷轧北区" onclick="northClick()"></div>--%>
    <%--<div class="south" title="冷轧南区" onclick="southClick()"></div>--%>
    <%--</div>--%>
    <%--<div class="right_div">--%>
        <%--<div id="sumPre" style="height: 10%;width: 280px;border-radius:5px!important;"></div>--%>
        <%--<span style="font-size:12px;font-weight:800;color:white;">设备在线率</span>--%>

        <%--<div id="onLineRate" style="height: 100px;width: 280px;border-radius:5px!important;margin-bottom:3px;"></div>--%>
        <%--<span style="font-size:12px;font-weight:800;color:white;">设备在线诊断</span>--%>

        <%--<div id="imageRate" style="height: 120px;width: 280px;border-radius:5px!important;margin-bottom:8px;"></div>--%>
        <%--<div style="height: 80px;width:280px;background:#1e475a87;border-radius:5px;">--%>
            <%--<span style="font-size:12px;font-weight:800;color:white;">视频调用统计</span>--%>
            <%--<table style="width:100%;font-size:12px;" border="1">--%>
                <%--<tr style="color:#4fb1f9;">--%>
                    <%--<td><span>（平台）当日调用</span></td>--%>
                    <%--<td><span>（第三方）当日调用</span></td>--%>
                <%--</tr>--%>
                <%--<tr style="text-align: center;color:white;font-weight:800;">--%>
                    <%--<td><span id="platform_day_sum">1</span></td>--%>
                    <%--<td><span id="without_day_sum">2</span></td>--%>
                <%--</tr>--%>
                <%--<tr style="color:#4fb1f9;">--%>
                    <%--<td><span>（平台）累计调用</span></td>--%>
                    <%--<td><span>（第三方）累计调用</span></td>--%>
                <%--</tr>--%>
                <%--<tr style="text-align: center;color:white;font-weight:800;">--%>
                    <%--<td><span id="platform_add_sum">1</span></td>--%>
                    <%--<td><span id="without_add_sum">2</span></td>--%>
                <%--</tr>--%>
            <%--</table>--%>
        <%--</div>--%>
        <%--<div id="videoStatistics" style="height:140px;width:280px;margin-top:15px;"></div>--%>
    <%--</div>--%>

</div>

<a href="http://localhost:8083/magang/web/GSMP01?areaId=49&mapId=1" target="_bank"
   style="display: block;width: 50px;height: 50px;position: absolute;left: 604px;top:353px;"></a>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/mp/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/static/echartsjs/echarts.js"></script>
<script src="${pageContext.request.contextPath}/static/echartsjs/echartsdark.js"></script>
<%--    <script src="${pageContext.request.contextPath}/static/echartsjs/echarts-liquidfill.js"></script>--%>
<script src="${pageContext.request.contextPath}/static/build/dist/echarts.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/api/sy/sy.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/api/sy/websoket.js"></script>
<script>
    var ctx = '${pageContext.request.contextPath}'
</script>
</body>
<script>
    // let speed = 80
    // let slide = document.getElementById("slide");
    // let slide2 = document.getElementById("slide2");
    // let slide1 = document.getElementById("slide1");
    // slide2.innerHTML = slide1.innerHTML
    //
    // function Marquee() {
    //     if (slide2.offsetTop - slide.scrollTop <= 0)
    //         slide.scrollTop -= slide1.offsetHeight
    //     else {
    //         slide.scrollTop++
    //     }
    // }
    //
    // let MyMar = setInterval(Marquee, speed)
    // slide.onmouseover = function () {
    //     clearInterval(MyMar)
    // }
    // slide.onmouseout = function () {
    //     MyMar = setInterval(Marquee, speed)
    // }

    /**
     * 北区
     */
    function northClick() {
        window.open("${pageContext.request.contextPath}/web/GSMP01?spaceId=1", "_bank");
    }

    /**
     * 南区
     */
    function southClick() {
        window.open("${pageContext.request.contextPath}/web/GSMP01?spaceId=0", "_bank");
    }
</script>

</html>


​
