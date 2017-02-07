package view;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.League;


@WebServlet("/ListLeagueServlet")
public class ListLeagueServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	List<League> league=null;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


		league=new ArrayList<League>();
		
		league.add(new League("Summer",2017,"Summer Soccer League 17"));
		league.add(new League("Winter",2017,"Winter Soccer League 17"));
		league.add(new League("RainFall",2017,"RainFall Soccer League 17"));
		
		response.setContentType("text/html");
		
		PrintWriter out=response.getWriter();
		
		out.println("<html>");
		out.println("<body>");
		
		Iterator<League> i=league.iterator();
		out.println("<ul>");
		while(i.hasNext())
		{
			out.println("<li>");
			
			League leaguelist=(League)i.next();
			out.println(leaguelist);
			out.println("</li>");
			
			
		}
		out.println("<ul>");
		
		out.println("</body>");
		out.println("</html>");
		
		
	}

}
