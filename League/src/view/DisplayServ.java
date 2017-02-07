package view;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DisplayServ
 */
@WebServlet("/DisplayServ")
public class DisplayServ extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		

		String choice = request.getParameter("season_title");
		String season = request.getParameter("season");
		String year = request.getParameter("year");
		PrintWriter out = response.getWriter();
		out.println("<html><body>");
		out.println("You have regisered for "+choice+" football league for the year "+year);
		out.println("</body></html>");
	}

}
