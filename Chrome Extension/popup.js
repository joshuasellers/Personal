'use strict';

let resetTime = document.getElementById('resetTimer');

resetTime.onclick = function() {
	chrome.extension.getBackgroundPage().timers = [];
	chrome.extension.getBackgroundPage().inYouTube = false;
	chrome.extension.getBackgroundPage().curr = 0;
	chrome.extension.getBackgroundPage().current_timer = 0;
	chrome.extension.getBackgroundPage().current_format = "00:00";
};

var bgPage = chrome.extension.getBackgroundPage();
var myVar = setInterval(myTimer, 1000);

function myTimer() {
	var yt = chrome.extension.getBackgroundPage().inYouTube;
	if (yt){
		document.getElementById("clock").textContent = bgPage.updateTime();
		var time = chrome.extension.getBackgroundPage().current_format;
		chrome.browserAction.setBadgeText({text: time});
	}
	else{
		document.getElementById("clock").textContent = chrome.extension.getBackgroundPage().current_format;
		var time = chrome.extension.getBackgroundPage().current_format;
		chrome.browserAction.setBadgeText({text: time});
	}
}



/*
var yt = chrome.extension.getBackgroundPage().inYouTube;
var currentTime = new Date();
while (yt){
	if(new Date() - currentTime > 1000)
	{
	  	let clock = document.getElementById('clock');
		clock.textContent = bgPage.updateTime();
	}
	currentTime = new Date();
	yt = chrome.extension.getBackgroundPage().inYouTube;
}
*/
