
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
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a0dabed2865c6b9cb878feb60563940b&libraries=services,clusterer,drawing"></script>
	<body>
		<div id="map" style="width: 710px; height: 710px;"></div>
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
			
			var lngX;
			var latY;
			var coordsLatY = new Array();
			var coordsLngX = new Array();
			var roadAddress;
			var addresses = new Array();
			var startIndex;
			var finalIndex;
			var markerIndex = 0;
			var startMark = null;
			var endMark = null;
			
			naver.maps.Event.addListener(map, 'click', function(e) {
				subMenu.close();
// 				var marker = new naver.maps.Marker({
// 					position:e.coord,
// 					map:map
// 				});
// 				searchCoordinateToAddress(e.coord);
			});
			
			naver.maps.Event.addListener(map, 'rightclick', function(e){
				latY = e.coord.y;
				lngX = e.coord.x;
				console.log(latY+","+lngX);
				subMenu.open(map, e.coord);
				searchCoordinateToAddress(e.coord);
			});
			
			var subMenuString = [
				'<div class="subMenu">',
				'	<button onclick="button1_start();">출발</button>',
				'	<button onclick="button2_via();">경유</button>',
				'	<button onclick="button3_end();">도착</button><br>',
				'	<button onclick="button4_search();">길찾기</button>',
				'</div>'
			].join('');
			
			var subMenu = new naver.maps.InfoWindow({
				content: subMenuString,
				maxWidth: 250,
				backgroundColor: "white",
				borderWidth: 2,
				borderColor: "blue"
			});
			
			
			function searchCoordinateToAddress(latlng){
				naver.maps.Service.reverseGeocode({
					location: latlng,
					coordType: naver.maps.Service.CoordType.LATLNG
				}, function(status, response){
					if(status === naver.maps.Service.Status.ERROR){
						return alert("잘못되었습니다.");
					}
					
// 					console.log(response.result);
					
					roadAddress = response.result.items[0].address;
					console.log(roadAddress);
					
// 					for(var i=0; i<response.result.items.length; i++){
// 						console.log(response.result.items[i].address);
// 					}
					
// 					var items = response.result.items, htmlAddresses = [];
// 					console.log('items:'+items);
// 					for(var i  = 0; ii=items.length, item, addrType; i<ii, i++){
// 						item = items[i];
// 						addrType = item.isRoadAddress ? '[도로명주소]' : '[지번 주소]';
// 						console.log('addrType:'+addrType);
// 						console.log('item.address:'+item.address);
// 						htmlAddresses.push((i+1)+'. '+addrType+' '+item.address);
// 					}
					
// 					console.log(htmlAddresses);
				});
			};
			
			function button1_start(){
				if(startMark == null){
					startMark = new naver.maps.Marker({
						title: '출발지',
						animation: 2,
						icon: {
							url: '${path}/img/start.png'
						},
						position: naver.maps.Point(lngX,latY),
						map: map
					});
				}else{
					startMark.setPosition(naver.maps.Point(lngX,latY));
				}
				coordsLatY.push(latY);
				coordsLngX.push(lngX);
				addresses.push(roadAddress);
				startIndex = coordsLatY.length-1;
				
				subMenu.close();
			};
			function button2_via(){
				coordsLatY.push(latY);
				coordsLngX.push(lngX);
				addresses.push(roadAddress);
				var viaMark = new naver.maps.Marker({
					title: '경유지',
					animation: 2,
					icon: {
						url: '${path}/img/viazip.png',
						size: new naver.maps.Size(24,37),
						origin: new naver.maps.Point(markerIndex*29, 0),
						anchor: new naver.maps.Point(12,37)
					},
					position: naver.maps.Point(lngX,latY),
					map: map
				});
// 				console.log(markerIndex);
				markerIndex += 1;
				subMenu.close();
			};
			
			function button3_end(){
				if(endMark == null){
					endMark = new naver.maps.Marker({
						title: '도착지',
						icon: {
							url: '${path}/img/end.png'
						},
						animation: 2,
						position: naver.maps.Point(lngX,latY),
						map:map
					});
				}else{
					endMark.setPosition(naver.maps.Point(lngX,latY));
				}
				coordsLatY.push(latY);
				coordsLngX.push(lngX);
				addresses.push(roadAddress);
				finalIndex = (coordsLatY.length-1);
				
				subMenu.close();
			};
			function button4_search(){
				window.location.href='../test/finding?coordsLatY='+coordsLatY+'&coordsLngX='+coordsLngX+'&addresses='+addresses+'&startIndex='+startIndex+'&finalIndex='+finalIndex;
			};
			
		</script>
	</body>
</html>