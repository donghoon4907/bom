<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BOM Search</title>
</head>
<link rel="stylesheet" type="text/css"
	href="/final/css/category/search.css">
<body>
	<div class="search-container"></div>
	<div class="search-result">
		<h3>${searchKeyword}</h3>
		<hr class="search-result-splitLine" />
		<div class="search-result-movie">
			<div class="search-result-movie-wrapper">
				<c:forEach var='m' items="${searchResult }">
					<div class="search-result-movie-item" onclick="goPlayer(${m.c_serial},'${m.c_movie_subject}, ${bomMemberSeiral }')">
						<img class="search-result-movie-img" src="/final/img/intro/${m.c_movie_subject_eng }.jpg"/>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</body>
</html>