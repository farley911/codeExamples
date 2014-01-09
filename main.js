//Global variables used for responsiveness
var deviceWidth = $('body').innerWidth();
var deviceHeight = $('body').innerHeight();
$video = $('#videoWrapper');
var videoHTML;

$(function(){		
	//Centers the video on page load
	centerVideo();
	
	//Remove video for mobile device so it doesn't waste data
	if(isMobile()) {
		videoHTML = $video.html();
		$video.html(""); 
	}
	
	setNavHeight();
		
	//navHandle click listener
	$('#navHandle').click(function(){
		if (isMobile){ animateNav(); }
	});
	
	//Prevent the user from scrolling to the left when the navigation is expanded on mobile devices to improve UX. Look into adding functionality that closes the navagation instead of scrolling left.
	var sPos = 0;
	$(window).scroll(function(){		
		if (isMobile){
			var sLeft = $(this).scrollLeft();
			if(sLeft > sPos){
				if($('nav#mobile').css('width') == '135px'){
					$(document).scrollLeft(0);
				}
			}
			sPos = sLeft;
		}
	});
	
	//Centers the video every time the browser is resized
	$(window).resize(function(){		
		//Reset the device height and width with the updated values
		deviceWidth = $('body').innerWidth();
		deviceHeight = $('body').innerHeight();
		
		setNavHeight();
		if(!isMobile() && !videoVisible()){ $video.html(videoHTML); }
		centerVideo();
	});

	//Animates project hover
	var projectDescHeights = new Array();
	$('.project>article').each(function(i){
		$this = $(this);
		projectDescHeights[i] = $this.css('height');
		$this.css('height','50px');
	});

	$('.project').hover(
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
});

function isMobile(){
	return deviceWidth <= 768 ? true : false;	
}

function videoVisible(){
	return $video.html() != "" ? true : false;
}

function animateNav(){
	var d = $('nav#mobile').css('width') == "135px" ? "0" : "135px";
	var s = 750;
	
	$('nav#mobile').animate({
		display:'toggle',
		width: d,
		left:'-' + d
	},s);
	$('header').animate({
		left:d
	},s);
	$('#pages').animate({
		left:d
	},s);	
}

function setNavHeight(){
	if(isMobile()){ $('nav#mobile').css('height', $(document).height()  + 'px'); }
}

//Calculates the width and height of the browser minus scroll bars, then calculates the size of the video scaled to fill the browser. I then test of the width or height will be cropped from the video and if the width is being cropped I adjust the margin-left to center the video.
function centerVideo(){
	//Default video size is 596(W) x 336(H)
	var h = (deviceWidth / 596) * 336;
	var w = (deviceHeight / 336) * 596;
	
	$('#home video').css('margin-left', h < deviceHeight ? '-' + ((w - deviceWidth) / 2) + 'px' : 'auto');
}

//Angular controllers
function HeadCtrl($scope){
	//Creates an array for both navigations
	$scope.navs = [
		{id: "mobile"},
		{id: "standard"}
	];
	
	//Creates an array with all navigation items
	$scope.pages = [
		{href: "AboutMe", text: "About Me"},
		{href: "Portfolio", text: "Portfolio"},
		{href: "Skills", text: "Skills"},
		{href: "Contact", text: "Contact"}
	];
}

function portfolioCtrl($scope){
	//Creates array for projects
	$scope.projects = [
		{src: "hubb", title: "hubb", name: "hubb", desc: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla quis convallis sapien, at auctor lorem. Ut accumsan mauris non risus convallis, ultricies lacinia purus scelerisque. Proin suscipit elit non odio aliquet, eu dignissim ligula pharetra. Ut ac aliquam ligula, a dignissim quam. Nullam et arcu eu mi vehicula luctus. Nam est urna, vulputate ac leo in, euismod venenatis enim. Proin posuere cursus justo at fermentum. Curabitur mauris eros, pharetra quis venenatis eget, lobortis tempus ligula.", url: "hubb.me"},
		{src: "mec", title: "Mircosoft Exchange Conference", name: "Microsoft Exchange Conference", desc: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla quis convallis sapien, at auctor lorem. Ut accumsan mauris non risus convallis, ultricies lacinia purus scelerisque. Proin suscipit elit non odio aliquet, eu dignissim ligula pharetra. Ut ac aliquam ligula, a dignissim quam. Nullam et arcu eu mi vehicula luctus. Nam est urna, vulputate ac leo in, euismod venenatis enim. Proin posuere cursus justo at fermentum. Curabitur mauris eros, pharetra quis venenatis eget, lobortis tempus ligula.", url: "iammec.com"},
		{src: "lync", title: "Microsoft Lync COnference", name: "Microsoft Lync Conference", desc: "The new commer approaches the existing group with, hey dude how wasted am I? which is meet with a courus of, he talked to fast to continue qouteing sheldon cooper", url: "lyncconf.com"},
		{src: "project", title: "Microsoft Project COnference", name: "Microsoft Project Conference", desc: "The new commer approaches the existing group with, hey dude how wasted am I? which is meet with a courus of, he talked to fast to continue qouteing sheldon cooper", url: "msprojectconference.com"},
		{src: "pyrex", title: "Pyrex", name: "Pyrex", desc: "The new commer approaches the existing group with, hey dude how wasted am I? which is meet with a courus of, he talked to fast to continue qouteing sheldon cooper", url: "pyrexware.com"},
		{src: "wtu", title: "Washington Teachers Union", name: "Washington Teachers' Union", desc: "The new commer approaches the existing group with, hey dude how wasted am I? which is meet with a courus of, he talked to fast to continue qouteing sheldon cooper", url: "wtulocal6.org"}
	];
}