<%@page import="java.util.Locale"%>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
   String lang = request.getParameter("lang");
   Locale currentLocale = request.getLocale();
   if(lang!= null && lang.trim().length()!=0){
      currentLocale = Locale.forLanguageTag(lang);
   }
%>   
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>03/requestHeader.jsp</title>
</head>

<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous">
</script>

<script type = "text/javascript">
   $(function() {
      $("[name='lang']").on("change", function() {
         document.langForm.submit();
//          var lang = $(this).val();
//          $("#h4").html(lang);

      });
   });
</script>


<body>
<%
   Locale[] locales = Locale.getAvailableLocales();
%>
<form name = "langForm">
   <select name = "lang">
      <option value = "">언어 선택</option>
      <%
         String optPattern = "<option value = '%s'%s>%s</option>";
         for(Locale tmp : locales){
            String value = tmp.toLanguageTag();
            String text = tmp.getDisplayLanguage();
            String selected = "";
            if(currentLocale.equals(tmp)){
               selected = "selected";
            }
            if(text != null && text.trim().length() != 0){
               out.println(String.format(optPattern, value,selected ,text));
            }
         }
      %>
   </select>
</form>
<ul>
   <li>
      현재 사용자의 언어와 국가 정보
      : <h4 id="h4"></h4>
   </li>
   <li>
      <%
//         ex) ko_KR : 로케일문자 언어_지역(국가)
         Locale locale = request.getLocale();
         String country = locale.getDisplayCountry(currentLocale);
         String language = locale.getDisplayLanguage(currentLocale);
      %>
      Locale 객체 활용
      : <%=language %><%= country %>
   </li>
</ul>

<table>
   <thead>
      <tr>
         <th>헤더명</th>
         <th>헤더값</th>
      </tr>
   </thead>
   <tbody>
      <%
         Enumeration<String> names = request.getHeaderNames();
         String pattern = "<tr><td>%s</td><td>%s</td></tr>";
         while(names.hasMoreElements()){
            String headerName = names.nextElement();
            String headerValue = request.getHeader(headerName);
            out.println(String.format(pattern, headerName, headerValue));
         }
      %>
   </tbody>
</table>
</body>
</html>