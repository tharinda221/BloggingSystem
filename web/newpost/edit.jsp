        <%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.parser.ParseException" %>
<%--
  Created by IntelliJ IDEA.
  User: Ehelepola
  Date: 04/05/2015
  Time: 18:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%
  String id = request.getParameter("id");
  String jsonFilePath = "Blogger\\posts\\" + id + ".json";
  JSONParser jsonParser = new JSONParser();
  FileReader fileReader = new FileReader(jsonFilePath);

  JSONObject jsonObject = (JSONObject) jsonParser.parse(fileReader);
  String title = (String) jsonObject.get("title");
  String post = (String) jsonObject.get("post");
%>
<head>
    <title>Edit your post</title>
</head>

<body>

  <h1>Edit Blogger post</h1>
  <form action="UpdatePost" method="post">
    Title of the post:
    <input type="text" name="title" id="ti" >
    <br>
    <br>
    <br>
    Enter your post:<br><br>
    <textarea name="post" rows="30" cols="50" id="po"></textarea>
    <br>
    <input type="submit" value="Submit">
    <input type="hidden" name="id" value="<%=id%>" />
  </form>

</body>
<script type="text/javascript">

  var title="<%=title%>";
  var post="<%=post%>";

  function assign(title,post){
    document.getElementById("ti").value=title;
    document.getElementById("po").value=post;

  }
  assign(title,post);

</script>
</html>
