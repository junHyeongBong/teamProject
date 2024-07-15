<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri= "http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value = "${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
		<link rel="stylesheet" href="${contextPath }/css/map.css">
		<script type="text/javascript" src="${contextPath }/js/scroll.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<script type="text/javascript" src="${contextPath }/js/map.js"></script>
		<script src="https://code.jquery.com/jquery-3.3.1.min.js"
			integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
			crossorigin="anonymous"></script>
		<script type="text/javascript"
				src="https://openapi.map.naver.com/openapi/v3/
				maps.js?clientId=C3g17HQW9Nteyqp72svy&submodules=panorama,geocoder,drawing"></script>
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link href="https://fonts.googleapis.com/css?family=Bangers|Nanum+Gothic|Nanum+Myeongjo|Parisienne|Permanent+Marker|Poiret+One" rel="stylesheet">
		<title>With Us</title>
	</head>
<body>	
		<nav class="navbar navbar-default navbar-fixed-top">
			<div class="container">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="#">TF</a>
				</div>		
					<div class="collapse navbar-collapse" id="myNavbar">
						<ul class="nav navbar-nav navbar-right">
							<li><a href="#">Travel Schedule</a></li>
							<li><a href="#">I'm back</a></li>
							<li><a href="#">With Us</a></li>
							<li><a href="#">Join</a></li>
							<li><a class="active" href="#">Log in</a></li>
						</ul>
				</div>	
			</div>
		</nav>
		
		<div class="jumbotron text-center">
			<h1>Write Your Dream</h1>
		</div>
		
		<div class="container-fluid">
			<div class="row">
				<div class="col-sm-7">
					<div id="daumMap" style="height:700px;width:700px" class=""></div>
				</div>
				<div class="col-sm-5">
	   
				</div>
			</div>
		</div>
</body>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a0dabed2865c6b9cb878feb60563940b"></script>
</html>
