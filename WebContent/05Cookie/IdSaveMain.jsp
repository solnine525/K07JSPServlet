<%@page import="utils.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//체크박스 체크용 변수
String cookieCheck = "";
//쿠키명이 loginId 인 쿠키값 읽어오기
String loginId = CookieManager.readCookie(request, "loginId");
//빈 값이 아니면
if(!loginId.equals("")){
	//체크용 변수에 checked를 할당
	cookieCheck = "checked";
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>로그인 페이지</h2>
	<form action ="IdSaveProcess.jsp" method="post">
	<!-- 
		생성된 쿠키가 있다면 저장된 아이디를 입력하고, 체크박스에
		checked 속성을 부여한다.
	 -->	
		아이디 : <input type="text" name="user_id" value="<%=loginId %>"
				tableindex="1"/>
			<label>
				<input type="checkbox" name="save_check" value="Y"
					<%=cookieCheck %> tableindex="3" /> 아이디저장하기
			</label>
		<br/>
		패스워드 : <input type="text" name="user_pw" tableindex="2" />
		<br/>
		<input type="submit" value="로그인하기" />
	</form>
</body>
</html>