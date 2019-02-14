'use strict';


var timers = [];
var inYouTube = false;
var curr = 0;

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
			var time = GetTime(timers)
			console.log(time);
			var format = FormatTime(time);
			console.log(format)
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
