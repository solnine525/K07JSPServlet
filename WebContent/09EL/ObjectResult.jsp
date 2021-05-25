<%@page import="model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ObjectResult.jsp</title>
</head>
<body>
	<h2>EL의 param 내장객체로 파라미터 읽기</h2>
	
	<h3>자바코드로 영역 및 파라미터 읽기</h3>
	
	<h4>영역에 저장된 값</h4>
	<%
	/*
	JSP코드를 통해 영역에 저장된 속성을 가져올 때는
	1.getAttribute()으로 속성을 얻어온다.
	2.형변환한다.
	3.getter로 저장된 값을 출력한다.
	*/
	MemberDTO member = (MemberDTO)request.getAttribute("dtoObj");
	%>
	<ul>
		<li>MemberDTO 객체 : <%=String.format("아이디:%s," +"비번:%s, 이름:%s"
				, member.getId()
				, member.getPass()
				, member.getName()) %>
		</li>
		<!-- String, Intetger와 같은 기본객체는 별도의 형변환 없이 사용할 수 있다. -->
		<li>
			String 객체 : <%=request.getAttribute("strObj") %>
		</li>
		<li>
			Integer 객체 : <%=request.getAttribute("integerObj") %>
		</li>
	</ul>
	
	<h4>파라미터로 전달된 값 읽기</h4>
	<%
	int fNum = Integer.parseInt(request.getParameter("firstNum"));
	int sNum = Integer.parseInt(request.getParameter("secondNum"));
	%>
	
	두 파라미터의 합 : <%=fNum+sNum %>
	
	<!-- 
	영역에 저장된 속성명이 중복되지 않는다면 xxxScope 내장객체를 사용하지
	않고도 읽어올 수 있고, 형ㅂ녀환도 별도로 하지 않아도 된다.
	또한, 산술연산시 int형으로 변환도 필요없다.
	 -->
	<h3>EL로 영역과 파라미터로 전달된 값 읽기</h3>
	<h4>영역에 저장된 값</h4>
	<ul>
		<li>MemberDTO객체 : <br/>
			아이디 : ${dtoObj.id },
			비번 : ${dtoObj.pass },
			이름 : ${dtoObj.name }
		</li>
		<!-- 
			속성명이 유일하다면 영역은 지정하지 않아도 된다.
		 -->
		<li>String 객체 : ${requestScope.strObj }</li>
		<li>Integer 객체 : ${integerObj }</li>
	</ul>
	
	<!--
	EL의 param 내장객체를 통해 파라미터를 읽을 때
		1.param.폼이름
		2.param['폼이름']
		3.param["폼이름"] 세가지 모두 표현 가능함.
	-->
	<h4>파라미터로 전달된 값의 합</h4>
	<ul>
		<!-- 200과 300의 합의 결과 500이 출력됨 -->
		<li> ${param.firstNum + param['secondNum'] }</li>
		<!-- 단순한 출력이므로 200+300으로 출력됨 -->
		<li> ${param.firstNum} + ${param['secondNum'] }</li>
	</ul>
</body>
</html>