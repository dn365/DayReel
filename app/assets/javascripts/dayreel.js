(function($){

	$(document).ready(function() {
        var mySlidebars = new $.slidebars({
	            siteClose: true, // true or false
	            hideControlClasses: false // true or false
	        });

        $(document).on('click', '.openOverlayLink', function() {
	            mySlidebars.open('left');
	            $('.overlay').removeClass('hidden');
	        });

        $(document).on('click', '.closeOverlayLink', function() {
	            mySlidebars.close();
	            $('.overlay').addClass('hidden');
	        });

        $(document).on('click', '.overlay', function() {
	        	mySlidebars.close();
	        	$('.overlay').addClass('hidden');
	        });

        $('.sidebar-link').bind('click', function() {
        	$('.overlay').addClass('hidden');
        })

        $('div.sb-slidebar li.sidebar-li').hover(
        	function() {
        		$(this).find('span.sidebar-icon').css('background-position-x', '-25px');
        	},
        	function() {
        		if ( !$(this).find('span.sidebar-icon').hasClass('active') )
        			$(this).find('span.sidebar-icon').css('background-position-x', '0');	
        	});

        $('li.col-custom-portfolio-item').hover(
        	function(){
				$(this).children('span.divider').css('background', '#f5812c');
				$(this).children('span.portfolio-item').css('background-position-y', '-54px');
			},
			function() {
				$(this).children('span.divider').css('background', '#ffffff');	
				$(this).children('span.portfolio-item').css('background-position-y', '0');
			});

		$('div.social-link-block .social-link span.social-icon').hover(
			function() {
				$(this).css('background-position-y', '-30px');
			},
			function() {
				$(this).css('background-position-y', '0');	
			});

		/**
		 *	Enabling Tooltip with background orange color
		 */
		$('[data-toggle="tooltip"]').tooltip();


    });
})(jQuery);
