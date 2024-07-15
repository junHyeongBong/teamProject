/* Javascript 샘플 코드 */

$(document).ready(function(){
	var xhr = new XMLHttpRequest();
	var url = 'http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchFestival'; /*URL*/
	var queryParams = '?' + encodeURIComponent('serviceKey') + '='+'piOn0c2v86L2HauXxqIEuzy%2B0S2gqfPTK11NO9f%2BT9j63pmmaIgIsfyaOUIz%2BrWWLrTmsXtgpWjjSP9TGFKmGw%3D%3D'; /*Service Key*/
	queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('9'); /*한 페이지 결과 수*/
	queryParams += '&' + encodeURIComponent('MobileOS') + '=' + encodeURIComponent('ETC'); /*IOS(아이폰),AND(안드로이드),WIN(원도우폰),ETC*/
	queryParams += '&' + encodeURIComponent('MobileApp') + '=' + encodeURIComponent('Project_TF'); /*서비스명=어플명*/
	queryParams += '&' + encodeURIComponent('arrange') + '=' + encodeURIComponent('P'); /*정렬구분=조회순*/
	queryParams += '&' + encodeURIComponent('listYN') + '=' + encodeURIComponent('Y'); /*목록구분=목록*/
	queryParams += '&' + encodeURIComponent('eventStartDate') + '=' + encodeURIComponent('20180817'); /*정렬구분=조회순*/
	queryParams += '&' + encodeURIComponent('eventEndDate') + '=' + encodeURIComponent('20181231'); /*정렬구분=조회순*/
	queryParams += '&_type=json';
	xhr.open('GET', url + queryParams);
	xhr.onreadystatechange = function () {
	    if (this.readyState == 4) {
//	        console.log('Status: '+this.status+' Headers: '+JSON.stringify(this.getAllResponseHeaders())+' Body: '+this.responseText);
	        var festivalJson = JSON.parse(this.responseText);
	        var festivalList = festivalJson.response.body.items.item;
//	        console.log(festivalList);
	        for(var i=0; i<festivalList.length; i++){
	        	var startdateTmp =festivalList[i].eventstartdate+"";
	        	var enddateTmp =festivalList[i].eventenddate+"";
	        	var startdate = startdateTmp.substr(0, 4)+'.'+startdateTmp.substr(4, 2)+'.'+startdateTmp.substr(6, 2)
	        	var enddate = enddateTmp.substr(0, 4)+'.'+enddateTmp.substr(4, 2)+'.'+enddateTmp.substr(6, 2)
	        	
	        	$(".festivalInfo").append(
        			'<div class="box">'
        			+'	<div class="imgBox">'
        			+'		<img style="width:370px;height:246px;" src="'+festivalList[i].firstimage2+'">'
        			+'	</div>'
        			+'	<div class="content">'
        			+'		<h2>'+festivalList[i].title+'</h2>'
        			+'		<p><i class="fa fa-calendar-o pr-1"></i> '+startdate+'~'+enddate+'</p>'
        			+'		<p>'+festivalList[i].addr1+'</p>'
        			+'		<a class="btn" href="http://korean.visitkorea.or.kr/kor/bz15/where/festival/festival.jsp?cid='+festivalList[i].contentid+'" target="blank">Detail View >></a>'
        			+'	</div>'
        			+'</div>'
	        	);
	        }
	        
	    }
	};
	xhr.send('');
	makeRecommend6BoardList('all', 'recommend', '1')
})

function makeRecommend6BoardList(pageType, sortType, selectpage){
	$(".bestRecoTripBoard").empty();
	
	var imgArr = shuffleRandom();
	
	$.ajaxSettings.traditional = true;
	$.ajaxSetup({
	    headers: {
	      'X-CSRF-Token': $('meta[name="csrf_token"]').attr('content')
	    }
	});
	$.ajax({
		type:"POST",
		url:"./totalTripBoardListAndPaging",
		data: {
			pageType:pageType,
			sortType:sortType,
			selectpage:selectpage
		},
		success:function(data){
			var boardList = data[0];
			
			for(var i=0; i<boardList.length; i++){
				var pageType;
				if(boardList[i].trip_board_recruit == "true"){
					pageType = "recruit";
				}else{
					pageType = "bool";
				}
				$(".bestRecoTripBoard").append(
						'<div class="box">'
	        			+'	<div class="imgBox">'
	        			+'		<img style="width:370px;height:246px;" src="../boardImg/boardback ('+imgArr[i]+').jpg">'
	        			+'	</div>'
	        			+'	<div class="content">'
	        			+'		<h2>'+boardList[i].trip_board_title+'</h2>'
	        			+'		<p>'
	        			+'			<i class="fa fa-calendar-o pr-1"></i> '+boardList[i].trip_board_startdate+'~'+boardList[i].trip_board_enddate
	        			+'			<i class="fa fa-user pr-1 pl-1"></i>'+boardList[i].member_nick+'<br>'
	        			+'			<i class="fa fa-comments-o pl-1 pr-1"></i>12'
	        			+'			<i class="fa fa-eye"></i>'+boardList[i].trip_board_hits
	        			+'			<i class="fa fa-thumbs-up"></i>'+boardList[i].trip_board_recommend
	        			+'		</p>'
	        			+'		<p>'+boardList[i].trip_board_memo+'</p>'
	        			+'		<a class="btn" href="../common/readOneTripBoard?pageType='+pageType+'&trip_board_num='+boardList[i].trip_board_num+'">Detail View >></a>'
	        			+'	</div>'
	        			+'</div>'
				);
			}
		},
		error:function(data){
			swal("추천이없다");
		}
	})
}

function shuffleRandom(){
    var ar = new Array();
    var temp;
    var rnum;

    for(var i=1; i<=30; i++){
        ar.push(i);
    }

    for(var i=0; i<ar.length ; i++)
    {
        rnum = Math.floor(Math.random()*30);
        temp = ar[i];
        ar[i] = ar[rnum];
        ar[rnum] = temp;
    }
    return ar;
}