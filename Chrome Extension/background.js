'use strict';

chrome.runtime.onInstalled.addListener(function() {
    chrome.storage.sync.set({time: 0}, function() {
      console.log("The time is set to 0.");
    });
  });