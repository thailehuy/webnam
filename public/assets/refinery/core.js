$(document).ready(function(){$("form input[type=text]:first").focus(),init_flash_messages()}),init_flash_messages=function(){$("#flash").css({opacity:0,visibility:"visible"}).animate({opacity:"1"},550),$("#flash_close").live("click",function(a){try{$("#flash").animate({opacity:0,visibility:"hidden"},330,function(){$("#flash").hide()})}catch(b){$("#flash").hide()}a.preventDefault()}),$("#flash.flash_message").prependTo("#records")};