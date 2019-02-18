'use strict';

var inYouTube = false;
var curr_time = 0;
var curr_date = 0;
var warned = false;
var limit = -1;


chrome.tabs.onActivated.addListener(
	function (activeINFO)
	{
		var tabID = activeINFO.tabId;
		var windowID = activeINFO.windowId;
		checkLimit();
		chrome.tabs.get(tabID, function (tab)
			{
				var url = tab.url;
				if (url != null && url.includes("youtube.com")) {
					if (inYouTube){
						curr_time += new Date() - curr_date;
					}
					inYouTube = true;
					curr_date = new Date();
				}
				else{
					if (inYouTube){
						curr_time += new Date() - curr_date;
						curr_date = 0;
						checkLimit();
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
			var tabID = tabId;
			var url = tab.url;
			checkLimit();
			if (url != null && url.includes("youtube.com")) {
					if (inYouTube){
						curr_time += new Date() - curr_date;
					}
					inYouTube = true;
					curr_date = new Date();
				}
			else{
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
		console.log(limit);
		checkLimit();
		return FormatTime(curr_time);
	}
	else{
		return FormatTime(curr_time);
	}
}

function checkLimit(){
	if (!warned && limit >= 0){
		if(curr_time >= limit){
			window.alert("YouTube usage time limit reached!!!");
			warned = true;
		}
	}
}
