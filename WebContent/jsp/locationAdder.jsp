<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
		src="https://openapi.map.naver.com/openapi/v3/
		maps.js?clientId=C3g17HQW9Nteyqp72svy&submodules=panorama,geocoder,drawing">
		</script>
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
</head>
<body>
	<button onclick="switcher(0)">관광지</button>
	<button onclick="switcher(1)">편의시설</button>
	<div id="map" style="height:700px;width:700px;" class=""></div>
</body>
	<script type="text/javascript">
		var selecting = 0;
		var address;
		var laty;
		var lngx;
		
		var map = new naver.maps.Map('map', {
			zoom : 8,
			minZoom : 1,
			zoomControl : true,
			zoomControlOptions : {
				position : naver.maps.Position.TOP_RIGHT
			},
			mapTypeControl : true
		});
	
		var subMenuString0 = [ '<div class="subMenu">',
			'관광지이름<input type="text" name="place_name"><br>',
			'관광지지형<select name="place_type">',
			'<option value="land">평지</option>',
			'<option value="mountain">산</option>',
			'<option value="sea">바다</option>',
			'<option value="river">강</option>',
			'<option value="valley">계곡</option>',
			'<option value="lake">호수</option>',
			'<option value="island">섬</option>',
			'<option value="others">기타</option>',
			'</select><br>',
			'관광지목적<select name="place_purpose">',
			'<option value="leisuresports">레포츠</option>',
			'<option value="camp">캠핑</option>',
			'<option value="eating">먹거리</option>',
			'<option value="healing">힐링</option>',
			'<option value="culture">문화</option>',
			'<option value="mountain">산</option>',
			'<option value="religion">종교</option>',
			'</select><br>',
			'<input type="button" onclick="placeAdd()" value="등록">',
			'</div>' ].join('');
	
		var subMenu0 = new naver.maps.InfoWindow({
			content: subMenuString0,
			maxWidth: 1250,
			backgroundColor: "white",
			borderWidth: 3,
			borderColor: "black"
		});
		
		var subMenuString1 = [ '<div class="subMenu">',
			'편의시설이름<input type="text" name="convenient_name"><br>',
			'편의시설타입<select name="convenient_type">',
			'<option value="conveniencestore">편의점</option>',
			'<option value="hospital">병원</option>',
			'<option value="gasstation">주유소</option>',
			'<option value="stay">숙박</option>',
			'</select><br>',
			'<input type="button" onclick="convenientAdd()" value="등록">',
			'</div>' ].join('');
	
		var subMenu1 = new naver.maps.InfoWindow({
			content: subMenuString1,
			maxWidth: 1250,
			backgroundColor: "white",
			borderWidth: 3,
			borderColor: "black"
		});
		
		naver.maps.Event.addListener(map, 'click', function(e) {
			if(selecting == 0){
				subMenu0.close();
			}else{
				subMenu1.close();
			}
		});

		naver.maps.Event.addListener(map, 'rightclick', function(e) {
			latYlngX = e.coord //좌표값 저장
			laty = latYlngX.y;
			lngx = latYlngX.x;
// 			daumCoord = new daum.maps.LatLng(latYlngX.y, latYlngX.x).toCoords(); //다음좌표값 저장
			searchAddressByLatLng(latYlngX); //좌표에따른 도로명주소
			console.log("latYlngX:" + latYlngX);
// 			console.log("daumCoord:" + daumCoord);
			if(selecting == 0){
				subMenu0.open(map, e.coord);
			}else{
				subMenu1.open(map, e.coord);
			}
		});
		
		function switcher(num){
			selecting = num;
		}
		
		function searchAddressByLatLng(addressLatLng){
			naver.maps.Service.reverseGeocode({
				location: addressLatLng,
				coordType: naver.maps.Service.CoordType.LATLNG
			}, function(status, response){
				if(status === naver.maps.Service.Status.ERROR){
					return swal("잘못되었습니다.");
				}
				address = response.result.items[0].address;
				console.log(address);
			});
		}
		
		function placeAdd(){
			$.ajaxSettings.traditional = true;
			$.ajax({
				type:"POST",
				url:"../common/placeAdder",
				data: {
					place_name:$("input[name=place_name]").val(),
					place_address:address,
					place_laty:laty,
					place_lngx:lngx,
					place_type:$("select[name=place_type]").val(),
					place_purpose:$("select[name=place_purpose]").val()
// 					place_:$("textarea[name=trip_board_memo]").val(),
// 					place_:$("input[name=trip_board_bool]").val()
				},
				success:function(data){
					swal("전송완료");
				}
			})
		}
		
		function convenientAdd(){
			$.ajaxSettings.traditional = true;
			$.ajax({
				type:"POST",
				url:"../common/convenientAdder",
				data: {
					convenient_name:$("input[name=convenient_name]").val(),
					convenient_address:address,
					convenient_laty:laty,
					convenient_lngx:lngx,
					convenient_type:$("select[name=convenient_type]").val(),
				},
				success:function(data){
					swal("전송완료");
				}
			})
		}
	</script>
</html>