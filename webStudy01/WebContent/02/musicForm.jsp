<%@page import="java.io.FilenameFilter"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	File folder = (File)application.getAttribute("contentFolder");

	String[] names = folder.list((dir, name) -> {
		return application.getMimeType(name).startsWith("text");
	});
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>02/musicForm.jsp</title>
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous">
</script>
<script type = "text/javascript">
   $(function(){
      var songForm = $("#songForm");
      var resultArea = $("#resultArea");
      $("[name='music']").on("change", function(){
         var song = $(this).val();
         var url = songForm.attr("action");
         var method = songForm.attr("method");
         $.ajax({
            url : url,
            method : method,
            data : {
               song : song
            },
            dataType : "html", // accept : text/html
            success : function(resp){
               resultArea.html(resp);
            },
            error : function(resp) {
               console.log(resp.responseText);
            }
         });
      })
   });
</script>
</head>
<body>
<form id = "songForm" action = "<%= request.getContextPath()%>/song" method = "post">
   <select name = "music">
      <option value = "">가사 선택</option>
      <%
         for(String name : names){
            out.println(String.format(
               "<option>%s</option>", name   
                  ));
         }
      %>
   </select>
</form>
<div id = "resultArea"></div>
</body>
</html>