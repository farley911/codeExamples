//Define Device class
function Device() {
	var _width = $('body').innerWidth();
	var _height = $('body').innerHeight();
	var _chrome = navigator.userAgent.match(/chrome/i) ? true : false;
	var _tablet = _width <= 1024 ? true : false;
	var _mobile = _width <= 768 ? true : false;

	return{
		//Define Width get; set;
		width : function(newWidth){
			if(newWidth){ _width = newWidth; }
			return _width;
		},
		//Define height get; set;
		height : function(newHeight){
			if(newHeight){ _height = newHeight; }
			return _height;
		},
		//Define isChrome get; set;
		chrome : function(isChrome){
			if (isChrome){ _chrome = isChrome; }
			return _chrome;
		},
		//Define isTablet get; set;
		tablet : function(isTablet){
			if(isTablet){ _tablet = isTablet; }
			return _tablet;
		},
		//Define isMobile get; set;
		mobile : function(newMobile){
			if(newMobile){ _mobile = newMobile; }
			return _mobile;
		},
		//Define reset method
		reset : function(){
			_width = $('body').innerWidth();
			_height = $('body').innerHeight();
			_tablet = _width <= 1024 ? true : false;
			_mobile = _width <= 768 ? true : false;
		}
	};
}


//Define Video class
function Video(d){
	//Init Video attributes
	var _self = this;
	var _HTML = $('#videoWrapper').html();
	var _visible = $('#videoWrapper').html() !== "" ? true : false;

	//Define HTML get; set;
	Video.prototype.HTML = function(newHTML){
		if(newHTML){ _HTML = newHTML; }
		return _HTML;
	};

	//Define visible get; set;
	Video.prototype.visible = function(isVisible){
		if(isVisible){ _visible = isVisible; }
		return _visible;
	};

	//Define toggle method
	Video.prototype.toggle = function(){
		var scrollTop = $('body').scrollTop();
		if ((d.tablet() || (d.chrome() && scrollTop !== 0)) && _visible){
			//Remove video for mobile device so it doesn't waste data and reduces GPU load in Chrome
			_visible = false;
			$('#videoWrapper').html(""); 
		} else if ((!d.tablet() || (d.chrome() && scrollTop !== 0)) && !_visible) {
			//Adds video if it has been removed
			_visible = true;
			$('#videoWrapper').html(_HTML);
		}
	};

	//Define center method
	//Calculates the width and height of the browser minus scroll bars, then calculates the size of the video scaled to fill the browser. I then test of the width or height will be cropped from the video and if the width is being cropped I adjust the margin-left to center the video.
	Video.prototype.center = function(){
		if(!d.mobile()){
			//Default video size is 596(W) x 336(H)
			var h = (d.width() / 596) * 336;
			var w = (d.height() / 336) * 596;
			
			$('#home video').css('margin-left', h < d.height() ? '-' + ((w - d.width()) / 2) + 'px' : 'auto');
		}
	};

	//Initilize video object
	_self.toggle();
	_self.center();
}	

//Define Preloader Class
function Preloader(d){
	if(!d.mobile()){
    var interval;
		$('body').jpreLoader({
			splashID: '#jSplash',
			loaderVPos: '50%',
			splashVPos: '25%',
			splashFunction: function(){
				interval = setInterval(function(){
					//Aniumate the ... during loading
					var $loading = $('#loading');
					$loading.html($loading.html().length < 3 ? $loading.html() + "." : "");
				}, 500);
			}
		}, function(){
			clearInterval(interval);
		});
	} else {
		$('#jSplash').css('display', 'none');
		$('body').css('display', 'block');
	}	
}

//Define Nav class
function Nav(d){
	var _self = this;

	//Define scroll method
	Nav.prototype.scroll = function(e, dist){
		$.scrollTo($("#" + e.data('href')), 1000, {offset: dist});
	};

	//Define animate method
	Nav.prototype.animate = function(){
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
	};

	//Define setHeight method
	Nav.prototype.setHeight = function(d){
		if(d.mobile()){ $('nav#mobile').css('height', $(document).height()  + 'px'); }
	};

	//Define fadeBG method
	Nav.prototype.fadeBG = function(){
		if($(window).scrollTop() !== 0 && $('header').css('backgroundColor') != "rgba(0,0,0,.7)"){
			$('header').animate({
				backgroundColor: "rgba(0,0,0,.7)"
			}, 500);
		}
	};

	//Define init method
	Nav.prototype.init = function(){
		$('header img').click(function(){
			_self.scroll($(this), 0);
		});

		$('nav a').click(function(){
			var offset = -110;
			if(d.mobile()){ 
				_self.animate();
				offset = 0; 
			}
			_self.scroll($(this), offset);
		});

		if (d.mobile()){ 
			//navHandle click listener
			$('#navHandle').click(function(){ _self.animate(); });

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

		_self.setHeight(d);
		_self.fadeBG();
	};
}

//Define project class
function Project(d){
	var _descHeights = [];

	Project.prototype.init = function(){
		$('.project>article').each(function(i){
			var $this = $(this);
			_descHeights[i] = $this.css('height');
			$this.css('height', d.mobile() ? '0px' : '50px');
		});

		if(d.mobile()){
			$('.project').unbind('mouseenter mouseleave').click(function(){
				var $article = $(this).find('article');
				$('.project>article').animate({
					height: '0px'
				}, 500);
				$article.animate({
					height: $article.css('height') == '0px' ? _descHeights[$(this).data('id')] : "0px"
				}, 750);
			});
		} else {
			$('.project').unbind('click').hover(
				function(){
						var $this = $(this);
						$this.find('img').fadeTo("slow", 0.3);
						$this.find('article').animate({
							height:_descHeights[$this.data('id')]
						},1000);
				}, function(){
						var $this = $(this);
						$this.find('img').fadeTo("slow",1);
						$this.find('article').animate({
							height:'50px'
						},1000);
				}
			);
		}
	};

	Project.prototype.resetDescHeights = function(){
		$('.project>article').each(function(){
			$(this).css('height', 'auto');
		});
	};
}

//Define Skills class
function Skill(){
	var _self = this;
	var _initilized = false;
	var _visible = false;

	//Define initilized method
	Skill.prototype.initilized = function(i){
		if(i){ _initilized = i; }
		return _initilized;
	};

	//Define visible method
	Skill.prototype.visible = function(){
		//Check is skills are visible
		$.each($('.page:in-viewport'), function(){
			if($(this).attr('id') == "skills"){ _visible = true; return false; }
		});
		return _visible;
	};

	//Define setSkillHeight method
	Skill.prototype.setSkillHeight = function(d){
		//Initilize View More/Less functionality
		var _wrapper = $('#chartWrapper');
		var _wrapperHeight = _wrapper.css('height');
		var _height = d.mobile() ? '670px' : '680px';
		_wrapper.css('height',_height);

		$('#moreBtn').click(function(){
			_wrapper.animate({
				height: _wrapper.css('height') == _height ? _wrapperHeight : _height
			}, 1000, function(){
				$('#moreBtn').html(_wrapper.css('height') == _height ? "View More" : "View Less");
			});
		});
	};

	//Define animate method
	Skill.prototype.init = function(d){
		_self.setSkillHeight(d);

		//Initilize skills dooughnuts
		$.each($('.chart>canvas'), function(){
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

		//Initilize skills bars
		$.each($('.chart .barWrapper div'), function(){
			var $this = $(this);
			$this.animate({
				width: $this.data('value') + "%"
			}, 1000);
		});

		_initilized = true;
	};

	Skill.prototype.reset = function(){
		$('#moreBtn').unbind('click').html('View More');
		$('#chartWrapper').css('height', 'auto');
	};
}

$(function(){
	//Create objects
	var device = new Device();
	var preloader = new Preloader(device);
	var video = new Video(device);
	var nav = new Nav(device);
	var projects = new Project(device);
	var skills = new Skill();

	//Create valiables for the scroll and resize functions
	var timeout = false;
	var delta = 200;
	var rtime;

	//Initilize nav
	nav.init();
	//Initilize projects
	projects.init();
	//Initilize skills
	if(!skills.initilized() && skills.visible()){
		skills.init(device);
	}

	//Handle scroll event
	$(window).scroll(function(){
		if(!skills.initilized() && skills.visible()){
			skills.init(device);
		}
		//Throttle scroll call so it waits until the user is done scrolling the window
		if(!device.mobile()){
			rtime = new Date();
			if(timeout === false){	
				timeout = true;
				nav.fadeBG();
				setTimeout(scrollEnd, delta);
			}
		}
	});

	function scrollEnd(){
		if (new Date() - rtime < delta){
			setTimeout(scrollEnd, delta);
		} else {
			//Code to run once the user has finished scrolling the window
			timeout = false;
			var scrollTop = $(window).scrollTop();
			if (scrollTop === 0){
				$('header').animate({
					backgroundColor: "rgba(0,0,0,0)"
				}, 500);
			}
		}
	}

	//Handle resize event
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
			//Code to run once the user has finished resizing the windo
			timeout = false;
			device.reset();
			nav.init();
			projects.resetDescHeights();
			projects.init();
			video.toggle();
			video.center();
			skills.reset();
			skills.setSkillHeight(device);
		}
	}
});