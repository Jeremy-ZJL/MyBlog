Stun.utils = Stun.$u = {
    debounce: function(t, e, n) {
        var i;
        return function() {
            var o = this,
            a = arguments;
            if (i && clearTimeout(i), n) {
                var r = !i;
                i = setTimeout(function() {
                    i = null
                },
                e),
                r && t.apply(o, a)
            } else i = setTimeout(function() {
                t.apply(o, a)
            },
            e)
        }
    },
    throttle: function(t, e, n) {
        var i, o, a, r = 0;
        n || (n = {});
        var s = function() {
            r = !1 === n.leading ? 0 : (new Date).getTime(),
            i = null,
            t.apply(o, a),
            i || (o = a = null)
        };
        return function() {
            var c = (new Date).getTime();
            r || !1 !== n.leading || (r = c);
            var l = e - (c - r);
            o = this,
            a = arguments,
            l <= 0 || l > e ? (i && (clearTimeout(i), i = null), r = c, t.apply(o, a), i || (o = a = null)) : i || !1 === n.trailing || (i = setTimeout(s, l))
        }
    },
    hasMobileUA: function() {
        var t = window.navigator.userAgent;
        return /iPad|iPhone|Android|Opera Mini|BlackBerry|webOS|UCWEB|Blazer|PSP|IEMobile|Symbian/g.test(t)
    },
    isTablet: function() {
        return window.screen.width > 767 && window.screen.width < 992 && this.hasMobileUA()
    },
    isMobile: function() {
        return window.screen.width < 767 && this.hasMobileUA()
    },
    isDesktop: function() {
        return ! this.isTablet() && !this.isMobile()
    },

    codeToKeyCode: function(t) {
        return {
            ArrowLeft: 37,
            ArrowRight: 39,
            Escape: 27,
            Enter: 13
        } [t]
    },
    popAlert: function(t, e, n) {
        if (!$(".stun-alert")[0]) {
            var i = CONFIG.fontawesome.prefix,
            o = $('<div class="stun-message"><div class="stun-alert stun-alert-' + t + '"><i class="stun-alert-icon ' + i + " fa-" + {
                success: "check-circle",
                info: "exclamation-circle",
                warning: "exclamation-circle",
                error: "times-circle"
            } [t] + '"></i><span class="stun-alert-description">' + e + "</span></div></div>");
            $("body").append(o)
        }
        $(document).ready(function() {
            $(".stun-alert").velocity("stop").velocity("transition.slideDownBigIn", {
                duration: 300
            }).velocity("reverse", {
                delay: 1e3 * n || 5e3,
                duration: 260,
                complete: function() {
                    $(".stun-alert").css("display", "none")
                }
            })
        })
    },
    copyText: function(t) {
        try {
            var e = window.getSelection(),
            n = document.createRange();
            n.selectNodeContents(t),
            e.removeAllRanges(),
            e.addRange(n);
            var i = e.toString(),
            o = document.createElement("input");
            if (o.style.display = "none", o.setAttribute("readonly", "readonly"), o.setAttribute("value", i), document.body.appendChild(o), o.setSelectionRange(0, -1), document.execCommand("copy")) return document.execCommand("copy"),
            document.body.removeChild(o),
            !0;
            document.body.removeChild(o)
        } catch(t) {
            return ! 1
        }
    },
    wrapImageWithFancyBox: function() {
        $(".content img").not(":hidden").each(function() {
            var t = $(this),
            e = t.attr("title") || t.attr("alt"),
            n = t.parent("a"),
            i = ["data-src", "data-original", "src"],
            o = "";
            if (!n[0]) {
                for (var a = 0; a < i.length; a++) if (t.attr(i[a])) {
                    o = t.attr(i[a]);
                    break
                }
                n = t.wrap('<a class="fancybox" href="' + o + '" itemscope itemtype="http://schema.org/ImageObject" itemprop="url"></a>').parent("a"),
                t.is(".gallery img") ? n.attr("data-fancybox", "gallery") : n.attr("data-fancybox", "default")
            }
            e && n.attr("title", e).attr("data-caption", e)
        }),
        $().fancybox({
            selector: "[data-fancybox]",
            loop: !0,
            transitionEffect: "slide",
            hash: !1,
            buttons: ["share", "slideShow", "fullScreen", "download", "thumbs", "close"]
        })
    },
    showImageToWaterfall: function() {
        var t = CONFIG.gallery_waterfall,
        e = parseInt(t.col_width),
        n = parseInt(t.gap_x);
        this.waitAllImageLoad(".gallery__img",
        function() {
            $(".gallery").masonry({
                itemSelector: ".gallery__img",
                columnWidth: e,
                percentPosition: !0,
                gutter: n,
                transitionDuration: 0
            })
        })
    },
    lazyLoadImage: function() {
        $("img.lazyload").lazyload()
    },
    addIconToExternalLink: function(t) {
        if ($(t)[0]) {
            var e = CONFIG.fontawesome.prefix,
            n = $('<span class="external-link"></span>'),
            i = $('<i class="' + e + " fa-" + CONFIG.external_link.icon.name + '"></i>');
            $(t).find('a[target="_blank"]').wrap(n).parent(".external-link").append(i)
        }
    },
    registerHotkeyToSwitchPost: function() {
        var t = this;
        $(document).on("keydown",
        function(e) {
            var n = e.keyCode === t.codeToKeyCode("ArrowLeft"),
            i = e.keyCode === t.codeToKeyCode("ArrowRight");
            if (e.ctrlKey && n) {
                var o = $(".paginator-post-prev").find("a")[0];
                o && o.click()
            } else if (e.ctrlKey && i) {
                var a = $(".paginator-post-next").find("a")[0];
                a && a.click()
            }
        })
    },
    registerShowReward: function() {
        $(".reward-button").on("click",
        function() {
            var t = $(".reward-qr");
            t.is(":visible") ? t.css("display", "none") : t.velocity("stop").velocity("transition.slideDownIn", {
                duration: 300
            })
        })
    },
    registerClickToZoomImage: function() {
        $("#content-wrap img").not(":hidden").each(function() {
            $(this).addClass("zoom-image")
        });
        var t = $('<div class="zoom-image-mask"></div>'),
        e = $("<img>"),
        n = !1;
        function i() {
            e.velocity("reverse"),
            t.velocity("reverse", {
                complete: function() {
                    $(".zoom-image.show").remove(),
                    $(".zoom-image-mask").remove(),
                    $(".zoom-image").removeClass("hide")
                }
            })
        }
        $(window).on("scroll",
        function() {
            n && (n = !1, setTimeout(i, 200))
        }),
        $(document).on("click",
        function() {
            i()
        }),
        $(".zoom-image").on("click",
        function(i) {
            i.stopPropagation(),
            n = !0;
            var o = this.getBoundingClientRect(),
            a = $(this).width(),
            r = $(this).height(),
            s = $(this).outerWidth(),
            c = $(this).outerHeight(),
            l = $(window).width(),
            d = $(window).height(),
            u = l / a,
            p = d / r,
            f = (u < p ? u: p) || 1,
            h = l / 2 - (o.x + s / 2),
            g = d / 2 - (o.y + c / 2);
            e.attr("class", this.className),
            e.attr("src", this.src),
            e.addClass("show"),
            e.css({
                left: $(this).offset().left + (s - a) / 2,
                top: $(this).offset().top + (c - r) / 2,
                width: a,
                height: r
            }),
            $(this).addClass("hide"),
            $("body").append(t).append(e),
            t.velocity({
                opacity: 1
            }),
            e.velocity({
                translateX: h,
                translateY: g,
                scale: f
            },
            {
                duration: 300,
                easing: [.2, 0, .2, 1]
            })
        })
    },
    addCopyButton: function() {
        $("figure.highlight").each(function() {
            if (!$(this).find("figcaption")[0]) {
                var t = $(this).attr("class").split(/\s/).filter(function(t) {
                    return "highlight" !== t
                });
                $('<figcaption class="custom"><div class="custom-lang">' + t + "</div></figcaption>").insertBefore($(this).children().first())
            }
        });
        var t = CONFIG.fontawesome.prefix,
        e = $('<div class="copy-button" data-popover=' + CONFIG.prompt.copy_button + ' data-popover-pos="up"><i class="' + t + ' fa-clipboard"></i></div>');
        $("figure.highlight figcaption, .post-copyright").append(e)
    },
    registerCopyEvent: function() {
        $(".copy-button").on("click",
        function() {
            var t = null,
            e = $(this).parents("figure.highlight").find("td.code")[0];
            t = e || $(this).parent()[0],
            Stun.utils.copyText(t) ? Stun.utils.popAlert("success", CONFIG.prompt.copy_success) : Stun.utils.popAlert("error", CONFIG.prompt.copy_error)
        })
    },
    waitAllImageLoad: function(t, e) {
        var n = [];
        $(t).each(function() {
            var t = $.Deferred();
            $(this).bind("load",
            function() {
                t.resolve()
            }),
            this.complete && setTimeout(function() {
                t.resolve()
            },
            500),
            n.push(t)
        }),
        $.when.apply(null, n).then(e)
    }
};