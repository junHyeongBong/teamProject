$(document).ready(function(){
	$(window).on('scroll', function(){
  		if($(window).scrollTop()){
  			$('nav').addClass('blue');
  		}else{
  			$('nav').removeClass('blue');
  		}
 });
});



/*   	<script type="text/javascript"> */
/*   	$(window).on('scroll', function(){ */
/*   		if($(window).scrollTop()){ */
/*   			$('nav').addClass('blue'); */
/*   		}else{ */
/*   			$('nav').removeClass('blue'); */
/*   		} */
/*   	}); */
/*   </script> */