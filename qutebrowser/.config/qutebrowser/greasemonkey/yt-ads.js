// ==UserScript==
// @name         Auto Skip YouTube Ads
// @version      1.2.0
// @description  Automatically skips or fast-forwards YouTube ads
// @author       jso8910
// @match        *://*.youtube.com/*
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    setInterval(() => {
        // Click "Skip Ad" button if present
        const skipButton = document.querySelector('.videoAdUiSkipButton, .ytp-ad-skip-button-modern');
        if (skipButton) {
            skipButton.click();
        }

        // Fast forward video ads
        const adContainer = document.querySelector('.ad-showing');
        const video = document.querySelector('video');
        if (adContainer && video) {
            video.currentTime = video.duration;
        }
    }, 200); // Check every 500ms
})();

