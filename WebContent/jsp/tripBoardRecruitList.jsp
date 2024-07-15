<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri= "http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
<meta name="csrf_token" content="${_csrf.token}">
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
<link rel="stylesheet" href="${contextPath }/css/tripBoardRecruitList.css">
<%-- <script type="text/javascript" src="${contextPath }/js/infinite.js"></script> --%>

<!-- video tag -->
<link href='http://fonts.googleapis.com/css?family=Buenard:700' rel='stylesheet' type='text/css'>
<script src="http://pupunzi.com/mb.components/mb.YTPlayer/demo/inc/jquery.mb.YTPlayer.js"></script>

<!-- 헤더부분 -->
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Yeon+Sung&subset=korean" rel="stylesheet">
<script src="${contextPath}/js/header.js"></script>
<link rel="stylesheet" href="${contextPath}/css/header.css">

<title>함께가요!</title>
</head>
<body>
	<%@ include file="header.jsp" %>
	<header>
		<section class="content-section video-section">
			<div class="pattern-overlay">
				<a id="bgndVideo" class="player" data-property="{videoURL:'https://youtu.be/3sCGysVB41k', containment: '.video-section', quality:'large', autoPlay:true, mute:true, opacity:1, fadeOnStartTime: 0}"></a>
				<div class="container">
					<div class="row">
						<div class="col-lg-12">
							<h1>여행하지 않은 사람에겐,</h1><br>
							<h3>이 세상은 한 페이지만 읽은 책과 같다.</h3>
						</div>
					</div>
				</div>
			</div>
		</section>
	</header>
	
	<section id="tabs">
		<div class="container">
			<h6 class="section-title h1 neon" data-text="함께 가실래요?">함께 가실래요?</h6>
			<div class="row">
				<div class="col-sm-12">
					<nav>
						<div class="nav nav-tabs nav-fill" id="nav-tab" role="tablist">
							<a class="nav-item nav-link active" onclick="boardListSortRecruit('latest')" id="nav-all-tab" data-toggle="tab" href="" role="tab" aria-controls="nav-all" aria-selected="true">최근순</a>
							<a class="nav-item nav-link" onclick="boardListSortRecruit('recommend')" id="nav-love-tab" data-toggle="tab" href="" role="tab" aria-controls="nav-love" aria-selected="false">추천순</a>
							<a class="nav-item nav-link" onclick="boardListSortRecruit('view')" id="nav-contact-tab" data-toggle="tab" href="" role="tab" aria-controls="nav-contact" aria-selected="false">조회순</a>
						</div>
					</nav>
					
					<div class="tab-content py-3 px-3 px-sm-0 main">
						<div class="tab-pane fade show active all trip_boardList">
						<!-- 게시글 들어오는곳 -->
						</div>
						<div class="blog-pager" id="blog-pager">
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
			</div>
		</div>
	</section>
	
	<div class="searchForm">
		<select class="searchOption">
			<option selected="selected" value="title">제목</option>
			<option value="memo">내용</option>
			<option value="titlememo">제목+내용</option>
		</select>
 		<input type="text" name="searchText">
 		<input type="button" onclick="searchingTripBoard('1')" value="검색">
 	</div>
</body>

<script type="text/javascript">
	var pageType = "recruit";
</script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="${contextPath}/js/tripBoardList.js" charset="UTF-8"></script>
</html>