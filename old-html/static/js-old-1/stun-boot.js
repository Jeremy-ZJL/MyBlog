$(document).ready(function() {
    Stun.utils.showThemeInConsole();
    CONFIG.shortcuts.switch_post && Stun.utils.registerHotkeyToSwitchPost();
    CONFIG.external_link && Stun.utils.addIconToExternalLink("#footer");
    Stun.utils.pjaxReloadBoot = function() {
        if (this.addCopyButton(), this.registerCopyEvent(), CONFIG.reward && this.registerShowReward(), CONFIG.lazyload && this.lazyLoadImage(), CONFIG.gallery_waterfall && this.showImageToWaterfall(), CONFIG.external_link) {
            this.addIconToExternalLink(".archive, .post-header-title")
        }
        CONFIG.fancybox ? this.wrapImageWithFancyBox() : CONFIG.zoom_image && this.registerClickToZoomImage()
    };
    Stun.utils.pjaxReloadBoot()
});