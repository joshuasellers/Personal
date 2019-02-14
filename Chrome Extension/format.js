'use strict';

function FormatTime(times) {
	var x;
	var time = 0;
	var curr = 0;
	var i = 0;
	for (x in times) {
		if (curr == 0){
			curr = times[x];
		}
		else{
			time += times[x] - curr;
			curr = times[x];
		}
	}
	return time;
	//var seconds = time/1000;
	//function pad(x) {
	//return x < 10 ? "0" + x : x;
	//}
	//return Math.floor(seconds / 60) + ":" + pad(Math.floor((time % 60)));
};
