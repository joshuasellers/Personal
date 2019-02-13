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
	//chrome.tabs.query(
	//		{
	//		    active: true,               // Select active tabs
	//		    lastFocusedWindow: true
	//		}, 
	//function(tabs) 
	//{
		var tabID = tabId;//tabs[0].id;
		var url = changeInfo.url;//tabs[0].url;
		//var wt = tabs[0].windowType;
		console.log(url);
		if (url.includes("youtube.com")) {
			console.log("youtube!");
			timers[tabID] = new Date();
			var time = FormatTime(timers)
			console.log(time);
		};
	//});
});
