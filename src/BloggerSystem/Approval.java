package BloggerSystem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

/**
 * Created by Ehelepola on 06/05/2015.
 */
@WebServlet(name = "Approval")
public class Approval extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id=request.getParameter("id");
        System.out.println(id);
        request.getRequestDispatcher("approvalPage.jsp").forward(request, response);
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
}
