package model;

public class League {
	
	String season;
	int year;
	String title;
	public League(String season, int year, String title) {
		super();
		this.season = season;
		this.year = year;
		this.title = title;
	}
	public String getSeason() {
		return season;
	}
	public void setSeason(String season) {
		this.season = season;
	}
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	@Override
	public String toString() {
		return title;
	}
	
	


}
