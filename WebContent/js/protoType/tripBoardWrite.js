/*
	lat = jb = y
	lng = ib = x
	다음좌표 순서는 ib, jb이지만
	naver.maps.Point(x, y)
	daum.maps.LatLng(y, x).toCoords().jb or ib
	daum.maps.Coords(x, y)
*/

//-----------------변수선언시작-----------------
var map = new naver.maps.Map('map', {
	zoom : 8,
	minZoom : 1,
	zoomControl : true,
	zoomControlOptions : {
		position : naver.maps.Position.TOP_RIGHT
	},
	mapTypeControl : true
});


var subMenuString = [ '<div class="subMenu">',
	'<input type="button" id="btn1" onclick="button1_start()" value="출발">',
	'<input type="button" id="btn2" onclick="button2_via()" value="경유">',
	'<input type="button" id="btn3" onclick="button3_end()" value="도착">',
	'<input type="button" id="btn4" onclick="button4_reset()" value="리셋">',
	'</div>' ].join('');

var subMenu = new naver.maps.InfoWindow({
	content: subMenuString,
	maxWidth: 1250,
	backgroundColor: "",
	borderWidth: 3,
	borderColor: "black"
});

var road_finder_transport_type = "0"; //0:자동차(default), 1:대중교통, 2:자전거, 3:도보

var daumCoord; //다음좌표(jb, ib)
var latYlngX; //좌표(y, x)
var latY; //임시변수요@@@@@@@@@@@@@@@@@@@@@@@
var lngX; //임시변수요@@@@@@@@@@@@@@@@@@@@@@@
var address; //도로명주소
var daumCoordList = new Array(); //다음좌표리스트
var latYlngXList = new Array(); //좌표리스트
var addressList = new Array(); //주소리스트
var startIndex; //리스트 내 출발지인덱스
var endIndex; //리스트 내 도착지인덱스

var allDailyTrip = new Array();

var startMark = null; //출발지마크
var endMark = null; //도착지마크
var viaMarkList = new Array(); //경유지마크 리스트
var viaMarkImage = new Array();
var markerIndex = 1; //마크인덱스

var setdailyinputtext = 0;
var routesindex =0;//선택루트인덱스
var jsonObject;//java에서 넘어오는 json객체

var polyline = new naver.maps.Polyline({ //지도에 경로그리기
	map : map,
	path : [],
	strokeWeight : 7,
	strokeOpacity : 0.6,
	strokeColor : '#1478FF'
});
//-----------------변수선언끝-----------------


//-----------------이벤트등록시작-----------------
naver.maps.Event.addListener(map, 'click', function(e) {
	subMenu.close();
});

naver.maps.Event.addListener(map, 'rightclick', function(e) {
	latYlngX = e.coord //좌표값 저장
	latY = latYlngX.y //임시변수요@@@@@@@@@@@@@@@@@@@@@@@
	lngX = latYlngX.x //임시변수요@@@@@@@@@@@@@@@@@@@@@@@
	daumCoord = new daum.maps.LatLng(latYlngX.y, latYlngX.x).toCoords(); //다음좌표값 저장
	searchAddressByLatLng(latYlngX); //좌표에따른 도로명주소
	console.log("latYlngX:" + latYlngX);
	console.log("daumCoord:" + daumCoord);
	subMenu.open(map, e.coord);
	findingPlace('12', '1');
	findingStay('32', '1');
});
//-----------------이벤트등록끝-----------------


//-----------------function시작-----------------
function selectTansportType(type){ //이동수단 선택
	road_finder_transport_type = type.toString();
	console.log(road_finder_transport_type);
	
	if(startMark != null && endMark != null){
		searchStart();
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

function searchAddressByLatLng(addressLatLng){ //좌표로 주소찾기
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

function button1_start(){ //출발지 마크찍기
	if(startMark == null){
		startMark = new naver.maps.Marker({
			title: '출발지',
			animation: 2,
			icon: {
				url: '../img/startpoint.png',
				anchor: new naver.maps.Point(0, 42)
			},
			position: latYlngX,
			map: map
		});
		latYlngXList.push(latYlngX.y+"/"+latYlngX.x);
		addressList.push(address);
		startIndex = latYlngXList.length-1;
	}else{
		startMark.setPosition(latYlngX);
		latYlngXList.splice(startIndex, 1, latYlngX);
		addressList.splice(startIndex, 1, address);
	}
	$(".daily_trip_start"+setdailyinputtext).val(address);
	
	if(startMark != null && endMark != null){
		searchStart();
	}
	subMenu.close();
}

function button2_via(){ //경유지 마크찍기
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
			position: latYlngX,
			map: map
		});
		viaMarkList.push(viaMark);
		latYlngXList.push(latYlngX.y+"/"+latYlngX.x);
		addressList.push(address);
		if(markerIndex < 6){
			markerIndex += 1;
		}
	}
	$(".daily_trip_via"+setdailyinputtext).val(address);
	subMenu.close();
}

function button3_end(){ //도착지 마크찍기
	if(endMark == null){
		endMark = new naver.maps.Marker({
			title: '도착지',
			icon: {
				url: '../img/endpoint.png',
				anchor: new naver.maps.Point(0, 42)
			},
			animation: 2,
			position: latYlngX,
			map:map
			
		});
		latYlngXList.push(latYlngX.y+"/"+latYlngX.x);
		addressList.push(address);
		endIndex = latYlngXList.length-1;
	}else{
		endMark.setPosition(latYlngX);
		latYlngXList.splice(endIndex, 1, latYlngX);
		addressList.splice(endIndex, 1, address);
	}
	$(".daily_trip_end"+setdailyinputtext).val(address);
	
	if(startMark != null && endMark != null){
		searchStart();
	}
	subMenu.close();
}

function button4_reset(){ //길찾기 리셋
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
	$('#routesNav').empty();
	subMenu.close();
}

function searchStart(){ //길찾기 시작
	if(road_finder_transport_type == "1"){
		transLatLngListToDaumList(latYlngXList);
	}
	
	//길찾기 데이터(dailyData) 보내는 순서 : 교통수단, 다음좌표리스트, 좌표리스트, 주소리스트, 시작인덱스, 끝인덱스
	var dailyData = new Array();
	dailyData.push(road_finder_transport_type);
	dailyData.push(daumCoordList);
	dailyData.push(latYlngXList);
	dailyData.push(addressList);
	dailyData.push(startIndex);
	dailyData.push(endIndex);
	
	console.log(dailyData);
	
	$.ajaxSettings.traditional = true;
	$.ajaxSetup({
	    headers: {
	      'X-CSRF-Token': $('meta[name="csrf_token"]').attr('content')
	    }
	});
	$.ajax({
		type:"POST",
		url:"../common/routeFinder",
		data: {
			dailyData:dailyData
		},
		dataType:"text",
		success:function(data){
			jsonObject=JSON.parse(data);
			console.log(jsonObject);
			var startAddr;
			var viaAddr = "";
			var endAddr;
			var distan;
			var timewaste;
			
			$('#routesNav').empty();
			
			if(road_finder_transport_type == "1"){//다음
				startAddr = jsonObject.in_local.start.name;
				endAddr = jsonObject.in_local.end.name;
				$('#routesNav').append('<br><br><br><div id="nav0">'+'출발지 : '+startAddr+'<br><br>도착지 : '+endAddr+'</div><br><br>');
				
				for(var z=0; z<jsonObject.in_local.routes.length; z++){
					distan = jsonObject.in_local.routes[z].distance.text;
					timewaste = jsonObject.in_local.routes[z].time.text;
					$('#routesNav').append('<div id="nav1">'+'<input type="button" onclick="searchRouteByDaum('+z+')" value="경로'+(z+1)+
					'">총거리:'+distan+' / 소요시간:'+timewaste+'<br><div class="selectRoute" id="selectRoute'+z+'"></div>'+'</div>');
				}
				searchRouteByDaum(0);
			}else{//네이버
				if(road_finder_transport_type == "3"){ //걷기의 경우 변수명이 약간 다름
					startAddr = jsonObject.result.summary.startPoint.name;
					endAddr = jsonObject.result.summary.endPoint.name;
					distan = (jsonObject.result.summary.totalDistance)/1000;
					timewaste = jsonObject.result.summary.totalTime;
					$('#routesNav').append('<br><br><br><div id="nav0">'+'출발지 : '+startAddr+'<br>'+viaAddr+'<br>'+'도착지 : '+endAddr+'</div><br><br>');
					$('#routesNav').append('<div id="nav1">'+'총거리:'+distan.toFixed(2)	+'km<br>소요시간:'+timewaste+'분<br>이동속도:'+jsonObject.result.summary.speed+'km')+'</div>';
					$(".daily_trip_cost"+setdailyinputtext).val(0);
					searchRouteByNaverWalking();
				}else{ //자동차
					startAddr = jsonObject.routes[0].summary.start.address;
					endAddr = jsonObject.routes[0].summary.end.address;
					if(jsonObject.routes[0].summary.waypoints != null){
						for(var i=0; i<jsonObject.routes[0].summary.waypoints.length; i++){
							viaAddr += '<br>'+'경유지'+(i+1)+' : '+jsonObject.routes[0].summary.waypoints[i].address+'<br>';
						}
					}
					$('#routesNav').append('<br><br><br><div id="nav0">'+'출발지 : '+startAddr+'<br>'+viaAddr+'<br>'+'도착지 : '+endAddr+'</div><br><br>');
					
					for(var z=0; z < jsonObject.routes.length; z++){
						distan = (jsonObject.routes[z].summary.distance)/1000;
						timewaste = (jsonObject.routes[z].summary.duration)/60;
						$('#routesNav').append('<div id="nav1">'+'<input type="button" onclick="searchRouteByNaver('+z+')" value="경로'+(z+1)+'">총거리:'+distan.toFixed(2)
								+'km / 소요시간:'+timewaste.toFixed(2)+'분</div><br>');
					}
					searchRouteByNaver(0);
				}
			}
		},
		error:function(msg){
			alert("해당지역까지의 경로는 지원하지않습니다.");
		}
	})
}

function searchRouteByNaver(selectIndex){ //네이버 길찾기
	routesindex = selectIndex;
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
	$(".daily_trip_cost"+setdailyinputtext).val(jsonObject.routes[routesindex].summary.taxi_fare);
	polyline.setPath(lineArray);
}

function searchRouteByNaverWalking(){ //네이버길찾기(도보)
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

function searchRouteByDaum(selectIndex){ //다음길찾기(대중교통)
	routesindex = selectIndex;
	$('.selectRoute').empty();
	var lineArray = new Array();
	
	if(viaMarkImage.length > 0){
		for(var i=0; i<viaMarkImage.length; i++){
			viaMarkImage[i].setMap(null);
		}
		viaMarkImage = new Array();
	}
	
	if(jsonObject.inter_local != null){
		for(var i=0; i<jsonObject.inter_local.routes[routesindex].steps.length; i++){
			$('#selectRoute'+routesindex).append("<hr>이동순서"+(j+1)+" : "+jsonObject.in_local.routes[routesindex].steps[j].information+"<br>");
		}
	}else{
		
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
	$(".daily_trip_cost"+setdailyinputtext).val(jsonObject.in_local.routes[routesindex].fare.value);
	polyline.setPath(lineArray);
}

function saveDailydata(hiding){
	//길찾기 데이터(dailyData) 보내는 순서 : 교통수단, 다음좌표리스트, 좌표리스트, 주소리스트, 시작인덱스, 끝인덱스, 선택루트, 일일예상금액, 일일메모, json파일
	var dailyData = new Array();
	var saveJsonObject = JSON.stringify(jsonObject);
	dailyData.push(road_finder_transport_type);
	dailyData.push(daumCoordList);
	dailyData.push(latYlngXList);
	dailyData.push(addressList);
	dailyData.push(startIndex);
	dailyData.push(endIndex);
	dailyData.push(routesindex);
	dailyData.push($(".daily_trip_cost"+setdailyinputtext).val());
	dailyData.push($(".daily_trip_memo"+setdailyinputtext).val());
	dailyData.push(saveJsonObject);
	
//	allDailyTrip.push(dailyData);
	Array.prototype.push.apply(allDailyTrip, dailyData);
	button4_reset()
	$("#saveDailydata"+hiding).hide();
	setdailyinputtext += 1;
}

function board_write(){
	console.log(allDailyTrip);
	console.log($("input[name=member_id]").val());
	console.log($("input[name=member_nick]").val());
	console.log($("input[name=trip_board_title]").val());
	console.log($("input[name=trip_board_startdate]").val());
	console.log($("input[name=trip_board_enddate]").val());
	console.log($("select[name=trip_board_mancount]").val());
	console.log($("select[name=trip_board_womancount]").val());
	console.log($("select[name=trip_board_childcount]").val());
	console.log($("input[name=trip_board_recruit]").val());
	console.log($("textarea[name=trip_board_memo]").val());
	console.log($("input[name=trip_board_bool]").val());
	
	$.ajaxSettings.traditional = true;
	$.ajaxSetup({
	    headers: {
	      'X-CSRF-Token': $('meta[name="csrf_token"]').attr('content')
	    }
	});
	$.ajax({
		type:"POST",
		url:"../common/tripBoardWrite",
		data: {
			allDailyTrip:allDailyTrip,
			member_id:$("input[name=member_id]").val(),
			member_nick:$("input[name=member_nick]").val(),
			trip_board_title:$("input[name=trip_board_title]").val(),
			trip_board_startdate:$("input[name=trip_board_startdate]").val(),
			trip_board_enddate:$("input[name=trip_board_enddate]").val(),
			trip_board_mancount:$("select[name=trip_board_mancount]").val(),
			trip_board_womancount:$("select[name=trip_board_womancount]").val(),
			trip_board_childcount:$("select[name=trip_board_childcount]").val(),
			trip_board_recruit:$("input[name=trip_board_recruit]").val(),
			trip_board_memo:$("textarea[name=trip_board_memo]").val(),
			trip_board_bool:$("input[name=trip_board_bool]").val()
		},
		success:function(data){
			alert("하하");
		}
	})
}