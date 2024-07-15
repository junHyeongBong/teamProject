<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="<%=request.getContextPath() %>"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>여행가요!</title>
		<script src="https://code.jquery.com/jquery-3.3.1.min.js"
		integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
		crossorigin="anonymous"></script>
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a0dabed2865c6b9cb878feb60563940b&libraries=services,clusterer,drawing"></script>
	</head>
	<body>
		<div>
			<div>
			</div>
			<div id="map" style="height:800px;width:800px"></div>
		</div>
	</body>
	<script >
		var daumMap = document.getElementById("map");
		var map = new daum.maps.Map(daumMap, {
			center: new daum.maps.LatLng(37.48449863764073, 126.92965018256109),
			level: 3
		});
		var geocoder = new daum.maps.services.Geocoder();
		var daumCoord;
		var latYlngX;
		var address;
		var infoWindow;
		var infoContent="<div class='infoWindow'>"+
		"<button onclick='button1_start();'>출발</button>"+
		"<button onclick='button2_via();'>경유</button>"+
		"<button onclick='button3_end();'>도착</button><br>"+
		"<button onclick='button4_search();'>길찾기</button></div>";
		var startMark = null;
		var viaMark = null;
		var endMark = null;
		var markerIndex = 0;
		
		var daumCoordList = new Array();
		var latYlngXList = new Array();
		var addressList = new Array();
		var startIndex;
		var endIndex;
		
		daum.maps.event.addListener(map, 'click', function(e){
			infoWindow.close();
		});
		
		daum.maps.event.addListener(map, 'rightclick', function(e) {        
		    daumCoord = e.latLng.toCoords();
		    latYlngX = e.latLng;
		    console.log(daumCoord);
		    console.log(latYlngX);
		    
		    geocoder.coord2Address(latYlngX.getLng(), latYlngX.getLat(), function(result, status){
			    if (status === daum.maps.services.Status.OK) {
			    	address = result[0].address.address_name;
			    }
			    else{
			    	alert("없는주소입니다.");
			    }
			});
		    
		    infoWindow = new daum.maps.InfoWindow({
		    	map: map,
		    	position: latYlngX,
		    	content: infoContent
		    });
		});
		function button1_start(){
			daumCoordList.push(daumCoord.ib+","+daumCoord.jb);
			latYlngXList.push(latYlngX.ib+","+latYlngX.jb);
			addressList.push(address);
			startIndex = daumCoordList.length-1;
			console.log(startIndex);
			console.log(address);
			if(startMark == null){
				startMark = new daum.maps.Marker({
					title: '출발지',
					image: new daum.maps.MarkerImage('${path}/img/start.png',
							new daum.maps.Size(34,50),
							{offset:new daum.maps.Point(17,50)}),
					position: latYlngX,
					map: map
				});
			}else{
				startMark.setPosition(latYlngX);
			}
			infoWindow.close();
		};
		function button2_via(){
			daumCoordList.push(daumCoord.ib+","+daumCoord.jb);
			latYlngXList.push(latYlngX.ib+","+latYlngX.jb);
			addressList.push(address);
			console.log(address);
			viaMark = new daum.maps.Marker({
				title: '경유지',
				image: new daum.maps.MarkerImage('${path}/img/viazip.png',
						new daum.maps.Size(24,37),{
							spriteOrigin: new daum.maps.Point(markerIndex*29, 0),    
				            spriteSize: new daum.maps.Size(286, 37)
						}),
				position: latYlngX,
				map: map
			});
			console.log(markerIndex);
			markerIndex += 1;
			infoWindow.close();
		};
		function button3_end(){
			daumCoordList.push(daumCoord.ib+","+daumCoord.jb);
			latYlngXList.push(latYlngX.ib+","+latYlngX.jb);
			addressList.push(address);
			endIndex = daumCoordList.length-1;
			console.log(endIndex);
			console.log(address);
			if(endMark == null){
				
				endMark = new daum.maps.Marker({
					title: '도착지',
					image: new daum.maps.MarkerImage('${path}/img/end.png',
							new daum.maps.Size(34,50),
							{offset:new daum.maps.Point(17,50)}),
					position: latYlngX,
					map:map
				});
			}else{
				endMark.setPosition(latYlngX);
			}
			infoWindow.close();
		};
		function button4_search(){
			$.ajaxSettings.traditional = true;
			$.ajax({
				type:"POST",
				url:"../test/daum",
				data:{
					daumCoordList: daumCoordList,
					latYlngXList: latYlngXList,
					addressList: addressList,
					startIndex: startIndex,
					endIndex: endIndex
				},
				dataType:"json",
				success:function(data){
					console.log(JSON.parse(data));
				},
				error:function(xhr, status, error){
					alert(error);
				}
			});
		};
		
		function searchAddrFromCoord(coord){
			geocoder.coord2Address(coord.getLng(), coord.getLat(), function(result, status){
			    if (status === daum.maps.services.Status.OK) {
			    	var fuck = result[0].address.address_name;
			    }
			    else{
			    	alert("없는주소입니다.");
			    }
			});
		};
	</script>
</html>