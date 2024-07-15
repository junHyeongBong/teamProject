<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="csrf_token" content="${_csrf.token}">
		
		<!-- jquery -->
		<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
		
		<!-- sweetalert -->
		<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
		
		<!-- datepicker -->
		<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
		<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
		<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
		
		<!-- 지도 API -->
		<script type="text/javascript"
		src="https://openapi.map.naver.com/openapi/v3/
		maps.js?clientId=C3g17HQW9Nteyqp72svy&submodules=panorama,geocoder,drawing">
		</script>
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a0dabed2865c6b9cb878feb60563940b&libraries=services,clusterer,drawing"></script>
		
		<!-- tripBoardWriteForm CSS -->
		<link rel="stylesheet" href="${contextPath}/css/tripBoardWriteForm.css">
		<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:400,600">
		
		<!-- 버튼, 라디오등 css -->
		<link rel="stylesheet" href="${contextPath}/css/tripBoardWirteFormFromWeb.css">

		<!-- 헤더부분 -->
		<link href="https://fonts.googleapis.com/css?family=Do+Hyeon" rel="stylesheet">
		<link href="https://fonts.googleapis.com/css?family=Yeon+Sung&subset=korean" rel="stylesheet">
		<script src="${contextPath}/js/header.js"></script>
		<link rel="stylesheet" href="${contextPath}/css/header.css">
		
		<!-- 폰트 -->
		<link href="https://fonts.googleapis.com/css?family=Gamja+Flower" rel="stylesheet">
		
		<title>Insert title here</title>
	</head>
	<body>
		<div class="wrapper">
			<%@ include file="header.jsp" %>
			<form action="" method="post" class="form">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
				<input type="hidden" id="member_id" name="member_id" value="${member_id}">
				<input type="hidden" id="member_nick" name="member_nick" value="${member_nick}">
				<div class="tripBoard">
					<div class="welcomeText">
						당신만의 여행을 작성하세요!
					</div>
					<div class="tripInfo">
						<div class="titleForm">
							<label>타이틀</label><br>
							<input type="text" id="trip_board_title" name="trip_board_title">
						</div>
						<div class="startDateForm">
							<label>출발일</label><br>
							<input type="text" id="trip_board_startdate" name="trip_board_startdate" placeholder="날짜를 선택!">
						</div>
						<div class="endDateForm">
							<label>종료일</label><br>
							<input type="text" id="trip_board_enddate" name="trip_board_enddate" placeholder="날짜를 선택!">
						</div>
						<div class="nowPepleCount">
							<label>현재인원</label><br>
							<select id="trip_board_nowcount" name="trip_board_nowcount">
								<option value="1" selected="selected">1명</option>
			                    <option value="2">2명</option>
			                    <option value="3">3명</option>
			                    <option value="4">4명</option>
			                    <option value="5">5명</option>
			                    <option value="6">6명</option>
			                    <option value="7">7명</option>
			                    <option value="8">8명</option>
			                    <option value="9">9명</option>
			                    <option value="10">10명</option>
							</select>
						</div>
						<div class="finalPepleCount">
							<label>총인원</label><br>
							<select id="trip_board_finalcount" name="trip_board_finalcount">
								<option value="1" selected="selected">1명</option>
			                    <option value="2">2명</option>
			                    <option value="3">3명</option>
			                    <option value="4">4명</option>
			                    <option value="5">5명</option>
			                    <option value="6">6명</option>
			                    <option value="7">7명</option>
			                    <option value="8">8명</option>
			                    <option value="9">9명</option>
			                    <option value="10">10명</option>
							</select>
						</div>
						<div class="recruit">
							<label id="together">함께갈까요?</label><br>
							<label class="switch switch-flat">
								<input class="switch-input" type="checkbox" name="trip_board_recruit">
								<span class="switch-label" data-on="On" data-off="Off"></span> 
								<span class="switch-handle"></span> 
							</label>
						</div>
						<div class="bool">
							<label>공개할까요?</label><br>
							<label class="switch switch-flat">
								<input class="switch-input" type="checkbox" checked="checked" name="trip_board_bool">
								<span class="switch-label" data-on="On" data-off="Off"></span> 
								<span class="switch-handle"></span> 
							</label>
						</div>
					</div>
					<div class="travelDays">
					<!-- x일차 들어올곳 -->
					</div>
					<div class="dailyTripInfo">
						<table class="dailyTripInfoTable">
							<tr>
								<td class="timeTable">
								</td>
								<td class="place">
								</td>
								<td class="roadInfo">
								</td>
								<td class="mapForm">
								</td>
							</tr>
							<tr>
								<td class="stay" colspan="3">
								</td>
								<td class="rest">
								</td>
							</tr>
						</table>
					</div>
				</div>
			</form>
		</div>
		
	</body>
	<script type="text/javascript" src="${contextPath}/js/tripBoardWriteNew.js"></script>
	<script type="text/javascript" src="${contextPath}/js/tripBoardRecommends.js"></script>
</html>