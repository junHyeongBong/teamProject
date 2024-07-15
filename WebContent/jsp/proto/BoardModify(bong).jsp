<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri= "http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value = "${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script> 
  
<!-- bootstrap cdn -->  
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- googleMap -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

<!-- datepicker cdn -->
<script type='text/javascript' src='//code.jquery.com/jquery-1.8.3.js'></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/css/bootstrap-datepicker3.min.css">
<script type='text/javascript' src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/js/bootstrap-datepicker.min.js"></script>
<script src="${contextPath }/js/bootstrap-datepicker.kr.js" charset="UTF-8"></script>

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
<script type="text/javascript" src="${contextPath }/js/map.js"></script>


<script type="text/javascript">

	//table 행 추가 기능
	$(document).on("click","a[name=addStaff]",function(){
		var addStaffText = '<tr name="trStaff">'+
							   '<td>'+
							   	 '<p class="text-center text-primary" name="staff_Number"></p>'+
							   '</td>'+
							   '<td>'+
							     '<input class="text-center bg-success form-control" type="text" name="staff_Period" placeholder="기간을 적어주세요">'+
							   '</td>'+
							   '<td>'+
							     '<input class="text-center bg-success form-control" type="text" name="staff_Start" placeholder="출발지를 적어주세요">'+
							   '</td>'+
							   '<td>'+
							     '<input class="text-center bg-success form-control" type="text" name="staff_Waypoint" placeholder="경유지를 적어주세요">'+
							   '</td>'+
							   '<td>'+
							     '<input class="text-center bg-success form-control" type="text" name="staff_Destination" placeholder="도착지를 적어주세요">'+
							   '</td>'+
							   '<td>'+
							     '<input class="text-center bg-success form-control" type="text" name="staff_Cost" placeholder="예상비용을 적어주세요">'+
							   '</td>'+
							   '<td>'+
							   	  '<input class="text-center bg-success form-control" type="text" name="staff_Memo" placeholder="특이사항을 적어주세요">'+
							   '</td>'+
							   '<td>'+
							     '<a class="btn btn-danger text-center form-control" name="delStaff">삭제</a>'+
							   '</td>'+
						   '</tr>';
						   
		var trHtml = $("tr[name=trStaff]:last"); //last를 사용하여 trStaff라는 명을 가진 마지막 태그 호출
		
		trHtml.after(addStaffText); //마지막 trStaff명 뒤에 붙인다.
		
	});

	//행 삭제버튼
	$(document).on("click","a[name=delStaff]", function(){
		var trHtml = $(this).parent().parent();
		trHtml.remove(); //tr태그 삭제
		
	});
	
	$(function(){

        $('.input-group.date').datepicker({

            calendarWeeks: false,

            todayHighlight: true,

            autoclose: true,

            format: "yyyy/mm/dd",

            language: "kr"

        });

    });

</script>

<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>With Us</title>
</head>
<body id="myPage" data-spy="scroll" data-target=".navbar" data-offset="60">	
		<nav class="navbar navbar-default navbar-fixed-top">
			<div class="container">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="#">TF</a>
				</div>		
					<div class="collapse navbar-collapse" id="myNavbar">
						<ul class="nav navbar-nav navbar-right">
							<li><a href="#">Travel Schedule</a></li>
							<li><a href="#">I'm back</a></li>
							<li><a href="#">With Us</a></li>
							<li><a href="#">Join</a></li>
							<li><a class="active" href="#">Log in</a></li>
						</ul>
				</div>	
			</div>
		</nav>
		
		<div class="jumbotron text-center bg-1">
			<h1>Write Your Dream</h1>
		</div>
		
		<!-- container -->
		<div class="container-fluid one">
			<div class="row">
				<div class="col-sm-2">
					<!--경로추가되는곳 -->
					<div class="searchClass">
						<input type="text" placeholder="주소를 입력하세요" class="btn btn-default form-control">
						<button class="btn btn-success pull-right">검색</button><br>
					
					<br><br>
						<ul id="search" class="text-center">
							<li>
								<button class="btn btn-default" onclick="selectTansportType(0);alert('자동차를 선택하셨습니다.');" id="car" autocomplete="off" checked><img src="${contextPath }/img/sports-car.png" width="15px" height="15px">자동차</button>
							</li>
							<li>
								<button class="btn btn-default" onclick="selectTansportType(1);alert('대중교통을 선택하셨습니다.');" id="public transport" autocomplete="off"><img src="${contextPath }/img/subway.png" width="15px" height="15px">대중교통</button>
							</li>
							<li>
								<button class="btn btn-default" onclick="selectTansportType(2);alert('자전거를 선택하셨습니다.');" id="bicycle" autocomplete="off"><img src="${contextPath }/img/bicycle.png" width="15px" height="15px">자전거</button>
							</li>
							<li>
								<button class="btn btn-default" onclick="selectTansportType(3);alert('도보를 선택하셨습니다.');" id="walk" autocomplete="off" style="padding: 6px 14px 6px 14px;"><img src="${contextPath }/img/running (1).png" width="15px" height="15px">도보</button>
							</li>
						</ul>
					</div>	
					<div id="routesNav"></div>
				</div>
				<div class="col-sm-7">
					<div id="map" style="height:750px;width:100%" class=""></div><br><br>
				</div>
				<!-- 가볼만한곳 시작 -->
				<div class="col-sm-3">
	   				<div class="panel panel-default text-center">
	   					<div class="panel-heading">
	   						<h2>#Favorite</h2>
<!-- 	   							<span class="glyphicon glyphicon-exclamation-sign"></span> -->
	   							<img src="${contextPath }/img/information-in-circular-button.png" width="25px" height="25px">
	   							<div class="btn-group" data-toggle="buttons">
	   								<label class="btn btn-primary active">
	   									<input type="radio" name="options" id="option1" autocomplete="off" checked>전체
	   								</label>
	   								<label class="btn btn-primary">
	   									<input type="radio" name="options" id="option2" autocomplete="off">스포츠
	   								</label>
	   								<label class="btn btn-primary">
	   									<input type="radio" name="options" id="option3" autocomplete="off">캠핑
	   								</label>
	   								<label class="btn btn-primary">
	   									<input type="radio" name="options" id="option4" autocomplete="off">먹거리
	   								</label>
	   								<label class="btn btn-primary">
	   									<input type="radio" name="options" id="option5" autocomplete="off">힐링
	   								</label>
	   								<label class="btn btn-primary">
	   									<input type="radio" name="options" id="option6" autocomplete="off">문화
	   								</label>
	   							</div>
	   					</div>
	   					<div class="panel-body">
	   						<p>#서울</p>
	   						<p>#서울</p>
	   						<p>#서울</p>
	   						<p>#서울</p>
	   					</div>
	   					<div class="panel-footer">
	   						<button class="btn btn-info" data-toggle="modal" data-target="#myModal">더 알아보기</button>
	   					</div>
	   				</div>
				</div>
				
				
				
				<!-- 가볼만한곳 끝 -->
				<div class="col-sm-3">
	   				<div class="panel panel-default text-center">
	   					<div class="panel-heading">
	   							<h2>#Rest</h2>
<!-- 	   							<span class="glyphicon glyphicon-exclamation-sign"></span> -->
								<img src="${contextPath }/img/information-in-circular-button.png" width="25px" height="25px">
	   							<div class="btn-group" data-toggle="buttons">
	   								<label class="btn btn-primary active">
	   									<input type="radio" name="options" id="option1" autocomplete="off" checked>전체
	   								</label>
	   								<label class="btn btn-primary">
	   									<input type="radio" name="options" id="option2" autocomplete="off">편의시설
	   								</label>
	   								<label class="btn btn-primary">
	   									<input type="radio" name="options" id="option3" autocomplete="off">숙박
	   								</label>
	   							</div>
	   					</div>
	   					<div class="panel-body">
	   						<p>#Cu 강남역점</p>
	   						<p>#GS25시 서울역점</p>
	   						<p>#GS25시 서울역점</p>
	   						<p>#GS25시 서울역점</p>
	   						<p>#GS25시 서울역점</p>
	   					</div>
	   					<div class="panel-footer">
	   						<button class="btn btn-info" data-toggle="modal" data-target="#myModal-2">더 알아보기</button>
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
						<form role="form">
							<div class="form-group">
								<label for="psw"></label>
								#부산
							</div>
						</form>
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
						<form role="form">
							<div class="form-group">
								<label for="psw"></label>
								#Gs수유리점
							</div>
						</form>
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
		              <form class="form-inline">
		              	<div class="form-group">
		              		<label>Depart On</label>
			              		<div class="input-group date">
			              			<input type="text" class="form-control"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
			              		</div>
		              	</div>
		              	<div class="form-group ml-1">
		              		<label>Return On</label>
			              		<div class="input-group date">
				              		<input type="text" class="form-control"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
			              		</div>		              
		              	</div>
		                <div class="form-group ml-1">
		                  <label>Rooms</label>
		                  <select class="form-control">
		                    <option selected="selected">default</option>
		                    <option>1 Rooms</option>
		                    <option>2 Rooms</option>
		                    <option>3 Rooms</option>
		                    <option>4 Rooms</option>
		                    <option>5 Rooms</option>
		                    <option>6 Rooms</option>
		                    <option>7 Rooms</option>
		                    <option>8 Rooms</option>
		                    <option>9 Rooms</option>
		                    <option>10 Rooms</option>
		                  </select>
		                </div>
		                <div class="form-group ml-1">
		                  <label>Mens</label>
		                  <select class="form-control">
		                    <option selected="selected">default</option>
		                    <option>1 Adults</option>
		                    <option>2 Adults</option>
		                    <option>3 Adults</option>
		                    <option>4 Adults</option>
		                    <option>5 Adults</option>
		                    <option>6 Adults</option>
		                    <option>7 Adults</option>
		                    <option>8 Adults</option>
		                    <option>9 Adults</option>
		                    <option>10 Adults</option>
		                  </select>
		                </div>
		                <div class="form-group ml-1">
		                  <label>Womans</label>
		                  <select class="form-control">
		                    <option selected="selected">default</option>
		                    <option>1 Adults</option>
		                    <option>2 Adults</option>
		                    <option>3 Adults</option>
		                    <option>4 Adults</option>
		                    <option>5 Adults</option>
		                    <option>6 Adults</option>
		                    <option>7 Adults</option>
		                    <option>8 Adults</option>
		                    <option>9 Adults</option>
		                    <option>10 Adults</option>
		                  </select>
		                </div>
		                <div class="form-group ml-1">
		                  <label>Childrens</label>
		                  <select class="form-control">
		                    <option selected="selected">default</option>
		                    <option>1 children</option>
		                    <option>2 children</option>
		                    <option>3 children</option>
		                    <option>4 children</option>
		                    <option>5 children</option>
		                    <option>6 children</option>
		                    <option>7 children</option>
		                    <option>8 children</option>
		                    <option>9 children</option>
		                    <option>10 children</option>
		                  </select>
		                </div>
		                <div class="form-group ml-1 pull-right">
		                	<label>Do you want party?</label>
		                	<div class="material-switch input-group pull-right">
		                		<input id="someSwitchOptionSuccess" name="someSwitchOption001" type="checkbox" class="form-control"/>
		                		<label for="someSwitchOptionSuccess" class="label-success"></label>
		                	</div>
		                </div>
		              </form>
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
      <!-- banner end -->
      
      
      <!-- 스케쥴 시작 -->
     <form action="">
      <div class="container-fluid">
      	<div class="table-responsive">
      		<a class="text-center pull-right btn-success" name="addStaff"><span class="glyphicon glyphicon-plus"></span></a> <!-- 동적 추가버튼 -->
      		<table class="table table-hover">
      			<thead>
      				<tr>
      					<th class="text-center"><a href="#" class="btn btn-info btn-lg"><span class="glyphicon glyphicon-calendar"></span>Schedule View</a></th>
      					<th class="text-center"><p class="text-primary">Travel Period</p></th>
      					<th class="text-center"><p class="text-primary">Start Point</p></th>
      					<th class="text-center"><p class="text-primary">WayPoint</p></th>
      					<th class="text-center"><p class="text-primary">Destination</p></th>
      					<th class="text-center"><p class="text-primary">Expected Travel Cost</p></th>
      					<th class="text-center"><p class="text-primary">Memo</p></th>
      					<th class="text-center"><p class="text-primary">Option</p></th>
      				</tr>
      			</thead>
      			<tbody>
      				<tr class="text-center" name="trStaff">
      					<td><p class="text-center text-primary" name="staff_Number"></p></td>
      					<td><input class="text-center bg-success form-control" type="text" name="staff_Period" placeholder="기간을 적어주세요"></td>
      					<td><input class="text-center bg-success form-control" type="text" name="staff_Start" placeholder="출발지를 적어주세요"></td>
      					<td><input class="text-center bg-success form-control" type="text" name="staff_Waypoint" placeholder="경유지를 적어주세요"></td>
      					<td><input class="text-center bg-success form-control" type="text" name="staff_Destination" placeholder="도착지를 적어주세요"></td>
      					<td><input class="text-center bg-success form-control" type="text" name="staff_Cost" placeholder="예상비용을 적어주세요"></td>
      					<td><input class="text-center bg-success form-control" type="text" name="staff_Memo" placeholder="특이사항을 적어주세요"></td>
      				</tr>
      			</tbody>
      		</table>
      	</div>
      </div>	
      	<br><br><br><br><br><br><br><br><br><br><br><br>
      	
      	
      	<div class="container last">
      		<div class="row">
      			<div class="col-sm-12">
      				<label class="pull-left"><img src="${contextPath }/img/sound-651706_640.png" style="width: 25px; height: 25px;">&nbsp;&nbsp;<font class="text-danger">회원들에게 전해줄 메세지를 남겨주세요</font></label>
      				<textarea rows="10" cols="10" class="form-control" placeholder="글자수 2000자 제한입니다."></textarea>
      			</div>
      		</div>
      	</div>	
      	
      	<br><br><br>
      <div class="wrap">	
      	<div class="row text-center">
      	  <div class="col-sm-12">
	      	  <input type="reset" value="다시 쓰기" class="btn btn-default primary">
		      <input type="submit" value="수정" class="btn btn-success primary">
		      <input type="submit" value="삭제" class="btn btn-danger primary">
		      <a href="#" class="btn btn-primary primary">목록보기</a>
	      </div>
	   </div>
	  </div> 
	</form>
	
	
	<br><br><br><br>
	
	
	<div class="footer text-center">
	 	<a href="#myPage" title="To Top">
		 	<span class="glyphicon glyphicon-chevron-up"></span>
		 </a>
	</div>


	
	
</body>
<script type="text/javascript"
		src="https://openapi.map.naver.com/openapi/v3/
		maps.js?clientId=C3g17HQW9Nteyqp72svy&submodules=panorama,geocoder,drawing">
		</script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a0dabed2865c6b9cb878feb60563940b&libraries=services,clusterer,drawing"></script>


<script src="${contextPath}/js/findroute.js" charset="UTF-8"></script>
</html>
