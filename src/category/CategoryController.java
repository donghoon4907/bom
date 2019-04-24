package category;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CategoryController {
	CategoryDao cDao;
	CategoryValidator cVali;

	public CategoryController() {
	}

	public CategoryController(Category cDao, CategoryValidator cVali) {
		this.cDao = (CategoryDao) cDao;
		this.cVali = cVali;
	}

	@RequestMapping(value = "index.main")
	public ModelAndView index(HttpServletRequest req) {
		ModelAndView mv = new ModelAndView();
		try {
			Thread.sleep(1000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		mv.setViewName("index");
		return mv;
	}


	// 장르별 검색 지원
	@RequestMapping(value = "genre.category")
	public ModelAndView genre(HttpServletRequest req) {
		ModelAndView mv = new ModelAndView();
		try {
			req.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String genre = req.getParameter("genre");
		if (genre == null) {
			List<CategoryVo> result = cDao.list("");
			String genreResult = "모든 영화 목록";
			mv.addObject("searchKeyword", genreResult);
			mv.addObject("searchResult", result);

		} else {
			List<CategoryVo> result = cDao.genreSearch(genre);
			String genreResult = result.isEmpty() ? "검색 결과가 없습니다." : (genre + " - 별 검색 결과");
			mv.addObject("searchKeyword", genreResult);
			mv.addObject("searchResult", result);
		}
		mv.setViewName("search");
		return mv;
	}

	// 검색된 결과를 반환
	@RequestMapping(value = "search.category")
	public ModelAndView search(HttpServletRequest req) {
		ModelAndView mv = new ModelAndView();
		try {
			req.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String search = req.getParameter("search");
		List<CategoryVo> list = cDao.list(search);
		if (search == null) {
			String searchResult = "모든 영화 목록";
			mv.addObject("searchKeyword", searchResult);
			mv.addObject("searchResult", list);
		} else {
			String searchResult = list.isEmpty() ? "검색 결과가 없습니다." : (search + " - 검색 결과");
			mv.addObject("searchKeyword", searchResult);
			mv.addObject("searchResult", list);
		}
		mv.setViewName("search");
		return mv;
	}

	// 플레이어에서 연관 영화 및 추천 영화를 선택시
	@RequestMapping(value = "getSerial.category")
	public void getSerial(HttpServletRequest req, HttpServletResponse res) {
		try {
			req.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String result = cDao.getSerial(req.getParameter("search"));
		try {
			res.setCharacterEncoding("UTF-8");
			PrintWriter out = res.getWriter();
			out.print(result);
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 메인페이지에서 영화 선택시 예고편을 보여줄 때 사용
	@RequestMapping(value = "get.category")
	public void view(HttpServletRequest req, HttpServletResponse res) {
		try {
			req.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String serial = req.getParameter("serial");
		System.out.println(serial);
		if (serial != null) {
			String result = this.cDao.view(serial);
			try {
				res.setCharacterEncoding("UTF-8");
				PrintWriter out = res.getWriter();
				out.print(result);
				out.flush();
				out.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
	}

	// 영화 플레이어 화면을 제공할 때 사용
	@RequestMapping(value = "player.category")
	public ModelAndView player(HttpServletRequest req) {
		ModelAndView mv = new ModelAndView();
		try {
			req.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String serial = req.getParameter("serial");
		String playtime = req.getParameter("playtime");
		System.out.println("playtime은" + playtime);
		CategoryVo movie = cDao.viewPlayer(serial);
		if (movie != null) {
			List<ActorVo> actor = cDao.viewGetActor(serial);
			if (!actor.isEmpty()) {
				List<RecommendVo> recommend = cDao.viewGetRecommend(serial);
				if (!recommend.isEmpty()) {
					List<CategoryVo> movies = cDao.list(req.getParameter("search"));
					mv.addObject("movie", movie);
					mv.addObject("actor", actor);
					mv.addObject("recommend", recommend);
					mv.addObject("movies", movies);
					mv.addObject("playtime", playtime);
					mv.setViewName("view");
				}
			}
		}
		return mv;
	}

	// 검색 결과를 반환할 때 사용
	@RequestMapping(value = "list.category")
	public void list(HttpServletRequest req, HttpServletResponse res) {
		try {
			req.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String search = req.getParameter("search") == null ? "" : req.getParameter("search");
		String result = cDao.getListJSON(search);
		try {
			res.setCharacterEncoding("UTF-8");
			PrintWriter out = res.getWriter();
			out.print(result);
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
//	@RequestMapping(value="view.category")
//	public ModelAndView view(HttpServletRequest req) {
//		ModelAndView mv = new ModelAndView();
//		String serial = req.getParameter("serial");
//		String resultJSON = this.cDao.view(serial);
//		if(resultJSON != null) {
//			mv.addObject("result", resultJSON);
//			mv.setViewName("view");
//		} else {
//			mv.setViewName("errorpage");
//		}
//		return mv;
//	}
}
