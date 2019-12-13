// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require jquery
//= require popper
//= require bootstrap
//= require_tree .
$(document).ready(function() {
    // Show server notifications in toast
    $(".toast[data-has-content=true]").toast("show");
});
$(document).on("turbolinks:load", function() {
    $(".task-entity").each(function() {
        // SVGs cannot be colorified using style
        let color = $(this).data("entity-color");
        $(this).find("svg.back-icon path").css({ fill: color });
    });
    $("option").each(function() {
        $(this).text($(this).text().replace(String.fromCharCode(7), ""))
    });
});