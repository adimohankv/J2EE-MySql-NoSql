package view;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		generateView(request, response);

	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		generateView(request, response);

	}

	private void generateView(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/html");

		PrintWriter out = response.getWriter();
		out.println("<html>");
		out.println("<body>");
		out.println("<form action = 'DisplayServ' method='post'>");
		out.println("Season: <br/><input type='text' name='season'>");
		out.println("<br/> Year:<br/><input type='text' name='year'>");
		out.println("<br/> Title: <select name='season_title'>");

		out.println("<option value='spring'> Spring Soccer league </option>");
		out.println("<option value='autumn'> Autumn Soccer league </option>");
		out.println("<option value='summer'> Summer Soccer league </option>");
		out.println("<option value='winter'> Winter Soccer league </option>");
		out.println("<option value='Rainfall'> rainfall Soccer league </option>");
		out.println("</select>");
		out.println("<input type='submit' name='submit'>");
		out.println("</form>");
		out.println("</body>");
		out.println("</html>");
	}

}
