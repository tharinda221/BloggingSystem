package BloggerSystem;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

/**
 * Created by Ehelepola on 06/05/2015.
 */
@WebServlet(name = "approved")
public class approved extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String id=request.getParameter("id");
        String len=request.getParameter("len");

        String jsonFilePath ="Blogger\\posts\\"+id+".json";
        JSONParser jsonParser = new JSONParser();
        FileReader fileReader = new FileReader(jsonFilePath);

        JSONObject jsonObject = null;
        try {
            jsonObject = (JSONObject) jsonParser.parse(fileReader);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        JSONArray commentArray= (JSONArray) jsonObject.get("comment");
        JSONArray pendingArray= (JSONArray) jsonObject.get("pending");
        String[] temArray=new String[pendingArray.size()];
        for(int j=0;j<pendingArray.size();j++){
            temArray[j]=pendingArray.get(j).toString();
        }
        for(int i=0;i<Integer.parseInt(len);i++){

            String cmt=request.getParameter(Integer.toString(i));
            System.out.println(i);
            if(cmt!=null && cmt!=""){

                commentArray.add(temArray[i]);
                pendingArray.remove(temArray[i]);
            }

        }

        jsonObject.put("comment", commentArray);
        jsonObject.put("pending", pendingArray);
        FileWriter jsonFileWriter = new FileWriter(jsonFilePath);
        jsonFileWriter.write(jsonObject.toString());
        jsonFileWriter.flush();
        jsonFileWriter.close();

        request.getRequestDispatcher("approval.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
