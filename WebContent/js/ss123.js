var orderOption = 'latest';

$(document).ready(function(){
	makeBoardList(1, orderOption);
	makePaging();
	$("#mainContent").empty();
	
	$.ajaxSettings.traditional = true;
	$.ajax({
		type:"POST",
		url:"../common/getTripBoardListData",
		data: {
			selectPageNum:selectPage,
			boardListOrder:selectOrder
		},
		success:function(data){
			var boardList = data;
			$("#mainContent").append(
				<div class="card container-photo">
					<div class="box">
						<div class="imgBox">
							<img class="img-fluid" src="${contextPath }/img/ivy-3519431_1920.jpg">
						</div>
						<div class="card-img-overlay">
							<span class="badge badge-pill badge-danger">Hot</span>
						</div>
						<div class="content">
							<h2>Hey Cheese</h2>
							<p>I'm very awesome!!</p>
							<a class="btn" href="#">Detail View >></a>
						</div>
					</div>
					<div class="card-body">
						<div class="news-title text-center">
							<div class="header">
								<h2>
									<a href="#">제목</a>
								</h2>
								<div class="post-info">
									<span class="post-date"> <iclass="fa fa-calendar-o pr-1"></i> <span class="day">11</span>
									<span class="month">May 2017</span>
									<span class="submitted"><i class="fa fa-user pr-1 pl-1"></i> by <a href="#">John Doe</a></span>
									<span class="comments"><i class="fa fa-comments-o pl-1 pr-1"></i> <a href="#">22comments</a></span>
								</div>
							</div>
							<div class="blogpost-content">
								<p>
									Mauris dolor sapien, malesuada at interdum ut,
									hendrerit eget lorem. Nunc interdum mi neque, et sollicitudin
									purus fermentum ut. Suspendisse faucibus nibh odio, a
								</p>
							</div>
						</div>
					</div>
				</div>
			);			
		},error:function(data){
			alert("주변 편의시설이 없습니다.");
		}
	})
}

function boardListSort(){
	orderOption = $("#order_option").val();
	makePaging();
	makeBoardList(1, orderOption);
}

function makeBoardList(selectPage, selectOrder){
	$(".trip_boardList").empty();
	
	$.ajaxSettings.traditional = true;
	$.ajax({
		type:"POST",
		url:"../common/getTripBoardListData",
		data: {
			selectPageNum:selectPage,
			boardListOrder:selectOrder
		},
		success:function(data){
			var boardList = data;
			
			console.log(boardList);
			
			for(var i=0; i<boardList.length; i++){
				$(".trip_boardList").append(
					'<div class="col-sm-6 trip_board">'
						+'<div class="overlay-container">'
							+'<img src="../img/architecture-768432_1920.jpg" alt="">'
						+'</div>'
						+'<div class="header">'
							+'<h2>'
								+'<a href="../common/readOneTripBoard?trip_board_num='+boardList[i].trip_board_num+'">'+boardList[i].trip_board_title+'</a>'
							+'</h2>'
							+'<div class="post-info">'
								+'<span class="post-date">'
									+'<i class="fa fa-calendar-o pr-1"></i>'
									+boardList[i].trip_board_startdate+'~'+boardList[i].trip_board_enddate
								+'</span>'
								+'<span class="submitted">'
									+'<i class="fa fa-user pr-1 pl-1"></i><a href="#">'+boardList[i].member_nick+'</a>'
								+'</span>'
								+'<span class="comments">'
									+'<i class="fa fa-comments-o pl-1 pr-1"></i>12'
								+'</span>'
								+'<span>'
									+'<i class="far fa-eye"></i>'+boardList[i].trip_board_hits
								+'</span>'
								+'<span>'
									+'<i class="far fa-thumbs-up"></i>'+boardList[i].trip_board_recommend
								+'</span>'
							+'</div>'
						+'</div>'
						+'<div class="blogpost-content">'
							+'<p>'
								+boardList[i].trip_board_memo
							+'</p>'
						+'</div>'
					+'</div>'
				);
			}
		},
		error:function(data){
			alert("주변 편의시설이 없습니다.");
		}
	})
}

function makePaging(){
	$(".blog-pager").empty();
	
	$.ajaxSettings.traditional = true;
	$.ajax({
		type:"POST",
		url:"../common/getTripBoardListPaging",
		success:function(data){
			var paging = data;
			
//			$(".blog-pager").append('<span class="page-num page-active" onclick="makeBoardList(1,\''+orderOption+'\')">1</span>');
			for(var i=0; i<paging.length; i++){
				$(".blog-pager").append(
					'<a class="page-num" onclick="makeBoardList('+paging[i]+',\''+orderOption+'\')">'+paging[i]+'</a>'
				);
			}
		},
		error:function(data){
			alert("주변 편의시설이 없습니다.");
		}
	})
}