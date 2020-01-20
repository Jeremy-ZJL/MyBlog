window.addEventListener('DOMContentLoaded', function () {
    var pjax = new Pjax({
        "selectors": ["head title", "#main", ".pjax-reload"],
        "history": true,
        "scrollTo": false,
        "scrollRestoration": false,
        "cacheBust": false,
        "debug": false,
        "currentUrlFullReload": false,
        "timeout": 0
    });
    // 加载进度条的计时器
    var loadingTimer = null;

    // 重置页面 Y 方向上的滚动偏移量
    document.addEventListener('pjax:send', function () {
        $('.header-nav-menu').removeClass('show');

        if (CONFIG.pjax.scrollTo2screen) {
            $('html').velocity('scroll', {
                duration: 500,
                offset: $('#header').height(),
                easing: 'easeInOutCubic'
            });
        }

        var loadingBarWidth = 20;
        var MAX_LOADING_WIDTH = 95;

        $('.loading-bar').addClass('loading');
        $('.loading-bar .progress').css('width', loadingBarWidth + '%');

        clearInterval(loadingTimer);
        loadingTimer = setInterval(function () {
            loadingBarWidth += 3;

            if (loadingBarWidth > MAX_LOADING_WIDTH) {
                loadingBarWidth = MAX_LOADING_WIDTH;
            }

            $('.loading-bar .progress').css('width', loadingBarWidth + '%');
        }, 500);
    }, false);

    window.addEventListener('pjax:complete', function () {
        clearInterval(loadingTimer);
        $('.loading-bar .progress').css('width', '100%');
        $('.loading-bar').removeClass('loading');
        setTimeout(function () {
            $('.loading-bar .progress').css('width', '0');
        }, 400);

        $('link[rel=prefetch], script[data-pjax-rm]').each(function () {
            $(this).remove();
        });

        $('script[data-pjax], #pjax-reload script').each(function () {
            $(this).parent().append($(this).remove());
        });

        Stun.utils.pjaxReloadBoot();
        Stun.utils.pjaxReloadScroll();
        Stun.utils.pjaxReloadHeader();
        Stun.utils.pjaxReloadSidebar();
    }, false);
}, false);