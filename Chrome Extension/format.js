'use strict';

function FormatTime(time) {
  if (time < 0) {
    return "Time Error";
  }
  var seconds = time/1000;
  function pad(x) {
    return x < 10 ? "0" + x : x;
  }
  return Math.floor(seconds / 60) + ":" + pad(Math.floor((time % 60)));
}

exports.FormatTime = FormatTime;