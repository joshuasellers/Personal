'use strict';

chrome.tabs.query(
			{
			    active: true,               // Select active tabs
			    lastFocusedWindow: true     // In the current window
			}, function(tabs) {
	var tabID = tabs[0].id
	var url = tabs[0].url;
	chrome.extension.getBackgroundPage().timers[tabID] = new Date();
	var currentTime = new Date();
	if(currentTime - chrome.extension.getBackgroundPage().timers[tabID] > 5000)
	{
	  chrome.browserAction.enable(tabId);
	  chrome.browserAction.setIcon({path: "icon-enabled.png", tabID: tabID});
	}
});

