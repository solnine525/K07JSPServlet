<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>03If.jsp</title>
</head>
<body>
	<!--  
	if태그
	-JSTL의 if태그는 시작태그와 종료태그를 통해 조건을 판단한다.
	-else문이 없기때문에 다중 조건일 때는 표현이 어렵다.
	-다중 조건인 경우 choose태그를 사용한다.
	형식]
		test : 조건
		var : test의 조건을 반환받을 변수 지정
		scope : 영역설정(거의 사용되지 않음)
	-->
	<h2>if태그</h2>
	<c:set var="numVar" value="100" />
	<c:set var="strVar" value="JAVA" />
	
	<!--  
	if(num%2==0)와 동일한 조건으로, 해당 조건문은 true를 
	반환하므로 태그 사이의 문장이 출력된다. 그리고 var 속성에
	지정된 result에 true가 저장된다.
	-->
	<h3>JSTL의 if태그로 짝수/홀수 판단하기</h3>
	<c:if test="${numVar mod 2 eq 0 }" var = "result" >
		${numVar }는 작수입니다. <br/>
	</c:if>
	\${result } : ${result } <br/>
	
	<h3>위 if문을 EL식의 삼항식으로 표현</h3>
	${numVar } : ${numVar mod 2 == 0 ? "는 짝수" : "는 홀수" }
	
	<!--  
	JSTL의 if 태그는 else가 없기때문에 참 or 거짓의 형태로
	구문을 만들어서 조건을 판단해야한다.
	-->
	<h3>문자열 비교</h3>
	<!-- JAVA라는 변수는 만들지 않았으므로 조건은 false를 반환한다. -->
	<c:if test="${JAVA eq '자바' }" >
		${strVar }는 자바다 <br/>
	</c:if>
	<c:if test="${JAVA ne '자바' }" >
		${strVar }는 자바가 아니다 <br/>
	</c:if>
	
	
	
	<h3>문자열 비교2</h3>
	<!-- 
		첫번째 if문에서의 조건을 var속성을 통해 변수에 저장하고
		두번째 if문에서는 위 변수에 not을 붙여 반대의 조건을 만들어준다.
	 -->
	<c:if test="${JAVA eq '자바' }" var= "strResult">
		${strVar }는 자바다 <br/>
	</c:if>
	<c:if test="${not strResult }" >
		${strVar }는 자바가 아니다 <br/>
	</c:if>
	
	
	
	
	
	<!--  
	-test 속성에 EL이 아닌 일반값이 들어가면 무조건 false를 반호나한다.
	-EL이더라도 {} 양쪽에 공백이 들어가면 무조건 false를 반환한다.
	-단, 일반식이더라도 TRUE(true)인 경우에는 true를 반환한다.
	-->
	<h2>if문 사용시 주의사항</h2>
	<h3>항상 출력되거나 출력되지 않는 조건식</h3>
	
	<c:if test="${true }">
		난 항상 출력돼
	</c:if>
	<c:if test="${false }">
		난 항상 출력되지 않아
	</c:if>
	
	<h3>test속성에 일반값으로 조건지정</h3>
	<c:if test="100" var="result" >
		100은 일반값이므로 무조건 false 반환
	</c:if>
	\${result } : ${result } <br/>
	
	<c:if test="tRuE" var="result">
		TRUE(true) 대소문자 구분없음. 항상 참임. <br/>
	</c:if>
	\${result } : ${result } <br/>
	
	<%-- <h3>EL식으로 조건판단시 {}양쪽에 공백이 있으면
	무조건 false로 판단됨.</h3>
	<c:if test=" ${변수 eq 값 } " var="result">
		빈 공백이 있어서 무조건 false 처리됨.
	</c:if>
	\${result } : ${result } <br/> --%>



	<!-- 
	아이디, 패스워드를 입력 후 submit 하면 EL식을 통해 받은 파라미터가
	"kosmo", "1234"인 경우에는 "kosmo님 하이룽" 이라고 출력한다.
	만약 틀렸다면 "아이디와 비밀번호를 확인하세요"를 출력한다.
	EL과 JSTL의 if태그만을 이용해 작성하시오.
	-->
	
	<h3>연습문제 : if태그</h3>
	<form method="get">
		아이디 : <input type="text" name="user" />
		<br />
		패스워드 : <input type="text" name="pass" />
		<br />
		<input type="submit" value="로그인" />
	</form>	
		
	
	<c:if test="${not empty param.user }">
		<c:if test="${param.user eq 'kosmo' and param.pass=='1234'}" var="loginResult">
			${param.user }님 하이요
		</c:if>
		<c:if test="${not loginResult }">
			아이디와 비밀번호를 확인하세요.
		</c:if>
	</c:if>
	
	<c:set var="user" value="${param.user }" />
	<c:set var="pass" value="${param.pass }"/>
	
	<c:if test="${param.user eq 'kosmo' }" >
		<c:if test="${param.pass eq '1234' }">
			<h3>kosmo님 하이요</h3>
		</c:if>
	</c:if>	
		
</body>
</html>