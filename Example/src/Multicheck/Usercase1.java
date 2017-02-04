package Multicheck;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Usecase
 */
@WebServlet("/Usercase1")
public class Usercase1 extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] ff = request.getParameterValues("ff");
		PrintWriter out = response.getWriter();
		response.setContentType("text/html");
		out.println("<html><body>");
		out.println("<ul>");
		for(String s : ff){
			out.println("<li>"+s+"</li>");
			out.println("</ul>");
			out.println("</body></html>");
		}
	}

}
