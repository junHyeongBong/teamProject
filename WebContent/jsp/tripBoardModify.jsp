<%@page import="java.util.List"%>
<%@page import="model.Daily_Trip"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri= "http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value = "${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">

<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script> 
  
<!-- bootstrap cdn -->  
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- Map API -->
<script type="text/javascript"
		src="https://openapi.map.naver.com/openapi/v3/
		maps.js?clientId=C3g17HQW9Nteyqp72svy&submodules=panorama,geocoder,drawing">
		</script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a0dabed2865c6b9cb878feb60563940b&libraries=services,clusterer,drawing"></script>

<!-- fontaweasome cdn -->
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">

<!-- css,js -->
<link rel="stylesheet" href="${contextPath }/css/mapView.css">
<script type="text/javascript" src="${contextPath }/js/map.js"></script>

<!-- carousel -->
<link rel="stylesheet" href="${contextPath }/css/carousel3.css">
<link rel="stylesheet" href="${contextPath }/css/carousel2.css">

<!-- google font -->
<link href="https://fonts.googleapis.com/css?family=Bangers|Nanum+Gothic|Nanum+Myeongjo|Parisienne|Permanent+Marker|Poiret+One" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Jua&subset=korean" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Yeon+Sung&subset=korean" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Cormorant+SC" rel="stylesheet">

<!-- comment -->
<script src='//production-assets.codepen.io/assets/editor/live/console_runner-079c09a0e3b9ff743e39ee2d5637b9216b3545af0de366d4b9aad9dc87e26bfd.js'></script>
<!-- <script src='//production-assets.codepen.io/assets/editor/live/events_runner-73716630c22bbc8cff4bd0f07b135f00a0bdc5d14629260c3ec49e5606f98fdd.js'></script> -->
<script src='//production-assets.codepen.io/assets/editor/live/css_live_reload_init-2c0dc5167d60a5af3ee189d570b1835129687ea2a61bee3513dee3a50c115a77.js'></script>
<!-- <meta charset='UTF-8'><meta name="robots" content="noindex"> -->
<link rel="shortcut icon" type="image/x-icon" href="//production-assets.codepen.io/assets/favicon/favicon-8ea04875e70c4b0bb41da869e81236e54394d63638a1ef12fa558a4a835f1164.ico" />
<link rel="mask-icon" type="" href="//production-assets.codepen.io/assets/favicon/logo-pin-f2d2b6d2c61838f7e76325261b7195c27224080bc099486ddd6dccb469b8e8e6.svg" color="#111" />
<link rel="canonical" href="https://codepen.io/kavendish/pen/aOdopx?q=comment&limit=all&type=type-pens" />
<link rel='stylesheet prefetch' href='${contextPath }/css/comment2.css'>
<link rel="stylesheet" href="${contextPath }/css/comment.css">




<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- 전역으로 사용해야될 내용들 -->


<title>With Us</title>
</head>

<body id="myPage" data-spy="scroll" data-target=".navbar" data-offset="60">	

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
		
		<div class="jumbotron text-center bg-1">
			<h1>View Your Dream</h1>
		</div>
		
	<div>
      <div class="container-fluid">
      	<div class="table-responsive">
      		<table class="table table-hover">
      			<thead>
      				<tr>
<!--       					<th class="text-center"><a href="#" class="btn btn-info btn-lg"><span class="glyphicon glyphicon-calendar"></span>Schedule View</a></th> -->
      					<th class="text-center"><p class="text-primary">Number</p></th>
      					<th class="text-center"><p class="text-primary">Title</p></th>
      					<th class="text-center"><p class="text-primary">Start Location</p></th>
      					<th class="text-center"><p class="text-primary">Destination</p></th>
      					<th class="text-center"><p class="text-primary">Start Date</p></th>
      					<th class="text-center"><p class="text-primary">End Date</p></th>
      					<th class="text-center"><p class="text-primary">Personnel</p></th>
      					<th class="text-center"><p class="text-primary">Party Mode</p></th>
      					<th class="text-center"><p class="text-primary">Writer</p></th>
      				</tr>
      			</thead>
      			<tbody>
      				<tr>
      					<td><p class="text-info text-center">${trip_board.trip_board_num}</p></td>
      					<td><p class="text-info text-center">${trip_board.trip_board_title}</p></td>
      					<td><p class="text-info text-center">${startLocation}</p></td>
      					<td><p class="text-info text-center">${destination}</p></td>
      					<td><p class="text-info text-center">${trip_board.trip_board_startdate}</p></td>
      					<td><p class="text-info text-center">${trip_board.trip_board_enddate}</p></td>
      					<td><p class="text-info text-center">${personnel}</p></td>
      					<td><p class="text-info text-center">${trip_board.trip_board_recruit}</p></td>
      					<td><p class="text-info text-center">${trip_board.member_nick}(${trip_board.member_id})</p></td>
      				</tr>
      			</tbody>
      		</table>
      	</div>
    </div>
 </div>
		
		
		
		<!-- container -->
		<div class="container-fluid one">
			<div class="row">
				<div class="col-sm-2">
					<div class="searchClass">
<!-- 						<input type="text" placeholder="주소를 입력하세요" class="btn btn-default form-control"> -->
<!-- 						<input type="button" class="btn btn-success pull-right" value="검색"> -->
<!-- 					<br><br> -->
						<ul id="search" class="text-center">
<!-- 							<li> -->
<!-- 								<div class="btn btn-default" onclick='selectTansportType(0)' id="car"  checked> -->
<%-- 									<img src="${contextPath }/img/sports-car.png" width="15px" height="15px">자동차 --%>
<!-- 								</div> -->
<!-- 							</li> -->
<!-- 							<li> -->
<!-- 								<div class="btn btn-default" onclick='selectTansportType(1)' id="public transport" > -->
<%-- 									<img src="${contextPath }/img/subway.png" width="15px" height="15px">대중교통 --%>
<!-- 								</div> -->
<!-- 							</li> -->
<!-- 							<li> -->
<!-- 								<div class="btn btn-default" onclick='selectTansportType(2)' id="bicycle" > -->
<%-- 									<img src="${contextPath }/img/bicycle.png" width="15px" height="15px">자전거 --%>
<!-- 								</div> -->
<!-- 							</li> -->
<!-- 							<li> -->
<!-- 								<div class="btn btn-default" onclick='selectTansportType(3)' id="walk"  style="padding: 6px 12px 6px 12px;"> -->
<%-- 									<img src="${contextPath }/img/running (1).png" width="15px" height="15px">도보 --%>
<!-- 								</div> -->
<!-- 							</li> -->
<!-- 						</ul> -->
					</div>	
					<div id="routesNav"></div>
				</div>
				<div class="col-sm-7">
					<div id="map" style="height:800px;width:800px" class=""></div><br><br>
				</div>
				<!-- 가볼만한곳 시작 -->
				<div class="col-sm-3">
	   				<div class="panel panel-default text-center">
	   					<div class="panel-heading">
	   						<h2>#Favorite</h2>
<!-- 	   							<span class="glyphicon glyphicon-exclamation-sign"></span> -->
<%-- 	   							<img src="${contextPath }/img/information-in-circular-button.png" width="25px" height="25px"> --%>
	   							<div class="btn-group" data-toggle="buttons">
	   								<label class="btn btn-primary active" onclick="placeoption('all')">
	   									<input type="radio" name="placeoptions" checked>전체
	   								</label>
	   								<label class="btn btn-primary" onclick="placeoption('leisuresports')">
	   									<input type="radio" name="placeoptions">레포츠
	   								</label>
	   								<label class="btn btn-primary" onclick="placeoption('camp')">
	   									<input type="radio" name="placeoptions">캠핑
	   								</label>
	   								<label class="btn btn-primary" onclick="placeoption('eating')">
	   									<input type="radio" name="placeoptions">먹거리
	   								</label>
	   								<label class="btn btn-primary" onclick="placeoption('healing')">
	   									<input type="radio" name="placeoptions">힐링
	   								</label>
	   								<label class="btn btn-primary" onclick="placeoption('culture')">
	   									<input type="radio" name="placeoptions">문화
	   								</label>
	   								<label class="btn btn-primary" onclick="placeoption('mountain')">
	   									<input type="radio" name="placeoptions">산
	   								</label>
	   								<label class="btn btn-primary" onclick="placeoption('religion')">
	   									<input type="radio" name="placeoptions">종교
	   								</label>
	   							</div>
	   					</div>
	   					<div class="panel-place-body" style="overflow:scroll;overflow-x:hidden;">
	   						<!-- 추천명소들어올곳 -->
	   					</div>
	   					<div class="panel-footer">
	   						<button class="btn btn-info" data-toggle="modal" data-target="#myModal">더 알아보기</button>
	   					</div>
	   				</div>
				</div>
				<!-- 가볼만한곳 끝 -->
				<!-- rest시작 -->
				<div class="col-sm-3">
	   				<div class="panel panel-default text-center">
	   					<div class="panel-heading">
	   							<h2>#Rest</h2>
<!-- 	   							<span class="glyphicon glyphicon-exclamation-sign"></span> -->
<%-- 								<img src="${contextPath }/img/information-in-circular-button.png" width="25px" height="25px"> --%>
	   							<div class="btn-group" data-toggle="buttons">
	   								<label class="btn btn-primary active" onclick="restoption('all')">
	   									<input type="radio" name="restoptions" checked>전체
	   								</label>
	   								<label class="btn btn-primary" onclick="restoption('conveniencestore')">
	   									<input type="radio" name="restoptions">편의점
	   								</label>
	   								<label class="btn btn-primary" onclick="restoption('hospital')">
	   									<input type="radio" name="restoptions">병원
	   								</label>
	   								<label class="btn btn-primary" onclick="restoption('gasstation')">
	   									<input type="radio" name="restoptions">주유소
	   								</label>
	   								<label class="btn btn-primary" onclick="restoption('stay')">
	   									<input type="radio" name="restoptions">숙박
	   								</label>
	   							</div>
	   					</div>
	   					<div class="panel-rest-body" style="overflow:scroll;overflow-x:hidden;">
	   						<!-- 추천편의시설들어올곳 -->
	   					</div>
	   					<div class="panel-footer">
	   						<button class="btn btn-info" data-toggle="modal" data-target="#myModal-2">더 알아보기</button>
	   					</div>
	   				</div>
				</div>
			</div>
		</div>
		
		
		<!-- modal -->
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog">
				<!-- modal content -->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4><img alt="" src="${contextPath }/img/exclamation-mark.png" width="30px" height="30px">&nbsp;More..</h4>
					</div>
					<div class="modal-body">
						<div role="form">
							<div class="form-group">
								<label for="psw"></label>
								#부산
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-danger btn-default pull-left" data-dismiss="modal">
							<span class="glyphicon glyphicon-remove"></span>
						</button>
						<p>Need<a href="#">Help?</a></p>
					</div>
				</div>
			</div>
		</div>
		<div class="modal fade" id="myModal-2" role="dialog">
			<div class="modal-dialog">
				<!-- modal content -->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4><span class="glyphicon glyphicon-lock"></span>More..</h4>
					</div>
					<div class="modal-body">
						<div role="form">
							<div class="form-group">
								<label for="psw"></label>
								#Gs수유리점
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-danger btn-default pull-left" data-dismiss="modal">
							<span class="glyphicon glyphicon-remove"></span>
						</button>
						<p>Need</p>&nbsp;&nbsp;<a href="#">Help?</a>
					</div>
				</div>
			</div>
		</div>
		
      <!-- 스케쥴 시작 -->
    <div action="">
      <div class="container-fluid">
      	<div class="table-responsive">
      		<table class="table table-hover">
      			<thead>
      				<tr>
      					<th class="text-center"><a href="#" class="btn btn-info btn-lg"><span class="glyphicon glyphicon-calendar"></span>Schedule View</a></th>
      					<th class="text-center"><p class="text-primary">Travel Period</p></th>
      					<th class="text-center"><p class="text-primary">Strat Point</p></th>
      					<th class="text-center"><p class="text-primary">WayPoint</p></th>
      					<th class="text-center"><p class="text-primary">Destination</p></th>
      					<th class="text-center"><p class="text-primary">Expected Travel Cost</p></th>
      					<th class="text-center"><p class="text-primary">Memo</p></th>
      				</tr>
      			</thead>
      			<tbody name="trStaff">
      				<c:forEach items="${daily_tripList}" var="daily" varStatus="count">
	      				<tr>
	      					<td><input type="button" onclick="lookingRoute(${daily.daily_trip_index})" value="경로보기"></td>
	      					<td><p class="text-info text-center">${count.count}일차</p></td>
	      					<td><p class="text-info text-center">${daily.daily_trip_start_address}</p></td>
	      					<td><p class="text-info text-center">${daily.daily_trip_via1_address}</p></td>
	      					<td><p class="text-info text-center">${daily.daily_trip_end_address}</p></td>
	      					<td><p class="text-info text-center">${daily.daily_trip_cost}원</p></td>
	      					<td><p class="text-info text-center">${daily.daily_trip_memo}</p></td>
	      					<input type="hidden" name="daily_trip${daily.daily_trip_index}_starty" value="${daily.daily_trip_start_laty}">
	      					<input type="hidden" name="daily_trip${daily.daily_trip_index}_startx" value="${daily.daily_trip_start_lngx}">
      						<c:if test="${!empty daily.daily_trip_via1_laty}">
      							<input type="hidden" name="daily_trip${daily.daily_trip_index}_via1y" value="${daily.daily_trip_via1_laty}">
      							<input type="hidden" name="daily_trip${daily.daily_trip_index}_via1x" value="${daily.daily_trip_via1_lngx}">
      						</c:if>
      						<c:if test="${!empty daily.daily_trip_via2_laty}">
      							<input type="hidden" name="daily_trip${daily.daily_trip_index}_via2y" value="${daily.daily_trip_via2_laty}">
      							<input type="hidden" name="daily_trip${daily.daily_trip_index}_via2x" value="${daily.daily_trip_via2_lngx}">
      						</c:if>
      						<c:if test="${!empty daily.daily_trip_via3_laty}">
      							<input type="hidden" name="daily_trip${daily.daily_trip_index}_via3y" value="${daily.daily_trip_via3_laty}">
      							<input type="hidden" name="daily_trip${daily.daily_trip_index}_via3x" value="${daily.daily_trip_via3_lngx}">
      						</c:if>
      						<c:if test="${!empty daily.daily_trip_via4_laty}">
      							<input type="hidden" name="daily_trip${daily.daily_trip_index}_via4y" value="${daily.daily_trip_via4_laty}">
      							<input type="hidden" name="daily_trip${daily.daily_trip_index}_via4x" value="${daily.daily_trip_via4_lngx}">
      						</c:if>
      						<c:if test="${!empty daily.daily_trip_via5_laty}">
      							<input type="hidden" name="daily_trip${daily.daily_trip_index}_via5y" value="${daily.daily_trip_via5_laty}">
      							<input type="hidden" name="daily_trip${daily.daily_trip_index}_via5x" value="${daily.daily_trip_via5_lngx}">
      						</c:if>
	      					<input type="hidden" name="daily_trip${daily.daily_trip_index}_endy" value="${daily.daily_trip_end_laty}">
	      					<input type="hidden" name="daily_trip${daily.daily_trip_index}_endx" value="${daily.daily_trip_end_lngx}">
	      				</tr>
      				</c:forEach>
      			</tbody>
      		</table>
      	</div>
      	
      	<br><br><br><br><br><br><br><br>
      	
      	
      	<div class="container last">
      		<div class="row">
      			<div class="col-sm-12">
      				<label class="pull-left"><img src="${contextPath }/img/sound-651706_640.png" style="width: 25px; height: 25px;">&nbsp;&nbsp;<font class="text-danger">회원들에게 전해줄 메세지</font></label>
      				<textarea rows="10" cols="10" class="form-control" placeholder="글자수 2000자 제한입니다." readonly="readonly">${trip_board.trip_board_memo}
      				</textarea>
      			</div>
      		</div>
      	</div>
      	
      	<br><br><br><br>
       <div class="row text-center">
      	  <div class="col-sm-12">
		      <a href="tripBoardList" class="btn btn-info primary">목록보기</a>
		      <a href="#" class="btn btn-default primary"><img src="${contextPath }/img/like.png" width="20px" height="20px"></a>
		      <a href="#" class="btn btn-default primary"><img src="${contextPath }/img/thumb-down.png" width="20px" height="20px"></a>
	      </div>
	   </div>
      </div>
	</div>
	
	<br><br><br><br>
	
	
	
	
	<!-- commment ajax처리-->
		<div class="comments">
			<div class="comment-wrap">
				<div class="photo">
						<div class="avatar" style="background-image: url('../img/20171114112207_821582.png')"></div>
				</div>
				<div class="comment-block">
						<div>
								<textarea name="" id="" cols="30" rows="3" placeholder="권리침해, 욕설, 특정 대상을 비하하는 내용, 청소년에게 유해한 내용 등을 게시할 경우 운영정책과 이용약관 및 관련 법률에 의해 제재될 수 있습니다.댓글 작성 시 상대방에 대한 배려와 책임을 담아 주세요."></textarea>
								<input type="submit" class="btn btn-success pull-right" value="등록">
						</div>
				</div>
			</div>
	
			<div class="comment-wrap">
				<div class="photo">
						<div class="avatar" style="background-image: url('../img/user.png')"></div>
				</div>
				<div class="comment-block">
						<p class="comment-text">참가 하고 싶습니다. 전화번호는 010-1234-1234 입니다. 카톡,전화 부탁드리겠습니다.</p>
						<div class="bottom-comment">
								<div class="comment-date">Aug 02, 2018 @ 2:35 PM</div>
								<ul class="comment-actions">
										<li class="reply">Reply</li>
								</ul>
						</div>
				</div>
			</div>
	
			<div class="comment-wrap">
				<div class="photo">
						<div class="avatar" style="background-image: url('http://bootdey.com/img/Content/user_1.jpg')"></div>
				</div>
				<div class="comment-block">
						<p class="comment-text">회비가 너무 비싸네요..탈퇴하겠습니다. 죄송합니다.</p>
						<div class="bottom-comment">
								<div class="comment-date">Aug 23, 2018 @ 10:32 AM</div>
								<ul class="comment-actions">
										<li class="reply">Reply</li>
								</ul>
						</div>
				</div>
			</div>
		</div>

	
	
	<br><br><br><br><br><br>
	
	<div class="container-fluid" style="background-color: #E0ECF8">
		<div class="row">
			<div class="col-sm-12">
				<p class="text-center text-danger" style="font-size: 40px; font-family: 'Parisienne', cursive; color: #FA5858;">Related Post..</p>
			</div>
		</div>
	</div>
	<hr>
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-4">
				<div id="carousel" class="carousel slide carousel-fade" data-ride="carousel">
					<ol class="carousel-indicators">
						<li data-target="#carousel" data-slide-to="0" class="active"></li>
						<li data-target="#carousel" data-slide-to="1"></li>
						<li data-target="#carousel" data-slide-to="2"></li>
					</ol>
					
					<div class="carousel-inner carousel-zoom" role="listbox">
						<div class="item active">
							<img src="${contextPath }/img/bicycle-1846480_1920.jpg" class="img-responsive">
							<div class="carousel-caption">
								<h2><a href="http://www.naver.com">강남</a></h2>
								<p>강남역5번출구</p>
							</div>
						</div>
						<div class="item">
							<img src="${contextPath }/img/hamburg-2976711_1280.jpg" class="img-responsive">
							<div class="carousel-caption">
								<h3>역삼</h3>
								<p>역삼역5번출구</p>
							</div>
						</div>
						<div class="item">
							<img src="${contextPath }/img/hot-air-balloon-401545_1920.jpg" class="img-responsive">
							<div class="carousel-caption">
								<h3>논현</h3>
								<p>논현역5번출구</p>
							</div>
						</div>
					</div>
					<a class="left carousel-control" href="#carousel" role="button" data-slide="prev">
						‹
					</a>
					<a class="right carousel-control" href="#carousel" role="button" data-slide="next">
						›
					</a>
				</div>
			</div>
			
			<div class="col-sm-4">
				<div id="myCarousel2" class="carousel slide carousel-fade" data-ride="carousel">
					<ol class="carousel-indicators">
						<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
						<li data-target="#myCarousel" data-slide-to="1"></li>
						<li data-target="#myCarousel" data-slide-to="2"></li>
					</ol>
					<div class="carousel-inner carousel-zoom" role="listbox">
						<div class="item active">
							<img src="${contextPath }/img/bicycle-1846480_1920.jpg">
							<div class="carousel-caption">
								<h3>진해</h3>
								<p>진해군항전넘좋아욯ㅎ</p>
							</div>
						</div>
						<div class="item">
							<img src="${contextPath }/img/hamburg-2976711_1280.jpg">
							<div class="carousel-caption">
								<h3>설악산 Tour</h3>
								<p>설악반들 모여라</p>
							</div>
						</div>
						<div class="item">
							<img src="${contextPath }/img/hot-air-balloon-401545_1920.jpg">
							<div class="carousel-caption">
								<h3>제주도</h3>
								<p>감귤먹으러가자</p>
							</div>
						</div>
					</div>
					<a class="left carousel-control" href="#myCarousel2" role="button" data-slide="prev">
						‹			
					</a>
					<a class="right carousel-control" href="#myCarousel2" role="button" data-slide="next">
						›
					</a>
				</div>
			</div>
			
			<div class="col-sm-4">
				<div id="myCarousel3" class="carousel slide carousel-fade" data-ride="carousel">
					<ol class="carousel-indicators">
						<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
						<li data-target="#myCarousel" data-slide-to="1"></li>
						<li data-target="#myCarousel" data-slide-to="2"></li>
					</ol>
					<div class="carousel-inner carousel-zoom" role="listbox">
						<div class="item active">
							<img src="${contextPath }/img/bicycle-1846480_1920.jpg">
							<div class="carousel-caption">
								<h3>속초</h3>
								<p>태초마을이에요</p>
							</div>
						</div>
						<div class="item">
							<img src="${contextPath }/img/hamburg-2976711_1280.jpg">
							<div class="carousel-caption">
								<h3>창원</h3>
								<p>세븐City tour gogo</p>
							</div>
						</div>
						<div class="item">
							<img src="${contextPath }/img/hot-air-balloon-401545_1920.jpg">
							<div class="carousel-caption">
								<h3>부산</h3>
								<p>송도낚시</p>
							</div>
						</div>
					</div>
					<a class="left carousel-control" href="#myCarousel3" role="button" data-slide="prev">
						‹			
					</a>
					<a class="right carousel-control" href="#myCarousel3" role="button" data-slide="next">
						›
					</a>
				</div>
			</div>
		</div>
	</div>
	

	<div class="footer text-center">
	 	<a href="#myPage" title="To Top">
		 	<span class="glyphicon glyphicon-chevron-up"></span>
		 </a>
		<div class="container-fluid" id="icon">
		    <div class="row">
				<div class="sicon">
					<div class="col-lg-1 col-md-1 col-sm-2 col-xs-3 text-center">
						<div class="icon-circle text-center">
							<a href="#" class="ifacebook" title="Facebook"><i class="fa fa-facebook"></i></a>
						</div>
					</div>
					<div class="col-lg-1 col-md-1 col-sm-2 col-xs-3 text-center">
						<div class="icon-circle">
							<a href="#" class="itwittter" title="Twitter"><i class="fa fa-twitter"></i></a>
						</div>
					</div>
					<div class="col-lg-1 col-md-1 col-sm-2 col-xs-3 text-center">
						<div class="icon-circle">
							<a href="#" class="igoogle" title="Google+"><i class="fa fa-google-plus"></i></a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="${contextPath}/js/tripBoardRead.js" charset="UTF-8"></script>
<script src="${contextPath}/js/tripBoardRecommends.js" charset="UTF-8"></script>
</html>
