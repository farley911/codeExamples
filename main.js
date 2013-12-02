$(function(){
	// Create hover action for inline images
	$(".rollover").hover(function(){
		$(this).attr("src", ($(this).attr("src").substring(0,$(this).attr("src").length-4) + "-hover" + $(this).attr("src").substring($(this).attr("src").length-4, $(this).attr("src").length)));
	}, function(){
		$(this).attr("src", ($(this).attr("src").substring(0,$(this).attr("src").length-10) + $(this).attr("src").substring($(this).attr("src").length-4, $(this).attr("src").length)));
	});

	//Hide online demo button on demo page
	if(document.URL.indexOf("demo") != -1){
		$('#onlineDemoWrapper').html('');	
	}
	//Hide pricing button on pricing page
	if(document.URL.indexOf("pricing") != -1){
		$('#pricingBtnWrapper').html('');	
	}
	
	//scale items to screen resolution
	var scale = ($(window).height() / 1080).toString().substring(0,4);
	
	$(".scaleSize").each(function(){
		$(this).css("width", (parseInt($(this).css("width").substring(0,($(this).css("width").length-2)))*scale) + "px");
		if ($(this).hasClass("scalePosition")) {
			$(this).css("left", (parseInt($(this).css("left").substring(0, $(this).css("left").length-2))) * scale + "px");
			$(this).css("top", (parseInt($(this).css("top").substring(0, $(this).css("top").length-2))) * scale + "px");
		}
	});
	
	// Create hover action for background images
	$(".ro").hover(function(){
		$(this).toggleClass("hover");
	}, function() {
		$(this).toggleClass("hover");
	});
	
	// Left nav slide out animation
	$("#sideNav li").hoverIntent(function(){
		var li = $("#navFlyouts li[data-i='" + $(this).attr("data-i") + "']");
		$(this).animate({
			width: (parseInt(li.attr('data-width')) + 40) + 'px'
		});
		li.animate({
			width: li.attr('data-width') + 'px'
		});
	},function(){
		$(this).animate({
			width: '34px'
		});
		$("#navFlyouts li[data-i='" + $(this).attr("data-i") + "']").animate({
			width: '0px'
		});
	});
	
	// Init Nivo Slider
	$('#slider').nivoSlider({
		pauseTime: 5000,
		effect: 'slideInLeft',
		prevText: '',
		nextText: ''
	});
	
	// Respond to contact form status
	if (getParameterByName("contactStat") == "error"){
		alert("You have entered the wrong security phrase, please try again.");
	} else if (getParameterByName("contactStat") == "submitted"){
		alert("You message has been successfully sent.");
	}
	
	// Calculate/set width for infinite fades.
	$(".infiniteFade").css("width", (($(window).width()-1000)/2));
});

// Resize elements when the window size changes
$(window).resize(function(){
		var scale = ($(window).height() / 1080).toString().substring(0,4);
		
		$(".scaleSize").each(function(){			
			$(this).css("width", $(this).attr("data-origWidth")*scale + "px");
			if ($(this).hasClass("scalePosition")) {
				$(this).css("left", $(this).attr("data-origX") * scale + "px");
				$(this).css("top", $(this).attr("data-origY") * scale + "px");
			}
		});
		
		// Calculate/set width for infinite fades.
		$(".infiniteFade").css("width", (($(window).width()-1000)/2));
});

// Scroll function
function scrollDown(){
	$('body,html').animate({
		scrollTop: window.pageYOffset + $(window).height()
	}, 500);
}

function clearInput(id, defaultVal){
	$("#"+id).removeClass("error");
	if ($("#" + id).val() == defaultVal) {	$("#" + id).val(""); }
}

function getParameterByName(name)
{
  name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
  var regexS = "[\\?&]" + name + "=([^&#]*)";
  var regex = new RegExp(regexS);
  var results = regex.exec(window.location.search);
  if(results == null)
    return "";
  else
    return decodeURIComponent(results[1].replace(/\+/g, " "));
}