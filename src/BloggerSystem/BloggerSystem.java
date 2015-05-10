package BloggerSystem;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;

//json imports
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

//json writer
import java.io.IOException;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

@WebServlet(name = "BloggerSystem")
public class BloggerSystem extends HttpServlet {



    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String title=request.getParameter("title");
        String post=request.getParameter("post");

        int id=GetID()+1;
        String jsonFilePath = "Blogger\\posts\\"+Integer.toString(id)+".json";
        System.out.println(jsonFilePath);

        Map<String, String> map = new HashMap<String, String>();
        map.put("id",Integer.toString(id));
        map.put("name",request.getRemoteUser());
        map.put("title",title);
        map.put("post",post);
        map.put("views","0");

        JSONArray jsonArray = new JSONArray();

        JSONObject jsonObject = new JSONObject();
        jsonObject.putAll(map);
        jsonObject.put("comment", jsonArray);
        jsonObject.put("pending", jsonArray);

        System.out.println(jsonObject.toString());

        try {

            FileWriter jsonFileWriter = new FileWriter(jsonFilePath);
            jsonFileWriter.write(jsonObject.toString());
            writeID();
            jsonFileWriter.flush();
            jsonFileWriter.close();

            //System.out.print(jsonObject);
            request.getRequestDispatcher("finish.jsp").forward(request, response);

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    public int GetID() throws IOException {
        String filename="Blogger\\posts\\id.txt";
        Path path = Paths.get(filename);

        if (Files.notExists(path)) {

            File file = new File("Blogger\\posts");
            file.mkdirs();
            PrintWriter writer = new PrintWriter(filename, "UTF-8");
            writer.println("0");
            writer.close();
            return 0;
        }
        else{
            FileReader reader =new FileReader(filename);
            BufferedReader bufferRd = new BufferedReader(reader);
            String id=bufferRd.readLine();
            return Integer.parseInt(id);
        }

    }
    protected void writeID() throws IOException {


        int id=GetID()+1;
        FileWriter FileWriter = new FileWriter("Blogger\\posts\\id.txt");
        FileWriter.write(Integer.toString(id));
        FileWriter.flush();
        FileWriter.close();

    }
}
