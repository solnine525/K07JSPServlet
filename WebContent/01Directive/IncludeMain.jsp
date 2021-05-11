<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
include 지시어 : 공통으로 사용할 JSP파일을 생성한 후
	현재문서에 포함시킬 때 사용한다. 각각의 JSP 파일 상단에는
	반드시 page 지시어가 삽입되어야 한다.
	단, 하나의 JSP파일에서 page 지시어가 중복선언되면 안된다.
 --%>
 
<%@ include file = "IncludePage.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>IncludeMain.jsp</title>

<!-- CSS 코드는 양이 많으므로 외부파일로 선언하여 현재문서에 링크시킨다. -->
<link rel="stylesheet" href="./css/div_layout.css"/>
</head>
<body>
	<div class="AllWrap">
		<div class="header">
			<!--  GNB 영역 -->
			<%@ include file="../common/Top.jsp" %>
		</div>
		<div class="body">
			<div class="left_menu">
				<!-- LNB영역(Local Navigation Bar) -->
				<%@ include file="../common/Left.jsp" %>
			</div>
			<div class="contents">
				<!-- contents 영역 -->
				
				<h2>오늘의 날짜 : <%=todayStr %></h2>
				<br/><br/>
				
				전기자동차 기업 테슬라의 창업자인 일론 머스크(사진)가 이끄는 우주탐사 기업 스페이스X가 한 민간 기업과의 달 탐사 프로젝트에서 대금을 암호화폐인 ‘도지코인’으로 받겠다고 밝혔다.
				<br/><br/>
9일(현지 시간) 로이터통신에 따르면 스페이스X는 내년 1분기 ‘도지-1 달 탐사’라는 이름의 임무에 착수한다. 지오메트릭에너지라는 회사가 발표한 이 탐사 계획은 무게 40㎏인 정육면체 모양의 위성을 스페이스X의 팰컨9 로켓에 실어 달로 보내는 것이다. 지오메트릭은 스페이스X에 지불해야 할 비용 전체를 도지코인으로 결제하겠다고 이날 밝혔다. 다만 지오메트릭 측은 정확한 지불 대금 규모를 밝히지 않았다.

				
				<br/><br/>
			</div>
		</div>
		<div class="copyright">
		<!-- Copyright -->
			<%@ include file="../common/Copyright.jsp" %>
		</div>
	</div>
</body>
</html>