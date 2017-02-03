package DataProcess;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.eclipse.jdt.internal.compiler.codegen.BranchLabel;

/**
 * Servlet implementation class validation
 */
@WebServlet("/validation")
public class validation extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		String name = request.getParameter("name");
		String age = request.getParameter("age");
		String gender = request.getParameter("gender");
		String city = request.getParameter("city");
		String address = request.getParameter("address");
		String pin = request.getParameter("pin");
		String id = request.getParameter("id");
		String phone = request.getParameter("phone");
		String[] aoi = request.getParameterValues("aoi");
		
		if (id.length() > 4 || id.toLowerCase().charAt(0)!='c') {
			RequestDispatcher rd = request.getRequestDispatcher("index.html");
			out.println("Invalid ID please try aagain");
			rd.include(request, response);
		}
		int aGE = Integer.parseInt(age);
		if (aGE < 18) {
			RequestDispatcher rd = request.getRequestDispatcher("index.html");
			out.println("Your too young try again after "+(18-aGE)+" years");
			rd.include(request, response);
		}
		for (String i : aoi) {
			System.out.println(i);
		}
		/*if(aoi.length<2) {
			RequestDispatcher rd = request.getRequestDispatcher("index.html");
			out.println("Please select al least two options");
			rd.include(request, response);
		}*/
		
		/*String input = null;
		BufferedWriter br = null;
		try{
			br = new BufferedWriter(new FileWriter("D:\\Data.txt",true));
			
		}
		finally {
			br.close();
		}*/
		
		
	}
}

