<%@ page import="java.io.FileReader" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page import="BloggerSystem.Approval" %>
<%--
  Created by IntelliJ IDEA.
  User: Ehelepola
  Date: 03/05/2015
  Time: 16:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

  <title>Welcome to blogger!</title>

</head>
<body>

<%

  int idNum=new Approval().GetID();
  String [] titles=new String[idNum];
  String [] ids=new String[idNum];
  for(int i=1;i<=idNum;i++){

    String jsonFilePath ="Blogger\\posts\\"+Integer.toString(i)+".json";
    JSONParser jsonParser = new JSONParser();

    FileReader fileReader = new FileReader(jsonFilePath);
    JSONObject jsonObject = (JSONObject) jsonParser.parse(fileReader);
    titles[i-1] = (String) jsonObject.get("title");
    ids[i-1]=(String) jsonObject.get("id");

  }
%>

<h1>Welcome user!!! :)</h1>

<a href="../index.jsp">[menu]</a>



<div>



  <script type="text/javascript">

    <%

      StringBuffer ts = new StringBuffer();
      StringBuffer is = new StringBuffer();
      for (int i = 0; i < idNum; ++i) {
          if (ts.length() > 0) {
              ts.append(',');
              is.append(',');
          }
          ts.append('"').append(titles[i]).append('"');
          is.append('"').append(ids[i]).append('"');
      }

    %>
    var endNum=<%=titles.length%>;

    function writePost(ts,is,endNum){
      for(var i=0;i<endNum;i++){
        document.write("<div>")
        document.write("<a"+ " href="+"/newpost/Approval?id="+is[i]+">")
        document.write(ts[i])
        document.write("</a>")
        document.write("</div>")
      }
    }
    var ts = [ <%= ts.toString() %> ];
    var is = [ <%= is.toString() %> ];
    writePost(ts,is,endNum);

  </script>



</div>

</body>
</html>
