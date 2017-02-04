package Employee;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class EmployeeDetails
 */
@WebServlet("/EmployeeDetails")
public class EmployeeDetails extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		response.setContentType("test/html");
		PrintWriter out = response.getWriter();
		final double TAX = 0.1;
		String name = request.getParameter("name");
		String age = request.getParameter("age");
		String salary = request.getParameter("salary");
		//String nation = request.getParameter("nation");
		
		int salaryamount = Integer.parseInt(salary);
		int intage = Integer.parseInt(age);
		
		if(intage >= 30 && salaryamount < 50000) {
			salaryamount = salaryamount+5000;
		}
		double tax = salaryamount*TAX;
		double salaryAfterTax = salaryamount*(1-TAX);
		
		out.println("HI "+name+" your tax is "+tax+" and salary after"
				+ "deducting tax is "+salaryAfterTax);
	}

}
