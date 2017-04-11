//= require webpack-bundle

// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load', function() {
  $('form.search-tracks').on('submit', function(e) {
    e.preventDefault();
    console.log("I'm submitting");
    $.ajax({
      url: $('.search-tracks-btn').attr('ajax-path'),
      data: $('form').serialize(),
      async: true,
      method: 'GET',
      success: onSuccess
    })
  });

  function onSuccess(res) {
    var base_url = $('#path_input').val();
    var query = $('#search_query').val();
    window.location.replace(base_url + "?q=" + query );
  }

});

//for setting user geolocation
function getGeoLocation() {
  var location = navigator.geolocation.getCurrentPosition(setGeoQuery, handleError);
}

function setGeoQuery(position) {
  //reload the page with full location functionality
  var baseUrl = location.href;
  if (baseUrl.substring(-1) =="/") {
    baseUrl = baseUrl.substring(0, baseUrl.length -1);
  }
  if (!baseUrl.includes("?")){
    baseUrl = baseUrl + "?"
  } else {
    baseUrl = baseUrl + "&"
  }
  window.location.replace(baseUrl + `lat=${position.coords.latitude}&lon=${position.coords.longitude}`);
}

function handleError(err) {
  //helpful link, why not html5 - http://stackoverflow.com/questions/32329464/chrome-navigator-geolocation-getcurrentposition-error-403
  console.log(err, "attempting to get location by IP address");
  getGeoLocation2();
}

function getGeoLocation2() {
  var position;
  $.getJSON("http://ipinfo.io", function(ipinfo){
    console.log("Found location ["+ipinfo.loc+"] by ipinfo.io");
    position = ipinfo.loc.split(",");
    setGeoQuery2(position);
  });
}

function setGeoQuery2(position) {
  //reload the page with full location functionality
  var baseUrl = location.href;
  if (baseUrl.substring(-1) =="/") {
    baseUrl = baseUrl.substring(0, baseUrl.length -1);
  }
  if (!baseUrl.includes("?")){
    baseUrl = baseUrl + "?"
  } else {
    baseUrl = baseUrl + "&"
  }
  window.location.replace(baseUrl + `lat=${position[0]}&lon=${position[1]}`);
}
