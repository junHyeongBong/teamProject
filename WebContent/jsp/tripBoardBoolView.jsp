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
		
		<!-- tripBoardView CSS -->
		<link rel="stylesheet" href="${contextPath}/css/tripBoardViewForm.css">
		<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:400,600">
		
		<!-- 헤더부분 -->
		<link href="https://fonts.googleapis.com/css?family=Do+Hyeon" rel="stylesheet">
		<link href="https://fonts.googleapis.com/css?family=Yeon+Sung&subset=korean" rel="stylesheet">
		<script src="${contextPath}/js/header.js"></script>
		<link rel="stylesheet" href="${contextPath}/css/header.css">
		
		<!-- 폰트 -->
		<link href="https://fonts.googleapis.com/css?family=Gamja+Flower" rel="stylesheet">
		
		<title>구경해요!</title>
	</head>
	<body>
		<div class="wrapper">
			<%@ include file="header.jsp" %>
			
			<form action="" method="post" class="form">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
				<div class="tripBoard">
					<div class="welcomeText">
						다른 사람의 여행을 구경하세요!
					</div>
					<div class="tripInfo">
						<div class="titleForm">
							<label>타이틀</label><br>
							<input type="hidden" id="trip_board_num" name="trip_board_num" readonly="readonly" value="${tripBoard.trip_board_num}">
							<input type="text" id="trip_board_title" name="trip_board_title" readonly="readonly" value="${tripBoard.trip_board_title}">
						</div>
						<div class="startDateForm">
							<label>출발일</label><br>
							<input type="text" id="trip_board_startdate" name="trip_board_startdate" readonly="readonly" value="${tripBoard.trip_board_startdate}">
						</div>
						<div class="endDateForm">
							<label>종료일</label><br>
							<input type="text" id="trip_board_enddate" name="trip_board_enddate" readonly="readonly" value="${tripBoard.trip_board_enddate}">
						</div>
						<div class="nowPepleCount">
							<label>현재인원</label><br>
							<input type="text" id="trip_board_nowcount" name="trip_board_nowcount" readonly="readonly" value="${tripBoard.trip_board_nowcount}">
						</div>
						<div class="finalPepleCount">
							<label>총인원</label><br>
							<input type="text" id="trip_board_finalcount" name="trip_board_finalcount" readonly="readonly" value="${tripBoard.trip_board_finalcount}">
						</div>
						<div class="writerForm">
							<label>작성자</label><br>
							<img id="pf_image" alt="프로필사진이 없습니다." src="readTripBoardWriterImg?writer_id=${tripBoard.member_id}">
							<input type="text" onclick="dropDownShow()" class="dropdown-toggle" id="trip_board_member_nick" name="trip_board_member_nick" readonly="readonly" value="${tripBoard.member_nick}">
							
							<div class="dropdown-menu">
								<table class="dropdown-table">
									<tr>
										<td class="dropdown-button" onclick="newMessage('${tripBoard.member_id}','${tripBoard.member_nick}')">쪽지 보내기</td>
									</tr>
									<tr>
										<td class="dropdown-button" onclick="searching()">작성글 검색</td>
									</tr>
									<tr>
										<td class="dropdown-button" onclick="addRelation('${tripBoard.member_id}','friend')">친구 추가</td>
									</tr>
									<tr>
										<td class="dropdown-button" onclick="addRelation('${tripBoard.member_id}','ignored')">차단</td>
									</tr>
								</table>
							</div>
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
					<input type="hidden" id="trip_board_memo" name="trip_board_memo" value="${tripBoard.trip_board_memo}">
				</div>
				<c:if test="${member_id==tripBoard.member_id}">
					<input class="lastButton" type="button" onclick="modifyTripBoard(${tripBoard.trip_board_num})" value="수정">
					<input class="lastButton" type="button" onclick="deleteTripBoard(${tripBoard.trip_board_num})" value="삭제">
				</c:if>
				<c:if test="${!empty member_id}">
					<c:if test="${member_id != tripBoard.member_id}">
						<input class="lastButton" type="button" onclick="recommend('up', ${tripBoard.trip_board_num})" value="추천">
						<input class="lastButton" type="button" onclick="recommend('down', ${tripBoard.trip_board_num})" value="비추">
					</c:if>
				</c:if>
				<input class="lastButton" type="button" onclick="location.href='../common/tripBoardBoolList'" value="목록">
			</form>
			
			<div class="reply">
				<c:if test="${!empty member_id}">	
					<table border="1" width="1000" class="reply_insertArea" style="border-style: hidden;"> <!-- bordercolor="#46AA46" -->
						<tr style="border-style: hidden;">
							<td width="500px" style="border-style: hidden;">
								닉네임 : ${member_nick}
								<input type="hidden" id="member_id" value="${member_id}">
								<input type="hidden" id="member_nick" value="${member_nick}">
								<textarea rows="1" cols="70" placeholder="댓글을 입력해주세요" id="reply_content" name="reply_content"></textarea>
								<button id="reply_save" name="reply_save">등록</button>
							</td>
						</tr>
					</table>
				</c:if>
				
				<table border="1" width="1000" id="reply_area">
				</table>
			</div>
		</div>
		
	</body>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script type="text/javascript" src="${contextPath}/js/tripBoardViewNew.js"></script>
	<script type="text/javascript" src="${contextPath}/js/tripBoardRecommends.js"></script>
	<script type="text/javascript" src="${contextPath}/js/tripBoardReply.js"></script>
</html>