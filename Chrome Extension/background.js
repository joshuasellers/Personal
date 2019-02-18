'use strict';

var timers = [];
var inYouTube = false;
var curr_time = 0;
var curr_date = 0;
var warned = false;


chrome.tabs.onActivated.addListener(
	function (activeINFO)
	{
		console.log("Activated");
		var tabID = activeINFO.tabId;
		var windowID = activeINFO.windowId;
		chrome.tabs.get(tabID, function (tab)
			{
				console.log("New Tab Chosen");
				console.log(tab.url);
				var url = tab.url;
				if (url != null && url.includes("youtube.com")) {
					console.log("youtube");
					if (inYouTube){
						curr_time += new Date() - curr_date;
					}
					inYouTube = true;
					curr_date = new Date();
				}
				else{
					console.log("not youtube");
					if (inYouTube){
						curr_time += new Date() - curr_date;
						curr_date = 0;
					}
					else{
						curr_date = 0;
					}
					inYouTube = false;
				}
			});
	});

chrome.tabs.onUpdated.addListener(
	function(tabId, changeInfo, tab) 
	{
		if (changeInfo.status == "complete"){
			console.log("Updated Tab");
			console.log(tab.url);
			var tabID = tabId;
			var url = tab.url;
			if (url != null && url.includes("youtube.com")) {
					console.log("youtube");
					if (inYouTube){
						curr_time += new Date() - curr_date;
					}
					inYouTube = true;
					curr_date = new Date();
				}
			else{
				console.log("not youtube");
				if (inYouTube){
					curr_time += new Date() - curr_date;
					curr_date = 0;
				}
				else{
					curr_date = 0;
				}
				inYouTube = false;
			}
		;}
	});

function updateTime(){
	if (inYouTube){
		curr_time += new Date() - curr_date;
		curr_date = new Date();
		return FormatTime(curr_time);
	}
	else{
		return FormatTime(curr_time);
	}
}
