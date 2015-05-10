<%--
  Created by IntelliJ IDEA.
  User: Ehelepola
  Date: 09/05/2015
  Time: 01:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page import="BloggerSystem.BloggerSystem" %>
<html>
  <%

    int idNum=new BloggerSystem().GetID();
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
<head>
    <title>more posts</title>
</head>
<body>
  <h1>Other Posts</h1>
  <br>
  <br>
  <br>
  <div>
    <script type="text/javascript">

      <%

        StringBuffer ts = new StringBuffer();
        StringBuffer is = new StringBuffer();
        for (int i=0;i<idNum-10;i++) {
            if (ts.length() > 0) {
                ts.append(',');
                is.append(',');
            }
            ts.append('"').append(titles[i]).append('"');
            is.append('"').append(ids[i]).append('"');
        }

      %>
      var endNum=<%=idNum-10%>;

      function writePost(ts,is,endNum){

        for(var i=0;i<endNum;i++){
          document.write("<div>")
          document.write("<a"+ " href="+"/ClickedPost?id="+is[i]+">")
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
