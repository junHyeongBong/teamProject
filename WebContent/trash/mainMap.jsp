
<%@page import="model.Coordinate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="<%=request.getContextPath() %>"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>지도테스트</title>
	</head>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"
		integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
		crossorigin="anonymous"></script>
	<script type="text/javascript"
		src="https://openapi.map.naver.com/openapi/v3/
		maps.js?clientId=C3g17HQW9Nteyqp72svy&submodules=panorama,geocoder,drawing">
	</script>
	<body>
		<div id="map" style="width: 710px; height: 710px;"></div>
		<div id="test" style="width: 100px; height: 100px; border: 1px solid black;"><a href="hihihi">hi</a><br></div>
		<script>
			var HOME_PATH = window.HOME_PATH || '.';
			var map = new naver.maps.Map('map', {
				zoom : 8,
				minZoom : 1,
				zoomControl : true,
				zoomControlOptions : {
					position : naver.maps.Position.TOP_RIGHT
				},
				mapTypeControl : true
			});
			
			
			naver.maps.Event.addListener(map, 'click', function(e) {
				subMenu.close();
				var pointX = e.coord.lat(); //x좌표
				var pointY = e.coord.lng(); //y좌표
				
				var marker = new naver.maps.Marker({
					position:e.coord,
					map:map
				});
				
				$("#test").append("<a href='../test/testing?pointX="+pointX+"&pointY="+pointY+"'>이동</a>")
			});

			var subMenuString = [
				'<div class="subMenu">',
				'	<button onclick="button1_start();">출발</button>',
				'	<button onclick="button2_via();">경유</button>',
				'	<button onclick="button3_end();">도착</button>',
				'</div>'
			].join('');
			
			var subMenu = new naver.maps.InfoWindow({
				content: subMenuString,
				maxWidth: 250,
				backgroundColor: "white",
				borderWidth: 2,
				borderColor: "blue"
			});
			
			var position;
			
			naver.maps.Event.addListener(map, 'rightclick', function(e){
				position = e.coord;
				subMenu.open(map, e.coord);
			});
			
			function button1_start(){
				var startMark = new naver.maps.Marker({
					title: '출발지',
					animation: 2,
					icon: {
						url: '${path}/img/start.PNG'
					},
					position: position,
					map: map
				});
				alert('111출발지좌표 : '+position);
			};
			
			function button2_via(){
				var viaMark = new naver.maps.Marker({
					title: '경유지',
					animation: 2,
					icon: {
						url: '${path}/img/via.PNG'
					},
					position: position,
					map: map
				});
				alert('경유지좌표 : '+position);
			};
			
			function button3_end(){
				var endMark = new naver.maps.Marker({
					title: '도착지',
					icon: {
						url: '${path}/img/end.PNG'
					},
					animation: 2,
					position: position,
					map:map
				});
				alert('도착지좌표 : '+position);
			};
			
			

		</script>
	</body>
</html>