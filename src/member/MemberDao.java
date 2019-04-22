package member;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import db.MybatisFactory;


public class MemberDao implements Member {
  
	private SqlSession sqlSession;

	//page 분리를 위한 변수
	public int totSize;
	public int totPage;
	public int totBlock;
	public int nowBlock;
	public int endNo;
	public int startNo;
	public int endPage;
	public int startPage;
	
	public int listSize = 4;//페이지당 리스트수
	public int blockSize = 5;
	public int nowPage =1;
	
	
	
	public MemberDao() {
		sqlSession = MybatisFactory.getFactory().openSession();
	}
	
	public List<ViewingActivityVo> viewingActivityList(String serial){
		String viewingTable = "viewingactivity_"+serial;
		int cnt = sqlSession.selectOne("member.viweingPage", viewingTable);	
		pageCompute(cnt);
		Page p = new Page();
		p.setStartNo(this.startNo);
		p.setEndNo(this.endNo);
		p.setC_tableName(serial);
		p.setC_tableName1(serial);
		p.setC_tableName2(serial);
		List<ViewingActivityVo> data = sqlSession.selectList("member.viewingActivityList", p);
		
		return data;
	}
	
	public List<FavoriteVo> favorList(String serial){
		System.out.println(serial);
		String favorTable = "favorite_"+serial;
		int cnt = sqlSession.selectOne("member.favorPage", favorTable);
		pageCompute(cnt);
		Page p = new Page();
		p.setStartNo(this.startNo);
		p.setEndNo(this.endNo);
		p.setC_tableName(serial);
		p.setC_tableName1(serial);
		p.setC_tableName2(serial);
		
		
		List<FavoriteVo> data = sqlSession.selectList("member.favorList", p);
		
		
		return data;
	}
	

	public boolean favorCheck(FavoriteVo vo) {
		return sqlSession.selectOne("member.favorCheck", vo);
	}

	public boolean addFavorite(FavoriteVo vo) {
		boolean b = false;

		int cnt = sqlSession.insert("member.addFavorite", vo);

		if (cnt > 0) {
			b = true;
			sqlSession.commit();
			System.out.println("cnt-----" + cnt);
		} else {
			sqlSession.rollback();
		}

		return b;
	}

	public boolean deleteFavorite(FavoriteVo vo) {
		boolean b = false;

		int cnt = sqlSession.delete("member.deleteFavorite", vo);

		if (cnt > 0) {
			b = true;
			sqlSession.commit();

		} else {
			sqlSession.rollback();
		}

		return b;
	}

	@Override
	public boolean kakaoMemberCheck(int kakaoId) {
		return sqlSession.selectOne("member.kakaoMemberCheck", kakaoId);
	}

	@Override
	public int getKakaoMemberSerial(int kakaoId) {
		int serial = sqlSession.selectOne("member.getKakaoMemberSerial", kakaoId);
		return serial;
	}

	@Override
	public void createTable(int serial) {

		HashMap<String, String> map = new HashMap<String, String>();

		String pn = "purchase_" + serial;
		String vn = "viewingactivity_" + serial;
		String fn = "favorite_" + serial;

		map.put("pn", pn);
		map.put("vn", vn);
		map.put("fn", fn);

		sqlSession.update("member.createTablePurchase", map);
		sqlSession.update("member.createTableViewingActivite", map);
		sqlSession.update("member.createTableFavorite", map);

	}

	@Override
	public boolean kakaoMemberInsert(KakaoMemberVo vo) {
		int r = sqlSession.insert("member.kakaoMemberInsert", vo);
		boolean b = false;
		if (r > 0) {
			b = true;
			sqlSession.commit();
		}

		return b;
	}

	public MemberVo getMemberSerial(String email) {
		MemberVo vo = sqlSession.selectOne("member.getMemberSerial", email);
		return vo;
	}

	public boolean insert(MemberVo vo) {
		boolean b = false;
		int result = sqlSession.insert("member.memberInsert", vo);

		if (result > 0) {
			sqlSession.commit();
			b = true;
		}
		return b;
	}

	public boolean memberLogin(MemberVo vo) {
		boolean b = false;
		b = sqlSession.selectOne("member.memberLogin", vo);

		if (b) {
			b = true;
		}
		return b;
	}

	public int idcheck(String m_email) {
		return sqlSession.selectOne("member.idchk", m_email);
	}

	public int idnickName(String m_nickName) {
		return sqlSession.selectOne("member.idnickName", m_nickName);
	}

	public boolean addViewingActivity(String serial, String mSerial, String playtime) {
		ViewingActivityVo vo = new ViewingActivityVo();
		vo.setC_serial(Integer.parseInt(serial));
		vo.setC_tableName(mSerial);
		vo.setV_playtime(Integer.parseInt(playtime));

		int cnt = sqlSession.insert("member.addViewingActivity", vo);
		if (cnt > 0) {
			sqlSession.commit();
			return true;
		} else {
			sqlSession.rollback();
			return false;
		}
	}

	public String checkView(String serial, String mSerial) {
		ViewingActivityVo vo = new ViewingActivityVo();
		vo.setC_serial(Integer.parseInt(serial));
		vo.setC_tableName(mSerial);
		int cnt = sqlSession.selectOne("member.checkView", vo);
		if (cnt == 0) {
			return null;
		} else {
			int playtime = sqlSession.selectOne("member.getPlaytime", vo);
			return new String(playtime + "");
		}
	}

	public boolean updateView(String serial, String mSerial, String playtime) {
		ViewingActivityVo vo = new ViewingActivityVo();
		vo.setC_serial(Integer.parseInt(serial));
		vo.setC_tableName(mSerial);
		vo.setV_playtime(Integer.parseInt(playtime));
		int cnt = sqlSession.update("member.updateView", vo);
		if (cnt != 0) {
			sqlSession.commit();
			return true;
		} else {
			sqlSession.rollback();
			return false;
		}

	}
	
	public String idSearch(String id) {
		return sqlSession.selectOne("member.idSearck",id);
	}
  
  
	public String phoneSearch(String phone) {
		return sqlSession.selectOne("member.phoneSearch", phone);
	}
  
  
  
  	public boolean pwdchg(String pwd,String chgPwd, String email) {
		boolean b = false;
		MemberVo vo = new MemberVo();
		
		 vo.setM_email(email);
		 vo.setM_password(pwd);
			b = sqlSession.selectOne("member.pwdSearch",vo);
			System.out.println(b);
			 if(b) {
				 vo.setM_password(chgPwd);
				 System.out.println(vo.getM_password());
				 int cnt = sqlSession.update("member.chgSearch",vo);
				 System.out.println(cnt);
				 if(cnt >0) {
					 b=true;
					 sqlSession.commit();	 
				 }
				 
				 
			 }
			 System.out.println("b는실행안했지만 여기까지왔다");
		return b;
	}
	
	public boolean phoneChg(String phone, String nickName) {
		boolean b = false;
		MemberVo vo = new MemberVo();
		
		vo.setM_phone(phone);
		vo.setM_nickName(nickName);
		
		int a = sqlSession.update("member.phoneChg",vo);
		
		System.out.println("a" + a);
		
			 if(a>0) {
				 sqlSession.commit();
				 b=true;
			 }else{
				 sqlSession.rollback();
				 b=false;
			 }
			 
		return b;
	}
	
	public MemberVo nickNameSearch(String nickName) {
		
		return sqlSession.selectOne("member.nickNameSearch", nickName);
	}
	
	public boolean emailDelete(String email, String pwd) {
		MemberVo vo = new MemberVo();
		boolean c = false;
		
		vo.setM_email(email);
		vo.setM_password(pwd);
		
		 int b = sqlSession.delete("member.emailDelete", vo);
		 
		 if(b>0) {
			 c = true;
			 sqlSession.commit();
			 
		 }else {
			 c = false;
			 sqlSession.rollback();
		 }
		
		return c;
	}
	public boolean pwdSearch(String pwd,String chgPwd, String email) {
		boolean b = false;
		MemberVo vo = new MemberVo();
		
		 vo.setM_email(email);
		 vo.setM_password(pwd);
		 
			b = sqlSession.selectOne("member.pwdSearch",vo);
			System.out.println(b);
			 if(b) {
				 sqlSession.update("member.chgSearch",chgPwd);
				 sqlSession.commit();
				 b=true;
			 }
			 System.out.println(b);
		return b;
	}
  
		public void pageCompute(int cnt) {

		try {

				this.totSize = cnt;

				this.totPage = (int) Math.ceil(this.totSize / (double) this.listSize);
				this.totBlock = (int) Math.ceil(this.totPage / (double) this.blockSize);
				this.nowBlock = (int) Math.ceil(this.nowPage / (double) this.blockSize);
				
				this.endNo = this.nowPage * this.listSize;
				this.startNo = this.endNo - this.listSize + 1;
				if(this.endNo> this.totSize) this.endNo = this.totSize;
				
				
				this.endPage = this.nowBlock * this.blockSize;
				this.startPage = this.endPage - this.blockSize + 1;
				if(this.endPage > this.totPage) this.endPage = this.totPage;

				
		

		}catch (Exception e) {
			e.printStackTrace();
		}
	
	}


	public int getTotSize() {
		return totSize;
	}


	public void setTotSize(int totSize) {
		this.totSize = totSize;
	}


	public int getTotPage() {
		return totPage;
	}


	public void setTotPage(int totPage) {
		this.totPage = totPage;
	}


	public int getTotBlock() {
		return totBlock;
	}


	public void setTotBlock(int totBlock) {
		this.totBlock = totBlock;
	}


	public int getNowBlock() {
		return nowBlock;
	}


	public void setNowBlock(int nowBlock) {
		this.nowBlock = nowBlock;
	}


	public int getEndNo() {
		return endNo;
	}


	public void setEndNo(int endNo) {
		this.endNo = endNo;
	}


	public int getStartNo() {
		return startNo;
	}


	public void setStartNo(int startNo) {
		this.startNo = startNo;
	}


	public int getEndPage() {
		return endPage;
	}


	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}


	public int getStartPage() {
		return startPage;
	}


	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}


	public int getListSize() {
		return listSize;
	}


	public void setListSize(int listSize) {
		this.listSize = listSize;
	}


	public int getBlockSize() {
		return blockSize;
	}


	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}


	public int getNowPage() {
		return nowPage;
	}


	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}
	

}

