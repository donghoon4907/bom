
/**
 * 
 */
var booleanPassword = false;


function myinfoChange(){
	var nickName = document.getElementById("view-nickname").value;
	$.ajax({
		type:'post',
		url :'/final/myinfo_view_nickName.mem',
		data:{"nickName": nickName},
		dataType:'json',
			success : function(num){
				document.getElementById("view-date").value= num[0].birth.substring(0,10);
				document.getElementById("view-name").value= num[1].namei;
				document.getElementById("view-phone").value= num[2].phone;

		}
	})
	
}


function myinfoChange2(){
	var nickName2 = document.getElementById("kakao-nickname").value;
	$.ajax({
		type:'post',
		url :'/final/myinfo_kakao_nickName.mem',
		data:{"nickName2": nickName2},
		dataType:'json',
			success : function(num){
				document.getElementById("kakao-date").value= num[0].birthi.substring(0,10);
				document.getElementById("kakao-name").value= num[1].namei;
				document.getElementById("kakao-phone").value= num[2].phonei;
				document.getElementById("kakao-email").value= num[3].emaili;
		}
	})
}

function passwordChk(value){
	var passwordExp= /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{5,}$/;
	var changePassword = document.getElementById("changePassword");
	 
	if(value==""){
			booleanPassword = false;
			changePassword.innerHTML = "비밀번호를 입력해 주세요.";
		}else if(value.match(passwordExp)){
			booleanPassword = true;
			changePassword.innerHTML = "";
		}else{
			booleanPassword = false;
			changePassword.innerHTML = "숫자, 문자, 특수문자, 5자이상 작성헤 주세요.";
		}
}

function pwdChage(){
	var pwd 	= $('#view-password').val();
	var chgPwd  = $('#view-chageassword').val();
	var email 	= $('#view-email').val();
	
	
	if(booleanPassword){
		$.ajax({
			type:'post',
			url :'/final/member_myinfo_view.mem',
			data:{
				'pwd'	: pwd,
				'chgPwd': chgPwd,
				'email' : email
			},
			dataType:"html",
			success : function(num){
				if(num=="true"){
					alert("변경 되었습니다.");
				}else{
					alert("Password를 다시 확인해 주세요.");
				}
			}, error:function(error){
				console.log(error);
			}
		})
		
	}else{
		alert("Password가 일치하지 않습니다.");
	}
}

function personalChage(){
	var phone = $('#view-phone').val();
	var nickName = $('#view-nickname').val();
	
		$.ajax({
			type:'post',
			url :'/final/member_myinfo_personal.mem',
			data:{'phone':phone,
				  'nickName' : nickName
				},
			dataType:"html",
			success : function(num){
				if(num=="true"){
					alert("변경 되었습니다.");
				}else{
					alert("서버에 오류가 생겼습니다.");
				}
			}, error:function(error){
				console.log(error);
			}
		})
	
}


function myinfo_delete(frm){
	var email 	= $('#view-email').val();
	var password = $('#modal-password').val();
	
	if(password==null){
		alert("공백은 사용하실 수 없습니다.")
		
	}else{
		
		$.ajax({
			type:'post',
			url :'/final/member_myinfo_delete.mem',
			data:{
				'email' : email,
				'pwd'   : password
				},
			success : function(msg){
				if(msg=="true"){
				 alert("삭제되었습니다.");
				 location.href="/final/index.jsp";
				}else{
				 alert("비밀번호가 일치하지 않습니다.");
				}
			},error : function(error){
				console.log(error);
			}
		})
		
	}
}


//-------------------------------------카카오---------------------------------------
//Date Of Birth
$("#kakao-date").datepicker({
	format : "yyyy-mm-dd",
	endDate : "date()",
	language: "ko-KR"
});


function kakaoModify(){
	var email = $('#kakao-email').val();
	var name = $('#kakao-name').val();
	var date = $('#kakao-date').val();
	var phone = $('#kakao-phone').val();
	var id = $('#kakao-id').val();
	
	
	 if(email!="" && name!="" && date!="" && phone!=""){
		 var result = confirm(" 한번 수정하면 다시 수정할 수 없습니다. 수정을 원하십니까 ? ")
		if(result){
		 $.ajax({
			 type: "post", 
			 url: "/final/member_myinfo_kakaoModify.mem",
			 data: {
				 "email":email,
				 "name":name,
				 "date":date,
				 "phone":phone,
				 "id" : id
			 },
			 success:function(cnt){
				 console.log(cnt+1);
				 if(cnt>0){
				  alert(" 수정되었습니다. ");
				 }else{
				  alert(" 서버에 오류가 생겼습니다. ");
				 }
			 }
		 })
		}
	 }else{
		 alert("모든 사항을 입력해주세요.");
	 }
	 
	 
}
