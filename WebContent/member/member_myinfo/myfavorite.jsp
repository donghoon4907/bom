<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<link rel="stylesheet" type="text/css" href="/final/css/member/member_myfavorite.css">

<div class="member-myinfo-favorite">
	<div class="member-myinfo-favorite-list-wrap">	
		<div class="member-myinfo-favorite-list">
			<div class="member-myinfo-favorite-list-title">
				<span class="favorite-text-sub">번호</span>
				<span class="favorite-text-sub"></span>
				<span class="favorite-text-sub">영화명</span>
				<span class="favorite-text-sub">상영시간</span>
				<span class="favorite-text-sub">시청시간</span>
			</div>
			<div class="member-myinfo-favorite-items">
				<div class="member-myinfo-favorite-item">
					<span class="favorite-text-item">1</span>
					<span class="favorite-text-item"><img src="http://placehold.it/80x110"></span>
					<span class="favorite-text-item">2019.04.03</span>
					<span class="favorite-text-item">00:00:00</span>
					<span class="favorite-text-item">00:00:00</span>
				</div>
				<div class="member-myinfo-favorite-item">
					<span class="favorite-text-item">1</span>
					<span class="favorite-text-item"><img src="http://placehold.it/80x110"></span>
					<span class="favorite-text-item">2019.04.03</span>
					<span class="favorite-text-item">00:00:00</span>
					<span class="favorite-text-item">00:00:00</span>
				</div>
												<div class="member-myinfo-favorite-item">
					<span class="favorite-text-item">1</span>
					<span class="favorite-text-item"><img src="http://placehold.it/80x110"></span>
					<span class="favorite-text-item">2019.04.03</span>
					<span class="favorite-text-item">00:00:00</span>
					<span class="favorite-text-item">00:00:00</span>
				</div>
				<div class="member-myinfo-favorite-item">
					<span class="favorite-text-item">1</span>
					<span class="favorite-text-item"><img src="http://placehold.it/80x110"></span>
					<span class="favorite-text-item">2019.04.03</span>
					<span class="favorite-text-item">00:00:00</span>
					<span class="favorite-text-item">00:00:00</span>
				</div>			
			</div>
			<div class="member-myinfo-favorite-pagination-box">
				<div class="favorite-page-buttons">
					<a href="#" class="favorite-page-btn-dpre">&lt;&lt;</a>
					<a href="#" class="favorite-page-btn-pre">&lt;</a>
					<a href="#" class="favorite-page-btn favorite-page-btn-activity">1</a>
					<a href="#" class="favorite-page-btn">2</a>
					<a href="#" class="favorite-page-btn">3</a>
					<a href="#" class="favorite-page-btn">4</a>
					<a href="#" class="favorite-page-btn">5</a>
					<a href="#" class="favorite-page-btn-ne">&gt;</a>
					<a href="#" class="favorite-page-btn-dne">&gt;&gt;</a>
				</div>
				<div class="favorite-page-number">
					 0 / 0 페이지
				</div>
			</div>
		</div>
	</div>
</div>
<input type="text" id='bms' value="${bomMemberSeiral }">
<script>
var serial = $(bms).val();
console.log(serial);

$('.favorite-page-btn').click(function(){
	  $(this).parent().children('.favorite-page-btn').removeClass('favorite-page-btn-activity');
	  $(this).addClass('favorite-page-btn-activity');
});

$.ajax({
	url : 'FavoriteList.mem',
	type : 'POST',
	data : { 'serial' : serial},
	dataType : 'json',
	success : function(json){
		console.log(json);
	},error : function(error) {
		alert(error);
	}
});


</script>
