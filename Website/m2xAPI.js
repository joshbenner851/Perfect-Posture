/**
 * Created by Joel on 21/02/2016.
 */

var API_KEY = "83ffdd46ec1f3a278c0188dc034784d7";
var DEVICE_KEY ="286efac3f04c4a7433c6f94116f80a24";
var tiltData;

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


    var xhr = m2x.devices.streamValues(DEVICE_KEY,
        "posture", function() {
        tiltData = JSON.parse(xhr.response).values;
        console.log(tiltData);



            var labels = [],data=[];
            for(var i=0; i <30 && tiltData[i].value != null; i++){
                labels.push(tiltData[i].timestamp);
                data.push(tiltData[i].value);
            }

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


