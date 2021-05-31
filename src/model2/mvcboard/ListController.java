package model2.mvcboard;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.BoardConfig;
import utils.BoardPage;

public class ListController extends HttpServlet { 
  
	@Override 
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		
		//DAO객체 생성(커넥션 풀 사용함)
		MVCBoardDAO dao = new MVCBoardDAO();
	  	
		//검색 파라미터 및 View로 전달할 여러가지 데이터 저장용 Map컬렉션 생성
		Map<String, Object> map = new HashMap<String, Object>();
		
		//검색 파라미터 처리
		String searchField = req.getParameter("searchField");
		String searchWord = req.getParameter("searchWord");
		if(searchWord!=null){
			map.put("searchField", searchField);
			map.put("searchWord", searchWord);
		}
		
		//게시물 갯수 카운트
		int totalCount = dao.selectCount(map);
		
		/* 페이지처리 start */
		int pageSize = BoardConfig.PAGE_PER_SIZE;//리스트 출력 갯수
		int blockPage = BoardConfig.PAGE_PER_BLOCK;//페이지 번호 갯수
		
		//페이지번호 처리
		int pageNum = 1;
		String pageTemp = req.getParameter("pageNum");
		if(pageTemp!=null && !pageTemp.equals("")) 
			pageNum = Integer.parseInt(pageTemp);
		
		//한 페이지에 출력할 게시물의 범위 결정(between절에 사용)
		int start = (pageNum-1) * pageSize + 1; 
		int end = pageNum * pageSize;
		map.put("start", start);
		map.put("end", end);
		/* 페이지처리 end */
		
		//실제 출력할 레코드를 가져옴.
		List<MVCBoardDTO> boardLists = dao.selectListPage(map);
		dao.close();
		
		//View에 출력할 페이지 번호를 문자열로 저장
		String pagingImg = BoardPage.pagingImg(totalCount, pageSize, 
				blockPage, pageNum, "../mvcboard/list.do");
		map.put("pagingImg", pagingImg);//페이지 번호 문자열
		map.put("totalCount", totalCount);//게시물의 갯수
		map.put("pageSize", pageSize);//페이지 수
		map.put("pageNum", pageNum);//현재 페이지 번호
		
		req.setAttribute("boardLists", boardLists);//페이지에 출력할 게시물
		req.setAttribute("map", map);//각종 파라미터 및 페이지관련 값
		req.getRequestDispatcher("/14MVCBoard/List.jsp").forward(req, resp);
	}
}
