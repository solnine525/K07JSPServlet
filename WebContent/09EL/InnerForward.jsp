<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>forward된 페이지 입니다.</h2>
	
	<!-- 
	포워드 처리된 페이지에서는 page영역은 공유되지 않고
	request 영역이 공유된다. 따라서 해당 페이지에서 가장
	좁은 영역은 request 영역이 된다.
	 -->
	
	<h3>JSP코드를 통해서 속성읽기</h3>
	<ul>
		<li>
			<!-- 출력X 영역 소멸함. -->
			pageContext.getAttribute("scopeVar") :
				<%=pageContext.getAttribute("scopeVar") %>
		</li>
		<li>
			request.getAttribute("scopeVar") :
				<%=request.getAttribute("scopeVar") %>
		</li>
		<li>
			session.getAttribute("scopeVar") :
				<%=session.getAttribute("scopeVar") %>
		</li>
		<li>
			application.getAttribute("scopeVar") :
				<%=application.getAttribute("scopeVar") %>
		</li>
	</ul>
	
	<h3>각 영역에 저장된 속성읽기</h3>
	<h3>각 영역에 저장된 속성읽기</h3>
	<ul>
		<li>페이지 영역 : ${scopeVar }</li>
		<li>리퀘스트 영역 : ${requestScope.scopeVar }</li>
		<li>세션 영역 : ${sessionScope.scopeVar }</li>
		<li>어플리케이션 영역 : ${applicationScope.scopeVar }</li>
	</ul>
	
	<h3>xxxScope 미지정 후 속성읽기</h3>
	<ul>
		<li>가장 좁은 영역 읽음 : ${scopeVar }</li>
		<li>위처럼 영역부분을 생략한 후 EL로 읽게되면 가장 좁은 영역인
		page 영역이 읽혀지게 된다.</li>
	</ul>
	
	
	
</body>
</html>