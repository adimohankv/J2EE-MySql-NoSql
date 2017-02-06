package Employee;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

class Databaseconnection {
	
	Connection con = null;
	Statement stmt = null;
	public Databaseconnection() throws Exception{
		Class.forName("org.h2.Driver");
		con = DriverManager.getConnection("jdbc:h2:localhost/~/test","test","123");
		stmt = con.createStatement();
	}
	
/*	public ResultSet drtEmpID () throws Exception{
		
		ResultSet rs = stmt.executeQuery("Select EmployeeID from Employee");
		return rs;
	}
	public ResultSet drtEmpName () throws Exception{
		
		ResultSet rs = stmt.executeQuery("Select EmployeeName from Employee");
		return rs;
	}*/
	public ResultSet drtEmpAge () throws Exception{
	
		ResultSet rs = stmt.executeQuery("Select EmployeeAge,MStatus from Employee");
		return rs;
	}
	public ResultSet drtEmpCity () throws Exception{
		
		ResultSet rs = stmt.executeQuery("Select EmployeeCity from Employee");
		return rs;
	}
	public ResultSet drtEmpSalary () throws Exception{
		
		ResultSet rs = stmt.executeQuery("Select EmployeeSalary from Employee");
		return rs;
	}
	public ResultSet drtEmpDpt () throws Exception{
		
		ResultSet rs = stmt.executeQuery("Select EmployeeEmpDpt from Employee");
		return rs;
	}
	public ResultSet drtEmpDOJ () throws Exception{
		
		ResultSet rs = stmt.executeQuery("Select EmployeeDOJ from Employee");
		return rs;
	}
	public ResultSet drtEmpDOB () throws Exception{
		
		ResultSet rs = stmt.executeQuery("Select EmployeeDOB from Employee");
		return rs;
	}
}
