<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>Annotation으로 매핑하기</h2>
	<p>
		<strong>${message }</strong>
		<br/>
		<!-- 컨텍스트 루트 경로를 얻어와서 바로가기 링크 설정 -->
		<a href="<%=request.getContextPath() %>/13Servlet/AnnoMapping.do">
			바로가기</a>
	</p>
</body>
</html>