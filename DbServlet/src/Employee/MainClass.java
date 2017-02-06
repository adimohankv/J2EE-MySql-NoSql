package Employee;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class TestRun
 */
@WebServlet("/TestRun")
public class MainClass extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private KeepingCount kp;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			
			try {
				kp = new KeepingCount();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			out.println(kp.AgeCount+" "+kp.avgSalary+" "+kp.MSMCount);
		
	
	}
}
