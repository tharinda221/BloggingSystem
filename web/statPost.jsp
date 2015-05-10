<%--
  Created by IntelliJ IDEA.
  User: Ehelepola
  Date: 09/05/2015
  Time: 00:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="java.io.FileWriter" %>
<html>

  <%

    String id=request.getParameter("id");
    String jsonFilePath ="Blogger\\posts\\"+id+".json";
    JSONParser jsonParser = new JSONParser();
    FileReader fileReader = new FileReader(jsonFilePath);
    JSONObject jsonObject = (JSONObject) jsonParser.parse(fileReader);
    String title = (String) jsonObject.get("title");
    String name = (String) jsonObject.get("name");
    String post = (String) jsonObject.get("post");
    String views = (String) jsonObject.get("views");
    JSONArray comment = (JSONArray) jsonObject.get("comment");
  %>

<head>
    <title><%=title%>:statistics</title>
</head>
<body>
  <a href="index.jsp">[menu]</a>

  <br>
  <br>
  <div>
    Post Title:<%=title%>
    <br>
    Total views:<%=views%>
    <br>
    Total Comments:<%=comment.size()%>
  </div>
</body>
</html>
