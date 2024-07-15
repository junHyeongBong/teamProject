<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri= "http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="contextPath" value = "${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="csrf_token" content="${_csrf.token}">
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
  
<!-- bootstrap cdn -->  
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- datepicker cdn -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

<!-- fontaweasome cdn -->
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">

<!-- google font -->
<link href="https://fonts.googleapis.com/css?family=Cormorant+SC" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Yeon+Sung&subset=korean" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Jua&subset=korean" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Bangers|Nanum+Gothic|Nanum+Myeongjo|Parisienne|Permanent+Marker|Poiret+One" rel="stylesheet">


<!-- css,js -->
<link rel="stylesheet" href="${contextPath }/css/map.css">
<link rel="stylesheet" href="${contextPath }/css/toggle2.css">

<!-- 헤더부분 -->
<link href="https://fonts.googleapis.com/css?family=Yeon+Sung&subset=korean" rel="stylesheet">
<link rel="stylesheet" href="${contextPath }/css/header.css">


<script type="text/javascript"
		src="https://openapi.map.naver.com/openapi/v3/
		maps.js?clientId=C3g17HQW9Nteyqp72svy&submodules=panorama,geocoder,drawing">
		</script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a0dabed2865c6b9cb878feb60563940b&libraries=services,clusterer,drawing"></script>

<script type="text/javascript">
	var btDay;
	//datepicker

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

	$(function() {

		 $("#trip_board_startdate").datepicker({
			  	minDate: 0,
				numberOfMonths: 2,
				dateFormat: 'yy-mm-dd',
				onSelect: function(selected){
					$("#trip_board_enddate").datepicker("option","minDate", selected);
				}
			});
		  
	
		$("#trip_board_enddate").datepicker({
			numberOfMonths: 2,
			dateFormat: 'yy-mm-dd',
			onSelect: function(selected){
				$("#trip_board_startdate").datepicker("option","maxDate", selected);
				var date = $(this).val();
			},
			onClose: function(dateText, inst){
				var period;
				var start = $("#trip_board_startdate").datepicker('getDate');
				var end = $("#trip_board_enddate").datepicker('getDate');
			    var btMs = end - start;
			    btDay = btMs / (1000*60*60*24)+1;
			    
			    alert(btDay + "일 간의 여정을 선택하셨습니다.");
			    
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
			} //onclose end
		});
			
		$(document).on("click", "a[name=addStaff]", function() {
			var reset = $("tr[name=trStaff]");
			reset.remove();
			$.datepicker._clearDate($("#trip_board_startdate"));
			$.datepicker._clearDate($("#trip_board_enddate"));
		});
	});
</script>

<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>With Us</title>
</head>
<body id="myPage" data-spy="scroll" data-target=".navbar" data-offset="60">	
	<%@ include file="../header.jsp" %>
	
		<div class="jumbotron text-center bg-1">
			<h1>Write Your Dream</h1>
		</div>
		
		<form action="../common/tripBoardWrite" method="post" id="writeboard">
		
		<div class="container-fluid">
		<div class="row">
<!-- 			<div class="col-sm-6"> -->

<!-- 			</div> -->
			<div class="col-sm-12">
				<div class="banner banner-big-height dark-translucent-bg padding-bottom-clear" style="background-image:url('../img/action-2277292_1920.jpg');background-position: 50% 32%; background-repeat: no-repeat; background-size: cover; background-size: width:100%;" >
		        	<div class="container">
		        		<div class="row justify-content-lg-center">
		        			<div class="col-lg-8 text-center pv-20">
		<!--               <h1 class="title">Wellcome to Hotel</h1> -->
		<!--               <div class="separator mt-10"></div> -->
		<!--               <p class="text-center">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Excepturi perferendis magnam ea necessitatibus, officiis voluptas odit! Aperiam omnis, cupiditate laudantium velit nostrum, exercitationem accusamus, possimus soluta illo deserunt tempora qui.</p> -->
					        </div>
						</div>
		        	</div>
		        <!-- section start -->
		        <!-- ================ -->
		        	<div class="dark-translucent-bg section">
		          		<div class="container">
		            <!-- filters start -->
							<div class="sorting-filters text-center mb-20 d-flex justify-content-center">
								<div class="form-inline">
									<div class="form-group">
										<label>Depart On</label>
										<div class="input-group date">
											<input type="text" class="form-control" id="trip_board_startdate" name="trip_board_startdate">
										</div>
		              				</div>
									<div class="form-group ml-1">
										<label>Return On</label>
					              		<div class="input-group date">
											<input type="text" class="form-control" id="trip_board_enddate" name="trip_board_enddate">
					              		</div>		              
		              				</div>
		                <div class="form-group ml-1">
		                  <label>Mens</label>
		                  <select name="trip_board_mancount" class="form-control">
		                    <option selected="selected" value="0">남자없음</option>
		                    <option value="1">1 Adult</option>
		                    <option value="2">2 Adults</option>
		                    <option value="3">3 Adults</option>
		                    <option value="4">4 Adults</option>
		                    <option value="5">5 Adults</option>
		                    <option value="6">6 Adults</option>
		                    <option value="7">7 Adults</option>
		                    <option value="8">8 Adults</option>
		                    <option value="9">9 Adults</option>
		                    <option value="10">10 Adults</option>
		                  </select>
		                </div>
		                <div class="form-group ml-1">
		                  <label>Womans</label>
		                  <select name="trip_board_womancount" class="form-control">
		                    <option selected="selected" value="0">여자없음</option>
		                    <option value="1">1 Adult</option>
		                    <option value="2">2 Adults</option>
		                    <option value="3">3 Adults</option>
		                    <option value="4">4 Adults</option>
		                    <option value="5">5 Adults</option>
		                    <option value="6">6 Adults</option>
		                    <option value="7">7 Adults</option>
		                    <option value="8">8 Adults</option>
		                    <option value="9">9 Adults</option>
		                    <option value="10">10 Adults</option>
		                  </select>
		                </div>
		                <div class="form-group ml-1">
		                  <label>Childrens</label>
		                  <select name="trip_board_childcount" class="form-control">
		                    <option selected="selected" value="0">아이없음</option>
		                    <option value="1">1 child</option>
		                    <option value="2">2 children</option>
		                    <option value="3">3 children</option>
		                    <option value="4">4 children</option>
		                    <option value="5">5 children</option>
		                    <option value="6">6 children</option>
		                    <option value="7">7 children</option>
		                    <option value="8">8 children</option>
		                    <option value="9">9 children</option>
		                    <option value="10">10 children</option>
		                  </select>
		                </div>
		                <div class="form-group ml-1 pull-right">
		                	<label>Make a board public?</label>
		                	<div class="material-switch input-group pull-right">
		                		<input id="someSwitchOptionSuccess" name="trip_board_bool" type="checkbox" checked="checked" class="form-control"/>
		                		<label for="someSwitchOptionSuccess" class="label-success"></label>
		                	</div>
		                </div>
		                <div class="form-group ml-1 pull-right">
		                	<label>Do you want party?</label>
		                	<div class="material-switch input-group pull-right">
		                		<input id="someSwitchOptionSuccess2" name="trip_board_recruit" type="checkbox" class="form-control"/>
		                		<label for="someSwitchOptionSuccess2" class="label-success"></label>
		                	</div>
		                </div>
		              </div>
		            </div>
		            <!-- filters end -->
		          </div>
		        </div>
		<!--         section end -->
		        <div class="container">
		          <div class="row justify-content-lg-center">
		            <div class="col-lg-8 text-center pv-20">
		<!--               <h1 class="title">Wellcome to Hotel</h1> -->
		<!--               <div class="separator mt-10"></div> -->
		<!--               <p class="text-center">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Excepturi perferendis magnam ea necessitatibus, officiis voluptas odit! Aperiam omnis, cupiditate laudantium velit nostrum, exercitationem accusamus, possimus soluta illo deserunt tempora qui.</p> -->
		            </div>
		          </div>
		        </div>
	        </div>
	      </div>
	      </div>
	     </div> 
		
		<input type="hidden" name="member_id" value="${member_id}">
		<input type="hidden" name="member_nick" value="${member_nick}">
		
		
		<!-- container -->
		<div class="container-fluid one">
			<div class="row">
				<div class="col-sm-2">
					<!--경로추가되는곳 -->
					<div class="searchClass">
						<input type="text" placeholder="주소를 입력하세요" class="btn btn-default form-control">
						<input type="button" class="btn btn-success pull-right" value="검색">
					<br><br><br><br>
					</div>
					<div>
						<ul id="search" class="text-center">
							<li>
								<div class="btn btn-default" onclick='selectTansportType(0)' id="car"  checked>
									<img src="${contextPath }/img/sports-car.png" width="15px" height="15px">자동차
								</div>
							</li>
							<li>
								<div class="btn btn-default" onclick='selectTansportType(1)' id="public transport" >
									<img src="${contextPath }/img/subway.png" width="15px" height="15px">대중교통
								</div>
							</li>
							<li>
								<div class="btn btn-default" onclick='selectTansportType(2)' id="bicycle" >
									<img src="${contextPath }/img/bicycle.png" width="15px" height="15px">자전거
								</div>
							</li>
							<li>
								<div class="btn btn-default" onclick='selectTansportType(3)' id="walk"  style="padding: 6px 12px 6px 12px;">
									<img src="${contextPath }/img/running (1).png" width="15px" height="15px">도보
								</div>
							</li>
						</ul>
					</div>
					<div id="routesNav"></div>
				</div>
				<div class="col-sm-7">
					<div id="map" style="height:800px;width:800px;" class=""></div><br><br>
				</div>
				
				<!-- 가볼만한곳 시작 -->
				<div class="col-sm-3">
	   				<div class="panel panel-default text-center">
	   					<div class="panel-heading">
	   						<h2>#Favorite</h2>
<!-- 	   							<span class="glyphicon glyphicon-exclamation-sign"></span> -->
<%-- 	   							<img src="${contextPath }/img/information-in-circular-button.png" width="25px" height="25px"> --%>
	   							<div class="btn-group" data-toggle="buttons">
	   								<label class="btn btn-primary active" onclick="findingPlace('12', '1')">
	   									<input type="radio" name="placeoptions" checked>관광지
	   								</label>
	   								<label class="btn btn-primary" onclick="findingPlace('14', '1')">
	   									<input type="radio" name="placeoptions">문화시설
	   								</label>
	   								<label class="btn btn-primary" onclick="findingPlace('28', '1')">
	   									<input type="radio" name="placeoptions">레포츠
	   								</label>
	   								<label class="btn btn-primary" onclick="findingPlace('38', '1')">
	   									<input type="radio" name="placeoptions">쇼핑
	   								</label>
	   								<label class="btn btn-primary" onclick="findingPlace('39', '1')">
	   									<input type="radio" name="placeoptions">맛집
	   								</label>
	   								<label class="btn btn-primary" onclick="findingPlace('15', '1')">
	   									<input type="radio" name="placeoptions">각종행사
	   								</label>
	   							</div>
	   					</div>
	   					<div class="panel-place-body" style="overflow:scroll;overflow-x:hidden;">
	   					<!-- 추천명소들어올곳 -->
	   					</div>
	   					<div class="panel-footer panel-place-footer">
<!-- 	   						<button class="btn btn-info" data-toggle="modal" data-target="#myModal">더 알아보기</button> -->
	   					</div>
	   				</div>
				</div>
				<!-- 가볼만한곳 끝 -->
				<!-- rest시작 -->
				<div class="col-sm-3">
	   				<div class="panel panel-default text-center">
	   					<div class="panel-heading">
	   							<h2>#Rest</h2>
<!-- 	   							<span class="glyphicon glyphicon-exclamation-sign"></span> -->
<%-- 								<img src="${contextPath }/img/information-in-circular-button.png" width="25px" height="25px"> --%>
	   							<div class="btn-group" data-toggle="buttons">
	   								<label class="btn btn-primary active" onclick="findingStay('32', '1')">
	   									<input type="radio" name="restoptions" checked>숙박
	   								</label>
	   								<label class="btn btn-primary" onclick="restoption('conveniencestore')">
	   									<input type="radio" name="restoptions">편의점
	   								</label>
	   								<label class="btn btn-primary" onclick="restoption('hospital')">
	   									<input type="radio" name="restoptions">병원
	   								</label>
	   								<label class="btn btn-primary" onclick="restoption('gasstation')">
	   									<input type="radio" name="restoptions">주유소
	   								</label>
	   							</div>
	   					</div>
	   					<div class="panel-rest-body" style="overflow:scroll;overflow-x:hidden;">
	   					</div>
	   					<div class="panel-footer panel-rest-footer">
<!-- 	   						<button class="btn btn-info" data-toggle="modal" data-target="#myModal-2">더 알아보기</button> -->
	   					</div>
	   				</div>
				</div>
			</div>
		</div>
		
		
		<!-- modal -->
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog">
				<!-- modal content -->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4><img alt="" src="${contextPath }/img/exclamation-mark.png" width="30px" height="30px">&nbsp;More..</h4>
					</div>
					<div class="modal-body">
						<div role="form">
							<div class="form-group">
								<label for="psw"></label>
								#부산
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-danger btn-default pull-left" data-dismiss="modal">
							<span class="glyphicon glyphicon-remove"></span>
						</button>
						<p>Need<a href="#">Help?</a></p>
					</div>
				</div>
			</div>
		</div>
		<div class="modal fade" id="myModal-2" role="dialog">
			<div class="modal-dialog">
				<!-- modal content -->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4><span class="glyphicon glyphicon-lock"></span>More..</h4>
					</div>
					<div class="modal-body">
						<div role="form">
							<div class="form-group">
								<label for="psw"></label>
								#Gs수유리점
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-danger btn-default pull-left" data-dismiss="modal">
							<span class="glyphicon glyphicon-remove"></span>
						</button>
						<p>Need</p>&nbsp;&nbsp;<a href="#">Help?</a>
					</div>
				</div>
			</div>
		</div>
	
	
      <!-- banner end -->
      
      
      <!-- 스케쥴 시작 -->
      <div class="container-fluid">
      	<div class="table-responsive">
      		<a class="text-center pull-right btn-danger" name="addStaff" id="reset1">일정초기화버튼입니다.</a>
      		<table class="table table-hover">
      			<thead>
      				<tr>
      					<th class="text-center"><a href="#" class="btn btn-info btn-lg"><span class="glyphicon glyphicon-calendar"></span>Schedule View</a></th>
      					<th class="text-center"><p class="text-primary">What Dates</p></th>
      					<th class="text-center"><p class="text-primary">Start Point</p></th>
      					<th class="text-center"><p class="text-primary">WayPoint</p></th>
      					<th class="text-center"><p class="text-primary">Destination</p></th>
      					<th class="text-center"><p class="text-primary">Expected Travel Cost</p></th>
      					<th class="text-center"><p class="text-primary">Memo</p></th>
      				</tr>
      			</thead>
      			<tbody name="trStaff">
<!--       				<tr class="text-center" name="trStaff"> -->
<!--       					<td><p class="text-center text-primary" name="staff_Number"></p></td> -->
<!--       					<td><input class="text-center bg-success form-control" type="text" name="staff_Period" placeholder="x일차"></td> -->
<!--       					<td><input class="text-center bg-success form-control" type="text" name="start_address" placeholder="출발지"></td> -->
<!--       					<td><input class="text-center bg-success form-control" type="text" name="via_address" placeholder="경유지(첫 경유지만표시됩니다.)"></td> -->
<!--       					<td><input class="text-center bg-success form-control" type="text" name="end_address" placeholder="도착지"></td> -->
<!--       					<td><input class="text-center bg-success form-control" type="text" name="daily_trip_cost" placeholder="예상비용"></td> -->
<!--       					<td><input class="text-center bg-success form-control" type="text" name="daily_trip_memo" placeholder="특이사항을 적어주세요"></td> -->
<!--       				</tr> -->
      			</tbody>
      		</table>
      	</div>
      </div>	
      	<br><br><br><br><br><br><br><br><br><br><br><br>
      	
      	
      	<div class="container last">
      		
      	
      		<div class="row">
      			<div class="col-sm-12">
      				<label class="pull-left"><img src="${contextPath }/img/sound-651706_640.png" style="width: 25px; height: 25px;">&nbsp;&nbsp;<font class="text-danger">회원들에게 알릴 글 제목을 입력해주세요</font></label>
	      	<div class="row">
		      	<div class="col-sm-12">
		      		<br>
		      		<label>글 제목 : <input type="text" name="trip_board_title" class="pull-left form-control" placeholder="제목을 입력해주세요"></label>
		      	</div>	
	      	</div>			
	      <br><br><br><br><br>
	      <div class="row">
      			<div class="col-sm-12">
      				<label class="pull-left"><img src="${contextPath }/img/sound-651706_640.png" style="width: 25px; height: 25px;">&nbsp;&nbsp;<font class="text-danger">회원들에게 알릴 메세지를 남겨주세요</font></label>
      				<textarea rows="10" cols="10" name="trip_board_memo" class="form-control" placeholder="글자수 2000자 제한입니다."></textarea>
      			</div>
      		</div>	
	      			
      			</div>
      		</div>
      	</div>	
      	
      	<br><br><br>
      <div class="wrap">	
      	<div class="row text-center">
      	  <div class="col-sm-12">
	      	  <input type="reset" value="다시 쓰기" onclick="button4_reset()" class="btn btn-danger primary">
		      <input type="button" value="등록" onclick="board_write()" class="btn btn-success primary">
		      <a href="tripBoardBoolList" class="btn btn-primary primary">목록보기</a>
	      </div>
	   </div>
	  </div>
	
	</form>
	
	<br><br><br><br><br><br>
	
<!-- 	<div class="footer text-center"> -->
<!-- 	 	<a href="#myPage" title="To Top"> -->
<!-- 		 	<span class="glyphicon glyphicon-chevron-up"></span> -->
<!-- 		 </a> -->
		 
<!-- 		 <br><br><br><br> -->
<!-- 		<div class="container-fluid" id="icon"> -->
<!-- 		    <div class="row"> -->
<!-- 				<div class="sicon"> -->
<!-- 					<div class="col-lg-1 col-md-1 col-sm-2 col-xs-3 text-center"> -->
<!-- 						<div class="icon-circle text-center"> -->
<!-- 							<a href="#" class="ifacebook" title="Facebook"><i class="fa fa-facebook"></i></a> -->
<!-- 						</div> -->
<!-- 					</div> -->
		     
<!-- 					<div class="col-lg-1 col-md-1 col-sm-2 col-xs-3 text-center"> -->
<!-- 						<div class="icon-circle"> -->
<!-- 							<a href="#" class="itwittter" title="Twitter"><i class="fa fa-twitter"></i></a> -->
<!-- 						</div> -->
<!-- 					</div> -->
		      
<!-- 					<div class="col-lg-1 col-md-1 col-sm-2 col-xs-3 text-center"> -->
<!-- 						<div class="icon-circle"> -->
<!-- 							<a href="#" class="igoogle" title="Google+"><i class="fa fa-google-plus"></i></a> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
</body>
<script type="text/javascript"
		src="https://openapi.map.naver.com/openapi/v3/
		maps.js?clientId=C3g17HQW9Nteyqp72svy&submodules=panorama,geocoder,drawing">
		</script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a0dabed2865c6b9cb878feb60563940b&libraries=services,clusterer,drawing"></script>

<script src="${contextPath}/js/tripBoardWrite.js" charset="UTF-8"></script>
<script src="${contextPath}/js/tripBoardRecommends.js" charset="UTF-8"></script>
</html>
