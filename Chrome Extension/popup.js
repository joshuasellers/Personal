'use strict';

let resetTime = document.getElementById('resetTimer');

resetTime.onclick = function() {
	chrome.extension.getBackgroundPage().inYouTube = false;
	chrome.extension.getBackgroundPage().curr_time = 0;
	chrome.extension.getBackgroundPage().curr_date = 0;
};

let setTime = document.getElementById('setTime');

setTime.onclick = function() {
	let hours = document.getElementById('hrs');
	let minutes = document.getElementById('mins');
}

var myVar = setInterval(myTimer, 1000);

function myTimer() {
	var bgPage = chrome.extension.getBackgroundPage();
	document.getElementById("clock").textContent = bgPage.updateTime();
	var time = bgPage.updateTime();
}
