$(document).ready(function () {
    var tocDepth = CONFIG.sidebar.renderTocDepth;
    // Optimize selector by theme config.
    var HEADING_SELECTOR = 'h1,h2,h3,h4,h5,h6,'.slice(0, tocDepth * 3).slice(0, -1);

    function initTocDisplay() {
        if ($('.post-body').find(HEADING_SELECTOR)[0]) {
            return;
        }

        $('.sidebar-nav').addClass('hide');
        $('.sidebar-toc').addClass('hide');
        $('.sidebar-ov').removeClass('hide');
    }

    // The heading that reached the top currently.
    var currHeading = null;
    // The heading that reached the top last time.
    var lastHeading = null;
    var isRemoveTocClass = false;

    // Automatically expand items in the article directory
    //   based on the scrolling of heading in the article.
    function autoSpreadToc() {
        var $postBody = $('.post-body');
        var $allTocItem = $('.sidebar-toc li');
        var $headings = $postBody.find(HEADING_SELECTOR);
        var $firsetChild = $headings.first();

        $headings.each(function () {
            var headingTop = this.getBoundingClientRect().top;
            // The minimum distance from the top of the browser
            //   when heading is marked as active in toc.
            var MIN_HEIGHT_TO_TOP = 5;

            if (headingTop <= MIN_HEIGHT_TO_TOP) {
                currHeading = this.getAttribute('id');
            }
        });

        // All heading are not to the top.
        if ($postBody[0] && ($firsetChild[0] &&
            $firsetChild.offset().top - $(window).scrollTop() > 0)) {
            if (!isRemoveTocClass) {
                $allTocItem.removeClass('active current');
                isRemoveTocClass = true;
            }

            return;
        }

        if (currHeading !== lastHeading) {
            var $targetLink = $('.sidebar-toc a[href="#' + currHeading + '"]');

            // If the relevant "<a>" is not found, remain the state of the toc,
            //   either, remove styles for all active states.
            if ($targetLink[0]) {
                $allTocItem.removeClass('active current');
            }
            $targetLink.parents('li').addClass('active');
            $targetLink.parent().addClass('current');
            lastHeading = currHeading;
        }
    }

    // Whether toc needs scrolling.
    var isTocScroll = false;

    // Scroll the post toc to the middle.
    function scrollTocToMiddle() {
        var $tocWrapHeight = $('.sidebar-toc').height();
        var $tocHeight = $('.sidebar-toc > div').height();

        if ($tocHeight <= $tocWrapHeight) {
            return;
        }

        var $tocWrap = $('.sidebar-toc');
        var $currTocItem = $('.sidebar-toc .current a');

        if ($currTocItem[0] && $tocWrap[0]) {
            var tocTop = $currTocItem.offset().top - $tocWrap.offset().top;

            isTocScroll = tocTop > $tocWrapHeight || tocTop < 0;
        }

        if (isTocScroll) {
            $currTocItem
                .velocity('stop')
                .velocity('scroll', {
                    container: $tocWrap,
                    offset: (-$tocWrapHeight / 2),
                    duration: 500,
                    easing: 'easeOutQuart'
                });
        }
    }

    // Distance from sidebar to top.
    var SIDEBAR_STICKY_TOP = parseInt(CONFIG.sidebar.offsetTop);

    // Sticky the sidebar when it arrived the top.
    function sidebarSticky() {
        var $sidebar = $('.sidebar-inner');
        var targetY =
            document.getElementById('main').getBoundingClientRect().top;

        if (targetY < SIDEBAR_STICKY_TOP) {
            $sidebar.addClass('sticky');
        } else {
            $sidebar.removeClass('sticky');
        }
    }

    // Update the reading progress lines of post.
    function readProgress() {
        var $post = $('#content-wrap');
        var scrollH = ($post[0] &&
            $post[0].getBoundingClientRect().top * -1) || 0;

        var percent = parseInt((scrollH /
            Math.abs($post.height() - $(window).height())) * 100);
        percent = percent > 100 ? 100 : percent < 0 ? 0 : percent;

        $('.sidebar-reading-info-num').html(percent);
        $('.sidebar-reading-line').css(
            'transform', 'translateX(' + (percent - 100) + '%)'
        );
    }

    // Initial run
    autoSpreadToc();
    sidebarSticky();
    scrollTocToMiddle();
    readProgress();

    $(window).on('scroll', function () {
        sidebarSticky();
    });

    $(window).on('scroll', Stun.utils.throttle(function () {
        autoSpreadToc();
        scrollTocToMiddle();
        readProgress();
    }, 150));

    Stun.utils.pjaxReloadSidebar = function () {
        var t = $(".sidebar-nav-toc"),
            s = $(".sidebar-nav-ov"),
            i = $(".sidebar-toc"),
            o = $(".sidebar-ov");
        t.on("click", function () {
            $(this).hasClass("current") || (t.addClass("current"),
                s.removeClass("current"),
                i.css("display", "block"),
                i.velocity("stop").velocity("fadeIn"),
                o.css("display", "none"),
                o.velocity("stop").velocity("fadeOut"))
        }), s.on("click", function () {
            $(this).hasClass("current") || (s.addClass("current"),
                t.removeClass("current"),
                i.css("display", "none"),
                i.velocity("stop").velocity("fadeOut"),
                o.css("display", "block"),
                o.velocity("stop").velocity("fadeIn"))
        }), $(".post-body").find(e)[0] || ($(".sidebar-nav").addClass("hide"),
            $(".sidebar-toc").addClass("hide"),
            $(".sidebar-ov").removeClass("hide"))
    },
        Stun.utils.pjaxReloadSidebar()
});
