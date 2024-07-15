var sortType = "latest";
var searchText = "";

$(document).ready(function(){
	if(pageType == 'bool'){
		$("#mainContent").empty();
		
		$.ajaxSettings.traditional = true;
		$.ajaxSetup({
		    headers: {
		      'X-CSRF-Token': $('meta[name="csrf_token"]').attr('content')
		    }
		});
		$.ajax({
			type:"POST",
			url:"../common/bestRecoTripBoard",
			success:function(data){
				var bestBoard = data;
				$("#mainContent").append(
					'<div class="card container-photo">'
					+'	<div class="box">'
					+'		<div class="imgBox">'
					+'			<img class="img-fluid" src="../img/ivy-3519431_1920.jpg">'
					+'		</div>'
					+'		<div class="card-img-overlay">'
					+'			<span class="badge badge-pill badge-danger">Hot</span>'
					+'		</div>'
					+'		<div class="content">'
					+'			<h2>최고의 게시물!</h2>'
					+'			<p>Im very awesome!!</p>'
					+'			<a class="btn" href="../common/readOneTripBoard?pageType='+pageType+'&trip_board_num='+bestBoard.trip_board_num+'">Detail View >></a>'
					+'		</div>'
					+'	</div>'
					+'	<div class="card-body">'
					+'		<div class="news-title text-center">'
					+'			<div class="header">'
					+'				<h1>'
					+'					<a href="../common/readOneTripBoard?pageType='+pageType+'&trip_board_num='+bestBoard.trip_board_num+'">'+bestBoard.trip_board_title+'</a>'
					+'				</h1>'
					+'				<div class="post-info">'
					+'					<span class="post-date">'
					+'						<i class="fa fa-calendar-o pr-1"></i>'+bestBoard.trip_board_startdate+'~'+bestBoard.trip_board_enddate
					+'					</span><br>'
					+'					<span class="submitted">'
					+'						<i class="fa fa-user pr-1 pl-1"></i><a href="#">'+bestBoard.member_nick+'</a></span>'
					+'					<span class="comments">'
					+'						<i class="fa fa-comments-o pl-1 pr-1"></i>'+bestBoard.trip_board_reply_count
					+'					</span>'
					+'					<span>'
					+'						<i class="far fa-eye"></i>'+bestBoard.trip_board_hits
					+'					</span>'
					+'					<span>'
					+'						<i class="far fa-thumbs-up"></i>'+bestBoard.trip_board_recommend
					+'					</span>'
					+'				</div>'
					+'			</div>'
					+'			<div class="blogpost-content">'
					+'				<p>'
					+					bestBoard.trip_board_memo
					+'				</p>'
					+'			</div>'
					+'		</div>'
					+'	</div>'
					+'</div>'
				);			
			},error:function(data){
				swal("최고추천이없습니다..");
			}
		})
	}else if(pageType == 'recruit'){
	    $(".player").mb_YTPlayer();
	}
	makeBoardListAndPaging(pageType, sortType, '1');
})

function boardListSort(){
	sortType = $("#order_option").val();
	makeBoardListAndPaging(pageType, sortType, '1');
	$('html, body').scrollTop($('.trip_boardList').offset().top);
}

function boardListSortRecruit(sortType){
	$('a').removeClass('page-active');
	$(this).addClass('page-active');
	sortType = sortType;
	makeBoardListAndPaging(pageType, sortType, '1');
}

function makeBoardListAndPaging(pageType, sortType, selectpage){
	$(".trip_boardList").empty();
	$(".blog-pager").empty();
	
	var imgArr = shuffleRandom();
	
	$.ajaxSettings.traditional = true;
	$.ajaxSetup({
	    headers: {
	      'X-CSRF-Token': $('meta[name="csrf_token"]').attr('content')
	    }
	});
	$.ajax({
		type:"POST",
		url:"../common/totalTripBoardListAndPaging",
		data: {
			pageType:pageType,
			sortType:sortType,
			selectpage:selectpage
		},
		success:function(data){
			var boardList = data[0];
			var paging = data[1];
			
			for(var i=0; i<boardList.length; i++){
				var tmpTitle;
				if(boardList[i].trip_board_title.length > 11){
	        		tmpTitle = boardList[i].trip_board_title.substr(0, 11) + '..';
	        	}else{
	        		tmpTitle = boardList[i].trip_board_title;
	        	}
				var tmpMemo;
				if(boardList[i].trip_board_memo.length > 20){
					tmpMemo = boardList[i].trip_board_memo.substr(0, 20) + '..';
	        	}else{
	        		tmpMemo = boardList[i].trip_board_memo;
	        	}
				$(".trip_boardList").append(
					'<div class="col-sm-6 trip_board">'
						+'<div class="overlay-container">'
							+'<img class="boardbackImg" src="../boardImg/boardback ('+imgArr[i]+').jpg" alt="">'
						+'</div>'
						+'<div class="header">'
							+'<h1>'
								+'<a href="../common/readOneTripBoard?pageType='+pageType+'&trip_board_num='+boardList[i].trip_board_num+'" title="'+boardList[i].trip_board_title+'">'+tmpTitle+'</a>'
							+'</h1>'
							+'<div class="post-info">'
								+'<span class="post-date">'
									+'<i class="fa fa-calendar-o pr-1"></i>'
									+boardList[i].trip_board_startdate+'~'+boardList[i].trip_board_enddate
								+'</span><br>'
								+'<span class="submitted">'
//									+'<i class="fa fa-user pr-1 pl-1"></i><a href="#">'+boardList[i].member_nick+'</a>'
									+'<i class="fa fa-user pr-1 pl-1"></i>'+boardList[i].member_nick
								+'</span>'
								+'<span class="comments">'
									+'<i class="fa fa-comments-o pl-1 pr-1"></i>'+boardList[i].trip_board_reply_count
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
								+tmpMemo
							+'</p>'
						+'</div>'
					+'</div>'
				);
			}
			for(var i=0; i<paging.length; i++){
				$(".blog-pager").append(
					'<a class="page-num" onclick="makeBoardListAndPaging(\''
					+pageType+'\',\''+sortType+'\',\''+paging[i]+'\')">'+paging[i]+'</a>'
				);
			}
			
		},
		error:function(data){
			swal("게시물이 없습니다.");
		}
	})
}

function searchingTripBoard(selectPageNum){
	searchOption = $(".searchOption").val();
	searchText = $("input[name=searchText]").val();
	makeSearchTripBoardAndPaging(pageType, searchOption, searchText, '1');
}

function makeSearchTripBoardAndPaging(pageType, searchOption, searchText, selectPage){
	$(".trip_boardList").empty();
	$(".blog-pager").empty();
	
	var imgArr = shuffleRandom();
	
	$.ajaxSetup({
	    headers: {
	      'X-CSRF-Token': $('meta[name="csrf_token"]').attr('content')
	    }
	});
	$.ajax({
		type:"POST",
		url:"searchTripBoardAndPaging",
		data:{
			pageType:pageType,
			searchOption:searchOption,
			searchText:searchText,
			selectPage:selectPage
		},
		success:function(data){
			var boardList = data[0];
			var paging = data[1];
			
			for(var i=0; i<boardList.length; i++){
				var tmpTitle;
				if(boardList[i].trip_board_title.length > 11){
	        		var tmpTitle = boardList[i].trip_board_title.substr(0, 11) + '..';
	        	}else{
	        		var tmpTitle = boardList[i].trip_board_title;
	        	}
				var tmpMemo;
				if(boardList[i].trip_board_memo.length > 20){
					tmpMemo = boardList[i].trip_board_memo.substr(0, 20) + '..';
	        	}else{
	        		tmpMemo = boardList[i].trip_board_memo;
	        	}
				$(".trip_boardList").append(
					'<div class="col-sm-6 trip_board">'
						+'<div class="overlay-container">'
							+'<img class="boardbackImg" src="../boardImg/boardback ('+imgArr[i]+').jpg" alt="">'
						+'</div>'
						+'<div class="header">'
							+'<h1>'
							+'<a href="../common/readOneTripBoard?pageType='+pageType+'&trip_board_num='+boardList[i].trip_board_num+'" title="'+boardList[i].trip_board_title+'">'+tmpTitle+'</a>'
							+'</h1>'
							+'<div class="post-info">'
								+'<span class="post-date">'
									+'<i class="fa fa-calendar-o pr-1"></i>'
									+boardList[i].trip_board_startdate+'~'+boardList[i].trip_board_enddate
								+'</span><br>'
								+'<span class="submitted">'
//									+'<i class="fa fa-user pr-1 pl-1"></i><a href="#">'+boardList[i].member_nick+'</a>'
									+'<i class="fa fa-user pr-1 pl-1"></i>'+boardList[i].member_nick
								+'</span>'
								+'<span class="comments">'
									+'<i class="fa fa-comments-o pl-1 pr-1"></i>'+boardList[i].trip_board_reply_count
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
								+tmpMemo
							+'</p>'
						+'</div>'
					+'</div>'
				);
			}
			for(var i=0; i<paging.length; i++){
				$(".blog-pager").append(
						'<a class="page-num" onclick="makeSearchTripBoardAndPaging(\''
						+pageType+'\',\''+sortType+'\',\''+paging[i]+'\')">'+paging[i]+'</a>'
					);
			}
			
			$('html, body').scrollTop($('.trip_boardList').offset().top);
		},
		error:function(data){
			swal("검색결과가 없습니다.");
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