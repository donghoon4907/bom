<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<link rel="stylesheet" type="text/css" href="/final/css/member/member_myinfo.css">
<link rel="stylesheet" type="text/css" href="/final/css/member/member_myfavorite.css">

<script src="/final/js/member/myinfo.js"></script>

<div class="member-myinfo-wrapper">
	<div class="myinfo-wrap">
		<div class ="member-myinfo-content">
		
			<div class="member-myinfo-title">
				<h1>My Info</h1>
			
			</div>
			<div class="member-myinfo-tab-wrap" onclick="goViewingactivity()">최근시청내역</div>
			<div class="member-myinfo-tab-wrap" onclick="goMyinfoView()">개인정보</div>
			<div class="member-myinfo-tab-wrap  myinfo-tab-active" onclick="goMyFavorite()">즐겨찾기</div>
			<div class="member-myinfo-tab-wrap" onclick="goPurchase()">구매내역</div>
			<div class="member-myinfo-content-wrap">
				<div class="member-myinfo-content-cont">
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
									<c:forEach var="v" items="${favoriteList }" varStatus="i">
									<div class="member-myinfo-favorite-item" onclick="goPlayer(${v.c_serial}, '${v.c_movie_subject}', ${bomMemberSeiral })">
										<span class="favorite-text-item">${i.count}</span>
										<span class="favorite-text-item"><img src="/final/img/intro/${v.c_movie_subject_eng}.jpg" width="80px" height="110px"></span>
										
										<span class="favorite-text-item">${v.c_movie_subject }</span>
										<span class="favorite-text-item">${v.c_playtime}</span>
										<span class="favorite-text-item">${v.v_playtime}</span>
									</div>
									</c:forEach>	
								</div>
								<div class="member-myinfo-favorite-pagination-box">
									<div class="favorite-page-buttons">
									<c:if test="${favoritPage.nowBlock gt 1 }">
										<a href="#" class="favorite-page-btn-dpre" onclick="goMyFavorite(1)">&lt;&lt;</a>
										<a href="#" class="favorite-page-btn-pre" onclick="goMyFavorite(${favoritPage.startPage-1})" >&lt;</a>
									</c:if>
									<c:if test="${favoritPage.endPage != 1}">
										<c:forEach var="i" begin="${favoritPage.startPage }" end="${favoritPage.endPage }">
										<a href="#" class="favorite-page-btn" onclick="goMyFavorite(${i })"  ${favoritPage.nowPage == i  ? "disabled" : ""}>${i}</a>
										</c:forEach>
									</c:if>
									<c:if test="${favoritPage.nowBlock lt favoritPage.totBlock}">
										<a href="#" class="favorite-page-btn-ne" onclick="goMyFavorite(${favoritPage.endPage+1})" >&gt;</a>
										<a href="#" class="favorite-page-btn-dne" onclick="goMyFavorite(${favoritPage.totPage})" >&gt;&gt;</a>
									</c:if>
									</div>
									<div class="favorite-page-number">
										 ${favoritPage.nowPage} / ${favoritPage.totPage} 페이지
									</div>
								</div>
							</div>
						</div>
					</div>
		
									
				
				</div>
			</div>

		</div>
	</div>
</div>


<script>
$("#main-video").html(null); 
$("#main-video").css("background","#1a1a1a");
$("#main-content").css("background","#1a1a1a");


</script>
