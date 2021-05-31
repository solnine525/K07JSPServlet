<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- JSTL 사용을 위한 taglib 지시어 추가 -->    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html> 
<html>
<head>
<meta charset="UTF-8">
<title>파일첨부형 게시판</title>
<style>a{text-decoration:none;}</style>   
</head>  
<body>
	<h2>파일첨부형 게시판-목록보기(List)</h2>
	<form method="get">
	<table border="1" width="90%">
	<tr>
		<td align="center">
			<select name="searchField">
				<option value="title">제목</option>
				<option value="content">내용</option>
			</select>
			<input type="text" name="searchWord" />
			<input type="submit" value="검색하기" />
		</td>
	</tr>	
	</table>	
	</form>
	<table border="1" width="90%">
		<tr>
			<th width="10%">번호</th>
			<th width="*">제목</th>
			<th width="15%">작성자</th>
			<th width="10%">조회수</th>
			<th width="15%">작성일</th>
			<th width="8%">첨부</th>
		</tr>
<!-- 게시물 출력 부분을 JSTL로 변경함 -->
<c:choose>	
	<c:when test="${empty boardLists }">
		<!-- 등록된 게시물이 없을때. -->
		<tr>
			<td colspan="6" align="center">
				등록된 게시물이 없습니다^^*
			</td>
		</tr>
	</c:when>
	<c:otherwise>
		<!-- 게시물이 있는 경우 확장 for문 형태의 forEach태그 사용함. -->
		<c:forEach items="${boardLists }" var="row" varStatus="loop">	
		<tr align="center">
			<td><!-- 가상번호 -->
				${map.totalCount - (((map.pageNum-1) * map.pageSize) 
					+ loop.index)}   
			</td>
			<td align="left">
				<a href="../mvcboard/view.do?idx=${row.idx }">${row.title }</a>
			</td>
			<td>${row.name }</td>
			<td>${row.visitcount }</td>
			<td>${row.postdate }</td>
			<td>
			<!-- 첨부된 파일이 있는경우에만 다운로드 링크 출력됨. -->
			<c:if test="${not empty row.ofile }">
				<!-- 파일 다운로드 시 다운로드 횟수를 증가해야 하므로 
					게시물의 일련번호가 필요함. -->
				<a href="../mvcboard/download.do?ofile=${row.ofile 
					}&sfile=${row.sfile }&idx=${row.idx }">[Down]</a>
			</c:if>
			</td>
		</tr>
		</c:forEach>		
	</c:otherwise>	
</c:choose>
	</table>
	<table border="1" width="90%">
		<tr align="center">
			<td>
				<!-- 컨트롤러에서 map에 저장한 페이지번호 문자열 출력 -->
				${map.pagingImg }
			</td>
			<td width="100"><button type="button" 
				onclick="location.href='../mvcboard/write.do';">글쓰기</button></td>
		</tr>
	</table>
</body>
</html>