<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri= "http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="contextPath" value = "${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="csrf_token" content="${_csrf.token}">

<!-- jquery -->
<!-- <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script> -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- bootstrap cdn   -->
<!-- <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css"> -->
<!-- <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script> -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>

<!-- google font -->
<link href="https://fonts.googleapis.com/css?family=Cormorant+SC" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Jua&subset=korean" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Bangers|Nanum+Gothic|Nanum+Myeongjo|Parisienne|Permanent+Marker|Poiret+One" rel="stylesheet">

<!-- fontAwesome -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">

<link href="${contextPath }/css/bootstrap-social.css" rel="stylesheet">

<!-- ajax cdn -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

<!-- font awesome -->
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">

<!-- font rotator -->
<script type="text/javascript" src="${contextPath }/js/text-rotator3.js"></script>
<link rel="stylesheet" href="${contextPath }/css/text-rotator3.css">

<!-- 기타 css,js -->
<link rel="stylesheet" href="${contextPath }/css/tripBoardBoolList.css">

<!-- carousel -->
<link rel="stylesheet" href="${contextPath }/css/carousel3.css">
<link rel="stylesheet" href="${contextPath }/css/carousel2.css">

<!-- social -->
<link rel="stylesheet" href="${contextPath }/css/socialbutton.css">

<!-- 헤더부분 -->
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Yeon+Sung&subset=korean" rel="stylesheet">
<script src="${contextPath}/js/header.js"></script>
<link rel="stylesheet" href="${contextPath}/css/header.css">


<script type="text/javascript">
	$(document).ready(function() {
		$(".typewriter-effect").typer({
		startDelay: 3000,
		repeatDelay: 3000,
		backspaceDelay: 3000,
		strings: [
		"여행은 언제나 돈의 문제가 아닌",
		"용기의 문제다.",
		] });
		});
</script>

<script type="text/javascript">
	$(function(){
		$("#popup").animate({opacity:1},2300);
	});
</script>


<title>구경해요!</title>
</head>
<body>
	<%@ include file="header.jsp" %>
	
	<!-- 메인 부분 -->	
	<div class="wrap" id="popup">
		<div class="container-fluid">
		<!-- header부분 -->
			<div class="row">
				<div class="col-sm-12 text-center" id="header1">
					<h1 class="typewriter-effect" style=""></h1>
				</div>
			</div>
		</div>	

		<!-- header부분 끝 -->
		
		<div class="container">
		<!-- main content 시작 -->
			<div class="row">
				<div class="col-sm-8" id="main">
				<!-- main 첫부분 행 시작  -->
					<div class="row">
						<div class="col-sm-12" id="mainContent">
							<!-- 인기 게시물 -->
							<div class="card container-photo">
								<div class="box">
									<div class="imgBox">
										<img class="img-fluid" src="${contextPath }/img/ivy-3519431_1920.jpg">
									</div>
									<div class="card-img-overlay">
										<span class="badge badge-pill badge-danger">Hot</span>
									</div>
									<div class="content">
										<h2>Hey Cheese</h2>
										<p>I'm very awesome!!</p>
										<a class="btn" href="#">Detail View >></a>
									</div>
								</div>
								<div class="card-body">
									<div class="news-title text-center">
										<div class="header">
									<h2>
										<a href="#">제목</a>
									</h2>
									<div class="post-info">
										<span class="post-date"> <i
											class="fa fa-calendar-o pr-1"></i> <span class="day">11</span>
											<span class="month">May 2017</span>
										</span> <span class="submitted"><i
											class="fa fa-user pr-1 pl-1"></i> by <a href="#">John
												Doe</a></span> <span class="comments"><i
											class="fa fa-comments-o pl-1 pr-1"></i> <a href="#">22
												comments</a></span>
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
				<!-- main 첫부분 행 끝  -->
				
				<!-- main 세번째 행 시작 -->
				<div class="row text-center trip_boardList">
				<!-- 게시물 리스트들 들어올곳 -->
				</div>
				
				
				
				<div class="blog-pager container text-center" id="blog-pager">
					<span class="page-of">Page 1 of 6</span>
					<a class="page-num page-active">1</a>
					<a class="page-num" href="#">2</a>
					<a class="page-num" href="#">3</a>
					<span class="page-num page-dots">...</span>
					<a class="page-num" href="#">6</a>
					<a class="page-num page-next" href="#">다음</a>
				</div>	
				
				<div class="light-gray-bg section">
					<div class="container-fluid">
						<div class="sorting-filters text-center mb-20 d-flex justify-content-center">
							<div class="form-inline">
								<div class="form-group">
									<select class="form-control searchOption">
										<option selected="selected" value="title">제목</option>
										<option value="memo">내용</option>
										<option value="titlememo">제목+내용</option>
									</select>
								</div>
							 	<div class="form-group ml-1">
							 		<input type="text" class="form-control" name="searchText">
							 	</div>
							 	<div class="form-group ml-1">
							 		<input type="button" onclick="searchingTripBoard('1')" class="btn btn-default form-control" value="검색">
							 	</div>
							</div>
						</div>
					</div>
				</div>
			</div>
				
				
			<!-- main content 끝 -->	
			<!-- main 부분 끝 -->	
				
			<!-- side 메뉴 시작 -->	
				<aside class="col-sm-4 pr-0" id="sideNav" data-aos="fade-up">
					<div class="col-sm-12" id="sideNav-content">
						<div class="widget">
							<div class="sidebar-wrapper"></div>
							<div clas="stickBar">
								<div class="widget-title">
									<h3 class="title">Option</h3>
								</div>
								<div class="widget-content">
									<select class="form-control" onchange="boardListSort()" id="order_option">
										<option selected="selected" value="latest">최신순</option>
										<option value="view">조회순</option>
										<option value="recommend">인기순</option>
									</select>
								</div>
							</div>
						
						</div>
					</div>
					<div class="col-sm-12" id="sideNav-content2">
						<div class="widget">
							<div class="widget-title">
								<h3 class="title">Social Plugin</h3>
							</div>
							<div class="widget-content">
							<div class="container" id="social">
								<ul>
									<li><a href="#">
									<i class="fa fa-facebook-official" aria-hidden="true"></i></a></li>
									<li><a href="#"><i class="fa fa-twitter" saria-hidden="true"></i></a></li>
									<li><a href="#"><i class="fa fa-google-plus" aria-hidden="true"></i></a></li>
									<li><a href="#"><i class="fa fa-linkedin" aria-hidden="true"></i></a></li>
									<li><a href="#"><i class="fa fa-skype" aria-hidden="true"></i></a></li>
									<li><a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a></li>
									<li><a href="#"><i class="fa fa-youtube" aria-hidden="true"></i></a></li>
									<li><a href="#"><i class="fa fa-pinterest" aria-hidden="true"></i></a></li>
									<div style="clear: both;"></div>
								</ul>
							</div>
							</div>
						</div>
					</div>
					
				<div class="col-sm-12" id="sideNav-content4">
					<div class="widget">
							<div class="sidebar-wrapper"></div>
							<div clas="stickBar">
								<div class="widget-title">
									<h3 class="title">Hot keywords</h3>
								</div>
								<div class="widget-content cloud-label">
									<div class="tag"><a href="#" >평양</a></div>
									<div class="tag"><a href="#" >가자</a></div>
									<div class="tag"><a href="#" >어디로</a></div>
									<div class="tag"><a href="#" >낚시</a></div>
									<div class="tag"><a href="#" >와인</a></div>
									<div class="tag"><a href="#" >패션</a></div>
									<div class="tag"><a href="#" >라면</a></div>
									<div class="tag"><a href="#" >강남역</a></div>
								</div>
							</div>
						</div>
					</div>
					
					
					<div class="col-sm-12" id="sideNav-content3">
						<div class="widget">
							<div class="sidebar-wrapper"></div>
							<div clas="stickBar">
								<div class="widget-title">
									<h3 class="title">Reference Video</h3>
								</div>
								<div class="widget-content">
								<div class="video-sec">
									<div class="video-block">
										<div class="embed-responsive embed-responsive-4by3">
											<iframe width="1260" height="709" src="https://www.youtube.com/embed/jkEmvP6ih48" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
										</div>
									</div>
								</div>
							</div>
							</div>
						
						</div>
					</div>
					
					<div class="col-sm-12" id="sideNav-content5">
						<div class="widget">
							<div class="sidebar-wrapper"></div>
							<div clas="stickBar">
								<div class="widget-title">
									<h3 class="title" style="font-family: 'Nanum Gothic', sans-serif;">금주의 추천게시물 Top3</h3>
								</div>
								<div class="widget-content carousel slide" id="demo" data-ride="carousel">
									<ul class="carousel-indicators">
										<li data-target="#demo" data-slide-to="0" class="active"></li>
										<li data-target="#demo" data-slide-to="1"></li>
										<li data-target="#demo" data-slide-to="2"></li>
									</ul>
									
									<div class="carousel-inner">
										<div class="carousel-item active">
											<img src="${contextPath }/img/bike-986980_1920.jpg">
										</div>
										<div class="carousel-item">
											<img src="${contextPath }/img/hot-air-balloon-401545_1920.jpg">
										</div>
										<div class="carousel-item">
											<img src="${contextPath }/img/maldives-1993704_1920.jpg">
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<div class="col-sm-12" id="sideNav-content6">
						<div class="widget">
							<div class="sidebar-wrapper"></div>
							<div clas="stickBar">
								<div class="widget-title">
									<h3 class="title">Contact Us</h3>
								</div>
								<div class="widget-content">
									<p><i class="fas fa-map-marker-alt"></i>&nbsp; Seoul, Ko</p>
									<p><i class="fas fa-phone"></i>&nbsp;&nbsp;+82 010-7357-7389</p>
									<p><i class="fas fa-envelope"></i>&nbsp;&nbsp;hyeongham@naver.com</p>
								</div>
							</div>
						</div>
					</div>
									 
				</aside>
			</div>
		</div>
	</div>	
</body>
<script type="text/javascript">
	var pageType = "bool";
</script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="${contextPath}/js/tripBoardList.js" charset="UTF-8"></script>
</html>