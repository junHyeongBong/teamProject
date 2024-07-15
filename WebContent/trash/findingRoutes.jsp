<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		<div id="map" style="width: 900px; height: 900px;"></div>
		<div id="routesNav"></div>
		<script type="text/javascript">
		
			
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
				
// 				console.log(result);
				
				return result;
			};
			
			function transCoordLine(location){
				var array = new Array(); //결과값 배열
				var tmp = location.split(" ");
				for(i=0; i<tmp.length; i++){
					var inner = tmp[i].split(",");
					var trans = naver.maps.Point(inner[0], inner[1]);
					array.push(naver.maps.TransCoord.fromNaverToLatLng(trans));
				}
				return array;
			};
			
			function drawNaverMarker(x,y){
				var marker = new naver.maps.Marker({
					position : new naver.maps.LatLng(y,x),
					map: map
				});
			};

			
			$.getJSON('testing3.json',function(jsonObject){
				var data = jsonObject;
				console.log(data);
				for(var z=0; z < data.routes.length; z++){
					$('#routesNav').append('<button onclick="searchRoute('+z+')">경로'+(z+1)+'</button><br>');
				}
			});
			
			var polyline = new naver.maps.Polyline({
				map: map,
				path: [],
				strokeWeight: 3,
				strokeColor: 'blue'
			});

			function searchRoute(index){
				polyline.setPath(new Array());
				var lineArray = polyline.getPath();
				console.log(index);
				$.getJSON('testing3.json',function(json){
					var data = json;
					
					console.log(data);
					
					var startLoc = transCoord(data.routes[0].summary.start.location);  
					var endLoc = transCoord(data.routes[0].summary.end.location);
					drawNaverMarker(startLoc.x, startLoc.y);
					drawNaverMarker(endLoc.x, endLoc.y);
					
					console.log(data.routes.length);
					
// 					var lineArray = new Array();
					
					for(var i=0; i < data.routes[index].legs.length; i++){
						for(var j=0; j < data.routes[index].legs[i].steps.length; j++){
							if(data.routes[index].legs[i].steps[j].steps!=null){
								for(var k=0; k < data.routes[index].legs[i].steps[j].steps.length; k++){
									if(data.routes[index].legs[i].steps[j].steps[k].path != ""){
										var tmpArray = transCoordLine(data.routes[index].legs[i].steps[j].steps[k].path);
										for(l=0; l < tmpArray.length; l++){
											lineArray.push(new naver.maps.LatLng(tmpArray[l].y, tmpArray[l].x));
										};
									};
								};
							}else{
								if(data.routes[index].legs[i].steps[j].path != ""){
									var tmpArray = transCoordLine(data.routes[index].legs[i].steps[j].path);
									for(m=0; m < tmpArray.length; m++){
										lineArray.push(new naver.maps.LatLng(tmpArray[m].y, tmpArray[m].x));
									};
								};
							};
						};
					};
					
// 					var polyline = new naver.maps.Polyline({
// 						map: map,
// 						path: lineArray,
// 						strokeWeight: 3,
// 						strokeColor: 'blue'
// 					});
				});
			};
			
// 			function search(){
// 				var xhr = new XMLHttpRequest();
// 				var url = "https://map.naver.com/findroute2/searchPubtransPath.nhn?apiVersion=3&searchType=0&start=126.9295615%2C37.484108%2C신림역사거리&destination=126.9415645%2C37.4823085%2C처음만남";
// 				xhr.open("GET", url, true);
// 				xhr.send();
// 				xhr.onreadystatechange = function(){
// 					if(xhr.readyState==4 && xhr.status==200){
// 						console.log('4:'+JSON.parse(xhr.responseText));
// 					}else if(xhr.readyState==1){
// 						console.log('1:'+JSON.parse(xhr.responseText));
// 					}
// 				};
// 			};
			
// 			search();
		</script>
	</body>
</html>