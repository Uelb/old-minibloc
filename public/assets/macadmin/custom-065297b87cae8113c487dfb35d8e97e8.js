$(document).ready(function(){$(window).resize(function(){$(window).width()>=765?$(".sidebar #nav").slideDown(350):$(".sidebar #nav").slideUp(350)}),$("#nav > li > a").on("click",function(t){$(this).parent().hasClass("has_sub")&&t.preventDefault(),$(this).hasClass("subdrop")?$(this).hasClass("subdrop")&&($(this).removeClass("subdrop"),$(this).next("ul").slideUp(350)):($("#nav li ul").slideUp(350),$("#nav li a").removeClass("subdrop"),$(this).next("ul").slideDown(350),$(this).addClass("subdrop"))})}),$(document).ready(function(){$(".sidebar-dropdown a").on("click",function(t){t.preventDefault(),$(this).hasClass("open")?$(this).hasClass("open")&&($(this).removeClass("open"),$(".sidebar #nav").slideUp(350)):($(".sidebar #nav").slideUp(350),$(".sidebar-dropdown a").removeClass("open"),$(".sidebar #nav").slideDown(350),$(this).addClass("open"))})}),$(".wclose").click(function(t){t.preventDefault();var e=$(this).parent().parent().parent();e.hide(100)}),$(".wminimize").click(function(t){t.preventDefault();var e=$(this).parent().parent().next(".widget-content");e.is(":visible")?($(this).children("i").removeClass("icon-chevron-up"),$(this).children("i").addClass("icon-chevron-down")):($(this).children("i").removeClass("icon-chevron-down"),$(this).children("i").addClass("icon-chevron-up")),e.toggle(500)}),$(document).ready(function(){var t=new Date,e=t.getDate(),n=t.getMonth(),i=t.getFullYear();$("#calendar").fullCalendar({header:{left:"prev",center:"title",right:"month,agendaWeek,agendaDay,next"},editable:!0,events:[{title:"All Day Event",start:new Date(i,n,1)},{title:"Long Event",start:new Date(i,n,e-5),end:new Date(i,n,e-2)},{id:999,title:"Repeating Event",start:new Date(i,n,e-3,16,0),allDay:!1},{id:999,title:"Repeating Event",start:new Date(i,n,e+4,16,0),allDay:!1},{title:"Meeting",start:new Date(i,n,e,10,30),allDay:!1},{title:"Lunch",start:new Date(i,n,e,12,0),end:new Date(i,n,e,14,0),allDay:!1},{title:"Birthday Party",start:new Date(i,n,e+1,19,0),end:new Date(i,n,e+1,22,30),allDay:!1},{title:"Click for Google",start:new Date(i,n,28),end:new Date(i,n,29),url:"http://google.com/"}]})}),setTimeout(function(){$(".progress-animated .progress-bar").each(function(){var t=$(this),e=t.attr("data-percentage"),n=0,i=setInterval(function(){n>=e?clearInterval(i):(n+=1,t.css("width",n+"%")),t.text(n+"%")},600)})},600),$(function(){$("#master1, #master2").slider({value:60,orientation:"horizontal",range:"min",animate:!0}),$("#master4, #master3").slider({value:80,orientation:"horizontal",range:"min",animate:!0}),$("#master5, #master6").slider({range:!0,min:0,max:400,values:[75,200],slide:function(t,e){$("#amount").val("$"+e.values[0]+" - $"+e.values[1])}}),$("#eq > span").each(function(){var t=parseInt($(this).text(),10);$(this).empty().slider({value:t,range:"min",animate:!0,orientation:"vertical"})})}),$(document).ready(function(){$("#slist a").click(function(t){t.preventDefault(),$(this).next().toggle(200)})}),$(".totop").hide(),$(function(){$(window).scroll(function(){$(this).scrollTop()>300?$(".totop").slideDown():$(".totop").slideUp()}),$(".totop a").click(function(t){t.preventDefault(),$("body,html").animate({scrollTop:0},500)})}),$(document).ready(function(){0!=$(".notice").size()&&($(".notice").hide(),setTimeout(function(){noty({text:"<strong>"+$(".notice").html()+"</strong>",layout:"topRight",type:"success",timeout:5e3})})),0!=$(".alert").size()&&($(".alert").hide(),setTimeout(function(){noty({text:"<strong>"+$(".alert").html()+"</strong>",layout:"topRight",type:"error",timeout:5e3})}))}),$(document).ready(function(){$(".noty-alert").click(function(t){t.preventDefault(),noty({text:"Some notifications goes here...",layout:"topRight",type:"alert",timeout:2e3})}),$(".noty-success").click(function(t){t.preventDefault(),noty({text:"Some notifications goes here...",layout:"top",type:"success",timeout:2e3})}),$(".noty-error").click(function(t){t.preventDefault(),noty({text:"Some notifications goes here...",layout:"topRight",type:"error",timeout:2e3})}),$(".noty-warning").click(function(t){t.preventDefault(),noty({text:"Some notifications goes here...",layout:"bottom",type:"warning",timeout:2e3})}),$(".noty-information").click(function(t){t.preventDefault(),noty({text:"Some notifications goes here...",layout:"topRight",type:"information",timeout:2e3})})}),$(function(){$("#datetimepicker1").datetimepicker({pickTime:!1})}),$(function(){$("#datetimepicker2").datetimepicker({pickDate:!1})}),$(".cleditor").cleditor({width:"auto",height:"auto"}),$(".modal").appendTo($("body")),jQuery("a[class^='prettyPhoto']").prettyPhoto({overlay_gallery:!1,social_tools:!1});