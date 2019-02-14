'use strict';


var timers = [];

chrome.tabs.onCreated.addListener(
function(tab) 
{
	var tabIDC = tab.id;
	var urlC = tab.url;
	console.log("new tab");
	if (urlC.includes("youtube.com")) {
		console.log("youtube!");
		timers[tabIDC] = new Date();
		var time = FormatTime(timers)
		console.log(time);
	}
});

chrome.tabs.onUpdated.addListener(
function(tabId, changeInfo, tab) 
{
	var tabID = tabId;
	var url = changeInfo.url;
	if (url != null && url.includes("youtube.com")) {
		console.log("youtube!");
		console.log(url);
		timers[tabID] = new Date();
		var time = GetTime(timers)
		console.log(time);
		var format = FormatTime(time);
		console.log(format)
	};
});
