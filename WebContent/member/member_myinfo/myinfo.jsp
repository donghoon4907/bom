<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<link rel="stylesheet" type="text/css" href="/final/css/member/member_myinfo.css">
<script src="/final/js/member/myinfo.js"></script>

<div class="member-myinfo-wrapper">
	<div class="myinfo-wrap">
		<div class ="member-myinfo-content">
		
			<div class="member-myinfo-title">
				<h1>My Info</h1>
			
			</div>
			<div class="member-myinfo-tab-wrap myinfo-tab-active" onclick="goViewingactivity()">최근시청내역</div>
			<div class="member-myinfo-tab-wrap" onclick="goMyinfoView()">개인정보</div>
			<div class="member-myinfo-tab-wrap" onclick="goMyFavorite()">즐겨찾기</div>
			<div class="member-myinfo-tab-wrap" onclick="goPurchase()">구매내역</div>
			<div class="member-myinfo-content-wrap">
				<div class="member-myinfo-content-cont">
				
				
				
				</div>
			</div>

		</div>
	</div>
</div>

<script>
$("#main-video").html(null); 
$("#main-video").css("background","#1a1a1a");
$("#main-content").css("background","#1a1a1a");

$(".member-myinfo-content-cont").load('./member/member_myinfo/viewingactivity.jsp');


$('.member-myinfo-tab-wrap').click(function(){
	  $(this).parent().children('.member-myinfo-tab-wrap').removeClass('myinfo-tab-active');
	  $(this).addClass('myinfo-tab-active');
});



</script>