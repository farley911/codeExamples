$(function(){
	var videoHTML, 
		rtime, 
		timeout = false, 
		delta = 200, 
		skillsVisible = false,
		skillsInit = false;
		deviceWidth = $('body').innerWidth(),
		deviceHeight = $('body').innerHeight(),
		projectDescHeights = new Array(),
		mobile = isMobile();

	//Initilize site
	configPreloader();
	toggleVideo(isChrome());
	configNav();	
	if(mobile) { setNavHeight(); }	
	fadeNavBG();
	if(!mobile) { centerVideo(); }
	projectAnimationConfig();
	configSkills();
	
	$(window).scroll(function(){
		configSkills();
		//Throttle scroll call so it waits until the user is done scrolling the window
		if(!mobile){
			rtime = new Date();
			if(timeout === false){	
				timeout = true;
				fadeNavBG();
				setTimeout(scrollEnd, delta);
			}
		}
	});

	function scrollEnd(){
		if (new Date() - rtime < delta){
			setTimeout(scrollEnd, delta);
		} else {
			timeout = false;
			//Code to run once the user has finished scrolling the window
			var scrollTop = $(window).scrollTop();
			if (scrollTop == 0){
				$('header').animate({
					backgroundColor: "rgba(0,0,0,0)"
				}, 500);
			}
		}
	}

	$(window).resize(function(){
		//Throttle resize call so it waits until the user is done resizing the window
		rtime = new Date();
		if(timeout === false){	
			timeout = true;
			setTimeout(resizeEnd, delta);
		}
	});

	//Throttle resize call so it waits until the user is done resizing the window
	function resizeEnd(){
		if (new Date() - rtime < delta){
			setTimeout(resizeEnd, delta);
		} else {
			timeout = false;
			//Code to run once the user has finished resizing the window
			deviceWidth = $('body').innerWidth();
			deviceHeight = $('body').innerHeight();		
			mobile = isMobile();
			configNav();
			setNavHeight();
			resetProjectDescHeights();
			projectAnimationConfig();
			toggleVideo(false);
			if(!mobile) { centerVideo(); }
			resetSkillWrapper();
		}
	}

	function configPreloader(){
		if(!mobile){
			$('body').jpreLoader({
				splashID: '#jSplash',
				loaderVPos: '50%',
				splashVPos: '25%',
				splashFunction: function(){
					interval = setInterval(function(){
						//Aniumate the ... during loading
						$loading = $('#loading');
						$loading.html().length < 3 ? $loading.html($loading.html() + ".") : $loading.html("");
					}, 500);
				}
			}, function(){
				toggleVideo(isChrome());
				toggleVideo(isChrome());
				clearInterval(interval);
			});
		} else {
			$('#jSplash').css('display', 'none');
			$('body').css('display', 'block');
		}
	}

	function fadeNavBG(){
		if($(window).scrollTop() != 0 && $('header').css('backgroundColor') != "rgba(0,0,0,.7)"){
			$('header').animate({
				backgroundColor: "rgba(0,0,0,.7)"
			}, 500);
		}
	}

	function isMobile(){
		return deviceWidth <= 768 ? true : false;	
	}

	function configNav(){
		$('header img').click(function(){
			scrollNav($(this), 0);
		});

		$('nav a').click(function(){
			var offset = -110;
			if(mobile){ 
				animateNav();
				offset = 0; 
			}
			scrollNav($(this), offset);
		});

		if (mobile){ 
			//navHandle click listener
			$('#navHandle').click(function(){ animateNav(); });

			//Prevent the user from scrolling to the left when the navigation is expanded on mobile devices to improve UX. 
			//Look into adding functionality that closes the navagation instead of scrolling left.
			var sPos = 0;
			$(window).scroll(function(){
				var sLeft = $(this).scrollLeft();
				if(sLeft > sPos && $('nav#mobile').css('width') == '135px'){
					$(document).scrollLeft(0);
				}
				sPos = sLeft;
			});
		}
	}

	function scrollNav($this, distance){
		$.scrollTo($("#" + $this.data('href')), 1000, {offset: distance});
	}

	function animateNav(){
		var d = $('nav#mobile').css('width') == "135px" ? "0" : "135px";
		var s = 750;
		
		$('nav#mobile').animate({
			display:'toggle',
			width: d
		},s);
		$('header').animate({
			left:d
		},s);	
		$('#navHandle').animate({
			left:d
		},s);
		$('#pages').animate({
			left:d
		},s);	
	}

	function setNavHeight(){
		$('nav#mobile').css('height', $(document).height()  + 'px');
	}

	function isChrome(){
		return navigator.userAgent.match(/chrome/i) ? true : false;
	}

	function toggleVideo(chrome){
		var scrollTop = $('body').scrollTop();
		if ((mobile || (chrome && scrollTop != 0)) && videoVisible()){
			//Remove video for mobile device so it doesn't waste data and reduces GPU load in Chrome
			videoHTML = $('#videoWrapper').html();
			$('#videoWrapper').html(""); 
		} else if ((!mobile || (chrome && scrollTop != 0)) && !videoVisible()) {
			//Adds video if it has been removed
			$('#videoWrapper').html(videoHTML);
		}
	}

	function videoVisible(){
		return $('#videoWrapper').html() != "" ? true : false;
	}

	//Calculates the width and height of the browser minus scroll bars, then calculates the size of the video scaled to fill the browser. I then test of the width or height will be cropped from the video and if the width is being cropped I adjust the margin-left to center the video.
	function centerVideo(){
		//Default video size is 596(W) x 336(H)
		var h = (deviceWidth / 596) * 336;
		var w = (deviceHeight / 336) * 596;
		
		$('#home video').css('margin-left', h < deviceHeight ? '-' + ((w - deviceWidth) / 2) + 'px' : 'auto');
	}

	function resetProjectDescHeights(){
		$('.project>article').each(function(){
			$(this).css('height', 'auto')
		});
	}

	function projectAnimationConfig(){
		//Animates project hover
		$('.project>article').each(function(i){
			$this = $(this);
			projectDescHeights[i] = $this.css('height');
			mobile ? $this.css('height','0px') : $this.css('height','50px');
		})

		if(mobile){
			$('.project').unbind('mouseenter mouseleave').click(function(){
				$article = $(this).find('article');
				$('.project>article').animate({
					height: '0px'
				}, 500);
				$article.animate({
					height: $article.css('height') == '0px' ? projectDescHeights[$(this).data('id')] : "0px"
				}, 750);
			});
		} else {
			$('.project').unbind('click').hover(
				function(){
						$this = $(this);
						$this.find('img').fadeTo("slow", 0.3);
						$this.find('article').animate({
							height:projectDescHeights[$this.data('id')]
						},1000);
				}, function(){
						$this = $(this);
						$this.find('img').fadeTo("slow",1)
						$this.find('article').animate({
							height:'50px'
						},1000);
				}
			);
		}
	}

	function resetSkillWrapper(){
		$('#moreBtn').unbind('click').html('View More');
		$('#chartWrapper').css('height', 'auto');
	}

	function configSkills(){
		if(!skillsInit){ 
			//Check is skills are visible
			$.each($('.page:in-viewport'), function(){
				if($(this).attr('id') == "skills"){ skillsVisible = true; return false; }
			});

			if(skillsVisible){
				//Initilize skills dooughnuts
				$.each($('.chart>canvas'), function(i){
					var chart = $('#' + $(this).attr('id'));
					var context = chart.get(0).getContext("2d");
					var chartObj = new Chart(context).Doughnut([{
						value: chart.data('value'),
						color: "#f08800"
					}, {
						value: (100 - chart.data('value')),
						color: "#080a1c"
					}], {
						segmentShowStroke: false,
						percentageInnerCutout: 75,
						animationEasing: "easeOutQuart"
					});
				});

				//Initilize View More/Less functionality
				$wrapper = $('#chartWrapper');
				var wrapperHeight = $wrapper.css('height');
				var height = mobile ? '670px' : '680px';
				$wrapper.css('height',height);

				$('#moreBtn').click(function(){
					$wrapper.animate({
						height: $wrapper.css('height') == height ? wrapperHeight : height
					}, 1000, function(){
						$('#moreBtn').html($wrapper.css('height') == height ? "View More" : "View Less");
					});
				});
				//Initilize skills bars
				$.each($('.chart .barWrapper div'), function(){
					$this = $(this);
					$this.animate({
						width: $this.data('value') + "%"
					}, 1000);
				});
				skillsInit = true;
			}
		}
	}
});

//Angular controllers
function HeadCtrl($scope){
	//Creates an array for both navigations
	$scope.navs = [
		{id: "mobile"},
		{id: "standard"}
	];
	
	//Creates an array with all navigation items
	$scope.pages = [
		{href: "home", text: "Home"},
		{href: "skills", text: "Skills"},
		{href: "portfolio", text: "Portfolio"},
		{href: "about", text: "About Me"},
		{href: "contact", text: "Contact"}
	];
}

function portfolioCtrl($scope){
	//Creates array for projects
	$scope.projects = [
		{src: "hubb", title: "hubb", name: "hubb", desc: "The hubb website was a particularly fun website to work on as I had the chance to work very closely with the designer in order to develop a site that was both stunningly beautiful and built using the latest technologies at the time. I had planned to include additional features such as parallax scrolling and URL pushState to create navigation history, however the deadline prevented these additions.", url: "hubb.me"},
		{src: "mec", title: "Mircosoft Exchange Conference", name: "Microsoft Exchange Conference", desc: "Microsoft Exchange is a large conference held semi annually. The website development was a team effort to create a highly stylized and responsive website hosted in Windows Azure. In addition to the marketing website I was also responsible to the development of the registration websites ensuring that attendees can register, book hotel rooms and purchase any desired training sessions.", url: "iammec.com"},
		{src: "lync", title: "Microsoft Lync Conference", name: "Microsoft Lync Conference", desc: "Microsoft Lync Conference is a smaller conference. I was in charge of leading the development of the site with the help of my development assistant. Along with the marketing site I was also responsible for developing registration websites that collect payment, book hotels, and allow attendees to edit existing registrations.", url: "lyncconf.com"},
		{src: "project", title: "Microsoft Project Conference", name: "Microsoft Project Conference", desc: "Microsoft Project Conference is a large Microsoft conference. I was the lead developer on this project backed by a team of 3 developers. This project also included the development of multiple registration websites that allow the attendees to register, book hotels, add training sessions and edit existing registrations.", url: "msprojectconference.com"},
		{src: "pyrex", title: "Pyrex", name: "Pyrex", desc: "If you haven't heard of Pyrex they are a large national supplier of glass cookware that can be purchased in department stores around the country. I was responsible for the development of their eCommerce website that provides a listing of all of their products, pricing and the option to purchase online. The site also included a complete CMS backend that allowed managers to update and maintain their inventory, sales, webpage content and more.", url: "pyrexware.com"},
		{src: "wtu", title: "Washington Teachers Union", name: "Washington Teachers' Union", desc: "The Washington Teachers' Union operates in Washington, DC. Their site consisted of a full site development along with an extensive CMS backend that allows the site administrators to manage the content of the site including navigation, page content, recurring event calendars and more!", url: "wtulocal6.org"}
	];
}

function skillsCtrl($scope){
	$scope.skills = [
		{name: "HTML5", id: "html", value: "90"},
		{name: "CSS3", id: "css", value: "90"},
		{name: "JavaScript", id: "js", value: "90"},
		{name: "jQuery", id: "jquery", value: "90"},
		{name: "Responsive Design", id: "responsiveDesign", value: "85"},
		{name: "Sass", id: "sass", value: "85"},
		{name: "MV*", id: "mvc", value: "80"},		
		{name: "ASP", id: "asp", value: "80"},
		{name: "Bootstrap", id: "boosstrap", value: "70"},
		{name: "SQL", id: "sql", value: "70"},
		{name: "PHP", id: "php", value: "70"},
		{name: "Angular.js", id: "angularjs", value: "60"},
		{name: ".NET", id: "dotNet", value: "60"},
		{name: "AJAX", id: "ajax", value: "90"},
		{name: "Adobe CS", id: "adobe", value: "85"},
		{name: "Email Blasts", id: "email", value: "80"},
		{name: "Json", id: "json", value: "80"},
		{name: "Web Design", id: "design", value: "75"},
		{name: "Windows Azure", id: "azure", value: "70"},
		{name: "XML", id: "xml", value: "70"},
		{name: "C#", id: "csharp", value: "70"},
		{name: "Cake PHP", id: "cakephp", value: "50"}
	];
}

function contactForm($scope){
	$scope.sendEmail = function(message){
		if (message.$valid){
			var post = $.post("sendEmail.php", {name: $scope.name, email: $scope.email, phoneNumber: $scope.phoneNumber, website: $scope.website, message: $scope.message});
			post.done(function(response){
				if(response){
					$('#mailSuccess').css('display','block');
					$("html, body").animate({ scrollTop: $(document).height() }, "slow");
					$('#contact button').prop('disabled', true);
				} else {
					$('#mailFailure').css('display','block');
				}
			});
		}
	};
}