'use strict';


var timers = [];
var inYouTube = false;
var curr = 0;
var current_time = 0;
var current_format = "00:00";

chrome.tabs.onUpdated.addListener(
function(tabId, changeInfo, tab) 
{
	if (changeInfo.status == "complete"){
		var tabID = tabId;
		var url = tab.url;
		console.log("function")
		if (inYouTube){
			console.log("Get time for updated");
			timers[curr] = new Date() - timers[curr];
			current_time = GetTime(timers);
			console.log(current_time);
			current_format = FormatTime(current_time);
			console.log(current_format);
			inYouTube = false;
		}
		if (url != null && url.includes("youtube.com")) {
			inYouTube = true;
			console.log("updated to youtube!");
			console.log(url);
			timers[tabID] = new Date();
			curr = tabID;
		}
	;}
});

function updateTime(){
	if (inYouTube){
			console.log("Get time for updated");
			var holder = timers[curr];
			timers[curr] = new Date() - timers[curr];
			current_time = GetTime(timers);
			console.log(current_time);
			current_format = FormatTime(current_time);
			console.log(current_format);
			timers[curr] = holder;
		}
}
