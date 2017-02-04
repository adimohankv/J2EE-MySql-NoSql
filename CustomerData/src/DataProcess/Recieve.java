package DataProcess;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Recieve
 */
@WebServlet("/Recieve")
public class Recieve extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BufferedWriter bw;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		String name = request.getParameter("name");
		String age = request.getParameter("age");
		String gender = request.getParameter("gender");
		String city = request.getParameter("City");
		String address = request.getParameter("address");
		String pin = request.getParameter("pin");
		String id = request.getParameter("id");
		String phone = request.getParameter("phone");
		String[] aoi = request.getParameterValues("aoi");
		final int TOTALATRIBUTES = 9;
		
		//Valaditaion
		if(id.toLowerCase().charAt(0) != 'c' || id.length() > 4){
			
			out.println("Invalid ID! Please try again");
			
		}
	
		if(aoi.length<2) {
			out.println("Please select al least two options");
		}
		
		//writing
		String input = null;
		try {
		bw = new BufferedWriter(new FileWriter("D:\\data.txt", true));
		input = (name+","+age+","+gender+","+city+","+address+","+pin+","+id+","+phone+",");
		bw.write(input);
	
		if(aoi != null){
			for(int i = 0; i < aoi.length ; i++){
				String area = (aoi[i]+"_");
				bw.write(area);
			}
		}
		bw.write(",");
		}
		finally{
			bw.close();
		}
		
		//reading 
		String output = null;
		BufferedReader br = null;
		try {
			br = new BufferedReader(new FileReader("D:\\data.txt"));
			output = br.readLine();
			
		}
		catch (FileNotFoundException e){
			e.printStackTrace();
		}
		finally{
			br.close();
		}
		
		//analysis
		int malecount = 0;
		int femalecount = 0;
		int travelcount =0;
		int readingcount= 0;
		int agecount = 0;
		int phcount = 0;
		String [] data = output.split(",");
		int custcount = data.length/TOTALATRIBUTES;
		for(int i = 0;i<custcount;i++){
			if(data[2+(i*TOTALATRIBUTES)].equalsIgnoreCase("male"))malecount++;
			else if (data[2*i].equalsIgnoreCase("female"))femalecount++;
			
			if(data[7+(i*TOTALATRIBUTES)]==null)phcount++;
			
			if(Integer.parseInt(data[1+(i*TOTALATRIBUTES)])<18)agecount++;
			
			String[] aoidata = data[8+(i*TOTALATRIBUTES)].split("_");
			for(String a : aoidata){
				if(a.equalsIgnoreCase("reading"))readingcount++;
				if(a.equalsIgnoreCase("travelling"))travelcount++;
			}
			
		}
		out.println(malecount+" "+femalecount+" "+travelcount+" "+readingcount+" "+agecount+" "+phcount);
	}
}
