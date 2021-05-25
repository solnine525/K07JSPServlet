<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
pageContext.setAttribute("num1",9);
pageContext.setAttribute("num2",10);

pageContext.setAttribute("nullStr",null); //null값
pageContext.setAttribute("emptyStr",""); //문자열
pageContext.setAttribute("lengthZero",new Integer[0]); //Wrapper 클래스
pageContext.setAttribute("sizeZero",new ArrayList()); //List컬렉션
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Operator2.jsp</title>
</head>
<body>
	<h3>empty연산자</h3>
	<!-- 
	null일 때  true를 반환하는 연산자.
	String이 빈문자열일 때 , 컬렉션의 size가 0일 때, 배열의 길이가 0일 때.
	 -->
	empty nullStr : $[empty nullStr] <br/> 
	empty emptyStr : $[empty emptyStr] <br/>
	empty lengthZero : $[empty lengthZero] <br/>
	empty sizeZero : ${empty sizeZero }
	
	<h3>삼항연산자</h3>
	num1 gt num2 ? "참" : "거짓"
		=> ${num1 gt num2 ? "num1이크다" : "num2가크다" }
	
	
	<h3>null 연산</h3>
	<!-- 
	 Java에서는 null과 연산을 할 수 없다.
	 하지만 EL에서는 null을 0으로 간주하여 계산하므로
	 NullPointerException이 발생하지 않는다.
	 -->
	null+10 : ${null+10 } <br/>
	nullStr+10 : ${nullStr+10 } <br/>
	param.noVar>10 : ${param.noVar>10 }
	<!-- 
	해당페이지?noVar=99 => 숫자로 인식하므로 true
	해당페이지?noVar= => 0으로 긴주되어 false
	해당페이지?noVar=구십 => 문자는 숫자로 변경할 수 없으므로 에러발생됨.
	 -->
	
</body>
</html>