$(document).ready(function() {
    var o = 0,
    l = !1,
    s = !0;
    function e() {
        var e = $(".header-nav"),
        n = $(window).scrollTop(),
        t = n - o;
        if (0 === n) e.removeClass("fixed"),
        e.removeClass("slider-up"),
        e.addClass("slider-down"),
        l = !1;
        else {
            l || (e.addClass("fixed"), l = !0);
            Math.abs(t) > 5 && (s && t > 0 ? (e.removeClass("slider-down"), e.addClass("slider-up"), s = !1) : !s && t < 0 && (e.removeClass("slider-up"), e.addClass("slider-down"), s = !0))
        }
        o = n
    }
    function n(o) {
        $(o).velocity("stop").velocity("scroll", {
            easing: "ease-in-out",
            duration: 600
        })
    }
    var t = !1;
    function i() {
        var o = $("#back2top");
        0 !== $(window).scrollTop() ? t || (o.addClass("show"), o.removeClass("hide"), t = !0) : (o.addClass("hide"), o.removeClass("show"), t = !1)
    }
    e(),
    i(),
    $(window).on("DOMContentLoaded", i),
    $(window).on("scroll", Stun.utils.throttle(function() {
        e(),
        i()
    },
    100)),
    $("#back2top").on("click",
    function() {
        $("body").velocity("stop").velocity("scroll")
    }),
    Stun.utils.pjaxReloadScroll = function() {
        $("#content-wrap").find("h1,h2,h3,h4,h5,h6").on("click",
        function() {
            n("#" + $(this).attr("id"))
        }),
        $(".toc-link").on("click",
        function(o) {
            o.preventDefault(),
            n($(this).attr("href"))
        })
    },
    Stun.utils.pjaxReloadScroll()
});