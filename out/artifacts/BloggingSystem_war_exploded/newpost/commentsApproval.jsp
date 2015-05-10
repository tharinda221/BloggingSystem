<%--
  Created by IntelliJ IDEA.
  User: Ehelepola
  Date: 07/05/2015
  Time: 00:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page import="org.json.simple.JSONArray" %>
<html>

<%
  String id=request.getParameter("id");
  String jsonFilePath ="Blogger\\posts\\"+id+".json";
  JSONParser jsonParser = new JSONParser();
  FileReader fileReader = new FileReader(jsonFilePath);
  JSONObject jsonObject = (JSONObject) jsonParser.parse(fileReader);
  JSONArray comment = (JSONArray) jsonObject.get("comment");
  JSONArray pending = (JSONArray) jsonObject.get("pending");

%>

<head>
    <title></title>
</head>
<body>

<form action="approved">

<script type="text/javascript">

  <%
    StringBuffer cs = new StringBuffer();
    for(int i=0;i<pending.size();i++) {
      if (cs.length() > 0) {
        cs.append(',');
      }
      cs.append('"').append(pending.get(i)).append('"');
    }


  %>
  var cs = [ <%= cs.toString() %> ];

  for(var i=0;i<cs.length;i++){

    document.write("<input type="+"checkbox"+" name="+i+" value=")
    document.write(cs[i])
    document.write(">")
    document.write(cs[i])
    document.write("<br>")
  }

</script>

  <input type="hidden" name="len" value=<%=pending.size()%> />
  <input type="hidden" name="id" value=<%=id%> />
  <input type="submit" value="Submit">
  </form>
</body>
</html>
