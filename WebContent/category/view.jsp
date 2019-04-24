<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.8.1/css/all.css"
	integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf"
	crossorigin="anonymous">
<link rel="stylesheet" type="text/css"
	href="/final/css/category/category.css">
<title>BOM Player</title>
</head>
<body>
	<div class="category-view-container">
		<div class="category-view-videoZone">
			<div class="category-view-h1">
				<h1 style="color: white; font-size: 70px">${movie.c_movie_subject}</h1>
			</div>
			<div class="category-view-video">
				<div class="overlay">
					<div class="button"></div>
				</div>

				<div id="video-view">
					<video class="video-view-index" style="width: 100%; height: 100%;">
						<source id="video-source"
							src="/final/movie/${movie.c_movie_subject_eng}.mp4"
							type="video/mp4">
					</video>
					<input type="hidden" id="playedTime"
						value="${playtime == null ? 0 : playtime}" /> <input
						type="hidden" id="user" value="${bomMemberSeiral }" />
				</div>

				<div class=view-ad
					style="border: 1px solid white; width: 550px; height: 115px; position: absolute; top: 300px; left: 275px;">
					<img src="/final/img/광고.jpg" style="width: 100%; height: 100%;">

					<i class="fas fa-times close-icon fa-3x" id="view-ad-close"
						style="color: black; position: absolute; top: 0px; left: 515px; font-size: 35px;"></i>
				</div>


				<div id="controls">
					<div class="playButton">
						<div class="playPause"></div>
					</div>

					<div class="ProgressContainer">
						<div class="timer intialTime">00:00</div>
						<div class="progressBar">
							<div class="progress"></div>
							<div class="progressSave"></div>
						</div>
						<div class="time">00:00</div>
						<div class="timer fullTime">00:00</div>

					</div>

					<div class="volume">
						<div class="icon"></div>

						<div class="intensityBar">
							<div class="intensity"></div>
						</div>
					</div>

					<div class="scale">
						<div class="icon"></div>
					</div>
				</div>
			</div>

			<div class="category-view-video-description">
				<div class="category-view-video-detail">

					<div class="view-favorite"
						style="cursor: pointer; position: relative; float: right; display: inline-block; top: -25px; margin-right: 5px; margin-top: 10px;">
						<img id="images" src="/final/img/icon/yellow-1.png"
							style="width: 35px; height: 35px;">
					</div>


					<div class="saveTime" style="color: black">${playtiem }</div>

					<div class="playedTime"></div>



					<div id="container-tabs">
						<ul class="tabs">
							<li class="active" rel="tab1">영화 소개</li>
							<li rel="tab2">출연진</li>
						</ul>
						<div class="tab_container">
							<div id="tab1" class="tab_content">
								<ul>
									<li>개봉일 : ${movie.c_opendate.substring(0, 10)}</li>
									<li>관람등급 : ${movie.c_grade}</li>
									<li>제작사 : ${movie.c_company}</li>
									<li>상영 시간 : ${movie.c_playtime} 분</li>
									<li>${movie.c_description}</li>
								</ul>
							</div>
							<div id="tab2" class="tab_content">
								<c:forEach var='j' items="${actor}">
									<div class="tab_content_actor">
										<img src="/final/img/actor/${j.c_actor_name_eng}.jpg"
											style="width: 150px; height: 250px;">
										<p>${j.c_actor_name}</p>
									</div>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="category-view-Zone-h">
				<p>연관 영화 리스트</p>
				<i class="fas fa-times close-icon fa-3x" id="close"
					style="color: red"></i>
			</div>
			<div class="category-view-Zone">
				<c:forEach var="k" items="${movies}">
					<div class="category-view-player"
						onclick="goAnotherPlayer('${k.c_movie_subject}','${bomMemberSeiral }')">
						<img src="/final/img/intro/${k.c_movie_subject_eng}.jpg"
							width='120px' height='100%'> <span
							class="category-view-player-item">${k.c_movie_subject}</span>
					</div>
				</c:forEach>
			</div>

			<div class="category-view-playerZone-h">
				<p>추천 영화 리스트</p>
			</div>
			<div class="category-view-playerZone" style="overflow: scroll">
				<c:forEach var="l" items="${recommend}">
					<div class="category-view-player"
						onclick="goAnotherPlayer('${l.c_recommend_subject}', '${bomMemberSeiral }')">
						<img src="/final/img/intro/${l.c_recommend_subject_eng}.jpg"
							width="120px" height="100%" /> <span
							class="category-view-player-item">${l.c_recommend_subject}</span>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>



	<script>
   
   $(document).ready(function () {

       var play_pause     = $('.playButton');
       var container      = $('.category-view-video');
       var playIcon       = $('.playButton .playPause');
       var video          = $('.video-view-index');
       var play           = $('.play');
       var volume         = $('.volume .icon');
       var volumeIntesity = $('.volume .intensityBar');
       var intensity      = $('.intensity');
       var progressBar    = $('.progressBar');
       var progress       = $('.progressBar .progress');
       var progressSave   = $('.progressBar .progressSave');    
       var timer          = $('.intialTime');
       var vidDuration    = $('.fullTime');
       var expandButton   = $('.scale .icon');
       var overlayScreen  = $('.overlay');
       var timeState      = $('.time');
       var overlayButton  = $('.overlay .button');
       var update;
         
       var saveTime      = $('.saveTime'); //새로 저장 될 시간
       var playedTime      = $('#playedTime').val();        //기존 저장된 시간 입력
	   var fullTime = ${movie.c_playtime};
       var viewAd = $(".view-ad");
       var ad = $("#view-ad-close");
       
       viewAd.hide();
       
       setTimeout(function() {
            viewAd.show();
          }, 10000);
       
       
       ad.click(function(){
          
          viewAd.hide();
          
       });
       
       var text = $('#images');
      var i = 0;
      var movieSerial = ${movie.c_serial};
      var mSerial = $('#user').val();
       $.post("FavoriteCheck.mem",{
    		serial : movieSerial,
           	mSerial : mSerial
   		},function(data){
			if(data == "true"){
				i = 1;
				document.getElementById('images').src="./img/icon/yellow-2.png";
			}else{
				i = 0;
				document.getElementById('images').src="./img/icon/yellow-1.png";
			}
			
   		});

      
       var totalSeconeds = Math.round(parseInt(fullTime));
       var totalMinutes  = Math.floor(totalSeconeds/60);
       computeTime(totalSeconeds,totalMinutes);
      
      if(playedTime > 0){
    	  var totalSeconeds = Math.round(${playtime});
          var totalMinutes  = Math.floor(totalSeconeds/60);
         computeTime(totalSeconeds, totalMinutes);
         swal({
                  
         title : "이어보기 하시겠습니까?",
          text : totalMinutes +":"+ totalSeconeds + " 까지 시청하셨습니다.",
            buttons : true,
            dangerMode: true,
         })
         .then((willDelete)=>{
            if(willDelete){
               
               swal("이어보기가 실행됩니다.",{
               icon:"success",      
               });
               if(playedTime != null){
                  var percentage = ( playedTime / video[0].duration) * 100;
                    // 현재시간/전체시간을 100분율 값으로 나타냄
                    progressSave.css({'width': percentage + '%'});                  
                  //재생 시작시간 입력
                    video.get(0).currentTime = playedTime;
                    
               }
                  update = setInterval(updateplayer, 1);
                  
            }else{
               
               var percentage = ( playedTime / video[0].duration) * 100;
                 
                 progressSave.css({'width': percentage + '%'});   
            
               playedTime = 0;
               
               update = setInterval(updateplayer, 1);
                              
               swal("처음부터 재생됩니다.",{
                  icon:"success",
               });
            }
         });
      }
      
      
      text.click(function(){
			
    	  if(i == 0){
              i = 1;
              document.getElementById('images').src="./img/icon/yellow-2.png";

              $.post("addFavorite.mem",{
              	serial : movieSerial,
              	mSerial : mSerial
              },function(data){

              });
              swal({            
              	
                  title : "즐겨찾기에 추가되었습니다.",
                  text : "내 정보에서 확인 가능합니다!",
                    icon : "success",
               });   
           }else{
              i = 0;
              document.getElementById('images').src="./img/icon/yellow-1.png";
              
              $.post("addFavorite.mem",{
              	serial : movieSerial,
              	mSerial : mSerial
              },function(data){

              });
              
              swal({
                  title : "즐겨찾기에서 해제되었습니다.",
                    icon : "warning",
               });   
           }
      });
       
       //플레이어 변수 선언
      
      $(".tab_content").hide();
      $(".tab_content:first").show();

      $("ul.tabs li").click(function () {
      $("ul.tabs li").removeClass("active").css("color", "white");
      $(this).addClass("active").css("color", "white");
      $(".tab_content").hide()
         var activeTab = $(this).attr("rel");
          $("#" + activeTab).fadeIn()
       });
          
       $("#close").click(function(){
    	   var movieSerial = ${movie.c_serial};
           var playtime = $('.saveTime').text();
           var mSerial = $('#user').val();
           
    	   $.post('updateView.mem',{
        	   serial : movieSerial,
        	   mSerial : mSerial,
        	   playtime : playtime
           });
          location.href="/final/index.main";
       });
      
       
       $(window).resize(function () { 
          resizeVid(); 
       });
       resizeVid();
       updateplayer();
       //------------------
       //플레이어 클릭이벤트 실행 함수
       progressBar.click(function () {
          skip(); 
       });
       progressBar.mousemove(function () {           
          // 현재 재생시간을 나타내기위해 마우스가 움직일 때 재생된 시간을 text 위치에 실행
          timeState.text(getTimeState()); 
       });       
       volume.click(function () { 
          toggleMute(); 
       });       
       volumeIntesity.click(function () { 
          changeVolume(); 
       });    
       expandButton.click(function () { 
          fullScreen(); 
       });       
       
       vidDuration.text(getFormatedFullTime());
       
       overlayButton.click(function () { 
              playVid();
        });
           
        play_pause.add(video).click(function () { 
              playVid(); 
           
        });
       
        $(window).keypress(function (e) {
             if (e.keyCode === 32) {
                playVid();
             }
           }); 
       
        $(window).keypress(function (e) {
             if (e.keyCode === 13) {
                fullScreen();
             }
         });
       
       
      //video 실행시 (버튼 클릭시) 실행
      //css pause 버튼으로 이미지 변경 (또는 재생 버튼으로)
      //후에 hide / show 구분하게 함.
       function playVid() {
           if (video.get(0).paused) {
               
   
              video.get(0).play();   
              playIcon.css({
                 
                  'background': 'url(/final/img/icon/pause1.png)',
                  'background-size': '100% 100%'
               });
               
               overlayScreen.hide();
               update = setInterval(updateplayer, 1);

               //update변수에 setInterval함수의 값을 넣음( setInterval(fn, delay) -->> 1초마다 updateplayer를 실행함 )
           } else {
        	  var movieSerial = ${movie.c_serial};
              var playtime = $('.saveTime').text();
              var mSerial = $('#user').val();
              video.get(0).pause();
               playIcon.css({
               
                  'background': 'url(/final/img/icon/play.png)',
                     'background-size': '100% 100%'
               });
               
               overlayScreen.show();
               clearInterval(update);
               
               //다시 재생시킬 경우 update에 입력되어 있는 값을 clearInterval 시킴
               $.post('updateView.mem',{
            	   serial : movieSerial,
            	   mSerial : mSerial,
            	   playtime : playtime
               }, function(data){
            	   console.log(data);
               });
           }
       }
     
      //1초마다 실행되게 interval 설정해놓은 함수
      //재생시간 1초마다 초단위로 보여져야 하는 부분
       function updateplayer() {
          
         
            var percentage = (video[0].currentTime / video[0].duration) * 100;
              // 현재시간/전체시간을 100분율 값으로 나타냄
              progress.css({'width': percentage + '%'});           
              //시작위치의 시간
              timer.text(getFormatedTime());           
              //db저장하려는 재생시간 값
              saveTime.text(Math.floor(video[0].currentTime));
              //마지막위치의 시간
              vidDuration.text(getFormatedFullTime());
               
         
           
           //재생하는 비디오의 길이가 ended 됐을 경우
           if (video[0].ended) {
              
               playIcon.css({
                  
                  'background': 'url(/final/img/icon/play.png)',
                  'background-size': '100% 100%'
               });
                  
               //재생완료 시 pause 버튼 이미지 활성화    
               overlayScreen.show();
               overlayButton.css({
                  
                  'background': 'url(/final/img/icon/pause1.png)',
                  'background-size': '100% 100%'
               });
               
           } else if (video[0].paused) {
              
              overlayButton.show();
              overlayButton.css({
              'background': 'url(/final/img/icon/play.png)',
              'background-size': '100% 100%'
             
              });
           }
       }
      
       function getTimeState() {
        //offset() 특정 요소 좌표 값 가져옴
        // 페이지 맨 왼쪽부터 마우스의 위치 까지 총 수평 좌표 값 - progressBar의 처음~끝까지의 위치 좌표값 = mouseX,
        // border를 포함한 progressBar의 크기 = width;
         var mouseX = event.pageX - progressBar.offset().left,
             width  = progressBar.outerWidth();
   
          // (이동한 길이 좌표 값 / 총 길이) * 비디오 재생 총 시간 -->> round로 소수점이하 반올림
          var currentSeconeds = Math.round((mouseX / width) * video[0].duration);
          
          //60 값으로 나누어 소수점 이하 버리고 분단위로 저장
          var currentMinutes  = Math.floor(currentSeconeds/60);
          
          //저장 값 0 보다 큰 경우
          if (currentMinutes > 0) {
             
             currentSeconeds -= currentMinutes * 60;
          }
          //초 단위 1자리일 경우 0 붙임
          if (currentSeconeds.toString().length === 1) {
             
              currentSeconeds = "0" + currentSeconeds;
          }
         //분 단위 1자리일 경우 0 붙임          
          if (currentMinutes.toString().length === 1) {
              
               currentMinutes = "0" + currentMinutes;
          }

          timeState.css('left', (mouseX / width) * progressBar.width() + 18 + 'px');
         
          //분 : 초 형태로 리턴해 마우스 오버 시 출력되는 것처럼 리턴 값 설정
          return currentMinutes + ':' + currentSeconeds;
         
       }
      
       function skip() {
           var mouseX = event.pageX - progressBar.offset().left,
               width  = progressBar.outerWidth();
           
          video[0].currentTime = (mouseX / width) * video[0].duration;
          updateplayer();
       }

       //재생되는 영상의 풀타임 함수 (총 재생시간 나타내는 구간 -->> 분 : 초)
       function getFormatedFullTime() {
            var totalSeconeds = Math.round(fullTime);
            var totalMinutes  = Math.floor(totalSeconeds/60);
            
            
            if (totalMinutes > 0) {
               totalSeconeds -= totalMinutes * 60;
            }
            if (totalSeconeds.toString().length === 1) {
                totalSeconeds = "0" + totalSeconeds;
             }
             if (totalMinutes.toString().length === 1) {
                 totalMinutes = "0" + totalMinutes;
             }
           return totalMinutes + ':' + totalSeconeds;
       }
      
       //영상 시작부분 시간 실행 함수(재생되는 플레이 타임 구간 -->> 분 : 초)
        function getFormatedTime() {
          
            var seconeds = Math.round(video[0].currentTime);
            var minutes  = Math.floor(seconeds / 60);
             if (minutes > 0) {
               seconeds -= minutes * 60;
            }
            if (seconeds.toString().length === 1) {
                seconeds = "0" + seconeds;
             }
             if (minutes.toString().length === 1) {
                 minutes = "0" + minutes;
             }
            return minutes + ':' + seconeds;
        }
  
       function toggleMute() {
           if (!video[0].muted) {
              
           //mute 활성화
              video[0].muted = true;
              volume.css({
                 
                 'background': 'url(/final/img/icon/off1.png)',
                 'background-size': '100% 100%'
              });
              
              intensity.hide();
              
           } else {
              
           //mute 비활성화
              video[0].muted = false;
              volume.css({
                 
                 'background': 'url(/final/img/icon/on1.png)',
                 'background-size': '100% 100%'
              });
              
              intensity.show();
           }
       }

       function changeVolume() {
          var mouseX = event.pageX - volumeIntesity.offset().left,
              width  = volumeIntesity.outerWidth();

          video[0].volume = (mouseX / width);
          intensity.css('width', (mouseX / width) * width + 'px');
          video[0].muted = false;
          
          volume.css({
             
             'background': 'url(/final/img/icon/on1.png)',
             'background-size': '100% 100%'
          });
          
          intensity.show();
       }

       function fullScreen() {
          
           if (video[0].requestFullscreen) {
              
              video[0].requestFullscreen();
              
           } else if (video[0].webkitRequestFullscreen) {
              
              video[0].webkitRequestFullscreen();
              
           } else if (video[0].mozRequestFullscreen) {
              
              video[0].mozRequestFullscreen();
              
           } else if (video[0].msRequestFullscreen) {
              
              video[0].msRequestFullscreen();
              
           } else {
              
              video[0].dblclick(function () { 
                 fullScreen(); 
              });
              
           }

       }
       function computeTime(totalSeconeds, totalMinutes){
     	  if (totalMinutes > 0) {
               totalSeconeds -= totalMinutes * 60;
            }
            if (totalSeconeds.toString().length === 1) {
                totalSeconeds = "0" + totalSeconeds;
             }
             if (totalMinutes.toString().length === 1) {
                 totalMinutes = "0" + totalMinutes;
             }   
       }
       function resizeVid() {
          if (container.width() < 600) {
             container.addClass('small');
          } else {
             container.removeClass('small');
          }
       }
   });
         
</script>


</body>
</html>