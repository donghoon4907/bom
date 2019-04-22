/**
 * 
 */

var serial = $(bomMemberSerial).val();

function goViewingactivity(){
	location.href = 'goViewingActivity.mem';
}




function goPurchase(){
	location.href = 'index.jsp?content=./member/member_myinfo/purchase.jsp';
}
function goMyinfoView(){
	location.href = 'index.jsp?content=./member/member_myinfo/myinfo_view.jsp';
}
function goMyFavorite(nowPage){
	if(nowPage == null){ 
		location.href = 'FavoriteList.mem?serial='+serial+'&nowPage=1';
	}else{
		location.href = 'FavoriteList.mem?serial='+serial+'&nowPage='+nowPage;
	}
}
