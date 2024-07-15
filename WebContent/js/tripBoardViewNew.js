var dailyInfomation;
var polylineArray;

var startMark; //출발지마크          ☆★day별로 초기화 필요
var endMark; //도착지마크          ☆★day별로 초기화 필요
var viaMarkList; //경유지마크 리스트          ☆★day별로 초기화 필요
var markerIndex; //마크인덱스          ☆★day별로 초기화 필요
var transportMarkList; //교통갈아타기리스트          ☆★day별로 초기화 필요

var CoordList; //좌표리스트          ☆★day별로 초기화 필요
var addressList; //주소 리스트          ☆★day별로 초기화 필요

var latY; //우클릭했을때 y좌표
var lngX; //우클릭했을때 x좌표

var contentType = '12';
var restType = 'hospital';

$(document).ready(function(){
	$.ajaxSettings.traditional = true;
	$.ajaxSetup({
	    headers: {
	      'X-CSRF-Token': $('meta[name="csrf_token"]').attr('content')
	    }
	});
	$.ajax({
		type:"POST",
		url:"../common/readOneTripBoardAllDailyTrip",
		data: {
			trip_board_num : $("#trip_board_num").val()
		},
		success:function(data){
			console.log(data);
			dailyInfomation = data;
			for(var i=0; i < dailyInfomation.length; i++){
				$(".travelDays").append('<div class="days" id="days'+i+'" onclick="dailyTripMaker('+i+')">'+(i+1)+'일'+'</div>');
			}
			$(".tripBoard").append(
				'<div class="tripBoardMemo">'
				+'	<span>메모!</span>'
				+'	<textarea name="trip_board_memo" rows="8" readonly>'+$("#trip_board_memo").val()+'</textarea>'
				+'</div>'
			);
			dailyTripMaker('0');
			swal("지도 위 마커를 클릭하시면 주변 정보를 얻으실 수 있습니다.");
		},
		error:function(msg){
			swal("게시물을 못불러왔어요 ㅠㅠ");
		}
	})
	$(".recruitList").hide();
	$(".dropdown-menu").hide();
});

function dailyTripMaker(day){
	$(".days").removeClass("divActive");
	$("#days"+day).addClass("divActive");
	$(".timeTable").empty();
	$(".place").empty();
	$(".roadInfo").empty();
	$(".mapForm").empty();
	$(".stay").empty();
	$(".rest").empty();
	
	if(typeof polylineArray != "undefined"){
		for(var i=0; i<polylineArray.length; i++){
			polylineArray[i].setMap(null);
			polylineArray = new Array();
		}
	}else{
		polylineArray = new Array();
	}
	
	if(typeof viaMarkList != "undefined"){
		for(var i=0; i<viaMarkList.length; i++){
			viaMarkList[i].setMap(null);
			viaMarkList = new Array();
		}
	}else{
		viaMarkList = new Array();
	}
	
	if(typeof transportMarkList != "undefined"){
		for(var i=0; i<transportMarkList.length; i++){
			transportMarkList[i].setMap(null);
			transportMarkList = new Array();
		}
	}else{
		transportMarkList = new Array();
	}
	
	
	
	if(typeof startMark != "undefined"){
		startMark.setMap(null);
	}else{
		startMark = null;
	}
	
	if(typeof endMark != "undefined"){
		endMark.setMap(null);
	}else{
		endMark = null;
	}
	
	markerIndex = 1;
	
	$(".timeTable").append(
		'<div class="dailyTime" id="time09" ondrop="dropCopy(event)" ondragover="allowDropCopy(event)">&nbsp;&nbsp;오전9시'
//		+'	<input type="text" class="inputMemoForm" readonly="readonly" name="daily_trip_time09_memo" value="'+dailyInfomation[day].daily_trip_time09_memo+'">'
		+'	<textarea class="inputMemoForm" readonly="readonly" name="daily_trip_time09_memo">'+dailyInfomation[day].daily_trip_time09_memo+'</textarea>'
		+'	<input type="hidden" name="daily_trip_time09_address" value="'+dailyInfomation[day].daily_trip_time09_address+'">'
		+'	<input type="hidden" name="daily_trip_time09_laty" value="'+dailyInfomation[day].daily_trip_time09_laty+'">'
		+'	<input type="hidden" name="daily_trip_time09_lngx" value="'+dailyInfomation[day].daily_trip_time09_lngx+'">'
		+'</div>'
		+'<div class="dailyTime" id="time11" ondrop="dropCopy(event)" ondragover="allowDropCopy(event)">&nbsp;&nbsp;오전11시'
//		+'	<input type="text" class="inputMemoForm" readonly="readonly" name="daily_trip_time11_memo" value="'+dailyInfomation[day].daily_trip_time11_memo+'">'
		+'	<textarea class="inputMemoForm" readonly="readonly" name="daily_trip_time11_memo">'+dailyInfomation[day].daily_trip_time11_memo+'</textarea>'
		+'	<input type="hidden" name="daily_trip_time11_address" value="'+dailyInfomation[day].daily_trip_time11_address+'">'
		+'	<input type="hidden" name="daily_trip_time11_laty" value="'+dailyInfomation[day].daily_trip_time11_laty+'">'
		+'	<input type="hidden" name="daily_trip_time11_lngx" value="'+dailyInfomation[day].daily_trip_time11_lngx+'">'
		+'</div>'
		+'<div class="dailyTime" id="time13" ondrop="dropCopy(event)" ondragover="allowDropCopy(event)">&nbsp;&nbsp;오후1시'
//		+'	<input type="text" class="inputMemoForm" readonly="readonly" name="daily_trip_time13_memo" value="'+dailyInfomation[day].daily_trip_time13_memo+'">'
		+'	<textarea class="inputMemoForm" readonly="readonly" name="daily_trip_time13_memo">'+dailyInfomation[day].daily_trip_time13_memo+'</textarea>'
		+'	<input type="hidden" name="daily_trip_time13_address" value="'+dailyInfomation[day].daily_trip_time13_address+'">'
		+'	<input type="hidden" name="daily_trip_time13_laty" value="'+dailyInfomation[day].daily_trip_time13_laty+'">'
		+'	<input type="hidden" name="daily_trip_time13_lngx" value="'+dailyInfomation[day].daily_trip_time13_lngx+'">'
		+'</div>'
		+'<div class="dailyTime" id="time15" ondrop="dropCopy(event)" ondragover="allowDropCopy(event)">&nbsp;&nbsp;오후3시'
//		+'	<input type="text" class="inputMemoForm" readonly="readonly" name="daily_trip_time15_memo" value="'+dailyInfomation[day].daily_trip_time15_memo+'">'
		+'	<textarea class="inputMemoForm" readonly="readonly" name="daily_trip_time15_memo">'+dailyInfomation[day].daily_trip_time15_memo+'</textarea>'
		+'	<input type="hidden" name="daily_trip_time15_address" value="'+dailyInfomation[day].daily_trip_time15_address+'">'
		+'	<input type="hidden" name="daily_trip_time15_laty" value="'+dailyInfomation[day].daily_trip_time15_laty+'">'
		+'	<input type="hidden" name="daily_trip_time15_lngx" value="'+dailyInfomation[day].daily_trip_time15_lngx+'">'
		+'</div>'
		+'<div class="dailyTime" id="time17" ondrop="dropCopy(event)" ondragover="allowDropCopy(event)">&nbsp;&nbsp;오후5시'
//		+'	<input type="text" class="inputMemoForm" readonly="readonly" name="daily_trip_time17_memo" value="'+dailyInfomation[day].daily_trip_time17_memo+'">'
		+'	<textarea class="inputMemoForm" readonly="readonly" name="daily_trip_time17_memo">'+dailyInfomation[day].daily_trip_time17_memo+'</textarea>'
		+'	<input type="hidden" name="daily_trip_time17_address" value="'+dailyInfomation[day].daily_trip_time17_address+'">'
		+'	<input type="hidden" name="daily_trip_time17_laty" value="'+dailyInfomation[day].daily_trip_time17_laty+'">'
		+'	<input type="hidden" name="daily_trip_time17_lngx" value="'+dailyInfomation[day].daily_trip_time17_lngx+'">'
		+'</div>'
		+'<div class="dailyTime" id="time19" ondrop="dropCopy(event)" ondragover="allowDropCopy(event)">&nbsp;&nbsp;오후7시'
//		+'	<input type="text" class="inputMemoForm" readonly="readonly" name="daily_trip_time19_memo" value="'+dailyInfomation[day].daily_trip_time19_memo+'">'
		+'	<textarea class="inputMemoForm" readonly="readonly" name="daily_trip_time19_memo">'+dailyInfomation[day].daily_trip_time19_memo+'</textarea>'
		+'	<input type="hidden" name="daily_trip_time19_address" value="'+dailyInfomation[day].daily_trip_time19_address+'">'
		+'	<input type="hidden" name="daily_trip_time19_laty" value="'+dailyInfomation[day].daily_trip_time19_laty+'">'
		+'	<input type="hidden" name="daily_trip_time19_lngx" value="'+dailyInfomation[day].daily_trip_time19_lngx+'">'
		+'</div>'
		+'<div class="dailyTime" id="time21" ondrop="dropCopy(event)" ondragover="allowDropCopy(event)">&nbsp;&nbsp;오후9시'
//		+'	<input type="text" class="inputMemoForm" readonly="readonly" name="daily_trip_time21_memo" value="'+dailyInfomation[day].daily_trip_time21_memo+'">'
		+'	<textarea class="inputMemoForm" readonly="readonly" name="daily_trip_time21_memo">'+dailyInfomation[day].daily_trip_time21_memo+'</textarea>'
		+'	<input type="hidden" name="daily_trip_time21_address" value="'+dailyInfomation[day].daily_trip_time21_address+'">'
		+'	<input type="hidden" name="daily_trip_time21_laty" value="'+dailyInfomation[day].daily_trip_time21_laty+'">'
		+'	<input type="hidden" name="daily_trip_time21_lngx" value="'+dailyInfomation[day].daily_trip_time21_lngx+'">'
		+'</div>'
	);
	
	$(".place").append(
			'<div class="placeNavi">'
			+'	<div class="placeOption divActive" id="12" onclick="selectPlaceRecommend(\'12\')">관광지</div>'
			+'	<div class="placeOption" id="14" onclick="selectPlaceRecommend(\'14\')">문화시설</div>'
			+'	<div class="placeOption" id="28" onclick="selectPlaceRecommend(\'28\')">레포츠</div>'
			+'	<div class="placeOption" id="39" onclick="selectPlaceRecommend(\'39\')">맛집</div>'
			+'	<div class="placeOption" id="38" onclick="selectPlaceRecommend(\'38\')">쇼핑</div>'
			+'	<div class="placeOption" id="15" onclick="selectPlaceRecommend(\'15\')">각종행사</div>'
			+'</div>'
	);
	
	$(".place").append(
			'<div class="placeRecommendList">'
			+'</div>'
	);
	
	$(".place").append(
			'<div class="placeRecommendListPaging">'
			+'</div>'
	);
	
	
	$(".roadInfo").append(
		'<div class="transportNaviHeader">'
		+'	<div class="transportNavi divActive">길찾기</div>'
		+'</div>'
	);
	
	$(".roadInfo").append(
		'<div class="roadFinderForm">'
		+'</div>'
	);
	
	$(".mapForm").append(
			'<div class="mapNaviHeader">'
			+'	<div class="mapNavi divActive">지도</div>'
			+'	<div class="addressTextSearchForm">'
			+'		<input type="text" id="textSearcher" placeholder="도로명주소만 가능!ex)강남대로 396">'
			+'		<input type="button" id="textSearcherButton" onclick="textSearching()" value="검색">'
			+'	</div>'
			+'</div>'
		);
	
	$(".mapForm").append(
		'<div id="map">'
		+'	<div>'
		+'		<input type="checkbox" name="placeMarkerCheck" onclick="placeHideAndShow()" class="subMarkerOption" title="관광마커표시" value="관광" checked="checked">'
		+'		<input type="checkbox" name="stayMarkerCheck" onclick="stayHideAndShow()" class="subMarkerOption" title="숙박마커표시" value="숙박">'
		+'		<input type="checkbox" name="restMarkerCheck" onclick="restHideAndShow()" class="subMarkerOption" title="편의마커표시" value="편의">'
		+'	</div>'
		+'</div>'
	);
	
	$('#whatTime').hide();
	
	$(".stay").append(
		'<div class="stayForm">'
		+'</div>'
	);
	
	$(".rest").append(
		'<div class="restForm">'
		+'	<div class="restNavi">'
		+'		<div class="restOption divActive" id="" onclick="selectRestRecommend(\'hospital\')">병원</div>'
		+'		<div class="restOption" id="conveniencestore" onclick="selectRestRecommend(\'conveniencestore\')">편의점</div>'
		+'		<div class="restOption" id="gasstation" onclick="selectRestRecommend(\'gasstation\')">주유소</div>'
		+'	</div>'
		+'	<div class="restList">'
		+'	</div>'
		+'</div>'
	);
	
	CoordList = new Array();
	addressList = new Array();
	
	if(dailyInfomation[day].daily_trip_time09_laty != 0){
		var tmpPoint = new naver.maps.LatLng(dailyInfomation[day].daily_trip_time09_laty, dailyInfomation[day].daily_trip_time09_lngx);
		CoordList.push(tmpPoint);
		addressList.push(dailyInfomation[day].daily_trip_time09_address);
	}
	if(dailyInfomation[day].daily_trip_time11_laty != 0){
		var tmpPoint = new naver.maps.LatLng(dailyInfomation[day].daily_trip_time11_laty, dailyInfomation[day].daily_trip_time11_lngx);
		CoordList.push(tmpPoint);
		addressList.push(dailyInfomation[day].daily_trip_time11_address);
	}
	if(dailyInfomation[day].daily_trip_time13_laty != 0){
		var tmpPoint = new naver.maps.LatLng(dailyInfomation[day].daily_trip_time13_laty, dailyInfomation[day].daily_trip_time13_lngx);
		CoordList.push(tmpPoint);
		addressList.push(dailyInfomation[day].daily_trip_time13_address);
	}
	if(dailyInfomation[day].daily_trip_time15_laty != 0){
		var tmpPoint = new naver.maps.LatLng(dailyInfomation[day].daily_trip_time15_laty, dailyInfomation[day].daily_trip_time15_lngx);
		CoordList.push(tmpPoint);
		addressList.push(dailyInfomation[day].daily_trip_time15_address);
	}
	if(dailyInfomation[day].daily_trip_time17_laty != 0){
		var tmpPoint = new naver.maps.LatLng(dailyInfomation[day].daily_trip_time17_laty, dailyInfomation[day].daily_trip_time17_lngx);
		CoordList.push(tmpPoint);
		addressList.push(dailyInfomation[day].daily_trip_time17_address);
	}
	if(dailyInfomation[day].daily_trip_time19_laty != 0){
		var tmpPoint = new naver.maps.LatLng(dailyInfomation[day].daily_trip_time19_laty, dailyInfomation[day].daily_trip_time19_lngx);
		CoordList.push(tmpPoint);
		addressList.push(dailyInfomation[day].daily_trip_time19_address);
	}
	if(dailyInfomation[day].daily_trip_time21_laty != 0){
		var tmpPoint = new naver.maps.LatLng(dailyInfomation[day].daily_trip_time21_laty, dailyInfomation[day].daily_trip_time21_lngx);
		CoordList.push(tmpPoint);
		addressList.push(dailyInfomation[day].daily_trip_time21_address);
	}
	
	map = new naver.maps.Map('map', {
		zoom : 8,
		minZoom : 1,
		zoomControl : true,
		zoomControlOptions : {
			position : naver.maps.Position.TOP_RIGHT
		},
		center : CoordList[0],
		mapTypeControl : true
	});
	
//	console.log("좌표 길이 : "+CoordList.length);
	
	if(CoordList.length > 0){
		startMark = new naver.maps.Marker({
			title: addressList[0],
			animation: 2,
			icon: {
				url: '../img/startpoint.png',
				anchor: new naver.maps.Point(0, 42)
			},
			position: CoordList[0],
			map: map
		});
		
		latY = startMark.getPosition().y;
		lngX = startMark.getPosition().x;
		findingPlace(contentType, '1');
		findingStay('1');
		restoption(restType);
		
		naver.maps.Event.addListener(startMark, 'click', function(e) {
//			console.log(startMark.getPosition());
			latY = startMark.getPosition().y;
			lngX = startMark.getPosition().x;
			findingPlace(contentType, '1');
			findingStay('1');
			restoption(restType);
		});
	}
	
	if(CoordList.length > 1){
		endMark = new naver.maps.Marker({
			title: addressList[addressList.length-1],
			animation: 2,
			icon: {
				url: '../img/endpoint.png',
				anchor: new naver.maps.Point(0, 42)
			},
			position: CoordList[CoordList.length-1],
			map:map
		});
	}
	naver.maps.Event.addListener(endMark, 'click', function(e) {
//		console.log(endMark.getPosition());
		latY = endMark.getPosition().y;
		lngX = endMark.getPosition().x;
		findingPlace(contentType, '1');
		findingStay('1');
		restoption(restType);
	});
	
	if(CoordList.length > 2){
		for(var k=1; k<CoordList.length-1; k++){
			var viaMark = new naver.maps.Marker({
				title: addressList[k],
				animation: 2,
				icon: {
					url: '../img/via'+markerIndex+'.png',
					anchor: new naver.maps.Point(0, 44)
				},
				position: CoordList[k],
				map: map
			});
			viaMarkList.push(viaMark);
			markerIndex += 1;
		}
		
		for(var i=0; i<viaMarkList.length; i++){
			naver.maps.Event.addListener(viaMarkList[i], 'click', viaMarkerClick(i));
		}
	}
	loadRouteFinder(dailyInfomation[day].daily_trip_index);
}

function viaMarkerClick(index){
	return function(e){
		var tmpVia = viaMarkList[index];
		latY = tmpVia.getPosition().y;
		lngX = tmpVia.getPosition().x;
		findingPlace(contentType, '1');
		findingStay('1');
		restoption(restType);
	}
}

function loadRouteFinder(dailyTripIndex){
	$.ajaxSettings.traditional = true;
	$.ajaxSetup({
	    headers: {
	      'X-CSRF-Token': $('meta[name="csrf_token"]').attr('content')
	    }
	});
	$.ajax({
		type:"POST",
		url:"../common/loadingRoad",
		data: {
			daily_trip_index : dailyTripIndex
		},
		success:function(data){
			console.log(data);
			
			if(data.length > 0){
				for(var i=0; i<data.length; i++){
					$(".roadFinderForm").append(addressList[i]);
					
					if(data[i].split("^")[0] == "pubTransport"){
						console.log("대중교통");
						drawingRouteLine(data[i].split("^")[0], searchRouteByDaum(JSON.parse(data[i].split("^")[2]), data[i].split("^")[1]));
						$(".roadFinderForm").append('<br>↓<br><div class="transportOption pubTransport" onclick="#">대중교통</div><br>↓<br>');
					}else if(data[i].split("^")[0] == "walk"){
						console.log("걷기");
						drawingRouteLine(data[i].split("^")[0], searchRouteByNaverWalking(JSON.parse(data[i].split("^")[2]), data[i].split("^")[1]));
						$(".roadFinderForm").append('<br>↓<br><div class="transportOption walk" onclick="#">도보</div><br>↓<br>');
					}else if(data[i].split("^")[0] == "car"){
						console.log("차");
						drawingRouteLine(data[i].split("^")[0], searchRouteByNaver(JSON.parse(data[i].split("^")[2]), data[i].split("^")[1]));
						$(".roadFinderForm").append('<br>↓<br><div class="transportOption car" onclick="#">자동차</div><br>↓<br>');
					}else{
						console.log("자전거");
						drawingRouteLine(data[i].split("^")[0], searchRouteByNaver(JSON.parse(data[i].split("^")[2]), data[i].split("^")[1]));
						$(".roadFinderForm").append('<br>↓<br><div class="transportOption bicycle" onclick="#">자전거</div><br>↓<br>');
					}
				}
				$(".roadFinderForm").append(addressList[addressList.length-1]);
			}else{
				$(".roadFinderForm").empty();
				$(".roadFinderForm").append(
						'<span>작성자가 이날의 길찾기 경로를<br>등록하지 않았습니다.</span>'
				);
			}
		},
		error:function(msg){
			swal("작성하신 길찾기 정보가 없습니다.");
		}
	})
}


function searchRouteByNaver(jsonFile, selectIndex){ //네이버 길찾기
	var jsonObject = jsonFile;
//	$(".selectRoute").removeClass("divActive");
//	$("#selectRoute"+selectIndex).addClass("divActive");
	routesindex = selectIndex;
	
	var lineArray = new Array();
	
//	console.log(jsonObject.routes[routesindex]);
	
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
	return lineArray;
}

function searchRouteByNaverWalking(jsonFile, selectIndex){ //네이버길찾기(도보)
	var jsonObject = jsonFile;
	
	var lineArray = new Array();
	
	for(var i=0; i<jsonObject.result.route[selectIndex].point.length; i++){
		if(jsonObject.result.route[selectIndex].point[i].path != ""){
			var pathArray = transNaverListToLatLngList(jsonObject.result.route[0].point[i].path);
			Array.prototype.push.apply(lineArray, pathArray);
		};
	};
//	polyline.setPath(lineArray);
	return lineArray;
}

function searchRouteByDaum(jsonFile, selectIndex){ //다음길찾기(대중교통)
	var jsonObject = jsonFile;
	routesindex = selectIndex;
	var lineArray = new Array();
	
	if(jsonObject.in_local_status == "RESULT_NOT_FOUND"){ //인로컬 없을때
		if(jsonObject.inter_local_status == "OK"){
			console.log("인터로컬");
			for(var i=0; i<jsonObject.inter_local.routes[routesindex].sectionRoutes.length; i++){
				if(jsonObject.inter_local.routes[routesindex].sectionRoutes[i].polyline != null){
					var tmpDaumCoordList = jsonObject.inter_local.routes[routesindex].sectionRoutes[i].polyline.split("|");
					for(var k=0; k<tmpDaumCoordList.length/2; k++){
						if(tmpDaumCoordList.length < 16){
							var tmpDaumCoord = new daum.maps.Coords(tmpDaumCoordList[k*2], tmpDaumCoordList[(k*2)+1]);
							lineArray.push(new naver.maps.LatLng(tmpDaumCoord.toLatLng().jb, tmpDaumCoord.toLatLng().ib));
						}else if(tmpDaumCoordList.length < 32){
							if(k%2 == 0){
								var tmpDaumCoord = new daum.maps.Coords(tmpDaumCoordList[k*2], tmpDaumCoordList[(k*2)+1]);
								lineArray.push(new naver.maps.LatLng(tmpDaumCoord.toLatLng().jb, tmpDaumCoord.toLatLng().ib));
							}
						}else if(tmpDaumCoordList.length < 64){
							if(k%4 == 0){
								var tmpDaumCoord = new daum.maps.Coords(tmpDaumCoordList[k*2], tmpDaumCoordList[(k*2)+1]);
								lineArray.push(new naver.maps.LatLng(tmpDaumCoord.toLatLng().jb, tmpDaumCoord.toLatLng().ib));
							}
						}else if(tmpDaumCoordList.length < 128){
							if(k%8 == 0){
								var tmpDaumCoord = new daum.maps.Coords(tmpDaumCoordList[k*2], tmpDaumCoordList[(k*2)+1]);
								lineArray.push(new naver.maps.LatLng(tmpDaumCoord.toLatLng().jb, tmpDaumCoord.toLatLng().ib));
							}
						}else{
							if(k%16 == 0){
								var tmpDaumCoord = new daum.maps.Coords(tmpDaumCoordList[k*2], tmpDaumCoordList[(k*2)+1]);
								lineArray.push(new naver.maps.LatLng(tmpDaumCoord.toLatLng().jb, tmpDaumCoord.toLatLng().ib));
							}
						}
					}
				}else{
					if(jsonObject.inter_local.routes[routesindex].sectionRoutes[i].transferRoute != null){
						if(jsonObject.inter_local.routes[routesindex].sectionRoutes[i].transferRoute.status != null){
							console.log("transferRoute 있다.");
							for(var j=0; j<jsonObject.inter_local.routes[routesindex].sectionRoutes[i].transferRoute.route.steps.length; j++){
								if(typeof jsonObject.inter_local.routes[routesindex].sectionRoutes[i].transferRoute.route.steps[j].polyline != "undefined"){
									console.log("steps폴리라인 있다.");
									var tmpDaumCoordList = jsonObject.inter_local.routes[routesindex].sectionRoutes[i].transferRoute.route.steps[j].polyline.split("|");
									for(var k=0; k<tmpDaumCoordList.length/2; k++){
										if(tmpDaumCoordList.length < 16){
											var tmpDaumCoord = new daum.maps.Coords(tmpDaumCoordList[k*2], tmpDaumCoordList[(k*2)+1]);
											lineArray.push(new naver.maps.LatLng(tmpDaumCoord.toLatLng().jb, tmpDaumCoord.toLatLng().ib));
										}else if(tmpDaumCoordList.length < 32){
											if(k%2 == 0){
												var tmpDaumCoord = new daum.maps.Coords(tmpDaumCoordList[k*2], tmpDaumCoordList[(k*2)+1]);
												lineArray.push(new naver.maps.LatLng(tmpDaumCoord.toLatLng().jb, tmpDaumCoord.toLatLng().ib));
											}
										}else if(tmpDaumCoordList.length < 64){
											if(k%4 == 0){
												var tmpDaumCoord = new daum.maps.Coords(tmpDaumCoordList[k*2], tmpDaumCoordList[(k*2)+1]);
												lineArray.push(new naver.maps.LatLng(tmpDaumCoord.toLatLng().jb, tmpDaumCoord.toLatLng().ib));
											}
										}else{
											if(k%5 == 0){
												var tmpDaumCoord = new daum.maps.Coords(tmpDaumCoordList[k*2], tmpDaumCoordList[(k*2)+1]);
												lineArray.push(new naver.maps.LatLng(tmpDaumCoord.toLatLng().jb, tmpDaumCoord.toLatLng().ib));
											}
										}
									}
								}
							}
						}
					}else{
						var tmpDaumCoordDeparture = new daum.maps.Coords(jsonObject.inter_local.routes[routesindex].sectionRoutes[i].departure.x, jsonObject.inter_local.routes[routesindex].sectionRoutes[i].departure.y);
						lineArray.push(new naver.maps.LatLng(tmpDaumCoordDeparture.toLatLng().jb, tmpDaumCoordDeparture.toLatLng().ib));
						var tmpDaumCoordArrival = new daum.maps.Coords(jsonObject.inter_local.routes[routesindex].sectionRoutes[i].arrival.x, jsonObject.inter_local.routes[routesindex].sectionRoutes[i].arrival.y);
						lineArray.push(new naver.maps.LatLng(tmpDaumCoordArrival.toLatLng().jb, tmpDaumCoordArrival.toLatLng().ib));
						if(jsonObject.inter_local.routes[routesindex].sectionRoutes[i].vehicle.type == "TRAIN"){
							var viaMark = new naver.maps.Marker({
								title: "기차",
								animation: 2,
								icon: {
									url: '../img/subway.png'
								},
								position: naver.maps.LatLng(tmpDaumCoordDeparture.toLatLng().jb, tmpDaumCoordDeparture.toLatLng().ib),
								map: map
							});
							transportMarkList.push(viaMark);
						}else if(jsonObject.inter_local.routes[routesindex].sectionRoutes[i].vehicle.type.indexOf("BUS") != -1){
							var viaMark = new naver.maps.Marker({
								title: "버스",
								animation: 2,
								icon: {
									url: '../img/bus.png'
								},
								position: naver.maps.LatLng(tmpDaumCoordDeparture.toLatLng().jb, tmpDaumCoordDeparture.toLatLng().ib),
								map: map
							});
							transportMarkList.push(viaMark);
						}
					}
				}
			}
		}else{
			swal("해당지역의 경로는 제공하지 않습니다.");
		}
	}else{
		console.log("인로컬");
		for(var j=0; j<jsonObject.in_local.routes[routesindex].steps.length; j++){
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
				transportMarkList.push(viaMark);
			};
			if(jsonObject.in_local.routes[routesindex].steps[j].polyline != null){
				var tmpDaumCoordList = jsonObject.in_local.routes[routesindex].steps[j].polyline.split("|");
				for(var k=0; k<tmpDaumCoordList.length/2; k++){
					if(tmpDaumCoordList.length < 16){
						var tmpDaumCoord = new daum.maps.Coords(tmpDaumCoordList[k*2], tmpDaumCoordList[(k*2)+1]);
						lineArray.push(new naver.maps.LatLng(tmpDaumCoord.toLatLng().jb, tmpDaumCoord.toLatLng().ib));
					}else if(tmpDaumCoordList.length < 32){
						if(k%2 == 0){
							var tmpDaumCoord = new daum.maps.Coords(tmpDaumCoordList[k*2], tmpDaumCoordList[(k*2)+1]);
							lineArray.push(new naver.maps.LatLng(tmpDaumCoord.toLatLng().jb, tmpDaumCoord.toLatLng().ib));
						}
					}else if(tmpDaumCoordList.length < 64){
						if(k%4 == 0){
							var tmpDaumCoord = new daum.maps.Coords(tmpDaumCoordList[k*2], tmpDaumCoordList[(k*2)+1]);
							lineArray.push(new naver.maps.LatLng(tmpDaumCoord.toLatLng().jb, tmpDaumCoord.toLatLng().ib));
						}
					}else{
						if(k%5 == 0){
							var tmpDaumCoord = new daum.maps.Coords(tmpDaumCoordList[k*2], tmpDaumCoordList[(k*2)+1]);
							lineArray.push(new naver.maps.LatLng(tmpDaumCoord.toLatLng().jb, tmpDaumCoord.toLatLng().ib));
						}
					}
				}
			}
		}
	}
	return lineArray;
}

function drawingRouteLine(whatTrans, inputArray){
	var colorSel = "";
	
	if(whatTrans == "car"){
		colorSel = "#CD0000";
	}else if(whatTrans == "pubTransport"){
		colorSel = "#006400";
	}else if(whatTrans == "bicycle"){
		colorSel = "#0000CD";
	}else if(whatTrans == "walk"){
		colorSel = "#C15AF4";
	}
//	console.log("선택색 : "+colorSel);
	
	var polyline = new naver.maps.Polyline({ //지도에 경로그리기
		map : map,
		path : inputArray,
		strokeWeight : 7,
		strokeOpacity : 0.8,
		strokeColor : colorSel
	});
	
	polylineArray.push(polyline);
}

function modifyTripBoard(tripBoardNum){
	swal(tripBoardNum);
}

function deleteTripBoard(tripBoardNum){
//	swal(tripBoardNum);
	$.ajaxSettings.traditional = true;
	$.ajaxSetup({
	    headers: {
	      'X-CSRF-Token': $('meta[name="csrf_token"]').attr('content')
	    }
	});
	$.ajax({
		type:"POST",
		url:"../common/tripBoardDelete",
		data: {
			trip_board_num : tripBoardNum
		},
		success:function(data){
			if(data == "tripBoardBoolList"){
				swal("삭제에 성공하였습니다.");
				location.href = data;
			}else{
				swal("삭제에 실패하였습니다.");
				location.href = data;
			}
			
		}
	})
}

function recommend(upDown, tripBoardNum){
	swal(upDown);
	
	$.ajaxSettings.traditional = true;
	$.ajaxSetup({
	    headers: {
	      'X-CSRF-Token': $('meta[name="csrf_token"]').attr('content')
	    }
	});
	$.ajax({
		type:"POST",
		url:"../common/recommendUpDown",
		data: {
			upDown : upDown,
			trip_board_num : tripBoardNum
		},
		success:function(data){
			swal(data);
		}
	})
}

function selectPlaceRecommend(option){
	$(".placeOption").removeClass("divActive");
	$("#"+option).addClass("divActive");
	contentType = option;
	findingPlace(contentType, '1');
}

function selectRestRecommend(option){
	$(".restOption").removeClass("divActive");
	$("#"+option).addClass("divActive");
	restType = option;
	restoption(restType);
}

function recruitApply(){
	if($("#trip_board_nowcount").val() < $("#trip_board_finalcount").val()){
		$.ajaxSettings.traditional = true;
		$.ajaxSetup({
		    headers: {
		      'X-CSRF-Token': $('meta[name="csrf_token"]').attr('content')
		    }
		});
		$.ajax({
			url: "../common/recruitBoard",
			type:"post",
			data : {
				"trip_board_num":$("#trip_board_num").val(),
				"trip_board_member_id":$("#trip_board_member_id").val(),
			    "trip_board_member_nick":$("#trip_board_member_nick").val(),
			    "trip_board_recruit_id":$("#member_id").val(),
			    "trip_board_recruit_nick":$("#member_nick").val()
			},
			success : function(data){
				if(data == "성공"){
					swal("참가신청이 완료되었습니다!");
					stompClient.send("/client/message/"+ $("#member_id").val() + "/" + $("#trip_board_member_id").val(),
							{}, $("#trip_board_num").val()+"/\""+$("#trip_board_title").val()+"\"글에 참가신청이 왔습니다.");
				}else{
					swal(data);
				}
			}
		})
	}else{
		swal("참가인원이 마감되었어요~ㅠ");
	}
}

function recruitListHide(){
	$(".recruitList").hide();
}

function callRecruitList(tripBoardNum){
	$(".recruitList").show();
	
	$(".recruitListTable").empty();
	
	$.ajaxSettings.traditional = true;
	$.ajaxSetup({
	    headers: {
	      'X-CSRF-Token': $('meta[name="csrf_token"]').attr('content')
	    }
	});
	$.ajax({
		url: "../common/recruitListByBoardNum",
		type:"post",
		data : {
			"trip_board_num":tripBoardNum,
		},
		success : function(data){
			console.log(data);
			$(".recruitListTable").append(
				'<tr>'
				+'	<th>No.</th>'
				+'	<th>신청자</th>'
				+'	<th class="recruitDate">신청날짜</th>'
				+'	<th>수락여부</th>'
				+'	<th class="recruitListHide" onclick="recruitListHide()">목록닫기</th>'
				+'</tr>'
			);
			for(var i=0; i<data.length; i++){
				var msg;
				if(data[i].recruit_accept > 0){
					msg="<td colspan='2'>파티원입니다.</td>"
				}else{
					msg="<td colspan='2'>"
						+"	<input type='button' class='lastButton' onclick='recruitAcceptDeny("+$("#trip_board_num").val()+", "+data[i].recruit_index+", \"accept\")' value='수락'>"
						+"	<input type='button' class='lastButton' onclick='recruitAcceptDeny("+$("#trip_board_num").val()+", "+data[i].recruit_index+", \"deny\")' value='거절'>"
						+"</td>"
				}
				$(".recruitListTable").append(
						'<tr>'
						+'	<td>'+(i+1)+'</td>'
						+'	<td>'+data[i].trip_board_recruit_nick+'</td>'
						+'	<td>'+data[i].recruit_regdate+'</td>'
						+msg
						+'</tr>'
				);
			}
		}
	})
}

function recruitAcceptDeny(tripBoardNum, recruit_index, how){
	console.log(recruit_index);
	console.log(how);
	$.ajaxSettings.traditional = true;
	$.ajaxSetup({
	    headers: {
	      'X-CSRF-Token': $('meta[name="csrf_token"]').attr('content')
	    }
	});
	$.ajax({
		url: "../common/recruitAcceptDeny",
		type:"post",
		data : {
			"trip_board_num":tripBoardNum,
			"recruit_index":recruit_index,
			"acceptDeny":how
		},
		success : function(data){
			swal(data);
			callRecruitList($("#trip_board_num").val());
		}
	})
}

function dropDownShow(){
	if(typeof $("#member_id").val() != "undefined"){
		if($(".dropdown-menu").css("display") == "none") {
			$(".dropdown-menu").show();
		}else{
			$(".dropdown-menu").hide();
		}
	}else{
		swal("로그인 후 사용할 수 있는 기능입니다!");
	}
}

function addRelation(id,relation){
	$(".dropdown-menu").hide();
	$(".reply-subMenu").remove();
	
	if(id == $("#member_id").val()){
		swal("본인 아이디를 친구추가나 차단할 수 없습니다.");
		return false;
	}
	$.ajaxSettings.traditional = true;
	$.ajaxSetup({
	    headers: {
	      'X-CSRF-Token': $('meta[name="csrf_token"]').attr('content')
	    }
	});
	$.ajax({
		url:"../common/addRelation",
		type:"post",
		data : {
			"member_id":$("#member_id").val(),
			"relation_id":id,
			"member_relation":relation
		},
		dataType:"json",
		success : function(data){
			if(data.result){
				if(relation == "friend"){
					swal("친구 등록 성공");
				}else{
					swal("차단 등록 완료");
				}
			}else{
				if(data.checkRela == null){
					swal("등록 실패");	
				}else{
					if(data.checkRela == "friend"){
						if(relation=="friend"){
							swal("이미 친구로 등록되어 있습니다.");
						}else{
							swal("차단하려면 먼저 친구 삭제를 해야합니다.");
						}
					}else{
						if(relation=="friend"){
							swal("친구로 등록하려면 차단을 먼저 해제하세요.")	
						}else{
							swal("이미 차단되어 있습니다.");
						}
					}
				}
			}
		}
	})		
}

function newMessage(receive_id, receive_nick){
	$(".dropdown-menu").hide();
	$(".reply-subMenu").remove();
	
	var form = $("<form>");
	form.attr("id", "newMessageForm")
	form.attr("method", "post");
	form.attr("action", "../common/newMessage");
	form.attr("target", "newMessage");
	$(document.body).append(form);
	
	var input1 = $("<input>");
	input1.attr("type", "hidden");
	input1.attr("name", "message_receive_id");
	input1.attr("value", receive_id);
	form.append(input1);
	
	var input2 = $("<input>");
	input2.attr("type", "hidden");
	input2.attr("name", "message_receive_nick");
	input2.attr("value", receive_nick);
	form.append(input2);
	
	var input3 = $("<input>");
	input3.attr("type", "hidden");
	input3.attr("name", "_csrf");
	input3.attr("value", $('meta[name="csrf_token"]').attr('content'));
	form.append(input3);
	
	window.open("", "newMessage", "width=441 height=538");
	$("#newMessageForm").submit();
}
//------------------------------좌표변환파트시작------------------------------//

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

function transOneLatLngToDaumCoord(coords){
	var daumTmp = new daum.maps.LatLng(coords.latY, coords.lngX);
	coords.jb = daumTmp.toCoords().jb;
	coords.ib = daumTmp.toCoords().ib;
	return coords
}

//------------------------------좌표변환파트끝------------------------------//