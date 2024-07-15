//	-----------------변수선언-----------------
var place_purpose = 'all';
var restOption = 'all';
var latY;
var lngX;
//-----------------변수선언끝-----------------


//-----------------이벤트등록시작-----------------
naver.maps.Event.addListener(map, 'click', function(e) {
	subMenu.close();
});

//naver.maps.Event.addListener(map, 'rightclick', function(e) {
//	latYlngX = e.coord //좌표값 저장
//	latY = latYlngX.y;
//	lngX = latYlngX.x;
//	daumCoord = new daum.maps.LatLng(latYlngX.y, latYlngX.x).toCoords(); //다음좌표값 저장
//	searchAddressByLatLng(latYlngX); //좌표에따른 도로명주소
//	console.log("latYlngX:" + latYlngX);
//	console.log("daumCoord:" + daumCoord);
//	subMenu.open(map, e.coord);
//});
//-----------------이벤트등록끝-----------------


//-----------------function시작-----------------
function placeoption(option){
	$(".panel-place-body").empty();
	place_purpose = option;
	
	$.ajaxSettings.traditional = true;
	$.ajax({
		type:"POST",
		url:"../common/placeRecommend",
		data: {
			place_laty:latY,
			place_lngx:lngX,
			place_purpose:place_purpose
		},
		success:function(data){
			
			for(var i=0; i<data.length; i++){
				$(".panel-place-body").append('<div class="place-recommend">'
						+'<img style="width:150px;heigth:150px;" src="../common/image?imageName='+data[i].place_name+'&imageType=place"><br>'
//						+data[i].place_name+'</div>');dz
						+'<a href="https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=1&ie=utf8&query='+data[i].place_name+'" target="blank">'+data[i].place_name+'</a>');
			}
		},
		error:function(msg){
			alert("추천관광지가없습니다.");
		}
	})
}

function restoption(option){
	$(".panel-rest-body").empty();
	restOption = option;
	
	$.ajaxSettings.traditional = true;
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
				console.log(data[i].convenient_type);
				$(".panel-rest-body").append('<div class="rest-recommend">'
						+'<img style="width:70px;heigth:70px;" src="../common/image?imageName='+data[i].convenient_type+'&imageType=convenient"><br>'
						+'<a href="https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=1&ie=utf8&query='+data[i].convenient_name+'" target="blank">'+data[i].convenient_name+'</a>');
			}
		},
		error:function(data){
			alert("주변 편의시설이 없습니다.");
		}
	})
}