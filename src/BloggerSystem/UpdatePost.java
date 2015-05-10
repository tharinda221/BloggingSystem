package BloggerSystem;

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
  * Created by Ehelepola on 04/05/2015.
 * * */
@WebServlet(name = "UpdatePost")
public class UpdatePost extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id=request.getParameter("id");
        String title=request.getParameter("title");
        String post=request.getParameter("post");

        String jsonFilePath = "Blogger\\posts\\"+id+".json";
        JSONParser jsonParser = new JSONParser();
        FileReader fileReader = new FileReader(jsonFilePath);

        try {
            JSONObject jsonObject = (JSONObject) jsonParser.parse(fileReader);
            jsonObject.put("title", title);
            jsonObject.put("post", post);
            FileWriter jsonFileWriter = new FileWriter(jsonFilePath);
            jsonFileWriter.write(jsonObject.toString());
            jsonFileWriter.flush();
            jsonFileWriter.close();



        } catch (ParseException e) {
            e.printStackTrace();
        }
        request.getRequestDispatcher("../finish.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
