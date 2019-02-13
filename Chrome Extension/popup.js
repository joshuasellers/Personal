'use strict';

chrome.tabs.query(
			{
			    active: true,               // Select active tabs
			    lastFocusedWindow: true     // In the current window
			}, function(tabs) {
	var tabID = tabs[0].id;
	var url = tabs[0].url;
	chrome.extension.getBackgroundPage().timers[tabID] = new Date();
	var currentTime = new Date();
});

