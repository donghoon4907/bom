<%@page import="helpdesk.HelpDeskVo"%>
<%@page import="java.util.List"%>
<%@page import="helpdesk.HelpDeskDao"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="/final/js/helpdesk/helpdesk.js"></script>
<link rel="stylesheet" type="text/css" href="/final/css/helpdesk/helpdesk.css">
<title>Insert title here</title>
</head>
<body>
	<h2>고객센터 1:1 문의 PAGE</h2>
	<div class = "one">
	
		<%if(session.getAttribute("bomMemberSeiral") == null){ %>
		
				<hr style="border: 1px solid white;" />
				<h2>로그인을 먼저 해야합니다.</h2>
				
			<%}else{ %>
			
				<p>해당 문의 게시물은 운영자와 1:1 문의로 사용자외 다른 유저는 열람이나 게시  또는 수정이 불가합니다.
				<hr style="border: 1px solid white;" />	
				<form name = "frm" method = "post" enctype="multipart/form-data">
					<div class = "input-group mb-3">
						<div class = "input-group-prepend">
							<span class = "input-group-text">날짜</span>
						</div>
						<input type = "text" class = "form-control" name = "helpdeskDate" value="<%=new Date().toLocaleString()%>" readonly>
					</div>
					<p>
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text">제목</span>
						</div>
						<input type="text" class="form-control" name = "helpdeskSubject" id = "subject" placeholder="제목을 입력하세요.">
					</div>
					<p>
					<div class="form-group">
  						<textarea class="form-control" rows="3" name= "helpdeskContent" placeholder="문의 사항 내용을 입력하세요."></textarea>
					</div>
					<p>
					<div id = "image-zone-one">
						<img id='image' name='image' src='http://placehold.it/400x200' width='400' height='200'>
						<br/>
						<br/>
						<input type='file' name='photo' /><br />
					</div>
					<p>
					<p>
					<button type ="button" class="btn btn-outline-warning" onclick = "check()" id = "btnSubmit">문의하기</button>
			
					<br/>
					<!-- 페이지 로딩 후 기본으로 받아오는 닉네임 / 유저 시리얼 값  -->
					<input type = "text" id = "helpdeskMemberSerial" name = "helpdeskMemberSerial" value = "<%=session.getAttribute("bomMemberSeiral") %>" >
					<input type = "text" id = "helpdeskNickname" name = "helpdeskNickname" value = "<%=session.getAttribute("bomNickName")%>">

				</form>
		<%} %>
		
	</div>
	
</body>
</html>