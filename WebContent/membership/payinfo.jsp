<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<link rel="stylesheet" type="text/css"
	href="/final/css/membership/payinfo.css">
<div class="membership-container">
	<div class="membership-content">
		<div class="membership-title">
			<h1>BOM PREMIUM</h1>
			<h3>BOM만의 특별한 프리미엄 멤버쉽을 만나보세요.</h3>
		</div>
		<hr />
		<div class="membership-pay">
			<div class="membership-pay-title">
				<h1>무제한 감상</h1>
			</div>
			<div class="membership-pay-detail">
				<h1>월간 멤버쉽</h1>
				<h3>월 2,500원 (VAT별도)</h3>
				<ul class="membership-pay-detail-list">
					<li>광고없는 스트리밍 영화 감상</li>
					<li>무제한 영화 제공</li>
				</ul>
				<div class="member-ship-pay-order">
					<h2>결제 수단</h2>
					<button type='button' class="pay-btn-kakao"
						onclick="goKakaoPay('w@w','춘자','010','주소','16000')"></button>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	$("#main-video").html(null);
	$("#main-video").css("background", "#1a1a1a");
	
	
	var IMP = window.IMP; // 
	IMP.init('imp07369909'); // "가맹점 식별코드"
	function goKakaoPay(email, name, phone, addr, postcode) {
			
		
		IMP.request_pay({
			pg : 'kakao', // version 1.1.0부터 지원.
			pay_method : 'card',
			merchant_uid : 'merchant_' + new Date().getTime(),
			name : 'BOM 1개월 정액제 결제',
			amount : 2500,
			buyer_email : email,
			buyer_name : name,
			buyer_tel : phone,
			buyer_addr : addr,
			buyer_postcode : postcode
		}, function(rsp) {
			if (rsp.success) {
			
				$.ajax({
					url : 'addMemberShip.mem',
					data : {'serial': $('#bomMemberSerial').val()},
					type : 'POST',
					success: function(result){
						if(result ="true"){
							alert('결제가 완료되었습니다.');
							console.log("결완");
							location.href = '/final/index.main';
						}else{
							alert('결제가 실패하였습니다.');
						}
					},
					error:function(error){
						console.log(error);	
					}
				});
				
/* 				msg += '고유ID : ' + rsp.imp_uid;
				msg += '상점 거래ID : ' + rsp.merchant_uid;
				msg += '결제 금액 : ' + rsp.paid_amount;
				msg += '카드 승인번호 : ' + rsp.apply_num; */
			} else {
				alert('결제에 실패하였습니다.' +	'에러내용 : ' + rsp.error_msg);
			}
			
		});
	}
</script>
