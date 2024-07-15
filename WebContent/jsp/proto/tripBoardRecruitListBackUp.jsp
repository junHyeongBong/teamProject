<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri= "http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value = "${pageContext.request.contextPath}"></c:set>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- bootstrap cdn   -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- google font -->
<link href="https://fonts.googleapis.com/css?family=Cormorant+SC" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Yeon+Sung&subset=korean" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Jua&subset=korean" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Italianno" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Bangers|Nanum+Gothic|Nanum+Myeongjo|Parisienne|Permanent+Marker|Poiret+One" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Nanum+Brush+Script" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Tangerine" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Allura" rel="stylesheet">


<!-- fontAwesome -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">

<!-- ajax cdn -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

<!-- page 적용시킬 css,js -->
<link rel="stylesheet" href="${contextPath }/css/같이가요.css">
<%-- <script type="text/javascript" src="${contextPath }/js/infinite.js"></script> --%>

<!-- video tag -->
<link href='http://fonts.googleapis.com/css?family=Buenard:700' rel='stylesheet' type='text/css'>
<script src="http://pupunzi.com/mb.components/mb.YTPlayer/demo/inc/jquery.mb.YTPlayer.js"></script>

<!-- header -->
<link href="https://fonts.googleapis.com/css?family=Yeon+Sung&subset=korean" rel="stylesheet">
<link rel="stylesheet" href="${contextPath }/css/header.css">

<script type="text/javascript">
$(document).ready(function () {
    $(".player").mb_YTPlayer();
});
</script>

<script type="text/javascript">
	$(function(){
		$('a').on('click',function(){
			$('a').removeClass('page-active');
			$(this).addClass('page-active');
		});
	});
</script>


<title>같이가요</title>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<header>
		<section class="content-section video-section">
			<div class="pattern-overlay">
				<a id="bgndVideo" class="player" data-property="{videoURL:'https://youtu.be/3sCGysVB41k', containment: '.video-section', quality:'large', autoPlay:true, mute:true, opacity:1, fadeOnStartTime: 0}">bg</a>
				<div class="container">
					<div class="row">
						<div class="col-lg-12">
							<h1>The world is a book,</h1><br>
							<h3>and those who do not travel read only one page.</h3>
						</div>
					</div>
				</div>
			</div>
		</section>
	</header>
	
	<section id="tabs">
		<div class="container">
			<h6 class="section-title h1 neon" data-text="Can you join us?">Go Together?</h6>
			<br><br><br><br><br><br><br><br><br><br>
			<div class="row">
				<div class="col-sm-12">
					<nav>
						<div class="nav nav-tabs nav-fill" id="nav-tab" role="tablist">
							<a class="nav-item nav-link active" id="nav-all-tab" data-toggle="tab" href="#nav-all" role="tab" aria-controls="nav-all" aria-selected="true">최근순</a>
							<a class="nav-item nav-link" id="nav-love-tab" data-toggle="tab" href="#nav-love" role="tab" aria-controls="nav-love" aria-selected="false">추천순</a>
							<a class="nav-item nav-link" id="nav-contact-tab" data-toggle="tab" href="#nav-contact" role="tab" aria-controls="nav-contact" aria-selected="false">조회순</a>
						</div>
					</nav>
					
					
					<div class="tab-content py-3 px-3 px-sm-0 main">
						<div class="tab-pane fade show active all" id="nav-all" role="tabpanel" aria-labelledby="nav-all-tab">
							<div class="row text-center">
								<div class="col-sm-4">
									<div class="overlay-container">
										<img src="${contextPath }/img2/oceans-1149899_1920.jpg">
									</div>
									<div class="header">
										<h2>
											<a href="#">제목</a>
										</h2>
										<div class="post-info">
											<span class="post-date">
												<i class="fa fa-calendar-o pr-1"></i><span class="day">11</span>
												<span class="month">May 2018</span>
											</span>
											<span class="sumbmitted"><i class="fa fa-user pr-1 pl-1"></i>by <a href="#">John Doe</a></span>
											<span class="comments"><i class="fa fa-comments-o pl-1 pr-1"></i><a href="#">22 comments</a></span>
										</div>
									</div>
									<div class="blogpost-content">
										<p>
											Mauris dolor sapien, malesuada at interdum ut,
											hendrerit eget lorem. Nunc interdum mi neque, et sollicitudin
											purus fermentum ut. Suspendisse faucibus nibh odio, a
										</p>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="overlay-container">
										<img src="${contextPath }/img2/airport-2373727_1920.jpg">
									</div>
									<div class="header">
										<h2>
											<a href="#">제목</a>
										</h2>
										<div class="post-info">
											<span class="post-date">
												<i class="fa fa-calendar-o pr-1"></i><span class="day">11</span>
												<span class="month">May 2018</span>
											</span>
											<span class="sumbmitted"><i class="fa fa-user pr-1 pl-1"></i>by <a href="#">John Doe</a></span>
											<span class="comments"><i class="fa fa-comments-o pl-1 pr-1"></i><a href="#">22 comments</a></span>
										</div>
									</div>
									<div class="blogpost-content">
										<p>
											Mauris dolor sapien, malesuada at interdum ut,
											hendrerit eget lorem. Nunc interdum mi neque, et sollicitudin
											purus fermentum ut. Suspendisse faucibus nibh odio, a
										</p>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="overlay-container">
										<img src="${contextPath }/img2/rock-1895789_1920.jpg">
									</div>
									<div class="header">
										<h2>
											<a href="#">제목</a>
										</h2>
										<div class="post-info">
											<span class="post-date">
												<i class="fa fa-calendar-o pr-1"></i><span class="day">11</span>
												<span class="month">May 2018</span>
											</span>
											<span class="sumbmitted"><i class="fa fa-user pr-1 pl-1"></i>by <a href="#">John Doe</a></span>
											<span class="comments"><i class="fa fa-comments-o pl-1 pr-1"></i><a href="#">22 comments</a></span>
										</div>
									</div>
									<div class="blogpost-content">
										<p>
											Mauris dolor sapien, malesuada at interdum ut,
											hendrerit eget lorem. Nunc interdum mi neque, et sollicitudin
											purus fermentum ut. Suspendisse faucibus nibh odio, a
										</p>
									</div>
								</div>
							</div>
							
							<div class="row text-center row2">
								<div class="col-sm-4">
									<div class="overlay-container">
										<img src="${contextPath }/img2/water-3304118_1920.jpg">
									</div>
									<div class="header">
										<h2>
											<a href="#">제목</a>
										</h2>
										<div class="post-info">
											<span class="post-date">
												<i class="fa fa-calendar-o pr-1"></i><span class="day">11</span>
												<span class="month">May 2018</span>
											</span>
											<span class="sumbmitted"><i class="fa fa-user pr-1 pl-1"></i>by <a href="#">John Doe</a></span>
											<span class="comments"><i class="fa fa-comments-o pl-1 pr-1"></i><a href="#">22 comments</a></span>
										</div>
									</div>
									<div class="blogpost-content">
										<p>
											Mauris dolor sapien, malesuada at interdum ut,
											hendrerit eget lorem. Nunc interdum mi neque, et sollicitudin
											purus fermentum ut. Suspendisse faucibus nibh odio, a
										</p>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="overlay-container">
										<img src="${contextPath }/img2/japan-2014618_1920.jpg">
									</div>
									<div class="header">
										<h2>
											<a href="#">제목</a>
										</h2>
										<div class="post-info">
											<span class="post-date">
												<i class="fa fa-calendar-o pr-1"></i><span class="day">11</span>
												<span class="month">May 2018</span>
											</span>
											<span class="sumbmitted"><i class="fa fa-user pr-1 pl-1"></i>by <a href="#">John Doe</a></span>
											<span class="comments"><i class="fa fa-comments-o pl-1 pr-1"></i><a href="#">22 comments</a></span>
										</div>
									</div>
									<div class="blogpost-content">
										<p>
											Mauris dolor sapien, malesuada at interdum ut,
											hendrerit eget lorem. Nunc interdum mi neque, et sollicitudin
											purus fermentum ut. Suspendisse faucibus nibh odio, a
										</p>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="overlay-container">
										<img src="${contextPath }/img2/fence-996620_1920.jpg">
									</div>
									<div class="header">
										<h2>
											<a href="#">제목</a>
										</h2>
										<div class="post-info">
											<span class="post-date">
												<i class="fa fa-calendar-o pr-1"></i><span class="day">11</span>
												<span class="month">May 2018</span>
											</span>
											<span class="sumbmitted"><i class="fa fa-user pr-1 pl-1"></i>by <a href="#">John Doe</a></span>
											<span class="comments"><i class="fa fa-comments-o pl-1 pr-1"></i><a href="#">22 comments</a></span>
										</div>
									</div>
									<div class="blogpost-content">
										<p>
											Mauris dolor sapien, malesuada at interdum ut,
											hendrerit eget lorem. Nunc interdum mi neque, et sollicitudin
											purus fermentum ut. Suspendisse faucibus nibh odio, a
										</p>
									</div>
								</div>
							</div>
							
							<div class="row text-center row3">
								<div class="col-sm-4">
									<div class="overlay-container">
										<img src="${contextPath }/img2/forest-1835019_1920.jpg">
									</div>
									<div class="header">
										<h2>
											<a href="#">제목</a>
										</h2>
										<div class="post-info">
											<span class="post-date">
												<i class="fa fa-calendar-o pr-1"></i><span class="day">11</span>
												<span class="month">May 2018</span>
											</span>
											<span class="sumbmitted"><i class="fa fa-user pr-1 pl-1"></i>by <a href="#">John Doe</a></span>
											<span class="comments"><i class="fa fa-comments-o pl-1 pr-1"></i><a href="#">22 comments</a></span>
										</div>
									</div>
									<div class="blogpost-content">
										<p>
											Mauris dolor sapien, malesuada at interdum ut,
											hendrerit eget lorem. Nunc interdum mi neque, et sollicitudin
											purus fermentum ut. Suspendisse faucibus nibh odio, a
										</p>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="overlay-container">
										<img src="${contextPath }/img2/asphalt-1867667_1920.jpg">
									</div>
									<div class="header">
										<h2>
											<a href="#">제목</a>
										</h2>
										<div class="post-info">
											<span class="post-date">
												<i class="fa fa-calendar-o pr-1"></i><span class="day">11</span>
												<span class="month">May 2018</span>
											</span>
											<span class="sumbmitted"><i class="fa fa-user pr-1 pl-1"></i>by <a href="#">John Doe</a></span>
											<span class="comments"><i class="fa fa-comments-o pl-1 pr-1"></i><a href="#">22 comments</a></span>
										</div>
									</div>
									<div class="blogpost-content">
										<p>
											Mauris dolor sapien, malesuada at interdum ut,
											hendrerit eget lorem. Nunc interdum mi neque, et sollicitudin
											purus fermentum ut. Suspendisse faucibus nibh odio, a
										</p>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="overlay-container">
										<img src="${contextPath }/img2/van-1209169_1920.jpg">
									</div>
									<div class="header">
										<h2>
											<a href="#">제목</a>
										</h2>
										<div class="post-info">
											<span class="post-date">
												<i class="fa fa-calendar-o pr-1"></i><span class="day">11</span>
												<span class="month">May 2018</span>
											</span>
											<span class="sumbmitted"><i class="fa fa-user pr-1 pl-1"></i>by <a href="#">John Doe</a></span>
											<span class="comments"><i class="fa fa-comments-o pl-1 pr-1"></i><a href="#">22 comments</a></span>
										</div>
									</div>
									<div class="blogpost-content">
										<p>
											Mauris dolor sapien, malesuada at interdum ut,
											hendrerit eget lorem. Nunc interdum mi neque, et sollicitudin
											purus fermentum ut. Suspendisse faucibus nibh odio, a
										</p>
									</div>
								</div>
							</div>

							<div class="col-sm-12 text-center">
								<div class="blog-pager" id="">
									<span class="page-of">Page 1 of 5</span> 
									<a class="page-num page-active">1</a>
									<a class="page-num" href="#">2</a>
									<a class="page-num" href="#">3</a> 
									<span class="page-num page-dots">...</span>
									<a class="page-num" href="#">5</a> 
									<a class="page-num page-next" href="#">다음</a>
								</div>
							</div>

						</div>
						
						
						<div class="tab-pane fade recent" id="nav-recent" role="tabpanel" aria-labelledby="nav-recent-tab">
							<div class="row text-center">
								<div class="col-sm-4">
									<div class="overlay-container">
										<img src="${contextPath }/img2/oceans-1149899_1920.jpg">
									</div>
									<div class="header">
										<h2>
											<a href="#">제목</a>
										</h2>
										<div class="post-info">
											<span class="post-date">
												<i class="fa fa-calendar-o pr-1"></i><span class="day">11</span>
												<span class="month">May 2018</span>
											</span>
											<span class="sumbmitted"><i class="fa fa-user pr-1 pl-1"></i>by <a href="#">John Doe</a></span>
											<span class="comments"><i class="fa fa-comments-o pl-1 pr-1"></i><a href="#">22 comments</a></span>
										</div>
									</div>
									<div class="blogpost-content">
										<p>
											Mauris dolor sapien, malesuada at interdum ut,
											hendrerit eget lorem. Nunc interdum mi neque, et sollicitudin
											purus fermentum ut. Suspendisse faucibus nibh odio, a
										</p>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="overlay-container">
										<img src="${contextPath }/img2/airport-2373727_1920.jpg">
									</div>
									<div class="header">
										<h2>
											<a href="#">제목</a>
										</h2>
										<div class="post-info">
											<span class="post-date">
												<i class="fa fa-calendar-o pr-1"></i><span class="day">11</span>
												<span class="month">May 2018</span>
											</span>
											<span class="sumbmitted"><i class="fa fa-user pr-1 pl-1"></i>by <a href="#">John Doe</a></span>
											<span class="comments"><i class="fa fa-comments-o pl-1 pr-1"></i><a href="#">22 comments</a></span>
										</div>
									</div>
									<div class="blogpost-content">
										<p>
											Mauris dolor sapien, malesuada at interdum ut,
											hendrerit eget lorem. Nunc interdum mi neque, et sollicitudin
											purus fermentum ut. Suspendisse faucibus nibh odio, a
										</p>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="overlay-container">
										<img src="${contextPath }/img2/rock-1895789_1920.jpg">
									</div>
									<div class="header">
										<h2>
											<a href="#">제목</a>
										</h2>
										<div class="post-info">
											<span class="post-date">
												<i class="fa fa-calendar-o pr-1"></i><span class="day">11</span>
												<span class="month">May 2018</span>
											</span>
											<span class="sumbmitted"><i class="fa fa-user pr-1 pl-1"></i>by <a href="#">John Doe</a></span>
											<span class="comments"><i class="fa fa-comments-o pl-1 pr-1"></i><a href="#">22 comments</a></span>
										</div>
									</div>
									<div class="blogpost-content">
										<p>
											Mauris dolor sapien, malesuada at interdum ut,
											hendrerit eget lorem. Nunc interdum mi neque, et sollicitudin
											purus fermentum ut. Suspendisse faucibus nibh odio, a
										</p>
									</div>
								</div>
							</div>
							
							<div class="row text-center row2">
								<div class="col-sm-4">
									<div class="overlay-container">
										<img src="${contextPath }/img2/water-3304118_1920.jpg">
									</div>
									<div class="header">
										<h2>
											<a href="#">제목</a>
										</h2>
										<div class="post-info">
											<span class="post-date">
												<i class="fa fa-calendar-o pr-1"></i><span class="day">11</span>
												<span class="month">May 2018</span>
											</span>
											<span class="sumbmitted"><i class="fa fa-user pr-1 pl-1"></i>by <a href="#">John Doe</a></span>
											<span class="comments"><i class="fa fa-comments-o pl-1 pr-1"></i><a href="#">22 comments</a></span>
										</div>
									</div>
									<div class="blogpost-content">
										<p>
											Mauris dolor sapien, malesuada at interdum ut,
											hendrerit eget lorem. Nunc interdum mi neque, et sollicitudin
											purus fermentum ut. Suspendisse faucibus nibh odio, a
										</p>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="overlay-container">
										<img src="${contextPath }/img2/japan-2014618_1920.jpg">
									</div>
									<div class="header">
										<h2>
											<a href="#">제목</a>
										</h2>
										<div class="post-info">
											<span class="post-date">
												<i class="fa fa-calendar-o pr-1"></i><span class="day">11</span>
												<span class="month">May 2018</span>
											</span>
											<span class="sumbmitted"><i class="fa fa-user pr-1 pl-1"></i>by <a href="#">John Doe</a></span>
											<span class="comments"><i class="fa fa-comments-o pl-1 pr-1"></i><a href="#">22 comments</a></span>
										</div>
									</div>
									<div class="blogpost-content">
										<p>
											Mauris dolor sapien, malesuada at interdum ut,
											hendrerit eget lorem. Nunc interdum mi neque, et sollicitudin
											purus fermentum ut. Suspendisse faucibus nibh odio, a
										</p>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="overlay-container">
										<img src="${contextPath }/img2/fence-996620_1920.jpg">
									</div>
									<div class="header">
										<h2>
											<a href="#">제목</a>
										</h2>
										<div class="post-info">
											<span class="post-date">
												<i class="fa fa-calendar-o pr-1"></i><span class="day">11</span>
												<span class="month">May 2018</span>
											</span>
											<span class="sumbmitted"><i class="fa fa-user pr-1 pl-1"></i>by <a href="#">John Doe</a></span>
											<span class="comments"><i class="fa fa-comments-o pl-1 pr-1"></i><a href="#">22 comments</a></span>
										</div>
									</div>
									<div class="blogpost-content">
										<p>
											Mauris dolor sapien, malesuada at interdum ut,
											hendrerit eget lorem. Nunc interdum mi neque, et sollicitudin
											purus fermentum ut. Suspendisse faucibus nibh odio, a
										</p>
									</div>
								</div>
							</div>
						
						</div>
						<div class="tab-pane fade love" id="nav-love" role="tabpanel" aria-labelledby="nav-love-tab">
							<div class="row text-center row2">
								<div class="col-sm-4">
									<div class="overlay-container">
										<img src="${contextPath }/img2/water-3304118_1920.jpg">
									</div>
									<div class="header">
										<h2>
											<a href="#">제목</a>
										</h2>
										<div class="post-info">
											<span class="post-date">
												<i class="fa fa-calendar-o pr-1"></i><span class="day">11</span>
												<span class="month">May 2018</span>
											</span>
											<span class="sumbmitted"><i class="fa fa-user pr-1 pl-1"></i>by <a href="#">John Doe</a></span>
											<span class="comments"><i class="fa fa-comments-o pl-1 pr-1"></i><a href="#">22 comments</a></span>
										</div>
									</div>
									<div class="blogpost-content">
										<p>
											Mauris dolor sapien, malesuada at interdum ut,
											hendrerit eget lorem. Nunc interdum mi neque, et sollicitudin
											purus fermentum ut. Suspendisse faucibus nibh odio, a
										</p>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="overlay-container">
										<img src="${contextPath }/img2/japan-2014618_1920.jpg">
									</div>
									<div class="header">
										<h2>
											<a href="#">제목</a>
										</h2>
										<div class="post-info">
											<span class="post-date">
												<i class="fa fa-calendar-o pr-1"></i><span class="day">11</span>
												<span class="month">May 2018</span>
											</span>
											<span class="sumbmitted"><i class="fa fa-user pr-1 pl-1"></i>by <a href="#">John Doe</a></span>
											<span class="comments"><i class="fa fa-comments-o pl-1 pr-1"></i><a href="#">22 comments</a></span>
										</div>
									</div>
									<div class="blogpost-content">
										<p>
											Mauris dolor sapien, malesuada at interdum ut,
											hendrerit eget lorem. Nunc interdum mi neque, et sollicitudin
											purus fermentum ut. Suspendisse faucibus nibh odio, a
										</p>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="overlay-container">
										<img src="${contextPath }/img2/fence-996620_1920.jpg">
									</div>
									<div class="header">
										<h2>
											<a href="#">제목</a>
										</h2>
										<div class="post-info">
											<span class="post-date">
												<i class="fa fa-calendar-o pr-1"></i><span class="day">11</span>
												<span class="month">May 2018</span>
											</span>
											<span class="sumbmitted"><i class="fa fa-user pr-1 pl-1"></i>by <a href="#">John Doe</a></span>
											<span class="comments"><i class="fa fa-comments-o pl-1 pr-1"></i><a href="#">22 comments</a></span>
										</div>
									</div>
									<div class="blogpost-content">
										<p>
											Mauris dolor sapien, malesuada at interdum ut,
											hendrerit eget lorem. Nunc interdum mi neque, et sollicitudin
											purus fermentum ut. Suspendisse faucibus nibh odio, a
										</p>
									</div>
								</div>
							</div>
							<div class="row text-center row4">
								<div class="col-sm-4">
									<div class="overlay-container">
										<img src="${contextPath }/img2/maldives-2468188_1920.jpg">
									</div>
									<div class="header">
										<h2>
											<a href="#">제목</a>
										</h2>
										<div class="post-info">
											<span class="post-date">
												<i class="fa fa-calendar-o pr-1"></i><span class="day">11</span>
												<span class="month">May 2018</span>
											</span>
											<span class="sumbmitted"><i class="fa fa-user pr-1 pl-1"></i>by <a href="#">John Doe</a></span>
											<span class="comments"><i class="fa fa-comments-o pl-1 pr-1"></i><a href="#">22 comments</a></span>
										</div>
									</div>
									<div class="blogpost-content">
										<p>
											Mauris dolor sapien, malesuada at interdum ut,
											hendrerit eget lorem. Nunc interdum mi neque, et sollicitudin
											purus fermentum ut. Suspendisse faucibus nibh odio, a
										</p>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="overlay-container">
										<img src="${contextPath }/img2/waters-3161063_1920.jpg">
									</div>
									<div class="header">
										<h2>
											<a href="#">제목</a>
										</h2>
										<div class="post-info">
											<span class="post-date">
												<i class="fa fa-calendar-o pr-1"></i><span class="day">11</span>
												<span class="month">May 2018</span>
											</span>
											<span class="sumbmitted"><i class="fa fa-user pr-1 pl-1"></i>by <a href="#">John Doe</a></span>
											<span class="comments"><i class="fa fa-comments-o pl-1 pr-1"></i><a href="#">22 comments</a></span>
										</div>
									</div>
									<div class="blogpost-content">
										<p>
											Mauris dolor sapien, malesuada at interdum ut,
											hendrerit eget lorem. Nunc interdum mi neque, et sollicitudin
											purus fermentum ut. Suspendisse faucibus nibh odio, a
										</p>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="overlay-container">
										<img src="${contextPath }/img2/hot-air-balloon-1149183_1920.jpg">
									</div>
									<div class="header">
										<h2>
											<a href="#">제목</a>
										</h2>
										<div class="post-info">
											<span class="post-date">
												<i class="fa fa-calendar-o pr-1"></i><span class="day">11</span>
												<span class="month">May 2018</span>
											</span>
											<span class="sumbmitted"><i class="fa fa-user pr-1 pl-1"></i>by <a href="#">John Doe</a></span>
											<span class="comments"><i class="fa fa-comments-o pl-1 pr-1"></i><a href="#">22 comments</a></span>
										</div>
									</div>
									<div class="blogpost-content">
										<p>
											Mauris dolor sapien, malesuada at interdum ut,
											hendrerit eget lorem. Nunc interdum mi neque, et sollicitudin
											purus fermentum ut. Suspendisse faucibus nibh odio, a
										</p>
									</div>
								</div>
							</div>
						</div>
						
						<div class="tab-pane fade contact" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab">
							<div class="row text-center row4">
								<div class="col-sm-4">
									<div class="overlay-container">
										<img src="${contextPath }/img2/maldives-2468188_1920.jpg">
									</div>
									<div class="header">
										<h2>
											<a href="#">제목</a>
										</h2>
										<div class="post-info">
											<span class="post-date">
												<i class="fa fa-calendar-o pr-1"></i><span class="day">11</span>
												<span class="month">May 2018</span>
											</span>
											<span class="sumbmitted"><i class="fa fa-user pr-1 pl-1"></i>by <a href="#">John Doe</a></span>
											<span class="comments"><i class="fa fa-comments-o pl-1 pr-1"></i><a href="#">22 comments</a></span>
										</div>
									</div>
									<div class="blogpost-content">
										<p>
											Mauris dolor sapien, malesuada at interdum ut,
											hendrerit eget lorem. Nunc interdum mi neque, et sollicitudin
											purus fermentum ut. Suspendisse faucibus nibh odio, a
										</p>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="overlay-container">
										<img src="${contextPath }/img2/waters-3161063_1920.jpg">
									</div>
									<div class="header">
										<h2>
											<a href="#">제목</a>
										</h2>
										<div class="post-info">
											<span class="post-date">
												<i class="fa fa-calendar-o pr-1"></i><span class="day">11</span>
												<span class="month">May 2018</span>
											</span>
											<span class="sumbmitted"><i class="fa fa-user pr-1 pl-1"></i>by <a href="#">John Doe</a></span>
											<span class="comments"><i class="fa fa-comments-o pl-1 pr-1"></i><a href="#">22 comments</a></span>
										</div>
									</div>
									<div class="blogpost-content">
										<p>
											Mauris dolor sapien, malesuada at interdum ut,
											hendrerit eget lorem. Nunc interdum mi neque, et sollicitudin
											purus fermentum ut. Suspendisse faucibus nibh odio, a
										</p>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="overlay-container">
										<img src="${contextPath }/img2/hot-air-balloon-1149183_1920.jpg">
									</div>
									<div class="header">
										<h2>
											<a href="#">제목</a>
										</h2>
										<div class="post-info">
											<span class="post-date">
												<i class="fa fa-calendar-o pr-1"></i><span class="day">11</span>
												<span class="month">May 2018</span>
											</span>
											<span class="sumbmitted"><i class="fa fa-user pr-1 pl-1"></i>by <a href="#">John Doe</a></span>
											<span class="comments"><i class="fa fa-comments-o pl-1 pr-1"></i><a href="#">22 comments</a></span>
										</div>
									</div>
									<div class="blogpost-content">
										<p>
											Mauris dolor sapien, malesuada at interdum ut,
											hendrerit eget lorem. Nunc interdum mi neque, et sollicitudin
											purus fermentum ut. Suspendisse faucibus nibh odio, a
										</p>
									</div>
								</div>
							</div>
							<div class="row text-center row4">
								<div class="col-sm-4">
									<div class="overlay-container">
										<img src="${contextPath }/img2/maldives-2468188_1920.jpg">
									</div>
									<div class="header">
										<h2>
											<a href="#">제목</a>
										</h2>
										<div class="post-info">
											<span class="post-date">
												<i class="fa fa-calendar-o pr-1"></i><span class="day">11</span>
												<span class="month">May 2018</span>
											</span>
											<span class="sumbmitted"><i class="fa fa-user pr-1 pl-1"></i>by <a href="#">John Doe</a></span>
											<span class="comments"><i class="fa fa-comments-o pl-1 pr-1"></i><a href="#">22 comments</a></span>
										</div>
									</div>
									<div class="blogpost-content">
										<p>
											Mauris dolor sapien, malesuada at interdum ut,
											hendrerit eget lorem. Nunc interdum mi neque, et sollicitudin
											purus fermentum ut. Suspendisse faucibus nibh odio, a
										</p>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="overlay-container">
										<img src="${contextPath }/img2/waters-3161063_1920.jpg">
									</div>
									<div class="header">
										<h2>
											<a href="#">제목</a>
										</h2>
										<div class="post-info">
											<span class="post-date">
												<i class="fa fa-calendar-o pr-1"></i><span class="day">11</span>
												<span class="month">May 2018</span>
											</span>
											<span class="sumbmitted"><i class="fa fa-user pr-1 pl-1"></i>by <a href="#">John Doe</a></span>
											<span class="comments"><i class="fa fa-comments-o pl-1 pr-1"></i><a href="#">22 comments</a></span>
										</div>
									</div>
									<div class="blogpost-content">
										<p>
											Mauris dolor sapien, malesuada at interdum ut,
											hendrerit eget lorem. Nunc interdum mi neque, et sollicitudin
											purus fermentum ut. Suspendisse faucibus nibh odio, a
										</p>
									</div>
								</div>
								<div class="col-sm-4">
									<div class="overlay-container">
										<img src="${contextPath }/img2/hot-air-balloon-1149183_1920.jpg">
									</div>
									<div class="header">
										<h2>
											<a href="#">제목</a>
										</h2>
										<div class="post-info">
											<span class="post-date">
												<i class="fa fa-calendar-o pr-1"></i><span class="day">11</span>
												<span class="month">May 2018</span>
											</span>
											<span class="sumbmitted"><i class="fa fa-user pr-1 pl-1"></i>by <a href="#">John Doe</a></span>
											<span class="comments"><i class="fa fa-comments-o pl-1 pr-1"></i><a href="#">22 comments</a></span>
										</div>
									</div>
									<div class="blogpost-content">
										<p>
											Mauris dolor sapien, malesuada at interdum ut,
											hendrerit eget lorem. Nunc interdum mi neque, et sollicitudin
											purus fermentum ut. Suspendisse faucibus nibh odio, a
										</p>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
					
				
			</div>
		</div>
	</section>
</body>
</html>