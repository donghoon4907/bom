package helpdesk;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import org.apache.ibatis.session.SqlSession;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import db.MybatisFactory;

public class HelpDeskDao implements HelpDesk {

	String path = "C://Users/Administrator/eclipse-workspace/final/WebContent/img/";
	int size = 1024 * 1024 * 50; // 10Mb
	String encode = "utf-8";
	MultipartRequest multi;
	HttpServletRequest req;
	String msg = "";
	SqlSession sqlSession;

	public HelpDeskDao() {
		sqlSession = MybatisFactory.getFactory().openSession();
	}

	@Override
	public boolean modify(HttpServletRequest req) {
		boolean b = false;
		HelpDeskVo vo = null;
		
		try {
			multi = new MultipartRequest(req, path, size, encode, new DefaultFileRenamePolicy());
				
			vo = setModifyVo(multi);
			
			int cnt = sqlSession.update("helpdesk.helpdeskModify", vo);
			
			if(cnt > 0) {
				System.out.println("게시글 수정 성공");
				b = true;
				sqlSession.commit();
			}else {
				System.out.println("수정 실패");
				b = false;
				sqlSession.rollback();
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return b;	
	}
	
	
	@Override
	public boolean insert(HttpServletRequest req) {
		boolean b = false;
		HelpDeskVo vo = null;

		try {
			multi = new MultipartRequest(req, path, size, encode, new DefaultFileRenamePolicy());

			vo = setVo(multi);

			int cnt = sqlSession.insert("helpdesk.helpdeskInsert", vo);

			if (cnt > 0) {
				System.out.println("helpdesk insert OK");
				b = true;
				sqlSession.commit();

			} else {
				b = false;
				System.out.println("helpdesk insert False");
				sqlSession.rollback();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return b;
	}

	@Override
	public List<HelpDeskVo> listCheck(int memberSerial) {
		if (memberSerial == 0) {
			System.out.println("확인");
		}

		List<HelpDeskVo> result = sqlSession.selectList("helpdesk.helpdeskList", memberSerial);
		
		if(result.isEmpty()) {
			return null;
		}
		
		return result;
	}

	public HelpDeskVo setVo(MultipartRequest multi) throws Exception {
		HelpDeskVo vo = new HelpDeskVo();

		vo.setQ_subject(multi.getParameter("helpdeskSubject"));
		vo.setQ_content(multi.getParameter("helpdeskContent"));
		vo.setQ_mdate(multi.getParameter("helpdeskDate"));
		
		if(multi.getFilesystemName("photo") != null) {
			vo.setQ_photo(multi.getFilesystemName("photo"));
			
		}else {
			vo.setQ_photo("");
		}
		vo.setM_writer(multi.getParameter("helpdeskNickname"));
		vo.setM_serial(Integer.parseInt(multi.getParameter("helpdeskMemberSerial")));

		System.out.println(vo.getQ_subject());
		System.out.println(vo.getQ_content());
		System.out.println(vo.getQ_mdate());
		System.out.println(vo.getQ_photo());

		System.out.println(vo.getM_writer());
		System.out.println(vo.getM_serial());

		return vo;
	}
	
	public HelpDeskVo setModifyVo(MultipartRequest multi) throws Exception {
		HelpDeskVo vo = new HelpDeskVo();
		
		vo.setQ_serial(Integer.parseInt(multi.getParameter("modifySerial")));
		
		vo.setQ_subject(multi.getParameter("modifySubject"));
		vo.setQ_content(multi.getParameter("modifyContent"));
		vo.setQ_mdate(multi.getParameter("modifyDate"));
		
		vo.setM_writer(multi.getParameter("modifyNickname"));
		vo.setM_serial(Integer.parseInt(multi.getParameter("modifyMemberSerial")));
		
		System.out.println("inputImage : " + multi.getParameter("inputImg"));
		
		
		
		if(multi.getParameter("modifyDeleteImg") != null) {
			System.out.println("삭제파일이름" + multi.getParameter("modifyDeleteImg"));
			vo.setQ_photo_delete(multi.getParameter("modifyDeleteImg"));
			File f = new File(path + vo.getQ_photo_delete());
			if(f.exists()) {
				
				System.out.println("삭제 파일 경로" + f);
				
				f.delete();
			}
		}
		
		if(multi.getFilesystemName("inputImg") != null) {
			
			vo.setQ_photo(multi.getFilesystemName("inputImg"));
		}else {
			vo.setQ_photo("");
		}
		
		System.out.println(vo.getQ_serial());
		System.out.println(vo.getQ_subject());
		System.out.println(vo.getQ_content());
		System.out.println(vo.getQ_mdate());
		System.out.println(vo.getQ_photo());

		System.out.println(vo.getM_writer());
		System.out.println(vo.getM_serial());

		return vo;
	}
	
	@Override
	public boolean deletePhoto(String photo) {
		boolean b = false;
		
		try {
		File f = new File (path + photo);
		if(f.exists()) f.delete();
		b = true;
		}catch(Exception e) {
			b = false;
			e.printStackTrace();
		}
		return b;
	}
	
	@Override
	public int delete(int serial) {
		int result = sqlSession.delete("helpdesk.helpdeskDelete", serial);
		
		if(result > 0) {
			sqlSession.commit();
		}else {
			sqlSession.rollback();
		}
		
		return result;
	}

}
