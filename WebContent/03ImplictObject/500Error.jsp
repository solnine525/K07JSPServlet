<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>500Error.jsp</title>
</head>
<body>
<!-- 
개발하는 단계에선 web.xml에서 error 페이지를 처리하지 않는 것이 좋다.
web.xml에서 처리하면 오류코드를 확인할 수가 없기 때문.
 -->
<%
//실행시 무조건 에러가 발생하는 코드임.
int myAge = Integer.parseInt(request.getParameter("age")) +10;
out.println("10년후 당신의 나이는 "+myAge+"살 입니다.");
%>
</body>
</html>