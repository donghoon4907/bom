<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<ul class="navbar">
	<li class="logo"><a href='/final/index.jsp'><img
			src="/final/img/header/logo.png"></a></li>
	<li class="nav-search">
		<form name="nav-search-form" action="#">
			<input type="search" id="header-search" placeholder="검색어를 입력하세요."
				autocomplete='off'>
			<ul id="header-suggestLayer"></ul>
			<div id="header-loading">
				<i class="fas fa-spinner fa-pulse" style="color: red;"></i>
			</div>
			<input type="hidden" id="bomMemberSerial" value="${bomMemberSeiral }" />
		</form>
	</li>
	<li style="margin-left: 600px;">
		<a href="#">카테고리</a>
		<div>
			<div class="nav-column"></div>
			<div class="nav-column">
				<br />
				<h3 class="yellow">Genre</h3>
			</div>
			<div class="nav-column">
				<h3></h3>
				<ul>
					<li><a href="genre.category">전체</a></li>
					<li><a href="genre.category?genre=액션">액션</a></li>
					<li><a href="genre.category?genre=SF">SF</a></li>
					<li><a href="genre.category?genre=모험">모험</a></li>
				</ul>
			</div>

			<div class="nav-column">
				<h3></h3>
				<ul>
					<li><a href="genre.category?genre=가족">가족</a></li>
					<li><a href="genre.category?genre=코미디">코미디</a></li>
					<li><a href="genre.category?genre=로맨스">로맨스</a></li>
					<li><a href="genre.category?genre=반전">반전</a></li>
				</ul>
			</div>
		</div></li>
	
	<c:if test='${bomLoginId != null || kakaoLogin != null}'>
		<li>
			<a href="ViewingActivityList.mem?serial=${bomMemberSeiral }">마이페이지</a>
			<div>
				<div class="nav-column"></div>
				<div class="nav-column">
					<br />
					<h3 class="yellow">My Page</h3>
				</div>
				<div class="nav-column">
					<br />
					<h3 class="orange">내 정보</h3>
					<ul>
						<li><a href="#">내 정보</a></li>
					</ul>
				</div>
				<div class="nav-column">
					<br />
					<h3 class="orange">멤버쉽</h3>
					<ul>
						<li><a href="payinfo.mem">나의 멤버쉽</a></li>
						<li><a href="#">결제 내역</a></li>
					</ul>
				</div>
			</div>
		</li>
	</c:if>
	
	<li>
		<a href="view.help">고객센터</a>
	</li>
	
	  <li>
      <c:choose>
         <c:when test='${bomLoginId != null || kakaoLogin != null}'>   
            <a href="logout.mem">로그아웃</a>
         </c:when>
         <c:otherwise>
            <a href="login.mem">로그인</a>
         </c:otherwise>
      </c:choose>
   </li>
</ul>
<script src="/final/js/components/header.js"></script>