//contentType : 12=관광지 / 14=문화시설 / 15=축제,공연,행사 / 28=레포츠 / 32=숙박 /38=쇼핑 /39=음식
var placeMarkerList;
var stayMarkerList;
var restMarkerList;


//-----------------function시작-----------------
function findingPlace(contentType, selectPage){
	if(typeof placeMarkerList != "undefined"){
		for(var i=0; i<placeMarkerList.length; i++){
			placeMarkerList[i].setMap(null);
		}
	}
	placeMarkerList = new Array();
	$(".placeRecommendList").empty();
	$(".placeRecommendListPaging").empty();
	var xhr = new XMLHttpRequest();
	var url = 'http://api.visitkorea.or.kr/openapi/service/rest/KorService/locationBasedList'; /*URL*/
	var queryParams = '?' + encodeURIComponent('serviceKey') + '='+'piOn0c2v86L2HauXxqIEuzy%2B0S2gqfPTK11NO9f%2BT9j63pmmaIgIsfyaOUIz%2BrWWLrTmsXtgpWjjSP9TGFKmGw%3D%3D'; /*Service Key*/
	queryParams += '&' + encodeURIComponent('contentTypeId') + '=' + encodeURIComponent(contentType); /*관광타입*/
	queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('9'); /*한 페이지 결과 수*/
//	queryParams += '&' + encodeURIComponent('pageSize') + '=' + encodeURIComponent('6'); /*한 페이지 결과 수*/
	queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent(selectPage); /*현재 페이지 번호*/
//	queryParams += '&' + encodeURIComponent('startPage') + '=' + encodeURIComponent('1'); /*시작페이지*/
	queryParams += '&' + encodeURIComponent('MobileOS') + '=' + encodeURIComponent('ETC'); /*IOS(아이폰),AND(안드로이드),WIN(원도우폰),ETC*/
	queryParams += '&' + encodeURIComponent('MobileApp') + '=' + encodeURIComponent('Project_TF'); /*서비스명*/
	queryParams += '&' + encodeURIComponent('arrange') + '=' + encodeURIComponent('P'); /*조회순정렬*/
	queryParams += '&' + encodeURIComponent('listYN') + '=' + encodeURIComponent('Y'); /*목록출력*/
	queryParams += '&' + encodeURIComponent('mapX') + '=' + encodeURIComponent(lngX); /*X좌표*/
	queryParams += '&' + encodeURIComponent('mapY') + '=' + encodeURIComponent(latY); /*Y좌표*/
	queryParams += '&' + encodeURIComponent('radius') + '=' + encodeURIComponent('8000'); /*검색반경*/
	queryParams += '&_type=json';
//	console.log(url+queryParams);
	xhr.open('GET', url + queryParams);
	xhr.onreadystatechange = function () {
	    if (this.readyState == 4) {
//	        console.log('Status: '+this.status+' Headers: '+JSON.stringify(this.getAllResponseHeaders())+' Body: '+this.responseText);
	        var jsonObject = JSON.parse(this.responseText);
//	        console.log("플레이스 제이슨 오브젝트 : " + jsonObject);
	        var recommendList = jsonObject.response.body.items.item;
//	        console.log("플레이스 제이슨 리스트 : " + recommendList);
//	        console.log("제이슨1번 : "+recommendList[1]);
//	        console.log("제이슨2번 : "+recommendList[2]);
//	        console.log(recommendList);
	        for(var i=0; i<recommendList.length; i++){
	        	if(recommendList[i].firstimage2 == null){
	        		recommendList[i].firstimage2 = '../img/teemo.png'
	        	}
	        	if(recommendList[i].title.length > 6){
	        		var tmpTitle = recommendList[i].title.substr(0, 6) + '..';
	        	}else{
	        		var tmpTitle = recommendList[i].title;
	        	}
//	        	console.log("이미지1주소:"+recommendList[i].firstimage1);
//	        	console.log("이미지2주소:"+recommendList[i].firstimage2);
	        	$(".placeRecommendList").append('<div class="placeRecommend">'
						+'<img id="'+i+'" alt="'+recommendList[i].mapy+"/"+recommendList[i].mapx+'" title="'+recommendList[i].title+'" draggable="true" ondragstart="dragCopy(event)" src="'+recommendList[i].firstimage2+'"><br>'
						+'<a href="http://korean.visitkorea.or.kr/kor/bz15/where/festival/festival.jsp?cid='+recommendList[i].contentid+'" target="blank" title="'+recommendList[i].title+'">'+tmpTitle+'</a></div>');
	        	
	        	var placeMarker = new naver.maps.Marker({
					title: recommendList[i].title,
					position: new naver.maps.LatLng(recommendList[i].mapy, recommendList[i].mapx),
					map: map
				});
	        	if($('input[name="placeMarkerCheck"]').prop("checked")){
	        		placeMarker.setVisible(true);
	        	}else{
	        		placeMarker.setVisible(false);
	        	}
	        	placeMarkerList.push(placeMarker);
	        }
	        var totalPageList = (jsonObject.response.body.totalCount+"") / 9;
	        if(totalPageList > 10){
	        	for(var i=1; i<11; i++){
	        		$(".placeRecommendListPaging").append(
	        				"<input type='button' onclick='findingPlace("+contentType+", "+i+")' value="+i+">"
	        		);
	        	}
	        }else{
	        	for(var i=1; i<=totalPageList; i++){
	        		$(".placeRecommendListPaging").append(
	        				"<input type='button' onclick='findingPlace("+contentType+", "+i+")' value="+i+">"
	        		);
	        	}
	        }
	        
	    }
	};
	xhr.send('');
}

function findingStay(selectPage){
	if(typeof stayMarkerList != "undefined"){
		for(var i=0; i<stayMarkerList.length; i++){
			stayMarkerList[i].setMap(null);
		}
	}
	stayMarkerList = new Array();
	$(".stayForm").empty();
	var xhr = new XMLHttpRequest();
	var url = 'http://api.visitkorea.or.kr/openapi/service/rest/KorService/locationBasedList'; /*URL*/
	var queryParams = '?' + encodeURIComponent('serviceKey') + '='+'piOn0c2v86L2HauXxqIEuzy%2B0S2gqfPTK11NO9f%2BT9j63pmmaIgIsfyaOUIz%2BrWWLrTmsXtgpWjjSP9TGFKmGw%3D%3D'; /*Service Key*/
	queryParams += '&' + encodeURIComponent('contentTypeId') + '=' + encodeURIComponent('32'); /*관광타입*/
	queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('8'); /*한 페이지 결과 수*/
//	queryParams += '&' + encodeURIComponent('pageSize') + '=' + encodeURIComponent('6'); /*한 페이지 결과 수*/
	queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent(selectPage); /*현재 페이지 번호*/
//	queryParams += '&' + encodeURIComponent('startPage') + '=' + encodeURIComponent('1'); /*시작페이지*/
	queryParams += '&' + encodeURIComponent('MobileOS') + '=' + encodeURIComponent('ETC'); /*IOS(아이폰),AND(안드로이드),WIN(원도우폰),ETC*/
	queryParams += '&' + encodeURIComponent('MobileApp') + '=' + encodeURIComponent('Project_TF'); /*서비스명*/
	queryParams += '&' + encodeURIComponent('arrange') + '=' + encodeURIComponent('P'); /*조회순정렬*/
	queryParams += '&' + encodeURIComponent('listYN') + '=' + encodeURIComponent('Y'); /*목록출력*/
	queryParams += '&' + encodeURIComponent('mapX') + '=' + encodeURIComponent(lngX); /*X좌표*/
	queryParams += '&' + encodeURIComponent('mapY') + '=' + encodeURIComponent(latY); /*Y좌표*/
	queryParams += '&' + encodeURIComponent('radius') + '=' + encodeURIComponent('10000'); /*검색반경*/
	queryParams += '&_type=json';
	xhr.open('GET', url + queryParams);
	xhr.onreadystatechange = function () {
	    if (this.readyState == 4) {
	        var jsonObject = JSON.parse(this.responseText);
//	        console.log("레스트 제이슨오브젝트 : "+jsonObject);
	        var recommendList = jsonObject.response.body.items.item;
//	        console.log("레스트 리스트 : "+recommendList);
	        
	        if(typeof recommendList != "undefined"){
	        	if(selectPage > 1){
	        		$(".stayForm").append(
	        				'<div class="stayRecommend" style="width:20px !important;">'
	        				+'	<input type="button" class="stayRecommendListPaging" value="<" onclick="findingStay('+(selectPage-1)+')">'
	        				+'</div>'
	        		);
	        	}
	        	
	        	for(var i=0; i<recommendList.length; i++){
	        		if(recommendList[i].firstimage2 == null){
	        			recommendList[i].firstimage2 = '../img/teemo.png'
	        		}
	        		if(recommendList[i].title.length > 5){
	        			var tmpTitle = recommendList[i].title.substr(0, 5) + '..';
	        		}else{
	        			var tmpTitle = recommendList[i].title;
	        		}
	        		$(".stayForm").append('<div class="stayRecommend">'
	        				+'<img src="'+recommendList[i].firstimage2+'"><br>'
	        				+'<a href="http://korean.visitkorea.or.kr/kor/bz15/where/festival/festival.jsp?cid='+recommendList[i].contentid+'" target="blank" title="'+recommendList[i].title+'">'+tmpTitle+'</a>');
	        		var stayMarker = new naver.maps.Marker({
	        			title: recommendList[i].title,
	        			position: new naver.maps.LatLng(recommendList[i].mapy, recommendList[i].mapx),
	        			icon: {
	        				url: '../img/stay.png'
	        			},
	        			map: map
	        		});
	        		if($('input[name="stayMarkerCheck"]').prop("checked")){
	        			stayMarker.setVisible(true);
	        		}else{
	        			stayMarker.setVisible(false);
	        		}
	        		stayMarkerList.push(stayMarker);
	        	}
	        	var totalPageList = (jsonObject.response.body.totalCount+"") / 8;
	        	if(selectPage < totalPageList){
	        		$(".stayForm").append(
	        				'<div class="stayRecommend" style="width:20px !important;">'
	        				+'	<input type="button" class="stayRecommendListPaging" value=">" onclick="findingStay('+(selectPage+1)+')">'
	        				+'</div>'
	        		);
	        	}
	        }else{
	        	$(".stayForm").append("숙박지 정보가 없습니다.");
	        }
	    }
	};
	xhr.send('');
}

function restoption(option){
	if(typeof restMarkerList != "undefined"){
		for(var i=0; i<restMarkerList.length; i++){
			restMarkerList[i].setMap(null);
		}
	}
	restMarkerList = new Array();
	
	$(".restList").empty();
	restOption = option;
	
	$.ajaxSettings.traditional = true;
	$.ajaxSetup({
	    headers: {
	      'X-CSRF-Token': $('meta[name="csrf_token"]').attr('content')
	    }
	});
	$.ajax({
		type:"POST",
		url:"../common/restRecommend",
		data: {
			convenient_laty:latY,
			convenient_lngx:lngX,
			convenient_type:restOption
		},
		success:function(data){
			for(var i=0; i<data.length; i++){
				if(data[i].convenient_name.length > 5){
	        		var tmpTitle = data[i].convenient_name.substr(0, 5) + '..';
	        	}else{
	        		var tmpTitle = data[i].convenient_name;
	        	}
				$(".restList").append('<div class="restRecommend">'
						+'<img src="../common/image?imageName='+data[i].convenient_type+'&imageType=convenient"><br>'
						+'<a href="https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=1&ie=utf8&query='+data[i].convenient_name+'" target="blank" title="'+data[i].convenient_name+'">'+tmpTitle+'</a>');
				var restMarker = new naver.maps.Marker({
					title: data[i].convenient_name,
					position: new naver.maps.LatLng(data[i].convenient_laty, data[i].convenient_lngx),
					icon: {
						url: '../img/rest.png'
					},
					map: map
				});
	        	if($('input[name="restMarkerCheck"]').prop("checked")){
	        		restMarker.setVisible(true);
	        	}else{
	        		restMarker.setVisible(false);
	        	}
	        	restMarkerList.push(restMarker);
			}
		},
		error:function(data){
			swal("주변 편의시설이 없습니다.");
		}
	})
}

function placeHideAndShow(){
	if($('input[name="placeMarkerCheck"]').prop("checked")){
		if(typeof placeMarkerList != "undefined"){
			for(var i=0; i<placeMarkerList.length; i++){
				placeMarkerList[i].setVisible(true);
			}
		}
	}else{
		if(typeof placeMarkerList != "undefined"){
			for(var i=0; i<placeMarkerList.length; i++){
				placeMarkerList[i].setVisible(false);
			}
		}
	}
}

function stayHideAndShow(){
	if($('input[name="stayMarkerCheck"]').prop("checked")){
		if(typeof stayMarkerList != "undefined"){
			for(var i=0; i<stayMarkerList.length; i++){
				stayMarkerList[i].setVisible(true);
			}
		}
	}else{
		if(typeof stayMarkerList != "undefined"){
			for(var i=0; i<stayMarkerList.length; i++){
				stayMarkerList[i].setVisible(false);
			}
		}
	}
}

function restHideAndShow(){
	if($('input[name="restMarkerCheck"]').prop("checked")){
		if(typeof restMarkerList != "undefined"){
			for(var i=0; i<restMarkerList.length; i++){
				restMarkerList[i].setVisible(true);
			}
		}
	}else{
		if(typeof restMarkerList != "undefined"){
			for(var i=0; i<restMarkerList.length; i++){
				restMarkerList[i].setVisible(false);
			}
		}
	}
}