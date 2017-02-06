package Employee;

import java.sql.ResultSet;

public class KeepingCount {
	
	public KeepingCount() throws Exception{
		
	}
	Databaseconnection dbc = new Databaseconnection();

	 int Count,AgeCount,MSSCount,MSMCount;

	ResultSet rs = dbc.drtEmpAge();

	 int CBANCount;

	 int CMUMCount;

	 int CCHECount;

	 int CDELCount;

	private int totalSalary=0;
	while(rs.next()){
		if(rs.getInt("EmployeeAge")>=58)AgeCount++;
		
		if(rs.getString("MStatus").equalsIgnoreCase("Single"))MSSCount++;
		else if (rs.getString("MStatus").equalsIgnoreCase("Married"))MSMCount++;
			
	}
	rs = dbc.drtEmpCity();
	while(rs.next()){
		if(rs.getString("EmployeeCity").equalsIgnoreCase("Bangalore"))CBANCount++;
		else if(rs.getString("EmployeeCity").equalsIgnoreCase("Mumbai"))CMUMCount++;
		else if(rs.getString("EmployeeCity").equalsIgnoreCase("Chennai"))CCHECount++;
		if(rs.getString("EmployeeCity").equalsIgnoreCase("DELHI"))CDELCount++;
	}
	rs=dbc.drtEmpSalary();
	while(rs.next()){
		Count++;
		totalSalary +=rs.getInt("EmployeeSalary");
	}
	double avgSalary= (double)(totalSalary/Count);

	int DQACount;

	int DDEVCount;

	 int DCCCount;

	 int DHRCount;
	
	rs= dbc.drtEmpDpt();
	while(rs.nex()){
		if(rs.getString("EmployeeDpt").equalsIgnoreCase("QA"))DQACount++;
		else if(rs.getString("EmployeeDpt").equalsIgnoreCase("DEV"))DDEVCount++;
		else if(rs.getString("EmployeeDpt").equalsIgnoreCase("CCare"))DCCCount++;
		if(rs.getString("EmployeeDpt").equalsIgnoreCase("HR"))DHRCount++;
	}
	
	
}
}

