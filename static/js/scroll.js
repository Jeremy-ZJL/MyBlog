$(document).ready(function () {
    var o = 0,
        l = !1,
        s = !0;

    function e() {
        var e = $(".header-nav"),
            a = $(window).scrollTop(),
            t = a - o;
        if (0 === a) e.removeClass("fixed"), e.removeClass("slider-up"), e.addClass("slider-down"), l = !1;
        else {
            l || (e.addClass("fixed"), l = !0);
            Math.abs(t) > 5 && (s && t > 0 ? (e.removeClass("slider-down"), e.addClass("slider-up"), s = !1) : !s && t < 0 && (e.removeClass("slider-up"), e.addClass("slider-down"), s = !0))
        }
        o = a
    }

    function a(o) {
        $(o).velocity("stop").velocity("scroll", {
            easing: "ease-in-out",
            duration: 600
        })
    }

    e();
    var t = CONFIG.back2top && CONFIG.back2top.enable,
        n = !1;

    function i() {
        var o = $("#back2top");
        0 !== $(window).scrollTop() ? n || (o.addClass("show"), o.removeClass("hide"), n = !0) : (o.addClass("hide"), o.removeClass("show"), n = !1)
    }

    t && (i(), $("#back2top").on("click", function () {
        $("body").velocity("stop").velocity("scroll")
    })), $(window).on("scroll", Stun.utils.throttle(function () {
        e(), t && i()
    }, 100)), Stun.utils.pjaxReloadScroll = function () {
        $("#content-wrap").find("h1,h2,h3,h4,h5,h6").on("click", function () {
            a("#" + $(this).attr("id"))
        }), $(".toc-link").on("click", function (o) {
            o.preventDefault(), a($(this).attr("href"))
        })
    }, Stun.utils.pjaxReloadScroll()
});