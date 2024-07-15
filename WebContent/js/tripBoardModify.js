$(document).ready(function(){
	
})

function iljung(){
	for(var i=0; i<btDay; i++){
		period = i+1;
		var addStaffText = '<tr class="text-center" name="trStaff">'
								+ '<td>'
								+ '<input type="button" id="saveDailydata'+i+'" onclick="saveDailydata('+i+')" value="일정 저장">'
								+ '</td>'
								+ '<td>'
								+ '<input class="text-center bg-success form-control" type="text" name="staff_Period" value="'+ period +'" readonly>'
								+ '</td>'
								+ '<td>'
								+ '<input class="text-center bg-success form-control daily_trip_start'+i+'" type="text" name="staff_Start" placeholder="출발지">'
								+ '</td>'
								+ '<td>'
								+ '<input class="text-center bg-success form-control daily_trip_via'+i+'" type="text" name="staff_Waypoint" placeholder="경유지">'
								+ '</td>'
								+ '<td>'
								+ '<input class="text-center bg-success form-control daily_trip_end'+i+'" type="text" name="staff_Destination" placeholder="도착지">'
								+ '</td>'
								+ '<td>'
								+ '<input class="text-center bg-success form-control daily_trip_cost'+i+'" type="text" name="daily_trip_cost" placeholder="예상비용이동(원)">'
								+ '</td>'
								+ '<td>'
								+ '<input class="text-center bg-success form-control daily_trip_memo'+i+'" type="text" name="daily_trip_memo" placeholder="메모해주세요">'
								+ '</td>'
							+ '</tr>';
		var trHtml = $("tbody[name=trStaff]:last"); //last를 사용하여 trStaff라는 명을 가진 마지막 태그 호출
		trHtml.before(addStaffText); //마지막 trStaff명 뒤에 붙인다.
	}
}