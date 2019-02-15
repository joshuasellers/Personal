'use strict';

let resetTime = document.getElementById('resetTimer');

resetTime.onclick = function() {
  chrome.extension.getBackgroundPage().timers = [];
  chrome.extension.getBackgroundPage().inYouTube = false;
  chrome.extension.getBackgroundPage().curr = 0;
};

let getTime = document.getElementById('getTimer');

getTime.onclick = function() {
  chrome.extension.getBackgroundPage().timers = [];
  chrome.extension.getBackgroundPage().inYouTube = false;
  chrome.extension.getBackgroundPage().curr = 0;
};
