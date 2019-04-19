<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
								<div class="member-purchase-font">이용권이 30일 후에 만료 됩니다.</div>
							</div>
						
							<div class="member-purchase-bbswrap">
								<div class="member-purchase-bbs">
						    
									<span class="member-purchase-subject">번호</span><span class="member-purchase-subject">날짜</span><span class="member-purchase-subject">결제금액</span><div class="member-purchase-price"><span class="member-purchase-price-confirm">내역확인</span>
						
									<div class="member-div-select">
										<select name="member-purchase-date" class="custom-select">
											<option value="2019" selected="" disable="" hidden="">2019</option>
											<option value="2018">2018</option>
											<option value="2017">2017</option>
											<option value="2016">2016</option>
											<option value="2015">2015</option>
											<option value="2014">2014</option>
											<option value="2013">2013</option>
											<option value="2012">2012</option>
											<option value="2011">2011</option>
											<option value="2010">2010</option>
											<option value="2009">2009</option>
											<option value="2008">2008</option>
											<option value="2007">2007</option>
											<option value="2006">2006</option>
											<option value="2005">2005</option>
										</select>
									</div>
								</div>
							</div>
							
								<div class="member-purchase-list">
									<span class="member-purchase-span member-purchase-span1">1</span><span
										class="member-purchase-span member-purchase-span2">2019.01.03</span><div class="member-purchase-price">
										<span class="member-purchase-span member-purchase-span3">9,900원</span></div></div>
										
										<div class="member-purchase-list">
									<span class="member-purchase-span member-purchase-span1">2</span><span
										class="member-purchase-span member-purchase-span2">2019.01.03</span><div class="member-purchase-price">
										<span class="member-purchase-span member-purchase-span3">9,900원</span></div></div>
										
										<div class="member-purchase-list">
									<span class="member-purchase-span member-purchase-span1">3</span><span
										class="member-purchase-span member-purchase-span2">2019.01.03</span><div class="member-purchase-price">
										<span class="member-purchase-span member-purchase-span3">9,900원</span></div></div>
						
										<div class="member-purchase-list">
									<span class="member-purchase-span member-purchase-span1">4</span><span
										class="member-purchase-span member-purchase-span2">2019.01.03</span><div class="member-purchase-price">
										<span class="member-purchase-span member-purchase-span3">9,900원</span></div></div>
										 
										<div class="member-purchase-list">
									<span class="member-purchase-span member-purchase-span1">5</span><span
										class="member-purchase-span member-purchase-span2">2019.01.03</span><div class="member-purchase-price">
										<span class="member-purchase-span member-purchase-span3">9,900원</span></div></div>
										 
										<div class="member-purchase-list">
									<span class="member-purchase-span member-purchase-span1">6</span><span
										class="member-purchase-span member-purchase-span2">2019.01.03</span><div class="member-purchase-price">
										<span class="member-purchase-span member-purchase-span3">9,900원</span></div></div>
										 
										<div class="member-purchase-list">
									<span class="member-purchase-span member-purchase-span1">7</span><span
										class="member-purchase-span member-purchase-span2">2019.01.03</span><div class="member-purchase-price">
										<span class="member-purchase-span member-purchase-span3">9,900원</span></div></div>
										 
										<div class="member-purchase-list">
									<span class="member-purchase-span member-purchase-span1">8</span><span
										class="member-purchase-span member-purchase-span2">2019.01.03</span><div class="member-purchase-price">
										<span class="member-purchase-span member-purchase-span3">9,900원</span></div></div>
										 
										<div class="member-purchase-list">
									<span class="member-purchase-span member-purchase-span1">9</span><span
										class="member-purchase-span member-purchase-span2">2019.01.03</span><div class="member-purchase-price">
										<span class="member-purchase-span member-purchase-span3">9,900원</span></div></div>
										 
										<div class="member-purchase-list">
									<span class="member-purchase-span member-purchase-span1">10</span><span
										class="member-purchase-span member-purchase-span2">2019.01.03</span><div class="member-purchase-price">
										<span class="member-purchase-span member-purchase-span3">9,900원</span></div></div>
										
										<div class="member-purchase-list">
									<span class="member-purchase-span member-purchase-span1">11</span><span
										class="member-purchase-span member-purchase-span2">2019.01.03</span><div class="member-purchase-price">
										<span class="member-purchase-span member-purchase-span3">9,900원</span></div></div>
										
										<div class="member-purchase-list">
									<span class="member-purchase-span member-purchase-span1">12</span><span
										class="member-purchase-span member-purchase-span2">2019.01.03</span><div class="member-purchase-price">
										<span class="member-purchase-span member-purchase-span3">9,900원</span></div></div>
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
