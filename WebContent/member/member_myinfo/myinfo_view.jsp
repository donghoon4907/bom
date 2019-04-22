<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <!DOCTYPE html>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css" href="/final/css/member/member_myinfo_view.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="//code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="/final/js/member/member_myinfo.js"></script>
<!-- Popper JS -->
<script   src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script   src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
   
<link rel="stylesheet" type="text/css" href="/final/css/member/member_myinfo.css">
<script src="/final/js/member/myinfo.js"></script>

<div class="member-myinfo-wrapper">
	<div class="myinfo-wrap">
		<div class ="member-myinfo-content">
		
			<div class="member-myinfo-title">
				<h1>My Info</h1>
			
			</div>
			<div class="member-myinfo-tab-wrap" onclick="goViewingactivity()">최근시청내역</div>
			<div class="member-myinfo-tab-wrap  myinfo-tab-active" onclick="goMyinfoView()">개인정보</div>
			<div class="member-myinfo-tab-wrap" onclick="goMyFavorite()">즐겨찾기</div>
			<div class="member-myinfo-tab-wrap" onclick="goPurchase()">구매내역</div>
			<div class="member-myinfo-content-wrap">
				<div class="member-myinfo-content-cont">
					<c:choose>
					    <c:when test='${kakaoLogin != true}'>   
							 <div class="member-myinfo-content-wrap">
								<div class="member-myinfo-content-cont">
									<div class="member-view-wrapper">
										<div class="member-view-wrapper-item1 item-detail">
										<label class="member-view-label label-email">Email</label>
											<input name="view-email" class="nfTextField " id="view-email" type="email" autocomplete="off" placeholder="Email" value="${bomLoginId}" onfocus="javascript:blur();" style="cursor: default;" >
										</div>
										
										<div class="member-view-wrapper-item2 item-detail">
											<label class="member-view-label label-email">Name</label>
											<input autocomplete="off" type="text" id="view-name" class="nfTextField" name="view-name" placeholder="Name" value="" onfocus="javascript:blur();" style="cursor: default;">
										</div>
										
										<div class="member-view-wrapper-item3 item-detail">
											<label class="member-view-label label-email">Password</label>
											<input autocomplete="off" type="password" id="view-password" class="nfTextField" name="view-password" placeholder="Password" value="" autocomplete="off" >
										</div>
										
										<div class="member-view-wrapper-item4 item-detail">
											<label class="member-view-label label-email">NickName</label>
											<input autocomplete="off" type="text" id="view-nickname" class="nfTextField" name="view-nickname" placeholder="NickName" value="${bomNickName}" readonly onfocus="javascript:blur();" style="cursor: default;">
										</div>
										
										<div class="member-view-wrapper-item5 item-detail">
											<label class="member-view-label label-email">Change Password</label>
											<input autocomplete="off" type="Password" id="view-chageassword" class="nfTextField" name="view-changepassword" placeholder="Re-write Password" value="" onkeyup="passwordChk(this.value)">
										</div>
										
										<div class="member-view-wrapper-item6 item-detail">
											<label class="member-view-label label-email">Date Of Birth</label>
											<input autocomplete="off" type="date" id="view-date" class="nfTextField" name="view-date" readonly onfocus="javascript:blur();" style="cursor: default;" value="">
										</div>
										
										<div class="member-view-wrapper-item7 item-detail">
											<label style="color:#ff9933;width:300px;height:50px;" id="changePassword" class="changePassword"></label>
										</div>
										
										<div class="member-view-wrapper-item8 item-detail">
											<label class="member-view-label label-email">Phone</label>
											<input autocomplete="off" type="text" id="view-phone" class="nfTextField" name="view-phone" placeholder="NickName" value="">
										</div>
										
										<div class="member-view-wrapper-item9">
											<input value="비밀번호 변경" autocomplete="off" type="button" id="member-view-btn-modify" class="btn btn-secondary member-view-modify" onclick="pwdChage()">
										</div>
										
										<div class="member-view-wrapper-item10">
											<input value="개인정보 수정" autocomplete="off" type="button" id="member-view-btn-delete" class="btn btn-secondary member-view-delete" onclick="personalChage()">
										</div>
										
										<div class="member-view-wrapper-item11 item-detail item-delete">
							    			<a href="#" data-toggle="modal" data-target="#myModal" >회원탈퇴</a> 하기를 원하십니까?
							    		</div>
							    		
							    		
							    		<!-- BootStrap Modal  -->
								    		<div class="modal fade" id="myModal">
									         <div class="modal-dialog">
									            <div class="modal-content">
									                              
									               <div class="modal-header">
									                  <h3 class="modal-title" style="color:black;">비밀번호를 입력하세요.</h3>
									                  <button type="button" class="close" data-dismiss="modal">×</button>
									               </div>
									                              
									               <div class="modal-body">                                          
									                  <form name = "폼 네임" method="POST">      
									                     <div class = "input-group mb-3">
									                        <div class = "input-group-prepend">
									                           <span class = "input-group-text">Password</span>
									                        </div>
									                        <input type = "password" id="modal-password" class = "form-control" name = "password" required="required" placeholder="your password">
									                     </div>                     <p>                                    
									                     <button type ="button" class="btn btn-outline-danger" onclick = "myinfo_delete(this.form)" style= "width: 200px; margin-left: 10px;">삭제</button>
									                     <button type ="button" class="btn btn-outline-secondary" data-dismiss="modal" style= "width: 200px; margin-left: 30px;">취소</button>
									                  </form>
									               </div>
									            </div>
									         </div>
										</div>							    		
									</div>	
								</div>
							</div>     
					    </c:when>
					    <c:otherwise>
							 <div class="member-myinfo-content-wrap">
								<div class="member-myinfo-content-cont">
									<div class="member-view-wrapper">
									
										<div class="member-view-wrapper-item1 item-detail">
										<label class="member-view-label label-email">Email</label>
											<input name="kakao-email" class="nfTextField " id="kakao-email" type="email" autocomplete="off" placeholder="Email" value="lozxc1004@naver.com" onfocus="javascript:blur();" style="cursor: default;">
										</div>
										
										<div class="member-view-wrapper-item2 item-detail">
											<label class="member-view-label label-email">Name</label>
											<input autocomplete="off" type="text" id="kakao-name" class="nfTextField" name="kakao-name" placeholder="Name" value="김영웅" onfocus="javascript:blur();" style="cursor: default;">
										</div>
										
										<div class="member-view-wrapper-item3 item-detail">	</div>
										
										<div class="member-view-wrapper-item4 item-detail">
											<label class="member-view-label label-email">NickName</label>
											<input autocomplete="off" type="text" id="kakao-nickname" class="nfTextField" name="kakao-nickname" placeholder="NickName" value="Heros">
										</div>
										
										<div class="member-view-wrapper-item5 item-detail"></div>
										
										<div class="member-view-wrapper-item6 item-detail">
											<label class="member-view-label label-email">Date Of Birth</label>
											<input autocomplete="off" type="date" id="kakao-date" class="nfTextField" name="kakao-date" readonly onfocus="javascript:blur();" style="cursor: default;" value="1993-11-18">
										</div>
										
										<div class="member-view-wrapper-item7 item-detail"></div>
										
										<div class="member-view-wrapper-item8 item-detail">
											<label class="member-view-label label-email">Phone</label>
											<input autocomplete="off" type="text" id="kakao-nickname" class="nfTextField" name="kakao-nickname" placeholder="NickName" value="01099997878">
										</div>
										
										<div class="member-view-wrapper-item9"></div>
										
										<div class="member-view-wrapper-item10">
											<input value="개인정보 수정" autocomplete="off" type="button" id="member-view-btn-delete" class="btn btn-secondary member-view-delete">
										</div>
										
										<div class="member-view-wrapper-item11 item-detail item-delete">
							    			<a href="#">개인정보를 삭제</a> 하기를 원하십니까?</div>
									</div>
								</div>
							</div>     
					    </c:otherwise>
					</c:choose>				
				</div>
			</div>

		</div>
	</div>
</div>

<script>
$("#main-video").html(null); 
$("#main-video").css("background","#1a1a1a");
$("#main-content").css("background","#1a1a1a");


$('.member-myinfo-content-wrap').ready(function(){
	myinfoChange();
});
</script>  

