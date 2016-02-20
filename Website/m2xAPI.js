/**
 * Created by Joel on 21/02/2016.
 */

var API_KEY = "83ffdd46ec1f3a278c0188dc034784d7";
var DEVICE_KEY ="286efac3f04c4a7433c6f94116f80a24";
var tiltData;
var score;
window.onload = function() {
    var m2x = new M2X(API_KEY);

    m2x.status(function(data) {
        console.log(data);
    }, function(error) {
        console.log("Oops, the API cannot be reached: ", error);
    });

    m2x.devices.view(DEVICE_KEY, function(device) {
        console.log(device);
    }, function(error) { console.log(error); });

    var xhr2 = m2x.devices.streamValues(DEVICE_KEY,
        "achievementNumber", function() {
            score = JSON.parse(xhr2.response).values[0].value;
            $(".score").append(score);
            console.log("score: ", score);
        });

    var xhr = m2x.devices.streamValues(DEVICE_KEY,
        "posture", function() {
        tiltData = JSON.parse(xhr.response).values;
        console.log(tiltData);

            var timestamp = tiltData[0].timestamp;
            var day = timestamp.slice(5,7);
            console.log(timestamp);
            console.log("timestamp : ",day);
            console.log("tilt: " ,tiltData[0].value);
            var count = 0;
            var minutes = 5;
            var lastTen = timestamp.slice(15,16);
            console.log("min : ",lastTen);
            var avg =0;
            var sum = 0;
            var labels = [],data=[];
            var objNum = 0;
            while( day == tiltData[count].timestamp.slice(5,7) && count < tiltData.length &&  typeof(tiltData[count].timestamp) != undefined )
            {

                currentData = tiltData[count].timestamp;
                var minute = currentData.slice(15,16);
                if( Math.trunc( minute / minutes) != lastTen && avg != NaN )
                {

                    labels.push(tiltData[count].timestamp);
                    avg = sum / count;
                    alert("avg: ", avg);
                    data.push( tiltData[count].value );  //change to avg
                    objNum = 0;
                    lastTen = Math.trunc(minute / minutes);
                    count += 1;
                }
                else {
                    objNum += 1;
                    sum += tiltData[count].value;
                    count +=1;

                }
                if(count > 500) {
                    break;
                }
            }
            console.log("avg: ", avg);

        var tempData = {
            labels : labels,
            datasets : [{
                fillColor : "rgba(172,194,132,0.4)",
                strokeColor : "#ACC26D",
                pointColor : "#fff",
                pointStrokeColor : "#9DB86D",
                data : data
            }]
        };

        var temp = document.getElementById('canvas').getContext('2d');
        var lineChart = new Chart(temp).Line(tempData);
    });

};


