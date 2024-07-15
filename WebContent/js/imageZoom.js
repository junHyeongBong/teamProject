$(window).scroll(function(){
	var scroll = $(window).scrollTop();
	$(".sec1 img").css({
		width: (100+ scroll/5) + "%"
	});
});