// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
 //= require jquery 
 //= require jquery.turbolinks 
 //= require jquery_ujs 
 //= require bootstrap-sprockets 
 //= require turbolinks

//= require_tree .


$(document).ready(function() { 
 document.getElementById("fullscreen").onclick = function() {myFunction()};
 document.getElementById("ede").onclick = function() {myFunction()};
 function myFunction() {
  document.getElementById('slides').style.display = "block";
  var windowHeight = $(window).height();
  var headerHeight = $("header").outerHeight();
  var calculatedHeight = windowHeight - headerHeight;
  var heightFill = $('.height-fill')
  $(heightFill).height(calculatedHeight);
  // superslides
  $(function()  {
    $('#slides').superslides({
        inherit_height_from: '.height-fill',
        
    });
  });
 };
 
});


/* The Modal (background) */
.modal {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1; /* Sit on top */
    padding-top: 100px; /* Location of the box */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content */
.modal-content {
    background-color: #fefefe;
    margin: 0 auto;
    padding: 20px;
    border: 1px solid #888;
    width: 80%;
}

/* The Close Button */
.close {
    color: #aaaaaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
}

.close:hover,
.close:focus {
    color: #000;
    text-decoration: none;
    cursor: pointer;
}