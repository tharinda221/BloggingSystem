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
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Ehelepola on 06/05/2015.
 */
@WebServlet(name = "PendingComments")
public class PendingComments extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String comment=request.getParameter("comment");
        String id=request.getParameter("id");

        String jsonFilePath ="Blogger\\posts\\"+id+".json";
        JSONParser jsonParser = new JSONParser();
        FileReader fileReader = new FileReader(jsonFilePath);
        try {
            JSONObject jsonObject = (JSONObject) jsonParser.parse(fileReader);
            JSONArray jsonArray= (JSONArray) jsonObject.get("pending");
            jsonArray.add(comment);
            jsonObject.put("pending", jsonArray);
            FileWriter jsonFileWriter = new FileWriter(jsonFilePath);
            jsonFileWriter.write(jsonObject.toString());
            jsonFileWriter.flush();
            jsonFileWriter.close();
            System.out.println(comment);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        request.getRequestDispatcher("Submittedpost.jsp").forward(request,response);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
