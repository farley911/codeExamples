$(function(){
	// Pricing page navigation
	$('.pricingBtn').click(function(){
		if (!$(this).hasClass('active')){
			// Switch active button
			$('.pricingBtn.active').removeClass('active');
			$('a[data-id=' + $(this).attr('data-id') + ']').addClass('active');
			
			//update speedo content
			var title, subTitle, contHTML, color, priceHTML, rotation;
			switch ($(this).attr('data-id')){
				case 'sf':
					title = "STANDARD FEATURES";
					subTitle = "Your attendees are evolving.<br />" +
								"Your event technology should be, too.";
					contHTML = [
									"EVENT MANAGER", 
									"Full Administrative Control – No more support tickets!<br />" +
										"Real Time Session Evaluations<br />" +
										"In-App Custom Pages",
									"TRACK MANAGERS & SPEAKERS",
									"Track Management Dashboard<br />" +
										"Speaker Dashboard (Session Detail Control,<br />" +
										"Document Workflow, Equipment Requests)",
									"ATTENDEES",
									"Attendee Calendar Building, Mobile Updates & Community+<br />" +
										"Networking (Includes Social Network Integration)<br />" +
										"Expo Hall Floor Plan+ & Exhibitor Info"
								];
						color = "65ffff";
						priceHTML = ['$10 per person', '$9 per person', '$6 per person', '$5 per person', 'QUOTE'];
						rotation = -60;
					break;
				case 'cfp':
					title = "CALL FOR PAPERS"
					subTitle = "Content Management made brand new.<br />" +
							   "We like to call it &qout;easy.&qout;";
					contHTML = [
									"SET UP",
									"Open a private or public Call for Papers to kick off your event planning",
									"Create call for content dashboard for track owners with custom branded information",
									"SESSION MANAGEMENT",
									"Set upload functions to collect files such as picture or whitepaper examples<br /><br />" +
										"Convert approved topics into official sessions with a single click"
								];
						color = 'd2ff27';
						priceHTML = ['$1,500', '$1,000', '$750', '$500', 'INCLUDED'];
						rotation = 0;
					break;
				case 'se':	
					title = "SPONSOR & EXPO";
					subTitle = "Bring your sponsors into the 21st century.<br />" +
								"They’ll thank you later.";
					contHTML = [
									"WORKFLOW",
									"Efficient workflow management for logo approval and downloadable resources by event managers",
									"PERSONALIZE",
									"Exhibitors control company profile including logos, social media, and downloadable resources",
									"EASY ACCESS",
									"Sponsor/Expo dashboard keeps all information centrally located<br /><br />" +
										"Attendees can search, sort, and filter by custom fields"
								];
						color = 'ff213f';
						priceHTML = ['$1 per person', '$1 per person', '$1 per person', '$1 per person', 'INCLUDED'];
						rotation = 60;
					break;
			}
			$('#speedoWrapper article span#title').html(title);
			$('#speedoWrapper article span#subTitle').html(subTitle);
			$.each(contHTML, function(i){
				$('#contWrapper article span').eq(i).html(contHTML[i]);				
			});
			$('#pricingTop').css('background', '#' + color);
			$.each(priceHTML, function(i){
				$('#pricingGrey div p#box' + (i+1)).html(priceHTML[i]);
			});
			$("#needle").rotate({animateTo:rotation});
		}
	});
	// Select first pricing option on page load
	$("#needle").rotate(-60);
	$('.pricingBtn').first().click();
});