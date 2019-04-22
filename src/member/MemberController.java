package member;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MemberController {
	MemberDao mDao;
	MemberValidator mVali;

	public MemberController() {
	}

	public MemberController(Member mDao, MemberValidator mVali) {
		this.mDao = (MemberDao) mDao;
		this.mVali = mVali;
	}

	@RequestMapping(value = "ViewingActivityList.mem")
	public ModelAndView ViewingActivityList(HttpServletRequest req){
		ModelAndView mv = new ModelAndView();
		String serial = req.getParameter("serial");
		System.out.println("serial");
		mDao.setListSize(5);
		mDao.setNowPage(1);
		List<ViewingActivityVo> firstData = mDao.viewingActivityList(serial);
		if(req.getParameter("nowPage") != null) {
			int nowPage = Integer.parseInt(req.getParameter("nowPage"));
			mDao.setNowPage(nowPage);
		}else {
			mDao.setNowPage(2);	
		}
		
		List<ViewingActivityVo> listData = mDao.viewingActivityList(serial);
		
		mv.addObject("viewingFirstData", firstData);
		mv.addObject("viewingListtData", listData);
		mv.addObject("viewingPage",mDao);
		
		
		mv.setViewName("index.jsp?content=./member/member_myinfo/myinfo.jsp");
		return mv;
	}
	
	@RequestMapping(value = "FavoriteList.mem")
	public ModelAndView favoriteList(HttpServletRequest req){
		ModelAndView mv = new ModelAndView();
		String serial = req.getParameter("serial");
		int nowPage = Integer.parseInt(req.getParameter("nowPage"));
		mDao.setListSize(4);
		mDao.setNowPage(nowPage);
		List<FavoriteVo> data = mDao.favorList(serial);
		
		
		mv.addObject("favoriteList",data);
		mv.addObject("favoritPage",mDao);
		mv.setViewName("index.jsp?content=./member/member_myinfo/myfavorite.jsp");
		
		return mv;
		
	}
	
	
	@RequestMapping(value = "FavoriteCheck.mem")
	public void favoriteCheck(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		PrintWriter out = resp.getWriter();
		String mSerial = req.getParameter("mSerial");
		String c_serial = req.getParameter("serial");

		FavoriteVo vo = new FavoriteVo();

		vo.setC_tableName(mSerial);
		vo.setC_serial(Integer.parseInt(c_serial));

		boolean b = mDao.favorCheck(vo);
		out.print(b);

	}

	@RequestMapping(value = "addFavorite.mem")
	public void addFavorite(HttpServletRequest req) {
		String mSerial = req.getParameter("mSerial");
		String c_serial = req.getParameter("serial");

		FavoriteVo vo = new FavoriteVo();

		vo.setC_tableName(mSerial);
		vo.setC_serial(Integer.parseInt(c_serial));

		boolean b = mDao.favorCheck(vo);
		System.out.println(b);
		if (b) {
			mDao.deleteFavorite(vo);
		} else {
			mDao.addFavorite(vo);
		}
	}

	@RequestMapping(value = "updateView.mem")
	public void updateView(HttpServletRequest req) {
		String serial = req.getParameter("serial");
		String mSerial = req.getParameter("mSerial");
		String playtime = req.getParameter("playtime");
		System.out.println("도착한 영화번호" + serial);
		System.out.println("도착한 유저" + mSerial);
		System.out.println("도착한 플레이시간" + playtime);
		if (playtime.equals("0")) {
			return;
		} else {
			boolean test = mDao.updateView(serial, mSerial, playtime);
			if (test) {
				System.out.println("데이터 저장 성공");
			} else {
				System.out.println("데이터 저장 중 에러");
			}
		}
	}

	@RequestMapping(value = "addViewingActivity.mem")
	public void addViewingActivity(HttpServletRequest req, HttpServletResponse res) {
		String serial = req.getParameter("serial");
		String mSerial = req.getParameter("mSerial");
		String playtime = req.getParameter("playtime");
		System.out.println("플에이어에 접속");
		String result = mDao.checkView(serial, mSerial);
		if (result == null) {
			System.out.println("처음 접속, 데이터를 저장");
			mDao.addViewingActivity(serial, mSerial, playtime);
		} else {
			System.out.println("이전 접속 기록이 있음, 이전에 " + result + "까지 봄");
			try {
				PrintWriter out = res.getWriter();
				out.print(result);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	@RequestMapping(value = "kakaoLogin.mem")
	public void kakoLogin(HttpServletRequest req) {
		ModelAndView mv = new ModelAndView();

		int kakaoId = Integer.parseInt(req.getParameter("kakaoId"));
		String kakaoNickName = req.getParameter("kakaoNickName");
		String kakaoLogin = req.getParameter("kakaoLogin");

		boolean b = mDao.kakaoMemberCheck(kakaoId);

		KakaoMemberVo vo = new KakaoMemberVo();

		vo.setK_id(kakaoId);
		vo.setK_nickname(kakaoNickName);

		if (b) {
			int serial = mDao.getKakaoMemberSerial(kakaoId);
			req.getSession().setAttribute("bomMemberSeiral", serial);
			req.getSession().setAttribute("bomLoginId", kakaoId);
			req.getSession().setAttribute("bomNickName", kakaoNickName);
			req.getSession().setAttribute("kakaoLogin", kakaoLogin);
		} else {
			b = mDao.kakaoMemberInsert(vo);

			if (b) {

				int serial = mDao.getKakaoMemberSerial(kakaoId);
				mDao.createTable(serial);
				
				req.getSession().setAttribute("bomMemberSeiral", serial);
				req.getSession().setAttribute("bomLoginId", kakaoId);
				req.getSession().setAttribute("bomNickName", kakaoNickName);
				req.getSession().setAttribute("kakaoLogin", kakaoLogin);

				try {
					Thread.sleep(1000);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				System.out.println("ok");
			}
		}

	}

	@RequestMapping(value = "login.mem")
	public ModelAndView login(HttpServletRequest req) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("member/login.jsp");
		return mv;
	}

	@RequestMapping(value = "logout.mem")
	public ModelAndView logout(HttpServletRequest req) {
		ModelAndView mv = new ModelAndView();

		req.getSession().setAttribute("bomMemberSeiral", null);
		req.getSession().setAttribute("bomLoginId", null);
		req.getSession().setAttribute("bomNickName", null);
		req.getSession().setAttribute("kakaoLogin", null);

		mv.setViewName("member/login.jsp");
		return mv;
	}
	@RequestMapping(value = "payinfo.mem")
	public ModelAndView payinfo(HttpServletRequest req) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("index.jsp?content=./membership/payinfo.jsp");
		return mv;
	}

	@RequestMapping(value = "signup.mem")
	public void signup(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		resp.setContentType("text/html; charset=UTF-8");
		req.setCharacterEncoding("UTF-8");

		MemberVo vo = new MemberVo();
		PrintWriter out = resp.getWriter();

		vo.setM_name(req.getParameter("name"));
		vo.setM_nickName(req.getParameter("nickName"));
		vo.setM_birth(req.getParameter("date"));
		vo.setM_phone(req.getParameter("phone"));
		vo.setM_gender(Integer.parseInt(req.getParameter("gender")));
		vo.setM_email(req.getParameter("email"));
		vo.setM_password(req.getParameter("password"));

		// 아이디 등록 중복체크
		boolean b = mDao.insert(vo);

		if (b) {
			vo = mDao.getMemberSerial(vo.getM_email());
			mDao.createTable(vo.getM_serial());
			out.println("<script>alert('계정이 등록 되었습니다'); location.href='/final/login.mem';</script>");
		} else {
			out.println("<script>alert('서버에 오류가 생겼습니다.');</script>");
		}
		out.flush();
	}

	@RequestMapping(value = "memberLogin.mem")
	public void memberLogin(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		MemberVo vo = new MemberVo();
		PrintWriter out = resp.getWriter();// 가져온놈에 print로 쓴다.

		vo.setM_email(req.getParameter("inputEmail"));
		vo.setM_password(req.getParameter("inputPassword"));

		boolean b = mDao.memberLogin(vo);

		if (b) {
			vo = mDao.getMemberSerial(vo.getM_email());
			req.getSession().setAttribute("bomMemberSeiral", vo.getM_serial());
			req.getSession().setAttribute("bomLoginId", vo.getM_email());
			req.getSession().setAttribute("bomNickName", vo.getM_nickName());
			req.getSession().setAttribute("kakaoLogin", false);
			out.print("true");

		} else {
			out.print("false");
		}
	}

	@RequestMapping(value = "idchk.mem")
	public void idcheck(HttpServletRequest req, HttpServletResponse resp) {
		resp.setCharacterEncoding("UTF-8");
		int data = mDao.idcheck(req.getParameter("id"));

		try {
			PrintWriter out = resp.getWriter();
			out.print(data);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "idnickName.mem")
	public void idnickName(HttpServletRequest req, HttpServletResponse resp) {
		resp.setCharacterEncoding("UTF-8");
		int data = mDao.idnickName(req.getParameter("nickName"));
		try {
			PrintWriter out = resp.getWriter();
			out.print(data);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	@RequestMapping(value = "/loginHelp.mem")
	public ModelAndView loginHelp(HttpServletRequest req) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("member/login_help.jsp");
		return mv;
	}

	@RequestMapping(value = "/pwdMailSending.mem")
	public void pwdMailSending(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		resp.setContentType("text/html; charset=UTF-8");
		req.setCharacterEncoding("UTF-8");

		PrintWriter out = resp.getWriter();

		String email = req.getParameter("pwdSearch");
		System.out.println("email" + email);
		String resultPwd = mDao.idSearch(email);
		System.out.println("resultPwd" + resultPwd);

		if (resultPwd != null) {

			String user = "lozxc1004@gmail.com"; // 네이버일 경우 네이버 계정, gmail경우 gmail 계정
			String password = "qha123456!"; // 패스워드

			// SMTP 서버 정보를 설정한다.
			Properties prop = new Properties();
			prop.put("mail.smtp.host", "smtp.gmail.com");
			prop.put("mail.smtp.port", 465);
			prop.put("mail.smtp.auth", "true");
			prop.put("mail.smtp.ssl.enable", "true");
			prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");

			Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(user, password);
				}
			});

			try {
				MimeMessage message = new MimeMessage(session);

				message.setFrom(new InternetAddress(user));

				// 수신자메일주소
				message.addRecipient(Message.RecipientType.TO, new InternetAddress("lozxc1004@gmail.com"));

				// Subject
				message.setSubject("BoM 요청하신 계정 정보입니다."); // 메일 제목을 입력

				// Text
				message.setText("귀하의 비밀번호는 " + resultPwd + " 입니다. 보안을 위해 로그인 후 변경해 주시길 바랍니다."); // 메일 내용을 입력

				// send the message
				Transport.send(message); //// 전송

				System.out.println("message sent successfully...");

				out.println("<script>alert('이메일로 정상적으로 발송되었습니다.'); location.href='/final/login.mem';</script>");

			} catch (AddressException e) {
				e.printStackTrace();
				out.println("<script>alert(" + e + "); location.href='/final/loginHelp.mem';</script>");

			} catch (MessagingException e) {
				e.printStackTrace();
				out.println("<script>alert(" + e + "); location.href='/final/loginHelp.mem';</script>");
			}
		}

		out.println("<script>alert('등록되지 않은 아이디 입니다.'); location.href='/final/loginHelp.mem';</script>");
	}

	@RequestMapping(value = "/idMailSending.mem")
	public void idMailSending(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");

		PrintWriter out = resp.getWriter();

		String phone = req.getParameter("idSearch");
		String resultPhone = mDao.phoneSearch(phone);

		if (resultPhone != null) {
			out.println("<script>alert('이메일은 " + resultPhone + " 입니다.'); location.href='/final/login.mem';</script>");
		} else {
			out.println("<script>alert('등록되지 않은 번호입니다.');location.href='/final/loginHelp.mem';</script>");
		}
	}

	@RequestMapping(value = "member_myinfo_view.mem")
	public void member_myinfo_view(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		PrintWriter out = resp.getWriter();
		boolean b = false;

		String pwd = req.getParameter("pwd");
		String chgPwd = req.getParameter("chgPwd");
		String email = req.getParameter("email");
		
		b = mDao.pwdchg(pwd, chgPwd, email);

		if (b) {
			out.print("true");
		} else {
			out.print("false");
		}
	}

	@RequestMapping(value = "myinfo_view_nickName.mem")
	public void myinfo_view_nickName(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");

		PrintWriter out = resp.getWriter();
		String nickName = req.getParameter("nickName");

		MemberVo vo = mDao.nickNameSearch(nickName);

		String json = String.format("[{'birth':'%s'},{'namei':'%s'},{'phone':'%s'}]", vo.getM_birth(), vo.getM_name(),
				vo.getM_phone());

		json = json.replace("\'", "\"");
		out.print(json);
	}

	@RequestMapping(value = "member_myinfo_personal.mem")
	public void member_myinfo_personal(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		PrintWriter out = resp.getWriter();
		boolean b = false;

		String phone = req.getParameter("phone");
		String nickName = req.getParameter("nickName");

		b = mDao.phoneChg(phone,nickName);

		if (b) {
			out.print("true");
		} else {
			out.print("false");
		}

	}

	@RequestMapping(value = "member_myinfo_delete.mem")
	public void member_myinfo_delete(HttpServletRequest req, HttpServletResponse resp) throws IOException{
		PrintWriter out = resp.getWriter();
		String email = req.getParameter("email");
		String pwd = req.getParameter("pwd");
		HttpSession session = req.getSession();
		
		boolean emailPwd = mDao.emailDelete(email,pwd);
		
		
		  if (emailPwd){ 
			  session.invalidate();
			  out.print("true");
		  }else{
			  out.print("false"); 
		  }
		 
		
	}

}
