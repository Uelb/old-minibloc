(function(){$(function(){return setInterval(function(){return $.get("/messages",{no_layout:!0},function(n){return $(".mainbar .col-md-12").replaceWith(n)})},5e3)})}).call(this);