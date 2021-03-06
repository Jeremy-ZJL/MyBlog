Stun.utils = Stun.$u = {
    debounce: function (e, t, n) {
        var o;
        return function () {
            var i = this,
                a = arguments;
            if (o && clearTimeout(o), n) {
                var r = !o;
                o = setTimeout(function () {
                    o = null
                }, t), r && e.apply(i, a)
            } else o = setTimeout(function () {
                e.apply(i, a)
            }, t)
        }
    },
    throttle: function (e, t, n) {
        var o, i, a, r = 0;
        n || (n = {});
        var c = function () {
            r = !1 === n.leading ? 0 : (new Date).getTime(), o = null, e.apply(i, a), o || (i = a = null)
        };
        return function () {
            var s = (new Date).getTime();
            r || !1 !== n.leading || (r = s);
            var l = t - (s - r);
            i = this, a = arguments, l <= 0 || l > t ? (o && (clearTimeout(o), o = null), r = s, e.apply(i, a), o || (i = a = null)) : o || !1 === n.trailing || (o = setTimeout(c, l))
        }
    },
    hasMobileUA: function () {
        var e = window.navigator.userAgent;
        return /iPad|iPhone|Android|Opera Mini|BlackBerry|webOS|UCWEB|Blazer|PSP|IEMobile|Symbian/g.test(e)
    },
    isTablet: function () {
        return window.screen.width > 767 && window.screen.width < 992 && this.hasMobileUA()
    },
    isMobile: function () {
        return window.screen.width < 767 && this.hasMobileUA()
    },
    isDesktop: function () {
        return !this.isTablet() && !this.isMobile()
    },
    Cookies: function () {
        function e() {
            for (var e = 0, t = {}; e < arguments.length; e++) {
                var n = arguments[e];
                for (var o in n) t[o] = n[o]
            }
            return t
        }
        return function t(n) {
            function o(t, i, a) {
                var r;
                if ("undefined" != typeof document) {
                    if (arguments.length > 1) {
                        if ("number" == typeof (a = e({
                                path: "/"
                            }, o.defaults, a)).expires) {
                            var c = new Date;
                            c.setMilliseconds(c.getMilliseconds() + 864e5 * a.expires), a.expires = c
                        }
                        a.expires = a.expires ? a.expires.toUTCString() : "";
                        try {
                            r = JSON.stringify(i), /^[{[]/.test(r) && (i = r)
                        } catch (e) {}
                        i = n.write ? n.write(i, t) : encodeURIComponent(String(i)).replace(/%(23|24|26|2B|3A|3C|3E|3D|2F|3F|40|5B|5D|5E|60|7B|7D|7C)/g, decodeURIComponent), t = (t = (t = encodeURIComponent(String(t))).replace(/%(23|24|26|2B|5E|60|7C)/g, decodeURIComponent)).replace(/[()]/g, escape);
                        var s = "";
                        for (var l in a) a[l] && (s += "; " + l, !0 !== a[l] && (s += "=" + a[l]));
                        return document.cookie = t + "=" + i + s
                    }
                    t || (r = {});
                    for (var d = document.cookie ? document.cookie.split("; ") : [], u = /(%[0-9A-Z]{2})+/g, p = 0; p < d.length; p++) {
                        var f = d[p].split("="),
                            m = f.slice(1).join("=");
                        '"' === m.charAt(0) && (m = m.slice(1, -1));
                        try {
                            var h = f[0].replace(u, decodeURIComponent);
                            if (m = n.read ? n.read(m, h) : n(m, h) || m.replace(u, decodeURIComponent), this.json) try {
                                m = JSON.parse(m)
                            } catch (e) {}
                            if (t === h) {
                                r = m;
                                break
                            }
                            t || (r[h] = m)
                        } catch (e) {}
                    }
                    return r
                }
            }
            return o.set = o, o.get = function (e) {
                return o.call(o, e)
            }, o.getJSON = function () {
                return o.apply({
                    json: !0
                }, [].slice.call(arguments))
            }, o.defaults = {}, o.remove = function (t, n) {
                o(t, "", e(n, {
                    expires: -1
                }))
            }, o.withConverter = t, o
        }(function () {})
    },
    showThemeInConsole: function () {
        console.log("1-1")
    },
    codeToKeyCode: function (e) {
        return {
            ArrowLeft: 37,
            ArrowRight: 39,
            Escape: 27,
            Enter: 13
        } [e]
    },
    popAlert: function (e, t, n) {
        0 !== $(".stun-message").length && $(".stun-message").remove();
        var o = CONFIG.fontawesome && CONFIG.fontawesome.prefix || "fa",
            i = $('<div class="stun-message">' + `<div class="stun-alert stun-alert-${e}">` + `<i class="stun-alert-icon ${o} fa-${{success:"check-circle",info:"exclamation-circle",warning:"exclamation-circle",error:"times-circle"}[e]}"></i>` + `<span class="stun-alert-description">${t}</span>` + "</div></div>");
        $("body").append(i), $(document).ready(function () {
            $(".stun-alert").velocity("stop").velocity("transition.slideDownBigIn", {
                duration: 300
            }).velocity("reverse", {
                delay: 1e3 * n || 5e3,
                duration: 260,
                complete: function () {
                    $(".stun-alert").css("display", "none")
                }
            })
        })
    },
    copyText: function (e) {
        try {
            var t = window.getSelection(),
                n = document.createRange();
            n.selectNodeContents(e), t.removeAllRanges(), t.addRange(n);
            var o = t.toString(),
                i = document.createElement("input");
            if (i.style.display = "none", i.setAttribute("readonly", "readonly"), i.setAttribute("value", o), document.body.appendChild(i), i.setSelectionRange(0, -1), document.execCommand("copy")) return document.execCommand("copy"), document.body.removeChild(i), !0;
            document.body.removeChild(i)
        } catch (e) {
            return !1
        }
    },
    wrapImageWithFancyBox: function () {
        $(".content img").not(":hidden").each(function () {
            var e = $(this),
                t = e.attr("title") || e.attr("alt"),
                n = e.parent("a"),
                o = ["data-src", "data-original", "src"],
                i = "";
            if (!n[0]) {
                for (var a = 0; a < o.length; a++)
                    if (e.attr(o[a])) {
                        i = e.attr(o[a]);
                        break
                    } n = e.wrap(`\n          <a class="fancybox" href="${i}" itemscope\n            itemtype="http://schema.org/ImageObject" itemprop="url"></a>\n        `).parent("a"), e.is(".gallery img") ? n.attr("data-fancybox", "gallery") : n.attr("data-fancybox", "default")
            }
            t && n.attr("title", t).attr("data-caption", t)
        }), $().fancybox({
            selector: "[data-fancybox]",
            loop: !0,
            transitionEffect: "slide",
            hash: !1,
            buttons: ["share", "slideShow", "fullScreen", "download", "thumbs", "close"]
        })
    },
    showImageToWaterfall: function () {
        var e = CONFIG.gallery_waterfall,
            t = parseInt(e.col_width),
            n = parseInt(e.gap_x);
        this.waitAllImageLoad(".gallery__img", function () {
            $(".gallery").masonry({
                itemSelector: ".gallery__img",
                columnWidth: t,
                percentPosition: !0,
                gutter: n,
                transitionDuration: 0
            })
        })
    },
    lazyLoadImage: function () {
        $("img.lazyload").lazyload()
    },
    addIconToExternalLink: function (e) {
        if ($(e)[0]) {
            var t = CONFIG.fontawesome && CONFIG.fontawesome.prefix || "fa",
                n = CONFIG.external_link.icon.name,
                o = $('<span class="external-link"></span>'),
                i = $(`<i class="${t} fa-${n}"></i>`);
            $(e).find('a[target="_blank"]').wrap(o).parent(".external-link").append(i)
        }
    },
    registerHotkeyToSwitchPost: function () {
        var e = this;
        $(document).on("keydown", function (t) {
            var n = t.keyCode === e.codeToKeyCode("ArrowLeft"),
                o = t.keyCode === e.codeToKeyCode("ArrowRight");
            if (t.ctrlKey && n) {
                var i = $(".paginator-post-prev").find("a")[0];
                i && i.click()
            } else if (t.ctrlKey && o) {
                var a = $(".paginator-post-next").find("a")[0];
                a && a.click()
            }
        })
    },
    registerShowReward: function () {
        $(".reward-button").on("click", function () {
            var e = $(".reward-qr");
            e.is(":visible") ? e.css("display", "none") : e.velocity("stop").velocity("transition.slideDownIn", {
                duration: 300
            })
        })
    },
    registerClickToZoomImage: function () {
        $("#content-wrap img").not(":hidden").each(function () {
            "none" !== $(this).attr("data-zoom") && $(this).addClass("zoom-image")
        });
        var e = $('<div class="zoom-image-mask"></div>'),
            t = $("<img>"),
            n = !1;

        function o() {
            t.velocity("reverse"), e.velocity("reverse", {
                complete: function () {
                    $(".zoom-image.show").remove(), $(".zoom-image-mask").remove(), $(".zoom-image").removeClass("hide")
                }
            })
        }
        $(window).on("scroll", function () {
            n && (n = !1, setTimeout(o, 200))
        }), $(document).on("click", function () {
            o()
        }), $(".zoom-image").on("click", function (o) {
            o.stopPropagation(), n = !0;
            var i = this.getBoundingClientRect(),
                a = $(this).width(),
                r = $(this).height(),
                c = $(this).outerWidth(),
                s = $(this).outerHeight(),
                l = $(window).width(),
                d = $(window).height(),
                u = l / a,
                p = d / r,
                f = (u < p ? u : p) || 1,
                m = l / 2 - (i.x + c / 2),
                h = d / 2 - (i.y + s / 2);
            t.attr("class", this.className), t.attr("src", this.src), t.addClass("show"), t.css({
                left: $(this).offset().left + (c - a) / 2,
                top: $(this).offset().top + (s - r) / 2,
                width: a,
                height: r
            }), $(this).addClass("hide"), $("body").append(e).append(t), e.velocity({
                opacity: 1
            }), t.velocity({
                translateX: m,
                translateY: h,
                scale: f
            }, {
                duration: 300,
                easing: [.2, 0, .2, 1]
            })
        })
    },
    addCodeHeader: function (e) {
        $("figure.highlight").each(function () {
            if (!$(this).find("figcaption")[0]) {
                var t = "";
                if (e) "carbon" === e && (t += '\n            <div class="custom-carbon">\n              <div class="custom-carbon-dot custom-carbon-dot--red"></div>\n              <div class="custom-carbon-dot custom-carbon-dot--yellow"></div>\n              <div class="custom-carbon-dot custom-carbon-dot--green"></div>\n            </div>\n          ');
                else {
                    t += `<div class="custom-lang">${$(this).attr("class").split(/\s/).filter(function(e){return"highlight"!==e})}</div>`
                }
                $(`<figcaption class="custom">${t}</figcaption>`).insertBefore($(this).children().first())
            }
        })
    },
    addCopyButton: function () {
        var e = CONFIG.fontawesome && CONFIG.fontawesome.prefix || "fa",
            t = $(`<div class="copy-button" data-popover="${CONFIG.prompt.copy_button}" data-popover-pos="up">` + `<i class="${e} fa-clipboard"></i>` + "</div>");
        $("figure.highlight figcaption, .post-copyright").append(t)
    },
    registerCopyEvent: function () {
        $(".copy-button").on("click", function () {
            var e = null,
                t = $(this).parents("figure.highlight").find("td.code")[0];
            e = t || $(this).parent()[0], Stun.utils.copyText(e) ? Stun.utils.popAlert("success", CONFIG.prompt.copy_success) : Stun.utils.popAlert("error", CONFIG.prompt.copy_error)
        })
    },
    waitAllImageLoad: function (e, t) {
        var n = [];
        $(e).each(function () {
            var e = $.Deferred();
            $(this).bind("load", function () {
                e.resolve()
            }), this.complete && setTimeout(function () {
                e.resolve()
            }, 500), n.push(e)
        }), $.when.apply(null, n).then(t)
    }
};