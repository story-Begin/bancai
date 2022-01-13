<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.baosight.iplat4j.core.FrameworkInfo" %>
<%@ page import="com.baosight.iplat4j.core.ioc.spring.PlatApplicationContext" %>

<%@ page import="com.baosight.iplat4j.core.license.LicenseStub" %>
<%@ page import="com.baosight.iplat4j.core.util.StringUtils" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="static com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="EF" tagdir="/WEB-INF/tags/EF" %>

<%
    org.springframework.security.core.context.SecurityContextHolder.clearContext();
    LicenseStub.setLicenseDir(application.getRealPath("/WEB-INF"));
    String[] ret = LicenseStub.checkLicense2();
    boolean valid = "true".equals(ret[0]); //LicenseStub.checkLicense2();
    int days = 0;
    if (!"".equals(ret[2]) && !"0".equals(ret[2])) {
        days = Integer.parseInt(ret[2]);
    }
    String licMsg = valid ? (("false".equals(ret[3]) && days >= -10 && days < 0) ? "<div style='color:#ee9933;font-weight:bold;font-size:18px'>许可证还有[" + (-days) + "]天将过期!</div>" : "")
            : "<div style='color:red;font-weight:bold;font-size:22px'>许可证非法!</div>";

    Exception exp = (Exception) request.getAttribute("AuthenticationException");
    String user = (String) request.getAttribute("AuthenticationUser");

    if (!org.springframework.util.StringUtils.isEmpty(request.getParameter("expmsg"))) {
        String expmsg = request.getParameter("expmsg");
        exp = new Exception(URLDecoder.decode("Exception:" + expmsg));
    }
    String loginErrTag = "0";
    if (!org.springframework.util.StringUtils.isEmpty(request.getParameter("login_error"))) {
        loginErrTag = request.getParameter("login_error");
    }
    String username = "";
    String password = "";
    String captcha = "";
    if (exp != null) {
        username = user;
    }

    String usrHeader = request.getHeader("user-agent");


    String projectCname = FrameworkInfo.getProjectCname();
    String projectTypeDesc = FrameworkInfo.getProjectTypeDesc();

    // 获取iPlatUI静态资源地址
    String iPlatStaticURL = FrameworkInfo.getPlatStaticURL(request);

    String theme = org.apache.commons.lang.StringUtils.defaultIfEmpty(PlatApplicationContext.getProperty("theme"), "ant");

    // 获取Context根路径，考虑到分布式部署的场景，不能直接使用WebContext
    String iPlatContext = FrameworkInfo.getPlatWebContext(request);
    // 验证码验证信息
    String captchaMessage = (String) request.getAttribute("captchaMessage");
%>
<c:set var="ctx" value="<%=iPlatContext%>"/>
<c:set var="iPlatStaticURL" value="<%=iPlatStaticURL%>"/>

<c:set var="loginExp" value="<%=exp%>"/>
<c:set var="theme" value="<%=theme%>" scope="session"/>

<html class="i-theme-blue">
<head>
    <meta charset="utf-8"/>
    <meta name="robots" content="noindex, nofollow"/>
    <meta name="description" content="登录界面"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>


    <% if (StringUtils.isNotEmpty(projectCname) && StringUtils.isNotEmpty(projectTypeDesc)) { %>
    <title><%=projectCname%>[<%=projectTypeDesc%>]登录界面</title>
    <% } else { %>
    <title>登录界面</title>
    <% } %>

    <link rel="shortcut icon" href="iplat.ico" type="image/x-icon">
    <link rel="stylesheet" id="css-main" href="${iPlatStaticURL}/iplatui/assets/css/iplat.ui.bootstrap.min.css">
    <%--    <link href="static/css/login/iPlatV6-login.css" rel="stylesheet" type="text/css"/>--%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/login/iPlatV6-login.css"/>
    <%--<link rel="stylesheet" type="text/css"  href="${iPlatStaticURL}/iplatui/css/iplat.ui.ued.login.css">&lt;%&ndash;ued亮色样式&ndash;%&gt;--%>
    <script src="${iPlatStaticURL}/kendoui/js/jquery.min.js"></script>

    <!--[if lte IE 8]>
    <link href="${iPlatStaticURL}/iPlatV6-login-ie.css" rel="stylesheet" type="text/css"/>
    <link href="${iPlatStaticURL}/static/css/iplat.ui.deep-blue.min.css" rel="stylesheet" type="text/css"/>
    <script src="${iPlatStaticURL}/iplatui/assets/js/polyfills/iplat.ui.ie8.polyfills.min.js"></script>
    <![endif]-->

    <script src="${iPlatStaticURL}/iPlatV6-login.js"></script>
    <%
        String domain = FrameworkInfo.getProjectAppTopDomain();
        if (domain != null && domain.startsWith(".")) {
            domain = domain.substring(1);
    %>
    <script type="text/javascript">
        try {
            document.domain = '<%=domain%>';
        } catch (ex) {
            alert('model not valid[<%=domain%>]');
        }
    </script>
    <%
        }
    %>
</head>
<body class="i-theme-${theme}" style="">
<div class="main" >
    <div class="wrapper" style="display:inline;">
        <div style="width: 100%; height: 100%;padding-left: 20%;padding-right: 20%;padding-top:10%;padding-bottom:10%;position: relative;">
            <div style="width:100%;height:100%;">
                <div class="login-left"></div>
                <div style="width:40%; height:99%; float:right;margin-top:5px;"
                     class="login-block  <c:if test="${not empty loginExp}"> animated shake</c:if>">
                    <div style="width:100%;height:100%;">
                        <div class="form-header" style="padding-top:20%;">
                            <div class="logo"></div>
                            <p>用户登录</p>
                            <%
                                if (org.apache.commons.lang3.StringUtils.isNotBlank(captchaMessage)) { %>
                            <p style="color:red; font-size: 12px;"><%=captchaMessage%>
                            </p>

                            <% } %>

                            <p class="text-danger">
                                <c:if test="${not empty loginExp}">
                                    <%
                                        String loginError = exp.getMessage();
                                        int index = loginError.indexOf("Exception:");
                                        if (index >= 0) {
                                            loginError = loginError.substring(index + 10);
                                        }
                                        if (!"1".equals(loginErrTag) &&
                                                (request.getAttribute("AuthenticationUser") == null || request.getAttribute("AuthenticationUser") == "")) {
                                            loginError = "请输入用户名";
                                        }
                                    %>
                                    <%=loginError%>
                                </c:if>
                            </p>
                        </div>

                        <form autocomplete="off" class="form-horizontal" style="height:80%;padding-top:20%;padding-bottom:20%;" action="${ctx}/login"
                              method="post" onsubmit="javascript:return loginClick();">
                            <div class="form-group user-icon-div">
                                <div class="col-xs-12">
                                    <i class="user-icon"></i>
                                    <input class="form-input" type="text"
                                    <%--                                           value="<%=encoder.encodeForHTMLAttribute(username)%>" id="p_username"--%>
                                           name="p_username"
                                           placeholder="请输入用户名"/>
                                </div>
                            </div>
                            <div class="form-group password user-passwd-div">
                                <div class="col-xs-12">
                                    <i class="user-passwd-icon"></i>
                                    <input class="form-input" type="password"
                                    <%-- value="<%=encoder.encodeForHTMLAttribute(password)%>" id="p_password"--%>
                                           name="p_password"
                                           placeholder="请输入密码"/>
                                </div>
                            </div>
                            <div class="form-group user-kaptcha-div">
                                <div class="col-xs-12">
                                    <i class="user-kaptcha-icon"></i>
                                    <input class="form-input" type="text" name="captcha" style="width: 50%;"
                                           name="captcha" id="p_captcha"
                                           placeholder="验证码"/>
                                    <img src="${ctx}/captcha.jpg?Math.random()" class="vaildImg"
                                         style="cursor:pointer; width: 40%;  height: 40px; margin-top: -4px; margin-left:5%;"/>
                                </div>
                            </div>
                            <div class="form-group remember">
                                <div class="col-xs-6">
                                    <%--<label class="css-input">--%>
                                    <%--<input type="checkbox" id="login-remember-me" value="false"--%>
                                    <%--name="remember-me"/><span class="i-icon"></span>--%>
                                    <%--2周内免登录--%>
                                    <%--</label>--%>
                                </div>
                                <div style="text-align: right;width: 100%;">
                                    <%--<a href="${ctx}/web/XS0102" style="margin-right: 6px">注册</a>--%>
                                    <a href="${ctx}/web/XS0106">忘记密码？</a>
                                </div>
                            </div>
                            <div class="form-group log-in">
                                <div class="col-xs-12">
                                    <button id="login" class="login-btn" type="submit">登录
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="content">
            <%--<div class="col-lg-6 col-lg-offset-3 col-sm-8 col-sm-offset-2">--%>
            <%--<div class="warning-window" style="margin-top: -354px; height: 354px;">--%>
            <%--<div class="i-region-header">警告<span class="i-icon i-close"></span>--%>
            <%--</div>--%>
            <%--<div class="i-region-content">--%>
            <%--<div class="col-md-12">--%>
            <%--<span class="warning-msg">请使用IE8或Chrome v35及以上浏览器访问</span>--%>
            <%--</div>--%>
            <%--<div class="col-lg-6 col-lg-offset-3 col-sm-8 col-sm-offset-2" style="padding: 0">--%>
            <%--<div class="browser-icon col-md-12" style="padding: 0">--%>
            <%--<div class="col-xs-5">--%>
            <%--<img src="${iPlatStaticURL}/iplatui/img/icon_ie.png" width="104" height="101">--%>
            <%--</div>--%>
            <%--<div class="col-xs-5 col-xs-offset-2">--%>
            <%--<img src="${iPlatStaticURL}/iplatui/img/icon_chrome.png" width="101"--%>
            <%--height="101">--%>
            <%--</div>--%>
            <%--</div>--%>
            <%--<div class="browser-name col-md-12" style="padding: 0">--%>
            <%--<div class="col-xs-5">--%>
            <%--<span class="ie-name">IE</span>--%>
            <%--</div>--%>
            <%--<div class="col-xs-5 col-xs-offset-2">--%>
            <%--<span class="chrome-name">Chrome</span>--%>
            <%--</div>--%>
            <%--</div>--%>
            <%--<div class="download-browser col-md-12" style="padding: 0">--%>
            <%--<div class="col-xs-5">--%>
            <%--<input class="download-ie download-btn" type="button" value="点击下载"--%>
            <%--onclick="window.open('https://support.microsoft.com/zh-cn/help/17621/internet-explorer-downloads')"/>--%>
            <%--</div>--%>
            <%--<div class="col-xs-5 col-xs-offset-2">--%>
            <%--<input class="download-chrome download-btn" type="button" value="点击下载"--%>
            <%--onclick="window.open('https://www.google.com/chrome/browser/desktop/index.html')"/>--%>
            <%--</div>--%>
            <%--</div>--%>
            <%--</div>--%>
            <%--</div>--%>
            <%--</div>--%>
            <%--</div>--%>
        </div>
    </div>
    <div class="info">
        <div class="row">
            <div class="footer-center col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3">
                <div class="phone-number">
                    &emsp;
                    <%--                    <span>运维平台热线  8008200220、4008210860、26646708、26642410</span>--%>
                </div>
                <div class="copyright-info">
                    <span>©上海宝信软件股份有限公司 Copyright ©2020 BAOSIGHT Corporation. All Rights Reserved</span>
                </div>
            </div>
            <div class="footer-right col-sm-2 col-md-3" style="display:none;">
                <div class="footer-logo">
                    <img src="${iPlatStaticURL}/iplatui/img/icon_ie.png" width="51"
                         onclick="window.open('https://support.microsoft.com/zh-cn/help/17621/internet-explorer-downloads')">
                </div>
                <div class="footer-logo">
                    <img src="${iPlatStaticURL}/iplatui/img/icon_chrome.png" width="51"
                         onclick="window.open('https://www.google.com/chrome/browser/desktop/index.html')">
                </div>
            </div>

        </div>
    </div>
</div>
<div class="i-overlay"></div>
</body>
</html>


