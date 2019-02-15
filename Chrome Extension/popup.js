'use strict';

let resetTime = document.getElementById('resetTimer');

resetTime.onclick = function() {
	chrome.extension.getBackgroundPage().timers = [];
	chrome.extension.getBackgroundPage().inYouTube = false;
	chrome.extension.getBackgroundPage().curr = 0;
	chrome.extension.getBackgroundPage().current_timer = 0;
	chrome.extension.getBackgroundPage().current_format = "00:00";
};

let getTime = document.getElementById('getTime');

getTime.onclick = function() {
	var time = chrome.extension.getBackgroundPage().current_format;
	chrome.browserAction.setBadgeText({text: time});
};
