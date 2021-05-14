<%@page import="utils.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PopupMain.jsp</title>
<style>
	/*
		레이어 팝업창을 다른 엘리먼트와 겹쳐서 배치하기 위해
		position 속서을 absolute로 부여해야 한다.
	*/
	div#popup {
		position: absolute; top:100px; left:200px;
		width:300px; height:200px; color:yellow;
		border:0px solid gray; background-color:gray;
	}
	/*
		팝업창 하단의 닫기버튼 있는 부분의 속성
	*/
	div#popup>div {
		position: relative; background-color:#ffffff; top:50px
		border:1px soid gray; padding:10px; color:black;
	}
</style>
</head>
<body>
	<h2>팝업 메인페이지</h2>
	
	페이지를 방문하면 레이어 팝업이 뜨게 됩니다. <br/>
	페이지를 방문하면 레이어 팝업이 뜨게 됩니다. <br/>
	페이지를 방문하면 레이어 팝업이 뜨게 됩니다. <br/>
	페이지를 방문하면 레이어 팝업이 뜨게 됩니다. <br/>
	페이지를 방문하면 레이어 팝업이 뜨게 됩니다. <br/>
	페이지를 방문하면 레이어 팝업이 뜨게 됩니다. <br/>
	페이지를 방문하면 레이어 팝업이 뜨게 됩니다. <br/>
	페이지를 방문하면 레이어 팝업이 뜨게 됩니다. <br/>
	페이지를 방문하면 레이어 팝업이 뜨게 됩니다. <br/>
	페이지를 방문하면 레이어 팝업이 뜨게 됩니다. <br/>
	
	<%
		//팝업 메인에서는 isPopup이 on이면 레이어 팝업창을 표시한다.
		String isPopup = "on";
		//쿠키명 PopupClose를 읽어온다.
		String PopCloseVal = CookieManager.readCookie(request, "PopupClose");
		//읽어온 쿠키값이 있다면 isPopup에 할당한다.
		if(!PopCloseVal.equals(""))
			isPopup=PopCloseVal;
		//읽어온 쿠키값이 없다면 레이어 팝업창을 보여준다.
		System.out.println("팝업쿠키:"+isPopup);
		if(isPopup.equals("on")){
	%>
		<script>
			function popClose() {
				var popup = document.getElementById('popup');
				popup.style.display = "none"; //웹브라우저에서 숨김처리
				var frm = documnet.popFrm;
				//오늘 하루 열지않음을 체크한 경우 폼값을 전송(submit)한다.
				if(frm.isToday.checked==true){
					console.log("isToday check..");
					frm.action = 'PopupCookie.jsp';//폼값을 전송할 경로
					frm.target = 'hiddenFrame'; //폼값을 전송할 타겟(하단의 Iframe으로 지정)
					frm.method = 'post'; //전송방식
					frm.submit();
				}
			}
		
		</script>
		
		<div id="popup">
			<h2>공지사항</h2>
			<p>
				중얼중얼 <br/> 
				중얼중얼 <br/>
				중얼중얼 <br/>
			</p>
			<div>
			<form name="popFrm">
				<input type="checkbox" name="isToday" value="1"/>
				오늘 하루 열지않음
				<input type="button" value="닫기" onclick="popClose();"/>
			</form>
			</div>			
		</div>
		<!-- 폼 값은 여기로 전송된다. -->
		<iframe name="giddenFrame"
			style="display:block; width:400px;"></iframe>
	<%
	}
	%>
</body>
</html>