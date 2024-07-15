//lat = jb = y
//lng = ib = x
//다음좌표 순서는 ib, jb이지만
//naver.maps.Point(x, y)
//daum.maps.LatLng(y, x).toCoords().jb or ib
//daum.maps.Coords(x, y)

var btDay; //datepicker
var daysPagingIndex;
var transportType = 'car'; //이동수단타입

// days 자료순서 0:
var subMenuString = [ '<div class="subMenu">',
	'<input type="button" class="subMenuButton" onclick="showWhatTime()" value="일정등록">',
//	'<input type="button" class="subMenuButton" onclick="callRouteModule()" value="길찾기시작">',
	'<input type="button" class="subMenuButton" onclick="searchAllStartDataSetting()" value="전체길찾기">',
	'</div>' ].join('');
var subMenu = new naver.maps.InfoWindow({
	content: subMenuString,
	backgroundColor: "transparent",
	anchorColor: "black",
	borderWidth: 0,
	borderColor: "transparent"
});

var map; //지도
var latY; //우클릭했을때 y좌표
var lngX; //우클릭했을때 x좌표
var address; //우클릭했을때 주소
var latYlngXList; //좌표리스트          ☆★day별로 초기화 필요

var polyLineArray; //경로저장어레이           ☆★day별로 초기화 필요

var startMark; //출발지마크          ☆★day별로 초기화 필요
var endMark; //도착지마크          ☆★day별로 초기화 필요
var viaMarkList; //경유지마크 리스트          ☆★day별로 초기화 필요
var markerIndex; //마크인덱스          ☆★day별로 초기화 필요

var contentType = '12';
var restType = 'hospital';
var firstEnter = true;
var alarmCheck = true;


//일차별 정보에 관련된 변수들
var daysArray; //일차별 정보를 저장하는 배열
var dayIndex = 0; //몇일차인지 인덱스
var tmpDailyTimetable; //가져온 json파일들 리스트로 저장(일차별로 저장할거고 0번째에 0일차 json전부)          ☆★day별로 초기화 필요
var tmpDailyTransportList; //길찾기할때 선택한 교통수단들 저장(일차별 저장, 0번째에 0일차 교통수단 전부)          ☆★day별로 초기화 필요
var tmpDailyJsonList; //길찾기할때 선택한 교통수단을 일단위로 임시저장하는 리스트          ☆★day별로 초기화 필요



/*----------------이벤트리스너 및 기본값 설정 시작----------------*/
$.datepicker.setDefaults({
	dateFormat : 'yy-mm-dd',
	prevText : '이전 달',
	nextText : '다음 달',
	monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월',
			'10월', '11월', '12월' ],
	monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월',
			'9월', '10월', '11월', '12월' ],
	dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
	dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
	dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
	showMonthAfterYear : true,
	yearSuffix : '년',

});

$(document).ready(function(){
	//출발날짜관련기능
	
	$("#trip_board_startdate").datepicker({
	  	minDate: 0,
		numberOfMonths: 2,
		dateFormat: 'yy-mm-dd',
		onSelect: function(selected){
			$("#trip_board_enddate").datepicker("option","minDate", selected);
		},
		onClose: function(){
			$(".tripBoardMemo").remove();
			$(".lastButton").remove();
			var start = $("#trip_board_startdate").datepicker('getDate');
			var end = $("#trip_board_enddate").datepicker('getDate');
			if(start != null && end !=null){
				var btMs = end - start;
				btDay = btMs / (1000*60*60*24)+1;
				
				swal(btDay + "일 간의 여정을 선택하셨습니다.");
				
				daysPagingIndex=0;
				$(".travelDays").empty();
				if(btDay > 3){
					$(".travelDays").append('<div class="daysPagingButton" onclick="daysPaging(\'before\')"> < </div>');
					for(var i=0; i<3; i++){
						$(".travelDays").append('<div class="days" id="days'+i+'" onclick="dailyTripMaker('+i+')">'+(i+1)+'일'+'</div>');
					}
					$(".travelDays").append('<div class="daysPagingButton" onclick="daysPaging(\'after\')"> > </div>');
				}else{
					for(var i=0; i<btDay; i++){
						$(".travelDays").append('<div class="days" id="days'+i+'" onclick="dailyTripMaker('+i+')">'+(i+1)+'일'+'</div>');
					}
				}
				daysArray = new Array(btDay);
//				console.log(daysArray);
				$(".tripBoard").append(
					'<div class="tripBoardMemo">'
					+'	<span>메모!</span>'
					+'	<textarea name="trip_board_memo" rows="8"></textarea>'
					+'</div>'
				);
				$(".form").append(
					'<input class="lastButton" type="reset" value="다시쓰기">'
					+'<input class="lastButton" type="button" onclick="boardWrite()" value="등록">'
					+'<input class="lastButton" type="button" onclick="location.href=\'./tripBoardBoolList\'" value="목록">'
				);
				dailyTripMaker(0);
			}
		}
	});
	//종료날짜관련기능
	$("#trip_board_enddate").datepicker({
		minDate: 0,
		numberOfMonths: 2,
		dateFormat: 'yy-mm-dd',
		onSelect: function(selected){
			$("#trip_board_startdate").datepicker("option","maxDate", selected);
			var date = $(this).val();
		},
		onClose: function(dateText, inst){
			$(".tripBoardMemo").remove();
			$(".lastButton").remove();
			var start = $("#trip_board_startdate").datepicker('getDate');
			var end = $("#trip_board_enddate").datepicker('getDate');
		    var btMs = end - start;
		    if(start != null && end !=null){
				var btMs = end - start;
				btDay = btMs / (1000*60*60*24)+1;
				
				swal(btDay + "일 간의 여정을 선택하셨습니다.");
				
				daysPagingIndex=0;
				$(".travelDays").empty();
				if(btDay > 3){
					$(".travelDays").append('<div class="daysPagingButton" onclick="daysPaging(\'before\')"> < </div>');
					for(var i=0; i<3; i++){
						$(".travelDays").append('<div class="days" id="days'+i+'" onclick="dailyTripMaker('+i+')">'+(i+1)+'일'+'</div>');
					}
					$(".travelDays").append('<div class="daysPagingButton" onclick="daysPaging(\'after\')"> > </div>');
				}else{
					for(var i=0; i<btDay; i++){
						$(".travelDays").append('<div class="days" id="days'+i+'" onclick="dailyTripMaker('+i+')">'+(i+1)+'일'+'</div>');
					}
				}
				daysArray = new Array(btDay);
//				console.log(daysArray);
				$(".tripBoard").append(
					'<div class="tripBoardMemo">'
					+'	<span>메모!</span>'
					+'	<textarea name="trip_board_memo" rows="8"></textarea>'
					+'</div>'
				);
				$(".form").append(
					'<input class="lastButton" type="reset" value="다시쓰기">'
					+'<input class="lastButton" type="button" onclick="boardWrite()" value="등록">'
					+'<input class="lastButton" type="button" onclick="location.href=\'./tripBoardBoolList\'" value="목록">'
				);
				dailyTripMaker(0);
			}
		} //onclose end
	});
	//날짜지우기기능
	$(document).on("click", "a[name=addStaff]", function() {
		var reset = $("tr[name=trStaff]");
		reset.remove();
		$.datepicker._clearDate($("#trip_board_startdate"));
		$.datepicker._clearDate($("#trip_board_enddate"));
	});
})
/*----------------이벤트리스너 및 기본값 설정 끝----------------*/


/*----------------function 시작----------------*/
function daysPaging(beforeAfter){
//	console.log(beforeAfter);
	if(beforeAfter == "before"){
		if(daysPagingIndex != 0){
			daysPagingIndex--;
			$(".travelDays").empty();
			$(".travelDays").append('<div class="daysPagingButton" onclick="daysPaging(\'before\')"> < </div>');
			for(var i=(daysPagingIndex*3); i<(daysPagingIndex*3)+3; i++){
				$(".travelDays").append('<div class="days" id="days'+i+'" onclick="dailyTripMaker('+i+')">'+(i+1)+'일'+'</div>');
			}
			$(".travelDays").append('<div class="daysPagingButton"onclick="daysPaging(\'after\')"> > </div>');
		}
	}else{
		if(daysPagingIndex < parseInt(btDay/3)){
//			console.log(daysPagingIndex);
//			console.log(btDay/3);
			daysPagingIndex++;
			$(".travelDays").empty();
			$(".travelDays").append('<div class="daysPagingButton" onclick="daysPaging(\'before\')"> < </div>');
			for(var i=(daysPagingIndex*3); i<(daysPagingIndex*3)+3; i++){
				if(i<btDay){
					$(".travelDays").append('<div class="days" id="days'+i+'" onclick="dailyTripMaker('+i+')">'+(i+1)+'일'+'</div>');
				}
			}
			$(".travelDays").append('<div class="daysPagingButton"onclick="daysPaging(\'after\')"> > </div>');
		}
	}
}


function dailyTripMaker(day){
	$(".days").removeClass("divActive");
	$("#days"+day).addClass("divActive");
	
	if(!firstEnter){
		saveDailydata(dayIndex);
	}
	
	$(".timeTable").empty();
	$(".place").empty();
	$(".roadInfo").empty();
	$(".mapForm").empty();
	$(".stay").empty();
	$(".rest").empty();
	
	$(".timeTable").append(
		'<div class="dailyTime" id="time09" ondrop="dropCopy(event)" ondragover="allowDropCopy(event)">&nbsp;&nbsp;오전9시'
		+'	<input type="text" name="daily_trip_time09_memo" value="" placeholder="일정을입력하세요">'
		+'	<input type="hidden" name="daily_trip_time09_address" value="">'
		+'	<input type="hidden" name="daily_trip_time09_laty" value="">'
		+'	<input type="hidden" name="daily_trip_time09_lngx" value="">'
		+'</div>'
		+'<div class="dailyTime" id="time11" ondrop="dropCopy(event)" ondragover="allowDropCopy(event)">&nbsp;&nbsp;오전11시'
		+'	<input type="text" name="daily_trip_time11_memo" value="" placeholder="일정을입력하세요">'
		+'	<input type="hidden" name="daily_trip_time11_address" value="">'
		+'	<input type="hidden" name="daily_trip_time11_laty" value="">'
		+'	<input type="hidden" name="daily_trip_time11_lngx" value="">'
		+'</div>'
		+'<div class="dailyTime" id="time13" ondrop="dropCopy(event)" ondragover="allowDropCopy(event)">&nbsp;&nbsp;오후1시'
		+'	<input type="text" name="daily_trip_time13_memo" value="" placeholder="일정을입력하세요">'
		+'	<input type="hidden" name="daily_trip_time13_address" value="">'
		+'	<input type="hidden" name="daily_trip_time13_laty" value="">'
		+'	<input type="hidden" name="daily_trip_time13_lngx" value="">'
		+'</div>'
		+'<div class="dailyTime" id="time15" ondrop="dropCopy(event)" ondragover="allowDropCopy(event)">&nbsp;&nbsp;오후3시'
		+'	<input type="text" name="daily_trip_time15_memo" value="" placeholder="일정을입력하세요">'
		+'	<input type="hidden" name="daily_trip_time15_address" value="">'
		+'	<input type="hidden" name="daily_trip_time15_laty" value="">'
		+'	<input type="hidden" name="daily_trip_time15_lngx" value="">'
		+'</div>'
		+'<div class="dailyTime" id="time17" ondrop="dropCopy(event)" ondragover="allowDropCopy(event)">&nbsp;&nbsp;오후5시'
		+'	<input type="text" name="daily_trip_time17_memo" value="" placeholder="일정을입력하세요">'
		+'	<input type="hidden" name="daily_trip_time17_address" value="">'
		+'	<input type="hidden" name="daily_trip_time17_laty" value="">'
		+'	<input type="hidden" name="daily_trip_time17_lngx" value="">'
		+'</div>'
		+'<div class="dailyTime" id="time19" ondrop="dropCopy(event)" ondragover="allowDropCopy(event)">&nbsp;&nbsp;오후7시'
		+'	<input type="text" name="daily_trip_time19_memo" value="" placeholder="일정을입력하세요">'
		+'	<input type="hidden" name="daily_trip_time19_address" value="">'
		+'	<input type="hidden" name="daily_trip_time19_laty" value="">'
		+'	<input type="hidden" name="daily_trip_time19_lngx" value="">'
		+'</div>'
		+'<div class="dailyTime" id="time21" ondrop="dropCopy(event)" ondragover="allowDropCopy(event)">&nbsp;&nbsp;오후9시'
		+'	<input type="text" name="daily_trip_time21_memo" value="" placeholder="일정을입력하세요">'
		+'	<input type="hidden" name="daily_trip_time21_address" value="">'
		+'	<input type="hidden" name="daily_trip_time21_laty" value="">'
		+'	<input type="hidden" name="daily_trip_time21_lngx" value="">'
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
			+'<br><br><br><br>'
			+'	지도에서 위치를 우클릭하시면<br>추천관광지가 등장합니다!<br>추천항목을 타임테이블로<br>드래그해보세요!'
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
		+'	<div class="findingOneDayRoute">'
		+'	</div>'
		+'	<div class="findingRouteOptionForm">'
		+'	</div>'
		+'	<div class="startArriveAddrForm">'
		+'	</div>'
		+'	<div class="explainRouteForm">'
		+'	<br><br>'
		+'	&nbsp;지도에 가고싶은 곳을<br>우클릭해서 추가 기능도<br>사용해보세요!'
		+'	</div>'
		+'</div>'
	);
	$(".findingOneDayRoute").hide();
	
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
		//modal
		+'	<div id="whatTime">'
		+'		<span>몇시에 일정을 등록할까요?</span><br>'
		+'		<div class="whatTimeButtons" onclick="timeSelect(\'time09\')">오전'
		+'		9시</div>'
		+'		<div class="whatTimeButtons" onclick="timeSelect(\'time11\')">오전'
		+'		11시</div>'
		+'		<div class="whatTimeButtons" onclick="timeSelect(\'time13\')">오후'
		+'		1시</div>'
		+'		<div class="whatTimeButtons" onclick="timeSelect(\'time15\')">오후'
		+'		3시</div>'
		+'		<div class="whatTimeButtons" onclick="timeSelect(\'time17\')">오후'
		+'		5시</div>'
		+'		<div class="whatTimeButtons" onclick="timeSelect(\'time19\')">오후'
		+'		7시</div>'
		+'		<div class="whatTimeButtons" onclick="timeSelect(\'time21\')">오후'
		+'		9시</div>'
		+'	</div>'
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
		+'	<br>'
		+'	지도에서 위치를 우클릭하시면 추천숙박지가 등장합니다!'
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
		+'		<br>'
		+'		지도에서 위치를 우클릭하시면<br>'
		+'		추천 편의시설이 등장합니다!'
		+'	</div>'
		+'</div>'
	);
	
	map = new naver.maps.Map('map', {
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
		$('#whatTime').hide();
	});
	
	naver.maps.Event.addListener(map, 'rightclick', function(e) {
		$('#whatTime').hide();
		latY = e.coord.y //임시변수요@@@@@@@@@@@@@@@@@@@@@@@
		lngX = e.coord.x //임시변수요@@@@@@@@@@@@@@@@@@@@@@@
		daumCoord = new daum.maps.LatLng(e.coord.y, e.coord.x).toCoords(); //다음좌표값 저장
		searchAddressByLatLng(e.coord); //좌표에따른 도로명주소
//		console.log("latYlngX:" + e.coord);
//		console.log("daumCoord:" + daumCoord);
		subMenu.open(map, e.coord);
		findingPlace(contentType, '1');
		findingStay('1');
		restoption(restType)
	});
	
	dailyReset();
	
	if(!firstEnter){
		loadDailydata(day);
	}
	dayIndex = day;
	firstEnter = false;
}

function dragCopy(ev){
	ev.dataTransfer.setData("id", ev.target.id);
	if(ev.target.id.indexOf("_img") != -1){
//		console.log("input삭제요망");
		$("#"+ev.target.id).prev().val("");
		$("#"+ev.target.id).prev().prev().val("");
		$("#"+ev.target.id).prev().prev().prev().val("");
		$("#"+ev.target.id).prev().prev().prev().prev().val("");
	}
}
function allowDropCopy(ev){
	ev.preventDefault();
}
function dropCopy(ev){
	ev.preventDefault();
	var dragImageId = ev.dataTransfer.getData("id");
	var checkCopy = document.getElementById(dragImageId).id+"";
	if(checkCopy.indexOf("_img") != -1){
		//이미복사
		ev.target.append(document.getElementById(dragImageId));
		ev.target.children[0].value = document.getElementById(dragImageId).title;
		ev.target.children[1].value = document.getElementById(dragImageId).title;
		ev.target.children[2].value = document.getElementById(dragImageId).alt.split("/")[0];
		ev.target.children[3].value = document.getElementById(dragImageId).alt.split("/")[1];
		var tmpIding = document.getElementById(dragImageId);
		tmpIding.id = ev.target.id+"_img";
	}else{
		//처음복사
		if(alarmCheck){
			swal("타임테이블의 사진을 더블클릭시 일정이 지워집니다!");
			alarmCheck = false;
		}
		
		var imgCopy = document.getElementById(dragImageId).cloneNode(true);
		imgCopy.id = ev.target.id+"_img";
		imgCopy.ondblclick = function(){
			$("#"+imgCopy.id).prev().val("");
			$("#"+imgCopy.id).prev().prev().val("");
			$("#"+imgCopy.id).prev().prev().prev().val("");
			$("#"+imgCopy.id).prev().prev().prev().prev().val("");
			$("#"+imgCopy.id).remove();
		}
		ev.target.append(imgCopy);
		ev.target.children[0].value = imgCopy.title;
		ev.target.children[1].value = imgCopy.title;
		ev.target.children[2].value = (imgCopy.alt+"").split("/")[0];
		ev.target.children[3].value = (imgCopy.alt+"").split("/")[1];
	}
}

function selectPlaceRecommend(option){
	$(".placeOption").removeClass("divActive");
	$("#"+option).addClass("divActive");
	contentType = option;
	findingPlace(contentType, '1');
}

function textSearching(){
	swal($("#textSearcher").val());
}

function selectRestRecommend(option){
	$(".restOption").removeClass("divActive");
	$("#"+option).addClass("divActive");
	restType = option;
	restoption(restType);
}

function showWhatTime(){
	subMenu.close();
	$('#whatTime').show();
}

function timeSelect(time){
	$('#whatTime').hide();
	if(document.getElementById(time+"_img")){
		$('#'+time+'_img').remove();
	};
	$('input[name="daily_trip_'+time+'_memo"').val(address);
	$('input[name="daily_trip_'+time+'_address"').val(address);
	$('input[name="daily_trip_'+time+'_laty"').val(latY);
	$('input[name="daily_trip_'+time+'_lngx"').val(lngX);
	
	var resultMessage = "";
	if(time == "time09"){
		resultMessage = "오전 9시";
	}else if(time == "time11"){
		resultMessage = "오전 11시";
	}else if(time == "time13"){
		resultMessage = "오후 1시";
	}else if(time == "time15"){
		resultMessage = "오후 3시";
	}else if(time == "time17"){
		resultMessage = "오후 5시";
	}else if(time == "time19"){
		resultMessage = "오후 7시";
	}else if(time == "time21"){
		resultMessage = "오후 9시";
	}
	swal(resultMessage+"에 일정이 등록되었습니다.");
}

function searchAllStartDataSetting(){
	$(".findingOneDayRoute").show();
	$(".findingOneDayRoute").empty();
	
	forRouteReset();
	
	subMenu.close();
	var count = 0;
	var checkTime09 = "";
	var checkTime09Trans ="";
	var checkTime11 = "";
	var checkTime11Trans ="";
	var checkTime13 = "";
	var checkTime13Trans ="";
	var checkTime15 = "";
	var checkTime15Trans ="";
	var checkTime17 = "";
	var checkTime17Trans ="";
	var checkTime19 = "";
	var checkTime19Trans ="";
	var checkTime21 = "";
	var checkTime21Trans ="";
	
	var CoordsAndAddress = {
		latY : "",
		lngX : "",
		jb : "",
		ib : "",
		address : ""
	};
	
	if($('input[name="daily_trip_time09_laty"]').val() != ""){
		checkTime09 = $('input[name="daily_trip_time09_address"]').val();
		checkTime09Trans =
			'<div>↓<br>'
			+'<div class="transportOption tpOption'+count+'" id="'+count+'_car" onclick="settingAllTransport(\''+count+'_car\')">자동차</div>'
			+'<div class="transportOption tpOption'+count+'" id="'+count+'_pubTransport" onclick="settingAllTransport(\''+count+'_pubTransport\')">대중교통</div>'
			+'<div class="transportOption tpOption'+count+'" id="'+count+'_bicycle" onclick="settingAllTransport(\''+count+'_bicycle\')">자전거</div>'
			+'<div class="transportOption tpOption'+count+'" id="'+count+'_walk" onclick="settingAllTransport(\''+count+'_walk\')">도보</div><br>↓'
			+'</div>';
		CoordsAndAddress = {
			latY : $('input[name="daily_trip_time09_laty"]').val(),
			lngX : $('input[name="daily_trip_time09_lngx"]').val(),
			jb : "",
			ib : "",
			address : $('input[name="daily_trip_time09_address"]').val()
		};
		latYlngXList.push(CoordsAndAddress);
		count ++;
	}
	if($('input[name="daily_trip_time11_laty"]').val() != ""){
		checkTime11 = $('input[name="daily_trip_time11_address"]').val();
		checkTime11Trans ='<div>↓<br>'
			+'<div class="transportOption tpOption'+count+'" id="'+count+'_car" onclick="settingAllTransport(\''+count+'_car\')">자동차</div>'
			+'<div class="transportOption tpOption'+count+'" id="'+count+'_pubTransport" onclick="settingAllTransport(\''+count+'_pubTransport\')">대중교통</div>'
			+'<div class="transportOption tpOption'+count+'" id="'+count+'_bicycle" onclick="settingAllTransport(\''+count+'_bicycle\')">자전거</div>'
			+'<div class="transportOption tpOption'+count+'" id="'+count+'_walk" onclick="settingAllTransport(\''+count+'_walk\')">도보</div><br>↓'
			+'</div>';
		CoordsAndAddress = {
			latY : $('input[name="daily_trip_time11_laty"]').val(),
			lngX : $('input[name="daily_trip_time11_lngx"]').val(),
			jb : "",
			ib : "",
			address : $('input[name="daily_trip_time11_address"]').val()
		};
		latYlngXList.push(CoordsAndAddress);
		count ++;
	}
	if($('input[name="daily_trip_time13_laty"]').val() != ""){
		checkTime13 = $('input[name="daily_trip_time13_address"]').val();
		checkTime13Trans ='<div>↓<br>'
			+'<div class="transportOption tpOption'+count+'" id="'+count+'_car" onclick="settingAllTransport(\''+count+'_car\')">자동차</div>'
			+'<div class="transportOption tpOption'+count+'" id="'+count+'_pubTransport" onclick="settingAllTransport(\''+count+'_pubTransport\')">대중교통</div>'
			+'<div class="transportOption tpOption'+count+'" id="'+count+'_bicycle" onclick="settingAllTransport(\''+count+'_bicycle\')">자전거</div>'
			+'<div class="transportOption tpOption'+count+'" id="'+count+'_walk" onclick="settingAllTransport(\''+count+'_walk\')">도보</div><br>↓'
			+'</div>';
		CoordsAndAddress = {
			latY : $('input[name="daily_trip_time13_laty"]').val(),
			lngX : $('input[name="daily_trip_time13_lngx"]').val(),
			jb : "",
			ib : "",
			address : $('input[name="daily_trip_time13_address"]').val()
		};
		latYlngXList.push(CoordsAndAddress);
		count ++;
	}
	if($('input[name="daily_trip_time15_laty"]').val() != ""){
		checkTime15 = $('input[name="daily_trip_time15_address"]').val();
		checkTime15Trans ='<div>↓<br>'
			+'<div class="transportOption tpOption'+count+'" id="'+count+'_car" onclick="settingAllTransport(\''+count+'_car\')">자동차</div>'
			+'<div class="transportOption tpOption'+count+'" id="'+count+'_pubTransport" onclick="settingAllTransport(\''+count+'_pubTransport\')">대중교통</div>'
			+'<div class="transportOption tpOption'+count+'" id="'+count+'_bicycle" onclick="settingAllTransport(\''+count+'_bicycle\')">자전거</div>'
			+'<div class="transportOption tpOption'+count+'" id="'+count+'_walk" onclick="settingAllTransport(\''+count+'_walk\')">도보</div><br>↓'
			+'</div>';
		CoordsAndAddress = {
			latY : $('input[name="daily_trip_time15_laty"]').val(),
			lngX : $('input[name="daily_trip_time15_lngx"]').val(),
			jb : "",
			ib : "",
			address : $('input[name="daily_trip_time15_address"]').val()
		};
		latYlngXList.push(CoordsAndAddress);
		count ++;
	}
	if($('input[name="daily_trip_time17_laty"]').val() != ""){
		checkTime17 = $('input[name="daily_trip_time17_address"]').val();
		checkTime17Trans ='<div>↓<br>'
			+'<div class="transportOption tpOption'+count+'" id="'+count+'_car" onclick="settingAllTransport(\''+count+'_car\')">자동차</div>'
			+'<div class="transportOption tpOption'+count+'" id="'+count+'_pubTransport" onclick="settingAllTransport(\''+count+'_pubTransport\')">대중교통</div>'
			+'<div class="transportOption tpOption'+count+'" id="'+count+'_bicycle" onclick="settingAllTransport(\''+count+'_bicycle\')">자전거</div>'
			+'<div class="transportOption tpOption'+count+'" id="'+count+'_walk" onclick="settingAllTransport(\''+count+'_walk\')">도보</div><br>↓'
			+'</div>';
		CoordsAndAddress = {
			latY : $('input[name="daily_trip_time17_laty"]').val(),
			lngX : $('input[name="daily_trip_time17_lngx"]').val(),
			jb : "",
			ib : "",
			address : $('input[name="daily_trip_time17_address"]').val()
		};
		latYlngXList.push(CoordsAndAddress);
		count ++;
	}
	if($('input[name="daily_trip_time19_laty"]').val() != ""){
		checkTime19 = $('input[name="daily_trip_time19_address"]').val();
		checkTime19Trans ='<div>↓<br>'
			+'<div class="transportOption tpOption'+count+'" id="'+count+'_car" onclick="settingAllTransport(\''+count+'_car\')">자동차</div>'
			+'<div class="transportOption tpOption'+count+'" id="'+count+'_pubTransport" onclick="settingAllTransport(\''+count+'_pubTransport\')">대중교통</div>'
			+'<div class="transportOption tpOption'+count+'" id="'+count+'_bicycle" onclick="settingAllTransport(\''+count+'_bicycle\')">자전거</div>'
			+'<div class="transportOption tpOption'+count+'" id="'+count+'_walk" onclick="settingAllTransport(\''+count+'_walk\')">도보</div><br>↓'
			+'</div>';
		CoordsAndAddress = {
			latY : $('input[name="daily_trip_time19_laty"]').val(),
			lngX : $('input[name="daily_trip_time19_lngx"]').val(),
			jb : "",
			ib : "",
			address : $('input[name="daily_trip_time19_address"]').val()
		};
		latYlngXList.push(CoordsAndAddress);
		count ++;
	}
	if($('input[name="daily_trip_time21_laty"]').val() != ""){
		checkTime21 = $('input[name="daily_trip_time21_address"]').val();
		checkTime21Trans ='<div>↓<br>'
			+'<div class="transportOption tpOption'+count+'" id="'+count+'_car" onclick="settingAllTransport(\''+count+'_car\')">자동차</div>'
			+'<div class="transportOption tpOption'+count+'" id="'+count+'_pubTransport" onclick="settingAllTransport(\''+count+'_pubTransport\')">대중교통</div>'
			+'<div class="transportOption tpOption'+count+'" id="'+count+'_bicycle" onclick="settingAllTransport(\''+count+'_bicycle\')">자전거</div>'
			+'<div class="transportOption tpOption'+count+'" id="'+count+'_walk" onclick="settingAllTransport(\''+count+'_walk\')">도보</div><br>↓'
			+'</div>';
		CoordsAndAddress = {
			latY : $('input[name="daily_trip_time21_laty"]').val(),
			lngX : $('input[name="daily_trip_time21_lngx"]').val(),
			jb : "",
			ib : "",
			address : $('input[name="daily_trip_time21_address"]').val()
		};
		latYlngXList.push(CoordsAndAddress);
		count ++;
	}
	
	$(".findingOneDayRoute").append(checkTime09+checkTime09Trans+checkTime11+checkTime11Trans+checkTime13+checkTime13Trans
			+checkTime15+checkTime15Trans+checkTime17+checkTime17Trans+checkTime19+checkTime19Trans+checkTime21+checkTime21Trans);
	
	$(".findingOneDayRoute").children().last().remove();

	$(".findingOneDayRoute").append('<br><br><input type="button" class="transportOption" onclick="searchAllStart()" value="길찾기!">');
	
	
	map.setCenter(new naver.maps.LatLng(latYlngXList[0].latY, latYlngXList[0].lngX));
	
	startMark.setTitle(latYlngXList[0].address);
	startMark.setPosition(new naver.maps.LatLng(latYlngXList[0].latY, latYlngXList[0].lngX));
	endMark.setTitle(latYlngXList[latYlngXList.length-1].address);
	endMark.setPosition(new naver.maps.LatLng(latYlngXList[latYlngXList.length-1].latY, latYlngXList[latYlngXList.length-1].lngX));
	
	for(var i=1; i<latYlngXList.length-1; i++){
		var viaMark = new naver.maps.Marker({
			title: latYlngXList[i].address,
			icon: {
				url: '../img/via'+markerIndex+'.png',
				anchor: new naver.maps.Point(0, 44)
			},
			position: new naver.maps.LatLng(latYlngXList[i].latY, latYlngXList[i].lngX),
			map: map
		});
		viaMarkList.push(viaMark);
		markerIndex += 1;
	}
}

function settingAllTransport(type){
//	$(".tpOption"+type.split("_")[0]).removeClass("divActive");
	$(".tpOption"+type.split("_")[0]).removeClass("car");
	$(".tpOption"+type.split("_")[0]).removeClass("pubTransport");
	$(".tpOption"+type.split("_")[0]).removeClass("bicycle");
	$(".tpOption"+type.split("_")[0]).removeClass("walk");
//	$("#"+type).addClass("divActive");
	$("#"+type).addClass(type.split("_")[1]);
	tmpDailyTransportList[type.split("_")[0]] = type.split("_")[1]; 
}

function searchAllStart(){
//	console.log(latYlngXList);
//	console.log(tmpDailyTransportList);
	
	swal("경로를 검색중입니다!", {
		icon: "info",
		buttons: false,
		timer: 5000,
	})
	
	tmpDailyJsonList = new Array();
	
	if(polyLineArray.length > 0){
		for(var i=0; i<polyLineArray.length; i++){
			polyLineArray[i].setMap(null);
		}
		polyLineArray = new Array();
	}
	if(transportMarkList.length > 0){
		for(var i=0; i<transportMarkList.length; i++){
			transportMarkList[i].setMap(null);
		}
		transportMarkList = new Array();
	}
	
	for(var i=0; i<latYlngXList.length-1; i++){
		if(tmpDailyTransportList[i] == "pubTransport"){
			latYlngXList[i] = transOneLatLngToDaumCoord(latYlngXList[i]);
			latYlngXList[i+1] = transOneLatLngToDaumCoord(latYlngXList[i+1]);
		}
		
		$.ajaxSettings.traditional = true;
		$.ajaxSetup({
			headers: {
				'X-CSRF-Token': $('meta[name="csrf_token"]').attr('content')
			}
		});
		$.ajax({
			type:"POST",
			url:"../common/dayRouteFinder",
			async:false,
			data: {
				transportList : tmpDailyTransportList[i],
				startLatY : latYlngXList[i].latY,
				startLngX : latYlngXList[i].lngX,
				startJb : latYlngXList[i].jb,
				startIb : latYlngXList[i].ib,
				startAddr : latYlngXList[i].address,
				arriveLatY : latYlngXList[i+1].latY,
				arriveLngX : latYlngXList[i+1].lngX,
				arriveJb : latYlngXList[i+1].jb,
				arriveIb : latYlngXList[i+1].ib,
				arriveAddr : latYlngXList[i+1].address
			},
			success:function(data){
				tmpDailyJsonList[i] = JSON.parse(data);
//				console.log("반복횟수"+i);
				console.log(JSON.parse(data));
				if(tmpDailyTransportList[i] == "pubTransport"){
					console.log("대중교통");
					drawingRouteLine(tmpDailyTransportList[i],searchRouteByDaum(JSON.parse(data), 0));
				}else if(tmpDailyTransportList[i] == "walk"){
					console.log("걷기");
					drawingRouteLine(tmpDailyTransportList[i], searchRouteByNaverWalking(JSON.parse(data), 0));
				}else{
					console.log("어나더");
					drawingRouteLine(tmpDailyTransportList[i], searchRouteByNaver(JSON.parse(data), 0));
				}
			},error:function(msg){
				swal("해당지역까지의 경로는 지원하지않습니다.");
			}
		})
	}
}

function searchRouteByNaver(jsonFile, selectIndex){ //네이버 길찾기
	var jsonObject = jsonFile;
//	$(".selectRoute").removeClass("divActive");
//	$("#selectRoute"+selectIndex).addClass("divActive");
	var routesindex = selectIndex;
	
	var lineArray = new Array();
	
//	console.log(jsonObject.routes[routesindex]);
	if(typeof jsonObject.routes != "undefined"){
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
	}else{
		swal("해당지역의 차량경로는 제공하지 않습니다.");
	}
	return lineArray;
}

function searchRouteByNaverWalking(jsonFile, selectIndex){ //네이버길찾기(도보)
	var jsonObject = jsonFile;
	
	var lineArray = new Array();
	
	if(typeof jsonObject.result.route != "undefined"){
		for(var i=0; i<jsonObject.result.route[selectIndex].point.length; i++){
			if(jsonObject.result.route[selectIndex].point[i].path != ""){
				var pathArray = transNaverListToLatLngList(jsonObject.result.route[0].point[i].path);
				Array.prototype.push.apply(lineArray, pathArray);
			};
		};
	}else{
		swal("해당지역의 도보경로는 지원하지 않습니다.")
	}
	
	return lineArray;
}

function searchRouteByDaum(jsonFile, selectIndex){ //다음길찾기(대중교통)
	var jsonObject = jsonFile;
	var routesindex = selectIndex;
	var lineArray = new Array();
	
	if(jsonObject.in_local_status == "RESULT_NOT_FOUND" || jsonObject.in_local_status == "NODES_NULL"){ //인로컬 없을때
		if(jsonObject.inter_local_status == "OK"){
			console.log("인터로컬");
			for(var i=0; i<jsonObject.inter_local.routes[routesindex].sectionRoutes.length; i++){
				if(jsonObject.inter_local.routes[routesindex].sectionRoutes[i].polyline != null){
					var tmpDaumCoordList = jsonObject.inter_local.routes[routesindex].sectionRoutes[i].polyline.split("|");
					for(var k=0; k<tmpDaumCoordList.length; k++){
						if(tmpDaumCoordList.length < 16){
							var tmpDaumCoord = new daum.maps.Coords(tmpDaumCoordList[k].split(",")[0], tmpDaumCoordList[k].split(",")[1]);
						}else if(tmpDaumCoordList.length < 32){
							if(k%2 == 0){
								var tmpDaumCoord = new daum.maps.Coords(tmpDaumCoordList[k].split(",")[0], tmpDaumCoordList[k].split(",")[1]);
							}
						}else if(tmpDaumCoordList.length < 64){
							if(k%4 == 0){
								var tmpDaumCoord = new daum.maps.Coords(tmpDaumCoordList[k].split(",")[0], tmpDaumCoordList[k].split(",")[1]);
							}
						}else if(tmpDaumCoordList.length < 128){
							if(k%6 == 0){
								var tmpDaumCoord = new daum.maps.Coords(tmpDaumCoordList[k].split(",")[0], tmpDaumCoordList[k].split(",")[1]);
							}
						}else if(tmpDaumCoordList.length < 256){
							if(k%8 == 0){
								var tmpDaumCoord = new daum.maps.Coords(tmpDaumCoordList[k].split(",")[0], tmpDaumCoordList[k].split(",")[1]);
							}
						}else{
							if(k%10 == 0){
								var tmpDaumCoord = new daum.maps.Coords(tmpDaumCoordList[k].split(",")[0], tmpDaumCoordList[k].split(",")[1]);
							}
						}
						
					}
//					for(var k=0; k<tmpDaumCoordList.length/2; k++){
//						if(tmpDaumCoordList.length < 16){
//							var tmpDaumCoord = new daum.maps.Coords(tmpDaumCoordList[k*2], tmpDaumCoordList[(k*2)+1]);
//							lineArray.push(new naver.maps.LatLng(tmpDaumCoord.toLatLng().jb, tmpDaumCoord.toLatLng().ib));
//						}else if(tmpDaumCoordList.length < 32){
//							if(k%2 == 0){
//								var tmpDaumCoord = new daum.maps.Coords(tmpDaumCoordList[k*2], tmpDaumCoordList[(k*2)+1]);
//								lineArray.push(new naver.maps.LatLng(tmpDaumCoord.toLatLng().jb, tmpDaumCoord.toLatLng().ib));
//							}
//						}else if(tmpDaumCoordList.length < 64){
//							if(k%4 == 0){
//								var tmpDaumCoord = new daum.maps.Coords(tmpDaumCoordList[k*2], tmpDaumCoordList[(k*2)+1]);
//								lineArray.push(new naver.maps.LatLng(tmpDaumCoord.toLatLng().jb, tmpDaumCoord.toLatLng().ib));
//							}
//						}else if(tmpDaumCoordList.length < 128){
//							if(k%8 == 0){
//								var tmpDaumCoord = new daum.maps.Coords(tmpDaumCoordList[k*2], tmpDaumCoordList[(k*2)+1]);
//								lineArray.push(new naver.maps.LatLng(tmpDaumCoord.toLatLng().jb, tmpDaumCoord.toLatLng().ib));
//							}
//						}else{
//							if(k%16 == 0){
//								var tmpDaumCoord = new daum.maps.Coords(tmpDaumCoordList[k*2], tmpDaumCoordList[(k*2)+1]);
//								lineArray.push(new naver.maps.LatLng(tmpDaumCoord.toLatLng().jb, tmpDaumCoord.toLatLng().ib));
//							}
//						}
//					}
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
			swal("해당지역의 대중교통 경로는 제공하지 않습니다.");
		}
	}else if(typeof jsonObject.in_local.routes != "undefined"){
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
	}else{
		swal("해당지역의 대중교통 경로는 지원하지 않습니다.");
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
	
	var polyline = new naver.maps.Polyline({ //지도에 경로그리기
		map : map,
		path : inputArray,
		strokeWeight : 7,
		strokeOpacity : 0.8,
		strokeColor : colorSel
	});
	polyLineArray.push(polyline);
}

function saveDailydata(day){
	
	tmpDailyTimetable.push($('input[name="daily_trip_time09_memo"]').val());
	tmpDailyTimetable.push($('input[name="daily_trip_time09_address"]').val());
	tmpDailyTimetable.push($('input[name="daily_trip_time09_laty"]').val());
	tmpDailyTimetable.push($('input[name="daily_trip_time09_lngx"]').val());
	tmpDailyTimetable.push($('#time09_img'));
	tmpDailyTimetable.push($('input[name="daily_trip_time11_memo"]').val());
	tmpDailyTimetable.push($('input[name="daily_trip_time11_address"]').val());
	tmpDailyTimetable.push($('input[name="daily_trip_time11_laty"]').val());
	tmpDailyTimetable.push($('input[name="daily_trip_time11_lngx"]').val());
	tmpDailyTimetable.push($('#time11_img'));
	tmpDailyTimetable.push($('input[name="daily_trip_time13_memo"]').val());
	tmpDailyTimetable.push($('input[name="daily_trip_time13_address"]').val());
	tmpDailyTimetable.push($('input[name="daily_trip_time13_laty"]').val());
	tmpDailyTimetable.push($('input[name="daily_trip_time13_lngx"]').val());
	tmpDailyTimetable.push($('#time13_img'));
	tmpDailyTimetable.push($('input[name="daily_trip_time15_memo"]').val());
	tmpDailyTimetable.push($('input[name="daily_trip_time15_address"]').val());
	tmpDailyTimetable.push($('input[name="daily_trip_time15_laty"]').val());
	tmpDailyTimetable.push($('input[name="daily_trip_time15_lngx"]').val());
	tmpDailyTimetable.push($('#time15_img'));
	tmpDailyTimetable.push($('input[name="daily_trip_time17_memo"]').val());
	tmpDailyTimetable.push($('input[name="daily_trip_time17_address"]').val());
	tmpDailyTimetable.push($('input[name="daily_trip_time17_laty"]').val());
	tmpDailyTimetable.push($('input[name="daily_trip_time17_lngx"]').val());
	tmpDailyTimetable.push($('#time17_img'));
	tmpDailyTimetable.push($('input[name="daily_trip_time19_memo"]').val());
	tmpDailyTimetable.push($('input[name="daily_trip_time19_address"]').val());
	tmpDailyTimetable.push($('input[name="daily_trip_time19_laty"]').val());
	tmpDailyTimetable.push($('input[name="daily_trip_time19_lngx"]').val());
	tmpDailyTimetable.push($('#time19_img'));
	tmpDailyTimetable.push($('input[name="daily_trip_time21_memo"]').val());
	tmpDailyTimetable.push($('input[name="daily_trip_time21_address"]').val());
	tmpDailyTimetable.push($('input[name="daily_trip_time21_laty"]').val());
	tmpDailyTimetable.push($('input[name="daily_trip_time21_lngx"]').val());
	tmpDailyTimetable.push($('#time21_img'));
	
	var dailyJavaScriptObject={
		timeTable : tmpDailyTimetable,
		transportList : tmpDailyTransportList,
		jsonList : tmpDailyJsonList
	};
	daysArray[day] = dailyJavaScriptObject;
	
	console.log(daysArray);
}

function loadDailydata(day){
	var dailyJavaScriptObject = daysArray[day];
	if(typeof dailyJavaScriptObject != "undefined"){
		if(typeof dailyJavaScriptObject.timeTable != "undefined"){
			$('input[name="daily_trip_time09_memo"]').val(dailyJavaScriptObject.timeTable[0]);
			$('input[name="daily_trip_time09_address"]').val(dailyJavaScriptObject.timeTable[1]);
			$('input[name="daily_trip_time09_laty"]').val(dailyJavaScriptObject.timeTable[2]);
			$('input[name="daily_trip_time09_lngx"]').val(dailyJavaScriptObject.timeTable[3]);
			$('#time09').append(dailyJavaScriptObject.timeTable[4]);
			$('input[name="daily_trip_time11_memo"]').val(dailyJavaScriptObject.timeTable[5]);
			$('input[name="daily_trip_time11_address"]').val(dailyJavaScriptObject.timeTable[6]);
			$('input[name="daily_trip_time11_laty"]').val(dailyJavaScriptObject.timeTable[7]);
			$('input[name="daily_trip_time11_lngx"]').val(dailyJavaScriptObject.timeTable[8]);
			$('#time11').append(dailyJavaScriptObject.timeTable[9]);
			$('input[name="daily_trip_time13_memo"]').val(dailyJavaScriptObject.timeTable[10]);
			$('input[name="daily_trip_time13_address"]').val(dailyJavaScriptObject.timeTable[11]);
			$('input[name="daily_trip_time13_laty"]').val(dailyJavaScriptObject.timeTable[12]);
			$('input[name="daily_trip_time13_lngx"]').val(dailyJavaScriptObject.timeTable[13]);
			$('#time13').append(dailyJavaScriptObject.timeTable[14]);
			$('input[name="daily_trip_time15_memo"]').val(dailyJavaScriptObject.timeTable[15]);
			$('input[name="daily_trip_time15_address"]').val(dailyJavaScriptObject.timeTable[16]);
			$('input[name="daily_trip_time15_laty"]').val(dailyJavaScriptObject.timeTable[17]);
			$('input[name="daily_trip_time15_lngx"]').val(dailyJavaScriptObject.timeTable[18]);
			$('#time15').append(dailyJavaScriptObject.timeTable[19]);
			$('input[name="daily_trip_time17_memo"]').val(dailyJavaScriptObject.timeTable[20]);
			$('input[name="daily_trip_time17_address"]').val(dailyJavaScriptObject.timeTable[21]);
			$('input[name="daily_trip_time17_laty"]').val(dailyJavaScriptObject.timeTable[22]);
			$('input[name="daily_trip_time17_lngx"]').val(dailyJavaScriptObject.timeTable[23]);
			$('#time17').append(dailyJavaScriptObject.timeTable[24]);
			$('input[name="daily_trip_time19_memo"]').val(dailyJavaScriptObject.timeTable[25]);
			$('input[name="daily_trip_time19_address"]').val(dailyJavaScriptObject.timeTable[26]);
			$('input[name="daily_trip_time19_laty"]').val(dailyJavaScriptObject.timeTable[27]);
			$('input[name="daily_trip_time19_lngx"]').val(dailyJavaScriptObject.timeTable[28]);
			$('#time19').append(dailyJavaScriptObject.timeTable[29]);
			$('input[name="daily_trip_time21_memo"]').val(dailyJavaScriptObject.timeTable[30]);
			$('input[name="daily_trip_time21_address"]').val(dailyJavaScriptObject.timeTable[31]);
			$('input[name="daily_trip_time21_laty"]').val(dailyJavaScriptObject.timeTable[32]);
			$('input[name="daily_trip_time21_lngx"]').val(dailyJavaScriptObject.timeTable[33]);
			$('#time21').append(dailyJavaScriptObject.timeTable[34]);
		}
		
		if(dailyJavaScriptObject.transportList.length > 0){
			for(var i=0; i<dailyJavaScriptObject.transportList.length; i++){
				if(dailyJavaScriptObject.transportList[i] == "pubTransport"){
					console.log("대중교통");
					drawingRouteLine(dailyJavaScriptObject.transportList[i],searchRouteByDaum(dailyJavaScriptObject.jsonList[i], 0));
				}else if(dailyJavaScriptObject.transportList[i] == "walk"){
					console.log("걷기");
					drawingRouteLine(dailyJavaScriptObject.transportList[i], searchRouteByNaverWalking(dailyJavaScriptObject.jsonList[i], 0));
				}else{
					console.log("어나더");
					drawingRouteLine(dailyJavaScriptObject.transportList[i], searchRouteByNaver(dailyJavaScriptObject.jsonList[i], 0));
				}
			}
			tmpDailyTransportList = dailyJavaScriptObject.transportList;
			tmpDailyJsonList = dailyJavaScriptObject.jsonList;
		}
	}
}

function boardWrite(){
	saveDailydata(dayIndex);
	
	for(var i=0; i<daysArray.length; i++){
		if(typeof daysArray[i] == "undefined"){
			saveDailydata(i);
		}
		if(daysArray[i].transportList.length == 0){
			daysArray[i].transportList[0] = 0;
			daysArray[i].jsonList[0] = 0;
		}
	}
	
	var sendingData = {
			tripBoardData : {
				member_id : $('input[name="member_id"]').val(),
				member_nick : $('input[name="member_nick"]').val(),
				trip_board_title : $('input[name="trip_board_title"]').val(),
				trip_board_startdate : $('input[name="trip_board_startdate"]').val(),
				trip_board_enddate : $('input[name="trip_board_enddate"]').val(),
				trip_board_nowcount : $('select[name="trip_board_nowcount"]').val(),
				trip_board_finalcount : $('select[name="trip_board_finalcount"]').val(),
				trip_board_recruit : $('input[name="trip_board_recruit"]').prop("checked"),
				trip_board_bool : $('input[name="trip_board_bool"]').prop("checked"),
				trip_board_memo : $('textarea[name="trip_board_memo"]').val()
			},
			dailyData : daysArray
	};
	
//	console.log(sendingData);
	
	var jsonTmp = JSON.stringify(sendingData);
	
	$.ajaxSettings.traditional = true;
	$.ajaxSetup({
	    headers: {
	      'X-CSRF-Token': $('meta[name="csrf_token"]').attr('content')
	    }
	});
	$.ajax({
		type:"POST",
		url:"../common/tripBoardWrite",
		async:false,
		data: jsonTmp,
		dataType:"json",
		processData : true,
		contentType : "application/json; charset=UTF-8",
		success:function(data){
			if(data.result.indexOf("실패") != -1){
				swal(data.result);
			}else{
				location.href = data.result;
			}
		}
	})
	return false;
}

function forRouteReset(){
	if(polyLineArray.length > 0){
		for(var i=0; i<polyLineArray.length; i++){
			polyLineArray[i].setMap(null);
		}
		polyLineArray = new Array();
	}
	
	startMark.setPosition(null);
	endMark.setPosition(null);
	if(viaMarkList.length > 0){
		for(var i=0; i<viaMarkList.length; i++){
			viaMarkList[i].setMap(null);
		}
		viaMarkList = new Array();
	}
	if(transportMarkList.length > 0){
		for(var i=0; i<transportMarkList.length; i++){
			transportMarkList[i].setMap(null);
		}
		transportMarkList = new Array();
	}
	markerIndex = 1;
	
	tmpDailyTimetable = new Array();
	tmpDailyTransportList = new Array();
	tmpDailyJsonList = new Array();
	latYlngXList = new Array();
}

function dailyReset(){
	polyLineArray = new Array();
	
	startMark = new naver.maps.Marker({
		title: "none",
		icon: {
			url: '../img/startpoint.png',
			anchor: new naver.maps.Point(0, 42)
		},
		position: null,
		map: map
	});
	endMark = new naver.maps.Marker({
		title: "none",
		icon: {
			url: '../img/endpoint.png',
			anchor: new naver.maps.Point(0, 42)
		},
		position: null,
		map: map
	});
	viaMarkList = new Array();
	transportMarkList = new Array();
	markerIndex = 1;

	tmpDailyTimetable = new Array();
	tmpDailyTransportList = new Array();
	tmpDailyJsonList = new Array();
	latYlngXList = new Array();
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
//	console.log("변환시작");
	var daumTmp = new daum.maps.LatLng(coords.latY, coords.lngX);
	coords.jb = daumTmp.toCoords().jb;
	coords.ib = daumTmp.toCoords().ib;
//	console.log(coords);
	return coords
}

//------------------------------좌표변환파트끝------------------------------//


function searchAddressByLatLng(coords){ //좌표로 주소찾기
	naver.maps.Service.reverseGeocode({
		location: coords,
		coordType: naver.maps.Service.CoordType.LATLNG
	}, function(status, response){
		if(status === naver.maps.Service.Status.ERROR){
			return swal("잘못되었습니다.");
		}
		address = response.result.items[0].address;
		console.log(address);
	});
}