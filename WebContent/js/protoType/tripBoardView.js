var map = new naver.maps.Map('map', {
	zoom : 8,
	minZoom : 1,
	zoomControl : true,
	zoomControlOptions : {
		position : naver.maps.Position.TOP_RIGHT
	},
	mapTypeControl : true
});

var road_finder_transport_type = "0"; //0:자동차(default), 1:대중교통, 2:자전거, 3:도보

var daumCoord; //다음좌표(jb, ib)
var latYlngX; //좌표(y, x)
var address; //도로명주소
var daumCoordList = new Array(); //다음좌표리스트
var latYlngXList = new Array(); //좌표리스트
var addressList = new Array(); //주소리스트
var startIndex; //리스트 내 출발지인덱스
var endIndex; //리스트 내 도착지인덱스

var startMark = null; //출발지마크
var endMark = null; //도착지마크
var viaMarkList = new Array(); //경유지마크 리스트
var viaMarkImage = new Array();
var markerIndex = 1; //마크인덱스

var setdailyinputtext = 0;
var routesindex = 0;//선택루트인덱스
var jsonObject;//java에서 넘어오는 json객체

var buttonClickCount = 0;

var polyline = new naver.maps.Polyline({ //지도에 경로그리기
	map : map,
	path : [],
	strokeWeight : 7,
	strokeOpacity : 0.6,
	strokeColor : '#1478FF'
});

function lookingRoute(daily_trip_index){
	if(buttonClickCount == 1){
		button4_reset();
		buttonClickCount = 0;
	}
	buttonClickCount += 1;
	
	var starty = $("input[name=daily_trip"+daily_trip_index+"_starty]").val();
	var startx = $("input[name=daily_trip"+daily_trip_index+"_startx]").val();
	var via1y = $("input[name=daily_trip"+daily_trip_index+"_via1y]").val();
	var via1x = $("input[name=daily_trip"+daily_trip_index+"_via1x]").val();
	var via2y = $("input[name=daily_trip"+daily_trip_index+"_via2y]").val();
	var via2x = $("input[name=daily_trip"+daily_trip_index+"_via2x]").val();
	var via3y = $("input[name=daily_trip"+daily_trip_index+"_via3y]").val();
	var via3x = $("input[name=daily_trip"+daily_trip_index+"_via3x]").val();
	var via4y = $("input[name=daily_trip"+daily_trip_index+"_via4y]").val();
	var via4x = $("input[name=daily_trip"+daily_trip_index+"_via4x]").val();
	var via5y = $("input[name=daily_trip"+daily_trip_index+"_via5y]").val();
	var via5x = $("input[name=daily_trip"+daily_trip_index+"_via5x]").val();
	var endy = $("input[name=daily_trip"+daily_trip_index+"_endy]").val();
	var endx = $("input[name=daily_trip"+daily_trip_index+"_endx]").val();
	var viaList = new Array();
	viaList.push(new naver.maps.LatLng(via1y, via1x));
	viaList.push(new naver.maps.LatLng(via2y, via2x));
	viaList.push(new naver.maps.LatLng(via3y, via3x));
	viaList.push(new naver.maps.LatLng(via4y, via4x));
	viaList.push(new naver.maps.LatLng(via5y, via5x));
	
	button1_start(starty, startx);
	for(var i=0; i<viaList.length; i++){
		button2_via(viaList[i]);
	}
	for(var i=0; i<viaMarkList.length; i++){
		naver.maps.Event.addListener(viaMarkList[i], 'click', getRecommend(i));
	}
	button3_end(endy, endx);
	
	$.ajaxSetup({
	    headers: {
	      'X-CSRF-Token': $('meta[name="csrf_token"]').attr('content')
	    }
	});
	$.ajax({
		type:"post",
		url:"../common/loadingRoad",
		data:{
			daily_trip_index:daily_trip_index
		},
		success:function(data){
			road_finder_transport_type = data.split("^")[0];
			routesindex = data.split("^")[1];
			jsonObject = JSON.parse(data.split("^")[2]);
			
			var distan;
			var timewaste;
			
			if(road_finder_transport_type == 0){
				searchRouteByNaver();
				distan = (jsonObject.routes[routesindex].summary.distance)/1000;
				timewaste = (jsonObject.routes[routesindex].summary.duration)/60;
				$("#search").append('<li>이동수단<div class="btn btn-default" id="car">'
						+'<img src="../img/sports-car.png" width="15px" height="15px">자동차'
						+'</div></li>');
				$('#routesNav').append('<div id="nav1">'+'<input type="button" value="이동경로">총거리:'+distan.toFixed(2)
						+'km / 소요시간:'+timewaste.toFixed(2)+'분</div><br>');
			}else if(road_finder_transport_type == 1){
				searchRouteByDaum();
				distan = jsonObject.in_local.routes[routesindex].distance.text;
				timewaste = jsonObject.in_local.routes[routesindex].time.text;
				$("#search").append('<li>이동수단<div class="btn btn-default" id="public transport">'
						+'<img src="../img/subway.png" width="15px" height="15px">대중교통'
						+'</div></li>');
				$('#routesNav').append('<div id="nav1">'+'<input type="button" value="이동경로"'
						+'>총거리:'+distan+' / 소요시간:'+timewaste+'<br><div class="selectRoute" id="selectRoute'+routesindex+'"></div>'+'</div>');
			}else if(road_finder_transport_type == 2){
				searchRouteByNaver();
				distan = (jsonObject.routes[routesindex].summary.distance)/1000;
				timewaste = (jsonObject.routes[routesindex].summary.duration)/60;
				$("#search").append('<li>이동수단<div class="btn btn-default" id="bicycle">'
						+'<img src="../img/bicycle.png" width="15px" height="15px">자전거'
						+'</div></li>');
				$('#routesNav').append('<div id="nav1">'+'<input type="button" value="이동경로">총거리:'+distan.toFixed(2)
						+'km / 소요시간:'+timewaste.toFixed(2)+'분</div><br>');
			}else{
				searchRouteByNaverWalking();
				distan = (jsonObject.result.summary.totalDistance)/1000;
				timewaste = jsonObject.result.summary.totalTime;
				$("#search").append('<li>이동수단<div class="btn btn-default" id="walk">'
						+'<img src="../img/running (1).png" width="15px" height="15px">도보'
						+'</div></li>');
				$('#routesNav').append('<div id="nav1">'+'총거리:'+distan.toFixed(2)	+'km<br>소요시간:'+timewaste+'분<br>이동속도:'+jsonObject.result.summary.speed+'km')+'</div>';
			}
		}
	})
};

function button1_start(starty, startx){
	if(startMark == null){
		startMark = new naver.maps.Marker({
			title: '출발지',
			animation: 2,
			icon: {
				url: '../img/startpoint.png',
				anchor: new naver.maps.Point(0, 42)
			},
			position: new naver.maps.LatLng(starty, startx),
			map: map
		});
	}else{
		startMark.setPosition(new naver.maps.LatLng(starty, startx));
	}
	naver.maps.Event.addListener(startMark, 'click', getRecommend(startMark));
}

function button2_via(vialatlng){
	if(markerIndex > 5){
		alert("경유지는 5개까지만 설정 가능합니다.");
	}else{
		var viaMark = new naver.maps.Marker({
			title: '경유지',
			animation: 2,
			icon: {
				url: '../img/via'+markerIndex+'.png',
				anchor: new naver.maps.Point(0, 44)
			},
			position: vialatlng,
			map: map
		});
		naver.maps.Event.addListener(viaMark, 'click', getRecommend(viaMark));
		viaMarkList.push(viaMark);
		if(markerIndex < 6){
			markerIndex += 1;
		}
	}
}

function button3_end(endy, endx){
	if(endMark == null){
		endMark = new naver.maps.Marker({
			title: '도착지',
			icon: {
				url: '../img/endpoint.png',
				anchor: new naver.maps.Point(0, 42)
			},
			animation: 2,
			position: new naver.maps.LatLng(endy, endx),
			map:map
			
		});
	}else{
		endMark.setPosition(new naver.maps.LatLng(endy, endx));
	}
	naver.maps.Event.addListener(endMark, 'click', getRecommend(endMark));
}

function button4_reset(){
	daumCoordList = new Array();
	latYlngXList = new Array();
	addressList = new Array();
	
	startMark.setMap(null);
	startMark = null;
	for(var i=0; i<viaMarkList.length; i++){
		viaMarkList[i].setMap(null);
	}
	viaMarkList = new Array();
	for(var i=0; i<viaMarkImage.length; i++){
		viaMarkImage[i].setMap(null);
	}
	viaMarkImage = new Array();
	markerIndex = 1;
	endMark.setMap(null);
	endMark = null;
	
	polyline.setMap(null);
	polyline = new naver.maps.Polyline({
		map: map,
		path: [],
		strokeWeight : 7,
		strokeOpacity : 0.6,
		strokeColor : '#1478FF'
	})
	$("#search").empty();
	$('#routesNav').empty();
}

function getRecommend(marker){
	return function(e){
//		console.log(marker.getPosition().y);
//		console.log(marker.getPosition().x);
		latY = marker.getPosition().y;
		lngX = marker.getPosition().x;
		findingPlace("12", "1");
		findingStay("32", "1");
	}
}

function transNaverListToLatLngList(naverCoordList){ //네이버좌표리스트를 좌표리스트로
	var resultArray = new Array(); //반환할 결과값 좌표리스트
	var splitTmpList = naverCoordList.split(" "); //x,y x,y x,y 로 되어있는걸 x,y로 짜르는 작업
	for(var i=0; i<splitTmpList.length; i++){
		var splitXY;
		if(splitTmpList.length < 5){ //속도상승을 위해 곡선 좌표개수별로 몇번에 한번찍을지 판단
			if(i%2 == 0){
				splitXY = splitTmpList[i].split(",");
			}
		}else if(splitTmpList.length < 10){
			if(i%4 == 0){
				splitXY = splitTmpList[i].split(",");
			}
		}else{
			if(i%5 == 0){
				splitXY = splitTmpList[i].split(",");
			}
		}
		resultArray.push(naver.maps.TransCoord.fromNaverToLatLng(naver.maps.Point(splitXY[0], splitXY[1])));
	}
	return resultArray;
}

function transLatLngListToDaumList(latlngList){ //좌표리스트를 다음좌표리스트로
	for(var i=0; i<latlngList.length; i++){
		var splitXY = new daum.maps.LatLng(latlngList[i].split("/")[0], latlngList[i].split("/")[1]);
		daumCoordList.push(splitXY.toCoords().jb+"/"+splitXY.toCoords().ib);
	}
}

function searchAddressByLatLng(addressLatLng){
	naver.maps.Service.reverseGeocode({
		location: addressLatLng,
		coordType: naver.maps.Service.CoordType.LATLNG
	}, function(status, response){
		if(status === naver.maps.Service.Status.ERROR){
			return alert("잘못되었습니다.");
		}
		address = response.result.items[0].address;
		console.log(address);
	});
}

function searchRouteByNaver(){
	if(viaMarkImage.length > 0){
		for(var i=0; i<viaMarkImage.length; i++){
			viaMarkImage[i].setMap(null);
		}
		viaMarkImage = new Array();
	}
	
	var lineArray = new Array();
	
	console.log(jsonObject.routes[routesindex]);
	
	for(var i=0; i<jsonObject.routes[routesindex].legs.length; i++){
		for(var j=0; j<jsonObject.routes[routesindex].legs[i].steps.length; j++){
			if(jsonObject.routes[routesindex].legs[i].steps[j].steps != null){
				for(var k=0; k < jsonObject.routes[routesindex].legs[i].steps[j].steps.length; k++){
					if(jsonObject.routes[routesindex].legs[i].steps[j].steps[k].path != ""){
						var pathArray = transNaverListToLatLngList(jsonObject.routes[routesindex].legs[i].steps[j].steps[k].path);
						Array.prototype.push.apply(lineArray, pathArray);
					};
				};
			}else{
				if(jsonObject.routes[routesindex].legs[i].steps[j].path != ""){
					var pathArray = transNaverListToLatLngList(jsonObject.routes[routesindex].legs[i].steps[j].path);
					Array.prototype.push.apply(lineArray, pathArray);
				};
			};
		};
	};
	polyline.setPath(lineArray);
}

function searchRouteByNaverWalking(){
	if(viaMarkImage.length > 0){
		for(var i=0; i<viaMarkImage.length; i++){
			viaMarkImage[i].setMap(null);
		}
		viaMarkImage = new Array();
	}
	
	var lineArray = new Array();
	
	for(var i=0; i<jsonObject.result.route[0].point.length; i++){
		if(jsonObject.result.route[0].point[i].path != ""){
			var pathArray = transNaverListToLatLngList(jsonObject.result.route[0].point[i].path);
			Array.prototype.push.apply(lineArray, pathArray);
		};
	};
	polyline.setPath(lineArray);
}

function searchRouteByDaum(){
	$('.selectRoute').empty();
	var lineArray = new Array();
	
	if(viaMarkImage.length > 0){
		for(var i=0; i<viaMarkImage.length; i++){
			viaMarkImage[i].setMap(null);
		}
		viaMarkImage = new Array();
	}
	
	for(var j=0; j<jsonObject.in_local.routes[routesindex].steps.length; j++){
		$('#selectRoute'+routesindex).append("<hr>이동순서"+(j+1)+" : "+jsonObject.in_local.routes[routesindex].steps[j].information+"<br>");
		var whatTypeTransport = jsonObject.in_local.routes[routesindex].steps[j].type
		if(jsonObject.in_local.routes[routesindex].steps[j].startLocation != null && whatTypeTransport != null && whatTypeTransport != 'WALKING'){
			var whatUseTransport;
			var viaTmpX = jsonObject.in_local.routes[routesindex].steps[j].startLocation.x;
			var viaTmpY = jsonObject.in_local.routes[routesindex].steps[j].startLocation.y;
			var viaTmpDaumCoord = new daum.maps.Coords(viaTmpX, viaTmpY);
			if(whatTypeTransport == 'BUS'){
				whatUseTransport = '../img/bus.png';
			}else if(whatTypeTransport == 'SUBWAY'){
				whatUseTransport = '../img/subway.png';
			}
			var viaMark = new naver.maps.Marker({
				title: '대중교통',
				animation: 2,
				icon: {
					url: whatUseTransport
				},
				position: naver.maps.Point(viaTmpDaumCoord.toLatLng().ib, viaTmpDaumCoord.toLatLng().jb),
				map: map
			});
			viaMarkImage.push(viaMark);
		};
		
		if(jsonObject.in_local.routes[routesindex].steps[j].polyline != null){
			var tmpDaumCoordList = jsonObject.in_local.routes[routesindex].steps[j].polyline;
			for(var k=0; k<tmpDaumCoordList.split("|").length/2; k++){
				var tmpDaumCoord = new daum.maps.Coords(tmpDaumCoordList.split("|")[k*2], tmpDaumCoordList.split("|")[(k*2)+1]);
				lineArray.push(new naver.maps.LatLng(tmpDaumCoord.toLatLng().jb, tmpDaumCoord.toLatLng().ib));
			}
		}
	}
	polyline.setPath(lineArray);
}