
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

		}, 
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
