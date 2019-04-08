'use strict';

let resetTime = document.getElementById('resetTimer');

resetTime.onclick = function() {
	chrome.extension.getBackgroundPage().inYouTube = false;
	chrome.extension.getBackgroundPage().curr_time = 0;
	chrome.extension.getBackgroundPage().curr_date = 0;
	chrome.extension.getBackgroundPage().warned = false;
	chrome.extension.getBackgroundPage().limit = -1;
};

let setTime = document.getElementById('setTime');

setTime.onclick = function() {
	var hours = document.getElementById('hrs').value;
	var minutes = document.getElementById('mins').value;
	chrome.extension.getBackgroundPage().limit = 3600000 * hours + 60000 * minutes;
}

var myVar = setInterval(myTimer, 1000);

function myTimer() {
	var bgPage = chrome.extension.getBackgroundPage();
	var time = bgPage.updateTime();
	document.getElementById("clock").textContent = "TIME: " + time;
	if (chrome.extension.getBackgroundPage().limit == -1){
		document.getElementById("limit").textContent = "LIMIT: " + "N/A"
	}
	else{
		document.getElementById("limit").textContent = "LIMIT: " + bgPage.updateLimit();
	}
}
