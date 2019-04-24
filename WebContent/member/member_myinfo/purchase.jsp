<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>



<link rel="stylesheet" type="text/css" href="/final/css/member/member_myinfo.css">
<link rel="stylesheet" type="text/css" href="css/member/member-purchase.css">

<script src="/final/js/member/myinfo.js"></script>

<div class="member-myinfo-wrapper">
	<div class="myinfo-wrap">
		<div class ="member-myinfo-content">
		
			<div class="member-myinfo-title">
				<h1>My Info</h1>
			
			</div>
			<div class="member-myinfo-tab-wrap" onclick="goViewingactivity()">최근시청내역</div>
			<div class="member-myinfo-tab-wrap" onclick="goMyinfoView()">개인정보</div>
			<div class="member-myinfo-tab-wrap" onclick="goMyFavorite()">즐겨찾기</div>
			<div class="member-myinfo-tab-wrap  myinfo-tab-active" onclick="goPurchase()">구매내역</div>
			<div class="member-myinfo-content-wrap">
				<div class="member-myinfo-content-cont">						
						<div class="member-purchase-wrapp">
						
							<div class="member-purchase-title">
							      <c:choose>
							         <c:when test='${endDays == 0}'>   
							            <div class="member-purchase-font">이용권이 만료 되었습니다.</div>
							         </c:when>
							         <c:otherwise>
							           <div class="member-purchase-font">이용권이 ${endDays}일 후에 만료 됩니다.</div>
							         </c:otherwise>
							      </c:choose>
								

							</div>
						
							<div class="member-purchase-bbswrap">
								<div class="member-purchase-bbs">
						    
									<span class="member-purchase-subject">번호</span><span class="member-purchase-subject">날짜</span><span class="member-purchase-subject">결제금액</span><div class="member-purchase-price"><span class="member-purchase-price-confirm">내역확인</span>
						
									<div class="member-div-select">
										<select name="member-purchase-date" id="purchaseIndex" class="custom-select" onchange="goPurchase(this.value)">
											<option value="2019" ${selYear == 2019 ? "selected" :"" }>2019</option>
											<option value="2018" ${selYear == 2018 ? "selected" :"" }>2018</option>
										</select>
									</div>
								</div>
							</div>
							<c:forEach var="v" items="${purchaseList }" varStatus="i">
								<div class="member-purchase-list">
									<span class="member-purchase-span member-purchase-span1">${i.count }</span><span
										class="member-purchase-span member-purchase-span2">${v.p_date }</span><div class="member-purchase-price">
										<span class="member-purchase-span member-purchase-span3">${v.p_cost }원</span></div></div>
							</c:forEach>
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
