document.addEventListener('turbolinks:load',() => {
    if(navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function(position) {
            var lat = position.coords.latitude
            var long = position.coords.longitude
            var arr = [lat, long]
            console.log(arr)
        });
    } else {
        alert("Sorry, your browser does not support HTML5 geolocation.");
    }    
})



