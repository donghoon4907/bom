package category;

import java.util.List;


import org.apache.ibatis.session.SqlSession;

import db.MybatisFactory;

public class CategoryDao implements Category{
	
	@Override
	public List<CategoryVo> genreSearch(String genre){
		SqlSession sqlSession = MybatisFactory.getFactory().openSession();
		List<CategoryVo> result = sqlSession.selectList("category.genre", genre);
		sqlSession.close();
		return result;
	}
	@Override
	public CategoryVo viewPlayer(String serial) {
		SqlSession sqlSession = MybatisFactory.getFactory().openSession();
		CategoryVo result = sqlSession.selectOne("category.view", Integer.parseInt(serial));
		sqlSession.close();
		return result;
	}
	@Override
	public List<ActorVo> viewGetActor(String serial) {
		SqlSession sqlSession = MybatisFactory.getFactory().openSession();
		List<ActorVo> result = sqlSession.selectList("category.getActor", Integer.parseInt(serial));
		sqlSession.close();
		return result;
	}
	@Override
	public List<RecommendVo> viewGetRecommend(String serial){
		SqlSession sqlSession = MybatisFactory.getFactory().openSession();
		List<RecommendVo> result = sqlSession.selectList("category.getRecommend", Integer.parseInt(serial));
		sqlSession.close();
		return result;
	}
	@Override 
	public String view(String serial) {
		SqlSession sqlSession = MybatisFactory.getFactory().openSession();
		CategoryVo result = sqlSession.selectOne("category.view", Integer.parseInt(serial));
		sqlSession.close();
		String resultJSON = result.toJSON();
		return resultJSON;
	}
	@Override
	public List<CategoryVo> list(String search) {
		SqlSession sqlSession = MybatisFactory.getFactory().openSession();
		List<CategoryVo> list = sqlSession.selectList("category.list", search);
		sqlSession.close();
		if(list.isEmpty()) {
			return null;
		}
		return list;
	}
	
	@Override
	public String getSerial(String search) {
		SqlSession sqlSession = MybatisFactory.getFactory().openSession();
		CategoryVo result = sqlSession.selectOne("category.getSerial", search);
		sqlSession.close();
		return result.toJSON();
	}
	

	public String getListJSON(String search) {
		SqlSession sqlSession = MybatisFactory.getFactory().openSession();
		List<CategoryVo> list = sqlSession.selectList("category.list", search);
		sqlSession.close();
		if(list.isEmpty()) {
			return null;
		}
		return this.toListJSON(list);
	}
	public String toListJSON(List<CategoryVo> list) {
		if(list.size() == 0) {
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return new String("{'movie': [{'subject':''}]}").replace("'", "\"");
		}
		StringBuilder sb = new StringBuilder();
		sb.append("{ 'movie': [");
		sb.append(list.get(0).toJSON());
		for(int i=1;i<list.size();i++) {
			sb.append(", "+list.get(i).toJSON());
		}
		sb.append("]}");
		return sb.toString().replace("'","\"");
	}
}
