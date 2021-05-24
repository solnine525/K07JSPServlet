<%@page import="homework.copy.MembershipDTO"%>
<%@page import="homework.copy.MembershipDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//파라미터 받기
String num = request.getParameter("num");//일련번호
String searchField = request.getParameter("searchField");
String searchWord = request.getParameter("searchWord");

String queryStr ="";
if(searchWord!=null){ 	
	//검색 파라미터 추가하기
	queryStr ="searchField="+searchField+"&searchWord="+searchWord;
}

MembershipDAO dao = new MembershipDAO(application);
//조회수 증가
//파라미터로 전달된 일련번호를 조회
MembershipDTO dto = dao.selectView(num); 
dao.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원제 게시판</title>
<script>
	/*
	Javascript를 통한 폼값 전송으로 삭제처리
	*/
	function isDelete() {
		var c = confirm("정말로 삭제하시겠습니까?");
		if(c) {
			var f = document.writeFrm;
			f.method = "post";
			f.action = "DeleteProcess.jsp";
			f.submit();
		}
	}
</script>
</head>
<body>
	<h2>회원제 게시판 - 상세보기(View)</h2>
	<!-- 
		회원제 게시판에서 게시물 삭제를 위해 상세보기에
		게시물의 일련번호를 hidden 입력상자에 삽입한다.
		게시물을 조회하는 
	 -->
	<form name="writeFrm">
		<input type="hidden" name="num" value="<%=num %>"/>
		<table border="1" width="90%">
			<tr>
				<td>아이디</td>
				<td><%=dto.getId() %>				
				<td>이름</td>
				<td><%=dto.getName() %>				
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><%=dto.getPass() %>				
				<td>생년월일</td>
				<td><%=dto.getBday() %>				
			</tr>
			<tr>
				<td>우편번호</td>
				<td><%=dto.getAddrNum() %>				
				<td>전체주소</td>
				<td><%=dto.getAddr() %>				
			</tr>
			<tr>
				<td>이메일</td>
				<td><%=dto.getEmail() %>				
				<td>휴대폰번호</td>
				<td><%=dto.getcPhone() %>				
			</tr>
			<tr>
				<td>전화번호</td>
				<td><%=dto.gettPhone() %>				
				<td>회원가입일</td>
				<td><%=dto.getRegidate() %>				
			</tr>
			<tr>
				<td>
					<button type="button" onclick="location.href='memberList.jsp?<%=queryStr%>';">
						리스트 바로가기 </button>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>