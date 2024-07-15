<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="<%=request.getContextPath() %>"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		<script src="https://code.jquery.com/jquery-3.3.1.min.js"
		integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
		crossorigin="anonymous"></script>
		<script type="text/javascript"
		src="https://openapi.map.naver.com/openapi/v3/
		maps.js?clientId=C3g17HQW9Nteyqp72svy&submodules=panorama,geocoder">
		</script>
	</head>
	<body>
		<div id="map" style="width: 800px; height: 800px;"></div>
		<div id="routesNav"></div>
		<script type="text/javascript">
			var routesIndex = 0;
			var startMark = null;
			var endMark = null;
			
			var map = new naver.maps.Map('map', {
				zoom : 8,
				minZoom : 1,
				zoomControl : true,
				zoomControlOptions : {
					position : naver.maps.Position.TOP_RIGHT
				},
				mapTypeControl : true
			});
			
			function transCoord(location){
				var tmp = location.split(",");
				var trans = naver.maps.Point(tmp[0], tmp[1]);
				var result = naver.maps.TransCoord.fromNaverToLatLng(trans);
				return result;
			};
			
			function transCoordLine(location){
				var array = new Array(); //결과값 배열
				var tmp = location.split(" ");
				if(tmp.length < 5){
					for(i=0; i<tmp.length; i++){
						if(i%2 == 0){
							var inner = tmp[i].split(",");
							var trans = naver.maps.Point(inner[0], inner[1]);
							array.push(naver.maps.TransCoord.fromNaverToLatLng(trans));
						};
					}
				}else if(tmp.length < 10){
					for(i=0; i<tmp.length; i++){
						if(i%4 == 0){
							var inner = tmp[i].split(",");
							var trans = naver.maps.Point(inner[0], inner[1]);
							array.push(naver.maps.TransCoord.fromNaverToLatLng(trans));
						};
					}
				}else{
					for(i=0; i<tmp.length; i++){
						if(i%5 == 0){
							var inner = tmp[i].split(",");
							var trans = naver.maps.Point(inner[0], inner[1]);
							array.push(naver.maps.TransCoord.fromNaverToLatLng(trans));
						};
					}
				};
				return array;
			};
			
			var polyline = new naver.maps.Polyline({
				map: map,
				path: [],
				strokeWeight: 4,
				strokeColor: 'blue'
			});
			
			var jsonObject = ${jsonObject};
			console.log(jsonObject);
			
			for(var z=0; z < jsonObject.routes.length; z++){
				$('#routesNav').append('<button onclick="searchRoute('+z+')">경로'+(z+1)+'</button><br>');
			}
			
			function searchRoute(routesIndex){
				polyline.setPath(new Array());
				var lineArray = polyline.getPath();
				
				var startLoc = transCoord(jsonObject.routes[0].summary.start.location);  
				var endLoc = transCoord(jsonObject.routes[0].summary.end.location);
				
				if(startMark == null){
					startMark = new naver.maps.Marker({
						title: '출발지',
						animation: 2,
						icon: {
							url: '${path}/img/start.png'
						},
						position: naver.maps.Point(startLoc.x,startLoc.y),
						map: map
					});
				}
				if(endMark == null){
					endMark = new naver.maps.Marker({
						title: '도착지',
						animation: 2,
						icon: {
							url: '${path}/img/end.png'
						},
						position: naver.maps.Point(endLoc.x,endLoc.y),
						map: map
					});
				}
				if(jsonObject.routes[0].summary.waypoints != null){
					var markerIndex = 0;
					for(var n=0; n<jsonObject.routes[0].summary.waypoints.length; n++){
						var viaLoc = transCoord(jsonObject.routes[0].summary.waypoints[n].location);
						var viaMark = new naver.maps.Marker({
							title: '경유지',
							animation: 2,
							icon: {
								url: '${path}/img/viazip.png',
								size: new naver.maps.Size(24,37),
								origin: new naver.maps.Point(markerIndex*29, 0),
								anchor: new naver.maps.Point(12,37)
							},
							position: naver.maps.Point(viaLoc.x,viaLoc.y),
							map: map
						});
						markerIndex += 1;
					}
				}
				
				for(var i=0; i < jsonObject.routes[routesIndex].legs.length; i++){
					for(var j=0; j < jsonObject.routes[routesIndex].legs[i].steps.length; j++){
						if(jsonObject.routes[routesIndex].legs[i].steps[j].steps!=null){
							for(var k=0; k < jsonObject.routes[routesIndex].legs[i].steps[j].steps.length; k++){
								if(jsonObject.routes[routesIndex].legs[i].steps[j].steps[k].path != ""){
									var tmpArray = transCoordLine(jsonObject.routes[routesIndex].legs[i].steps[j].steps[k].path);
									for(l=0; l < tmpArray.length; l++){
										lineArray.push(new naver.maps.LatLng(tmpArray[l].y, tmpArray[l].x));
									};
								};
							};
						}else{
							if(jsonObject.routes[routesIndex].legs[i].steps[j].path != ""){
								var tmpArray = transCoordLine(jsonObject.routes[routesIndex].legs[i].steps[j].path);
								for(m=0; m < tmpArray.length; m++){
									lineArray.push(new naver.maps.LatLng(tmpArray[m].y, tmpArray[m].x));
								};
							};
						};
					};
				};
			};
		</script>
	</body>
</html>