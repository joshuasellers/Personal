'use strict';

chrome.tabs.query(null,function(tab) {
	chrome.extension.getBackgroundPage().timers[tabId] = new Date();
	var currentTime = new Date();
	if(currentTime - chrome.extension.getBackgroundPage().timers[tabId] > 5000)
	{
	  chrome.browserAction.enable(tabId);
	  chrome.browserAction.setIcon({path: "icon-enabled.png", tabId: tabId});
	}
}

