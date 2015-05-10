<%--
  Created by IntelliJ IDEA.
  User: Ehelepola
  Date: 06/05/2015
  Time: 03:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page import="org.json.simple.JSONArray" %>
<html>
<head>
    <title></title>
</head>
<body>
<%
  String id=request.getParameter("id");
  String jsonFilePath ="Blogger\\posts\\"+id+".json";
  JSONParser jsonParser = new JSONParser();
  FileReader fileReader = new FileReader(jsonFilePath);
  JSONObject jsonObject = (JSONObject) jsonParser.parse(fileReader);
  String title = (String) jsonObject.get("title");
  String name = (String) jsonObject.get("name");
  String post = (String) jsonObject.get("post");
  JSONArray comment = (JSONArray) jsonObject.get("comment");
  System.out.println(title);

%>

  <div>
    <h2><%=title%></h2>
  </div>

  <div>
    <p><%=post%></p>
  </div>

  <div>
    post by:<%=name%>
  </div>

    <form action="commentsApproval" method="post">
      <input type="hidden" name="id" value=<%=id%> />
      <input type="submit" value="Pending comments">

    </form>

    <form action="edit" method="post">
      <input type="hidden" name="id" value=<%=id%> />
      <input type="submit" value="edit post">

    </form>

  <script type="text/javascript">

    <%
      StringBuffer cs = new StringBuffer();
      for(int i=comment.size()-1;i>=0;i--) {
        if (cs.length() > 0) {
          cs.append(',');
        }
        cs.append('"').append(comment.get(i)).append('"');
      }


    %>
    var cs = [ <%= cs.toString() %> ];

    for(var i=0;i<cs.length;i++){

      document.write("<div>")
      document.write(cs[i])
      document.write("</div>")
    }

  </script>

</body>
</html>
