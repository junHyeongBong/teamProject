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
		maps.js?clientId=C3g17HQW9Nteyqp72svy&submodules=panorama,geocoder,drawing">
		</script>
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a0dabed2865c6b9cb878feb60563940b&libraries=services,clusterer,drawing"></script>
	</head>
	<body>
		<div>
			<input type="text" value="주소를 입력하세요">
			<button>검색</button><br>
			<button name="car" onclick="moveType(0)">자동차</button>
			<button name="publicTransport" onclick="moveType(1)">대중교통</button>
			<button name="bicycle" onclick="moveType(2)">자전거</button>
			<button name="walk" onclick="moveType(3)">도보</button>
		</div>
		<div id="routesNav">
		</div>
		<div id="map" style="width: 710px; height: 710px;"></div>
		<script>
			var map = new naver.maps.Map('map', {
				zoom : 8,
				minZoom : 1,
				zoomControl : true,
				zoomControlOptions : {
					position : naver.maps.Position.TOP_RIGHT
				},
				mapTypeControl : true
			});
			var movingType=0;
			
			var daumCoord;
			var latYlngX;
			var address;
			var daumCoordList = new Array();
			var latYlngXList = new Array();
			var addressList = new Array();
			var startIndex;
			var endIndex;
			
			var startMark = null;
			var endMark = null;
			var viaMarkList = new Array();
			var markerIndex = 0;
			
			var subMenuString = [
				'<div class="subMenu">',
				'	<button onclick="button1_start();">출발</button>',
				'	<button onclick="button2_via();">경유</button>',
				'	<button onclick="button3_end();">도착</button><br>',
				'	<button onclick="button4_search();">길찾기</button>',
				'	<button onclick="reset();">리셋</button>',
				'</div>'
			].join('');
			
			var jsonObject;
			var polyline = new naver.maps.Polyline({
				map: map,
				path: [],
				strokeWeight: 4,
				strokeColor: 'blue'
			});

			naver.maps.Event.addListener(map, 'click', function(e) {
				subMenu.close();
			});
			
			naver.maps.Event.addListener(map, 'rightclick', function(e){
				latYlngX = e.coord
				console.log(latYlngX)
				console.log(latYlngX.y+","+latYlngX.x);
				subMenu.open(map, e.coord);
				searchCoordinateToAddress(latYlngX);
			});
			
			
			var subMenu = new naver.maps.InfoWindow({
				content: subMenuString,
				maxWidth: 250,
				backgroundColor: "white",
				borderWidth: 2,
				borderColor: "blue"
			});
			
			//function_start
			function moveType(moving){
				movingType = moving;
			}
			
			function searchCoordinateToAddress(latlng){
				naver.maps.Service.reverseGeocode({
					location: latlng,
					coordType: naver.maps.Service.CoordType.LATLNG
				}, function(status, response){
					if(status === naver.maps.Service.Status.ERROR){
						return alert("잘못되었습니다.");
					}
					address = response.result.items[0].address;
					console.log(address);
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
						position: latYlngX,
						map: map
					});
				}else{
					startMark.setPosition(latYlngX);
				}
				latYlngXList.push(latYlngX.y+","+latYlngX.x);
				addressList.push(address);
				startIndex = latYlngXList.length-1;
				
				subMenu.close();
			};
			function button2_via(){
				var viaMark = new naver.maps.Marker({
					title: '경유지',
					animation: 2,
					icon: {
						url: '${path}/img/viazip.png',
						size: new naver.maps.Size(24,37),
						origin: new naver.maps.Point(markerIndex*29, 0),
						anchor: new naver.maps.Point(12,37)
					},
					position: latYlngX,
					map: map
				});
				viaMarkList.push(viaMark);
				latYlngXList.push(latYlngX.y+","+latYlngX.x);
				addressList.push(address);
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
						position: latYlngX,
						map:map
					});
				}else{
					endMark.setPosition(latYlngX);
				}
				latYlngXList.push(latYlngX.y+","+latYlngX.x);
				addressList.push(address);
				endIndex = latYlngXList.length-1;
				
				subMenu.close();
			};
			
// 			$.getJSON('daumNonEx.json',function(data){
// 				jsonObject = data; 
// 				console.log(jsonObject);
// 			});
			
			function button4_search(){
				if(movingType == 1){
					transDaumCoordList(latYlngXList);
				}
				$.ajaxSettings.traditional = true;
				$.ajax({
					type:"POST",
					url:"../test/routeFinder",
					data:{
						movingType: movingType,
						daumCoordList: daumCoordList,
						latYlngXList: latYlngXList,
						addressList: addressList,
						startIndex: startIndex,
						endIndex: endIndex
					},
					dataType:"text",
					success:function(data){
						console.log(JSON.parse(data));
						jsonObject = JSON.parse(data);
						var startAddr;
						var viaAddr = "";
						var endAddr;
						var distan;
						var timewaste;
						
						if(movingType == 1){//다음
							startAddr = jsonObject.in_local.start.name;
							endAddr = jsonObject.in_local.end.name;
							$('#routesNav').append('출발지 : '+startAddr+'<br>도착지 : '+endAddr+'<br>');
							
							for(var z=0; z<jsonObject.in_local.routes.length; z++){
								distan = jsonObject.in_local.routes[z].distance.text;
								timewaste = jsonObject.in_local.routes[z].time.text;
								$('#routesNav').append('<button onclick="daumSearchRoute('+z+')">경로'+(z+1)+
								'</button> 총거리:'+distan+' / 소요시간:'+timewaste+'<br><div class="selectRoute" id="selectRoute'+z+'"></div>');
							}
						}else{//네이버
							startAddr = jsonObject.routes[0].summary.start.address;
							endAddr = jsonObject.routes[0].summary.end.address;
							if(jsonObject.routes[0].summary.waypoints != null){
								for(var i=0; i<jsonObject.routes[0].summary.waypoints.length; i++){
									viaAddr += '경유지'+(i+1)+' : '+jsonObject.routes[0].summary.waypoints[i].address+'<br>';
								}
							}
							$('#routesNav').append('출발지 : '+startAddr+'<br>'+viaAddr+'도착지 : '+endAddr+'<br>');
							
							for(var z=0; z < jsonObject.routes.length; z++){
								distan = (jsonObject.routes[z].summary.distance)/1000;
								timewaste = (jsonObject.routes[z].summary.duration)/60;
								$('#routesNav').append('<button onclick="searchRoute('+z+')">경로'+(z+1)+'</button> 총거리:'+distan.toFixed(2)
										+'km / 소요시간:'+timewaste.toFixed(2)+'분<br>');
							}
						}
					},
					error:function(xhr, status, error){
						alert("에러");
					}
				});
				subMenu.close();
			};
			
			function transCoord(location){
				var tmp = location.split(",");
				var trans = naver.maps.Point(tmp[0], tmp[1]);
				var result = naver.maps.TransCoord.fromNaverToLatLng(trans);
				return result;
			};
			
			function transDaumCoordList(location){
				for(var i=0; i<location.length; i++){
					daumCoord = new daum.maps.LatLng(location[i].split(",")[0],location[i].split(",")[1]);
					daumCoordList.push(daumCoord.toCoords().ib+","+daumCoord.toCoords().jb);
				}
// 				console.log(daumCoordList);
			}
			
			function transCoordLine(location){
				var array = new Array(); //결과값 배열
				var tmp = location.split(" ");
				if(tmp.length < 5){
					for(var i=0; i<tmp.length; i++){
						if(i%2 == 0){
							var inner = tmp[i].split(",");
							var trans = naver.maps.Point(inner[0], inner[1]);
							array.push(naver.maps.TransCoord.fromNaverToLatLng(trans));
						};
					}
				}else if(tmp.length < 10){
					for(var i=0; i<tmp.length; i++){
						if(i%4 == 0){
							var inner = tmp[i].split(",");
							var trans = naver.maps.Point(inner[0], inner[1]);
							array.push(naver.maps.TransCoord.fromNaverToLatLng(trans));
						};
					}
				}else{
					for(var i=0; i<tmp.length; i++){
						if(i%5 == 0){
							var inner = tmp[i].split(",");
							var trans = naver.maps.Point(inner[0], inner[1]);
							array.push(naver.maps.TransCoord.fromNaverToLatLng(trans));
						};
					}
				};
				return array;
			};
			
			function searchRoute(routesIndex){
				polyline.setPath(new Array());
				var lineArray = polyline.getPath();
				
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
				console.log(lineArray);
			};
			
			function daumSearchRoute(routesIndex){
				$('.selectRoute').empty();
				polyline.setPath(new Array());
				var lineArray = polyline.getPath();
				for(var i=0; i<viaMarkList.length; i++){
					viaMarkList[i].setMap(null);
				}
				viaMarkList = new Array();
				for(var j=0; j<jsonObject.in_local.routes[routesIndex].steps.length; j++){
					$('#selectRoute'+routesIndex).append("이동순서"+(j+1)+" : "+jsonObject.in_local.routes[routesIndex].steps[j].information+"<br>");
					var whatTypeTransPort = jsonObject.in_local.routes[routesIndex].steps[j].type
					if(jsonObject.in_local.routes[routesIndex].steps[j].startLocation != null && whatTypeTransPort != null && whatTypeTransPort != 'WALKING'){
// 						console.log(jsonObject.in_local.routes[routesIndex].steps[j].type);
						var whatUseTransport;
						var viaTmpX = jsonObject.in_local.routes[routesIndex].steps[j].startLocation.x;
						var viaTmpY = jsonObject.in_local.routes[routesIndex].steps[j].startLocation.y;
						var viaTmpDaumCoord = new daum.maps.Coords(viaTmpX, viaTmpY);
						console.log(naver.maps.Point(viaTmpDaumCoord.toLatLng().ib, viaTmpDaumCoord.toLatLng().jb));
						if(whatTypeTransPort == 'BUS'){
							whatUseTransport = '${path}/img/bus.png';
						}else if(whatTypeTransPort == 'SUBWAY'){
							whatUseTransport = '${path}/img/subway.png';
						}
						console.log(whatUseTransport);
						var viaMark = new naver.maps.Marker({
							title: '대중교통',
							animation: 2,
							icon: {
								url: whatUseTransport
							},
							position: naver.maps.Point(viaTmpDaumCoord.toLatLng().ib, viaTmpDaumCoord.toLatLng().jb),
							map: map
						});
						viaMarkList.push(viaMark);
					};
					if(jsonObject.in_local.routes[routesIndex].steps[j].polyline != null){
						var tmpDaumCoordList = jsonObject.in_local.routes[routesIndex].steps[j].polyline;
// 						console.log("tmpDaumCoordList:"+tmpDaumCoordList);
// 						console.log(tmpDaumCoordList.split("|").length);
						for(var k=0; k<tmpDaumCoordList.split("|").length/2; k++){
							var tmpDaumCoord = new daum.maps.Coords(tmpDaumCoordList.split("|")[k*2], tmpDaumCoordList.split("|")[(k*2)+1]);
// 							console.log("tmpDaumCoord:"+tmpDaumCoord);
							lineArray.push(new naver.maps.LatLng(tmpDaumCoord.toLatLng().jb, tmpDaumCoord.toLatLng().ib));
// 							console.log("naver:"+new naver.maps.LatLng(tmpDaumCoord.toLatLng().jb, tmpDaumCoord.toLatLng().ib));
						}
					}
				}
// 				console.log(lineArray);
			}
			
			function reset(){
				daumCoordList = new Array();
				latYlngXList = new Array();
				addressList = new Array();
				
				startMark.setMap(null);
				startMark = null;
				for(var i=0; i<viaMarkList.length; i++){
					viaMarkList[i].setMap(null);
				}
				viaMarkList = new Array();
				markerIndex = 0;
				endMark.setMap(null);
				endMark = null;
				
				polyline.setMap(null);
				polyline = new naver.maps.Polyline({
					map: map,
					path: [],
					strokeWeight: 4,
					strokeColor: 'blue'
				})
				$('#routesNav').empty();
				subMenu.close();
			}
			
		</script>
	</body>
</html>