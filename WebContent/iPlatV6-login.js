$(function () {
    // 登录页加载完成时，进行浏览器版本检测
    window.onload = function () {
        //初始化的时候加载验证码
        // $('.vaildImg').attr('src', '/captcha.jpg?d=' + (new Date()).getTime());
        //点击图片切换验证码
        $('.vaildImg').click(function () {
            $(this).attr('src', '/mgvideo/captcha.jpg?d=' + (new Date()).getTime());
        });
        var BROWSER_VERSION = 9;
        var browser = (function () {
            var ua = navigator.userAgent, tem,
                M = ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];
            if (/trident/i.test(M[1])) {
                tem = /\brv[ :]+(\d+)/g.exec(ua) || [];
                return 'IE ' + (tem[1] || '');
            }
            if (M[1] === 'Chrome') {
                tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
                if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
            }
            M = M[2] ? [M[1], M[2]] : [navigator.appName, navigator.appVersion, '-?'];
            if ((tem = ua.match(/version\/(\d+)/i)) != null) M.splice(1, 1, tem[1]);
            return M.join(' ');
        })();
        var BrowserVersion = browser.split(" ");
        if ((/^(MS)?( )?IE/).test(browser) && BrowserVersion[1] < BROWSER_VERSION) {
            $(".warning-window").css("display", "block");
            $(".i-overlay").css("display", "block");
        }
        if ((/^(MS)?( )?IE/).test(browser) && BrowserVersion[1] < BROWSER_VERSION - 1) {
            $("#login").attr("disabled", true);
        }
    };
    $(".i-close").on("click", function () {
        $(".warning-window").css("display", "none");
        $(".i-overlay").css("display", "none");
    });

    //放大镜
    $(".i-zoom-close").on("click", function () {
        $(".zoom-window").css("display", "none");
        $(".i-overlay").css("display", "none");
    });

    $(".info-detail").on("click", function () {
        $(".zoom-window").css("display", "block");
        $(".i-overlay").css("display", "block");
    });

    $.fn.textScroll = function (options) {
        var defaults = {
                duration: 8000,//滚动总时长控制
                mode: 'normal',//滚动模式：普通normal;逐行line
                perDistance: 18//line模式下每次滚动距离
            },
            that = this,
            scrollInterval,
            content = this.find(".text-content");
        var items = $.extend({}, defaults, options);

        //添加占位元素，处理无法滚动到底的情况
        function addHoldDiv(stage, textContent) {
            if (items.mode === 'no-gap') {
                that.append(content.clone().addClass("second-text"));
            } else {
                var holdDiv = "<div class='hold-scroll'></div>";
                stage.append(holdDiv);
                var divHeight = stage.height() + textContent.height();
                $(".hold-scroll").css({"width": "100%", "height": divHeight, "color": "transparent"});
            }
        }

        //根据不同模式添加动画
        function addAnimate() {
            if (items.mode === 'normal' || items.mode === 'no-gap') {
                var scrollPercent = that.scrollTop() / content.outerHeight(true);
                if (that.scrollTop() === 0) {
                    that.animate({scrollTop: '0'}, 1000);
                }
                that.animate({scrollTop: content.outerHeight(true)}, Math.round(items.duration * (1 - scrollPercent)), "linear");
                that.animate({scrollTop: '0'}, 0, arguments.callee);
            } else if (items.mode === 'line') {
                var times = Math.ceil(content.outerHeight(true) / items.perDistance);
                scrollInterval = setInterval(function () {
                    if (content.outerHeight(true) - that.scrollTop() <= 0) {
                        that.animate({scrollTop: 0}, 0);
                    } else {
                        that.animate({scrollTop: that.scrollTop() + items.perDistance}, 0);
                    }
                }, Math.round(items.duration / times));

            }
        }

        addHoldDiv(that, content);

        that.niceScroll({
            'autohidemode': 'false'
        });

        that.mouseenter(function () {
            if (items.mode === 'normal' || items.mode === 'no-gap') {
                that.stop(true);
            } else if (items.mode === 'line') {
                clearInterval(scrollInterval);
            }
            that.getNiceScroll().show();
        });

        that.mouseleave(function (e) {
            var targetElement = $(e.toElement);
            if (targetElement.hasClass("nicescroll-rails-vr") || targetElement.hasClass("nicescroll-cursors")) {
                targetElement.one("mouseleave", function (e) {
                    if ($(e.toElement) !== that && !$(e.toElement).hasClass("nicescroll-rails-vr")) {
                        that.getNiceScroll().hide();
                        addAnimate();
                    }
                });
            } else if (!targetElement.hasClass("nicescroll-rails-vr") && !targetElement.hasClass("nicescroll-cursors")) {
                that.getNiceScroll().hide();
                addAnimate();
            }
        });
        that.mouseleave();
    };

    loginClick = function () {
        var loginForm = document.getElementsByTagName("form")[0];
        var valueString = getParameterByName("jumpUrl", location.href);
        if (valueString != null) {
            var tmpInput = document.createElement("input");
            tmpInput.type = "hidden";
            tmpInput.name = "jumpUrl";
            tmpInput.value = valueString;
            loginForm.appendChild(tmpInput);
        }
    };

    function getParameterByName(name, url) {
        var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
            results = regex.exec(url);
        if (!results) {
            return null;
        }
        if (!results[2]) {
            return null;
        }
        return decodeURIComponent(results[2].replace(/\+/g, " "));
    }

});
