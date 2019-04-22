<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<link rel="stylesheet" type="text/css" href="/final/css/member/member_myinfo.css">
<link rel="stylesheet" type="text/css" href="/final/css/member/member_viewingactivity.css">
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
					
					
					<div class="member-myinfo-viewingactivity">
						<div class="member-myinfo-viewingactivity-imgs">
							<c:forEach var="v" items="${viewingFirstData }" varStatus="i">
							<div class="viewingactivity-imgs" onclick="goPlayer(${v.c_serial}, '${v.c_movie_subject}', ${bomMemberSeiral })">
								<img src="/final/img/intro/${v.c_movie_subject_eng}.jpg" width="180px" height="260px">
								
								<div >
									<div>
										<span class="viewingactivity-movie-title">${v.c_movie_subject }</span>
									</div>
									<div>
										<span class="viewingactivity-movie-play-day">시청일 :${v.c_date }</span>
									</div>
									<div>
										<span class="viewingactivity-movie-play-time">시간 :${v.v_playtime} / ${v.c_playtime}</span>
									</div>
								</div>
							</div>
							</c:forEach>
					
							
					
						</div>
						<div class="member-myinfo-viewingactivity-list-wrap">	
							<div class="member-myinfo-viewingactivity-list">
								<div class="member-myinfo-viewingactivity-list-title">
									<span class="viewingactivity-text-sub">번호</span>
									<span class="viewingactivity-text-sub">영화명</span>
									<span class="viewingactivity-text-sub">시청일</span>
									<span class="viewingactivity-text-sub">상영시간(분)</span>
									<span class="viewingactivity-text-sub">시청시간(분)</span>
								</div>
								<div class="member-myinfo-viewingactivity-items">
								<c:forEach var="v" items="${viewingListtData }" varStatus="i">
									<div class="member-myinfo-viewingactivity-item" onclick="goPlayer(${v.c_serial}, '${v.c_movie_subject}', ${bomMemberSeiral })">
										<span class="viewingactivity-text-item">${v.rn }</span>
										<span class="viewingactivity-text-item">${v.c_movie_subject }</span>
										<span class="viewingactivity-text-item">${v.c_date }</span>
										<span class="viewingactivity-text-item">${v.c_playtime}</span>
										<span class="viewingactivity-text-item">${v.v_playtime}</span>
									</div>		
								</c:forEach>
								</div>
								<div class="member-myinfo-viewingactivity-pagination-box">
									<div class="viewingactivity-page-buttons">
										<c:if test="${viewingPage.nowBlock gt 1 }">
										<a href="#" class="viewingactivity-page-btn-dpre" onclick="goViewingactivity(1)">&lt;&lt;</a>
										<a href="#" class="viewingactivity-page-btn-pre" onclick="goViewingactivity(${viewingPage.startPage-1})">&lt;</a>
										</c:if>
										<c:if test="${viewingPage.endPage != 1}">
											<c:forEach var="i" begin="${viewingPage.startPage }" end="${viewingPage.endPage }">
												<a href="#" class="viewingactivity-page-btn" onclick="goViewingactivity(${i })"  ${viewingPage.nowPage == i  ? "disabled" : ""}>${i}</a>
											</c:forEach>
										</c:if>
										<c:if test="${viewingPage.nowBlock lt viewingPage.totBlock}">
										<a href="#" class="viewingactivity-page-btn-ne" onclick="goViewingactivity(${viewingPage.endPage+1})" >&gt;</a>
										<a href="#" class="viewingactivity-page-btn-dne" onclick="goViewingactivity(${viewingPage.totPage})" >&gt;&gt;</a>
										</c:if>
									</div>
									<div class="viewingactivity-page-number">
										 ${viewingPage.nowPage} / ${viewingPage.totPage} 페이지
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