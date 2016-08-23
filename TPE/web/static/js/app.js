// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

$( "#filter-offers" ).click(function() {
  window.location.href = window.location.href.split('?')[0] + "?skill_id=" + $('#skills-select-filter').val();
});

$("span.menu").click(function () {
  $(".top-menu").slideToggle("slow", function () {
  });
});

$('.edit-button').on("click", function() {
  $('#info-user').css("display", "none");
  $('#editing-info-user').css("display", "block");
})

$('.cancel-edit-button').on("click", function() {
  $('#info-user').css("display", "block");
  $('#editing-info-user').css("display", "none");
})
