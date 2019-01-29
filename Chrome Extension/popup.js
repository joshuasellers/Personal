'use strict';

chrome.tabs.getSelected(null,function(tab) {
	chrome.extension.getBackgroundPage().timers[tabId] = new Date();
	chrome.browserAction.disable(tabId);
	chrome.browserAction.setIcon({path: "icon-disabled.png", tabId: tabId});

	var currentTime = new Date();
	if(currentTime - chrome.extension.getBackgroundPage().timers[tabId] > 5000)
	{
	  chrome.browserAction.enable(tabId);
	  chrome.browserAction.setIcon({path: "icon-enabled.png", tabId: tabId});
	}
}

//chrome.tabs.getSelected(null,function(tab) {
//var Mp=tab.url
//if(Mp=='http://www.examplesite.com')
//{
//var xhr=new XMLHttpRequest();
//var Params;
//xhr.open("POST", "http://myserver.com/post_from_extension.asp", true);
//xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
//Params='Url=' + tab.url;
//xhr.onreadystatechange=function()
//    {
//        if(xhr.readyState==4)
//        {
//        message.innerHTML=xhr.responseText;
//        }
//    }
//xhr.send(Params);
//}
//else
//{
//message.innerHTML='<span style="font-family: Segoe UI, Tahoma;color: #f00">This is not a valid url</span>';
//}
//});