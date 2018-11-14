<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>03/resourceIdentify.jsp</title>
</head>
<body>
<h4>자원의 식별</h4>
1. 파일 시스템 자원
2. 클래스패스(classpath) 자원 : classpath 기준 경로를 통한 식별
3. 웹 리소스 자원
   URI(Uniform Resource Indentifier)
      URL(Uniform Resource Locator)
      URN(Uniform Resource Name)
      URC(Uniform Resource Content)
   URL
   scheme://domain:port/context/depth1/depth2...../resource_name
   
   절대경로 : http://localhost:80/webStudy01/images/Hydrangeas.jpg
  	 client-side : /webStudy01/images/Hydrangeas.jpg
  	 server-side : /desc(contextPath를 제외한 이후 경로 표기)
   상대경로 : 경로를 판단할 기준 위치 : 현재 브라우저의 주소값
   <img src="<%=request.getContextPath() %>/images/Hydrangeas.jpg"/>
   <img src="http://Localhost:80/webStudy01/images/Hydrangeas.jpg"/>
   <img src="../images/Hydrangeas.jpg"/>
	
</body>
</html>