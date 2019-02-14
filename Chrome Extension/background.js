'use strict';


var timers = [];
var inYouTube = false;
var curr = 0;
/*
chrome.tabs.onCreated.addListener(
function(tab) 
{
	var tabID = tab.id;
	var url = tab.url;
	if (inYouTube){
		console.log("Get time for new tab");
		timers[curr] = new Date() - timers[curr];
		var time = GetTime(timers)
		console.log(time);
		var format = FormatTime(time);
		console.log(format)
	}
	inYouTube = false;
	if (url.includes("youtube.com")) {
		console.log("new youtube tab!");
		inYouTube = true;
		curr = tabID;
		timers[tabID] = new Date();
	}
});
*/
chrome.tabs.onUpdated.addListener(
function(tabId, changeInfo, tab) 
{
	var tabID = tabId;
	var url = changeInfo.url;
	if (inYouTube){
		console.log("Get time for updated");
		timers[curr] = new Date() - timers[curr];
		var time = GetTime(timers)
		console.log(time);
		var format = FormatTime(time);
		console.log(format)
	}
	inYouTube = false;
	if (url != null && url.includes("youtube.com")) {
		inYouTube = true;
		console.log("updated to youtube!");
		console.log(url);
		timers[tabID] = new Date();
	};
});
