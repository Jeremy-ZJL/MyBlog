$(document).ready(function () {
    var e = $(".header-nav-menu"),
        i = $(".header-nav-submenu"),
        n = $(".header-nav-menu-item"),
        o = $(".header-nav-btn"),
        t = o.is(":visible");

    function s() {
        n.velocity({
            height: n.height()
        }, {
            complete: function () {
                i.css({
                    display: "none",
                    opacity: 0
                })
            }
        })
    }

    var a = !1,
        c = !1;
    if ($(window).on("resize", Stun.utils.throttle(function () {
        (t = o.is(":visible")) && c ? (s(), c = !1) : i.css({
            display: "none",
            opacity: 0
        })
    }, 200)), $(document).on("click", function () {
        e.is(":visible") && (t && c && (s(), c = !1), e.css({
            display: "none"
        }), a = !1), d && (u.removeClass("mode--focus"), d = !1)
    }), CONFIG.night_mode && CONFIG.night_mode.enable) {
        var l = !1,
            d = !1,
            h = "night_mode",
            u = $(".mode");
        !function () {
            var e = !1;
            try {
                parseInt(Stun.utils.Cookies().get(h)) && (e = !0)
            } catch (e) {
            }
            return e
        }() ? l = !1 : (u.addClass("mode--checked"), u.addClass("mode--focus"), $("html").addClass("nightmode"), l = !0), $(".mode").on("click", function (e) {
            e.stopPropagation(), l = !l, d = !d, Stun.utils.Cookies().set(h, l ? 1 : 0), u.toggleClass("mode--checked"), u.addClass("mode--focus"), $("html").toggleClass("nightmode")
        })
    }
    o.on("click", function (i) {
        i.stopPropagation(), t && a && c && (s(), c = !1), a = !a, e.velocity("stop").velocity({
            opacity: a ? 1 : 0
        }, {
            duration: a ? 200 : 0,
            display: a ? "block" : "none"
        })
    });
    var r = !1;
    $(".header-nav-submenu-item").on("click", function () {
        r = !0
    }), n.on("click", function (e) {
        if (t) {
            var i = $(this).find(".header-nav-submenu");
            if (i.length) {
                r ? r = !1 : e.stopPropagation();
                var o = n.height(),
                    s = o + i.height() * i.length,
                    a = 0;
                $(this).height() > o ? (c = !1, a = o) : (c = !0, a = s), i.css({
                    display: "block",
                    opacity: 1
                }), $(this).velocity("stop").velocity({
                    height: a
                }, {
                    duration: 300
                }).siblings().velocity({
                    height: o
                }, {
                    duration: 300
                })
            }
        }
    }), n.on("mouseenter", function () {
        var e = $(this).find(".header-nav-submenu");
        e.length && (e.is(":visible") || (t ? e.css({
            display: "block",
            opacity: 1
        }) : e.velocity("stop").velocity("transition.slideUpIn", {
            duration: 200
        })))
    }), n.on("mouseleave", function () {
        var e = $(this).find(".header-nav-submenu");
        e.length && e.is(":visible") && !t && (e.css({
            display: "none",
            opacity: 0
        }), c = !1)
    }), Stun.utils.pjaxReloadHeader = function () {
        CONFIG.header && CONFIG.header.scrollDownIcon && $(".header-info-scrolldown").on("click", function () {
            $("#container").velocity("scroll", {
                offset: $("#header").height()
            })
        })
    }, Stun.utils.pjaxReloadHeader()
});