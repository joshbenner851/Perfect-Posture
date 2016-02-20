/**
 * Created by Joel on 21/02/2016.
 */

var API_KEY = "83ffdd46ec1f3a278c0188dc034784d7";
var DEVICE_KEY ="286efac3f04c4a7433c6f94116f80a24";

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
        console.log("resp: ", JSON.parse(xhr.response).values[1].value)
    });

};