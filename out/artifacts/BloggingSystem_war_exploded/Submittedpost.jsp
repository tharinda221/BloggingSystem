<%--
  Created by IntelliJ IDEA.
  User: Ehelepola
  Date: 03/05/2015
  Time: 15:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.io.FileReader" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="java.io.FileWriter" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
  String viewCount=Integer.toString(1+(Integer.parseInt(views)));
  JSONArray comment = (JSONArray) jsonObject.get("comment");

  jsonObject.put("views", viewCount);
  FileWriter jsonFileWriter = new FileWriter(jsonFilePath);
  jsonFileWriter.write(jsonObject.toString());
  jsonFileWriter.flush();
  jsonFileWriter.close();

%>
<head>
  <title><%=title%>:<%=name%></title>
</head>
  <body>

  <a href="index.jsp">[menu]</a>

  <div>
    <h2><%=title%></h2>
  </div>

  <div>
    <p><%=post%></p>
  </div>

  <div>
    post by:<%=name%>
  </div>

  <div>
    add your comments here...
    <br>
    <form action="PendingComments" method="post">
      <textarea name="comment" rows="3" cols="30"></textarea>
      <input type="hidden" name="id" value=<%=id%> />
      <input type="submit" value="submit">
    </form>
  </div>

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
