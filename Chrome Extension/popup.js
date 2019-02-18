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
	document.getElementById("clock").textContent = bgPage.updateTime();
	var time = bgPage.updateTime();
}

chrome.runtime.onMessage.addListener(
    function(request, sender, sendResponse) {
        if (request.msg === "LIMIT") {
        	clearInterval(myVar);
            chrome.extension.getBackgroundPage().inYouTube = false;
			chrome.extension.getBackgroundPage().curr_time = 0;
			chrome.extension.getBackgroundPage().curr_date = 0;
			chrome.extension.getBackgroundPage().warned = false;
			chrome.extension.getBackgroundPage().limit = -1;
			document.getElementById("clock").textContent = "LIMIT";
        }
    }
);
