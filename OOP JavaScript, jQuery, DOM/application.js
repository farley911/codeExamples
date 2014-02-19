$(function () {
    // Collapse/Expand sponsors sections
    $('.plusMinus').on('click', function () {
    	var path = '/Images/Sponsors/';
    	
    	$this = $(this);
        level = $this.data('level');

        if ($this.css('background-position') == "0% -25px") {
        	$('.sponsors.' + level + ' .sponsor a').each(function (index) {
        		var images = $(this).find('img');
        		images.eq(0).show();
        		images.eq(1).hide();
        	});

        	$this.css('background-position', '0% 0%');
            $('.sponsors.' + level + ' .sponsor').css({
                width: '230px',
                float: 'left',
                'margin-right': '20px'
            });           

            $('.sponsors.' + level + ' .description').css('display', 'none');
        }
        else {
        	$('.sponsors.' + level + ' .sponsor a').each(function (index) {
        		var	images = $(this).find('img');
        		images.eq(0).hide();
        		images.eq(1).show();
        	});

        	$this.css('background-position', '0% -25px');
            $('.sponsors.' + level + ' .sponsor').css({
                width: 'inherit',
                float: 'none',
                'margin-right': '0px'
            });

			$('.sponsors.' + level + ' .description').css('display', 'block');
        }

        return false;
    });

    $('.kmi_ipt').focus(function () {
        $this = $(this);
        if ($this.val() == "Keep me notified") { $(this).val(""); }
    });
    $(".kmi_submit").click(function () {
        submit_email();
        return false;
    });

    function check_email() {
        if ((/^[a-zA-Z0-9\._%\-\!\#\$\%\&\'\*\+\-\/\=\?\^\_\`\{\|\}\~]+@[a-zA-Z0-9.\_%\-]+\.[a-zA-Z0-9]{2,6}$/i).test($('#kmi_ipt').val()) === false) {
            $("#KMILink").html('The Email you entered is not formatted correctly.').animate({
                height: 'toggle'
            }, 1000, function () {
                setTimeout(function () {
                    $("#KMILink").animate({
                        height: 'toggle'
                    }, 1000);
                }, 5000);
            });
            return false;
        }
        return true;
    }

    function submit_email() {

        /***
        
        # DATA RETURN FORMAT #
        
        0 = Any Error. Message, "An Error Occurred, please refresh and try again."
        1 = Successfully submits email address, "Success!"
        2 = Email in use, "Email address is already entered to receive updates."
        3 = Email not formatted correctly, 
        
        ***/

        var go2url = 'Data.svc/register/';
        if ((check_email()) === true) {
            var request = $.ajax({
                url: go2url,
                type: "GET",
                data: { "email": escape($('#kmi_ipt').val()) },
                async: false,
                success: function (data) {
					var responseText;
                    if (data == '0') {
                        responseText = 'An Error Occurred, please refresh and try again.';
                    }
                    else if (data == '1') {
                        responseText = 'Your email has been successfully added to our mailing list.';
                    }
                    else if (data == '2') {
                        responseText = 'Email address is already entered to receive updates.';
                    }
                    else if (data == '3') {
                        responseText = 'Email not formatted correctly.';
                    }
                    else {
                        responseText = 'An Error Occurred, please refresh and try again.';
                    }
					
					$("#KMIResposne").html(responseText).animate({
						height: '20px'
					}, 500, function () {
						setTimeout(function () {
							$("#KMIResposne").animate({
								height: 'toggle'
							}, 500);
						}, 3000);
					});
                }
            });

            request.fail(function () {
                alert('An Error Occurred, please refresh and try again.');
            });

        }
    }
});