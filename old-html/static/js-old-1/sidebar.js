$(document).ready(function() {
    var e = CONFIG.sidebar.renderTocDepth,
    t = "h1,h2,h3,h4,h5,h6,".slice(0, 3 * e).slice(0, -1);
    var s = null,
    i = null,
    a = !1;
    function o() {
        var e = $(".post-body"),
        o = $(".sidebar-toc li"),
        n = e.find(t),
        r = n.first();
        if (n.each(function() {
            this.getBoundingClientRect().top <= 5 && (s = this.getAttribute("id"))
        }), e[0] && r[0] && r.offset().top - $(window).scrollTop() > 0) a || (o.removeClass("active current"), a = !0);
        else if (s !== i) {
            var c = $('.sidebar-toc a[href="#' + s + '"]');
            c[0] && o.removeClass("active current"),
            c.parents("li").addClass("active"),
            c.parent().addClass("current"),
            i = s
        }
    }
    var n = !1;
    function r() {
        var e = $(".sidebar-toc").height();
        if (! ($(".sidebar-toc > div").height() <= e)) {
            var t = $(".sidebar-toc"),
            s = $(".sidebar-toc .current a");
            if (s[0] && t[0]) {
                var i = s.offset().top - t.offset().top;
                n = i > e || i < 0
            }
            n && s.velocity("stop").velocity("scroll", {
                container: t,
                offset: -e / 2,
                duration: 500,
                easing: "easeOutQuart"
            })
        }
    }
    var c = parseInt(CONFIG.sidebar.offsetTop);
    function d() {
        var e = $(".sidebar-inner");
        document.getElementById("main").getBoundingClientRect().top < c ? e.addClass("sticky") : e.removeClass("sticky")
    }
    function l() {
        var e = $("#content-wrap"),
        t = e[0] && -1 * e[0].getBoundingClientRect().top || 0,
        s = parseInt(t / Math.abs(e.height() - $(window).height()) * 100);
        s = s > 100 ? 100 : s < 0 ? 0 : s,
        $(".sidebar-reading-info-num").html(s),
        $(".sidebar-reading-line").css("transform", "translateX(" + (s - 100) + "%)")
    }
    o(),
    d(),
    r(),
    l(),
    $(window).on("scroll",
    function() {
        d()
    }),
    $(window).on("scroll", Stun.utils.throttle(function() {
        o(),
        r(),
        l()
    },
    150)),
    Stun.utils.pjaxReloadSidebar = function() {
        var e = $(".sidebar-nav-toc"),
        s = $(".sidebar-nav-ov"),
        i = $(".sidebar-toc"),
        a = $(".sidebar-ov");
        e.on("click",
        function() {
            $(this).hasClass("current") || (e.addClass("current"), s.removeClass("current"), i.css("display", "block"), i.velocity("stop").velocity("fadeIn"), a.css("display", "none"), a.velocity("stop").velocity("fadeOut"))
        }),
        s.on("click",
        function() {
            $(this).hasClass("current") || (s.addClass("current"), e.removeClass("current"), i.css("display", "none"), i.velocity("stop").velocity("fadeOut"), a.css("display", "block"), a.velocity("stop").velocity("fadeIn"))
        }),
        $(".post-body").find(t)[0] || ($(".sidebar-nav").addClass("hide"), $(".sidebar-toc").addClass("hide"), $(".sidebar-ov").removeClass("hide"))
    },
    Stun.utils.pjaxReloadSidebar()
});