package member;

public class ViewingActivityVo {
	int rn;
	String c_tableName;
	String c_date;
	String c_movie_subject;
	String c_movie_subject_eng;
	int c_serial;
	int c_playtime;
	int v_playtime;
	
	public String getC_tableName() {
		return c_tableName;
	}
	public void setC_tableName(String c_tableName) {
		this.c_tableName = "viewingactivity_"+c_tableName;
	}
	public String getC_date() {
		return c_date;
	}
	public void setC_date(String c_date) {
		this.c_date = c_date;
	}
	public int getC_serial() {
		return c_serial;
	}
	public void setC_serial(int c_serial) {
		this.c_serial = c_serial;
	}
	public int getV_playtime() {
		return v_playtime;
	}
	public void setV_playtime(int c_playtime) {
		this.v_playtime = c_playtime;
	}
	public int getRn() {
		return rn;
	}
	public void setRn(int rn) {
		this.rn = rn;
	}
	public String getC_movie_subject() {
		return c_movie_subject;
	}
	public void setC_movie_subject(String c_movie_subject) {
		this.c_movie_subject = c_movie_subject;
	}
	public String getC_movie_subject_eng() {
		return c_movie_subject_eng;
	}
	public void setC_movie_subject_eng(String c_movie_subject_eng) {
		this.c_movie_subject_eng = c_movie_subject_eng;
	}
	public int getC_playtime() {
		return c_playtime;
	}
	public void setC_playtime(int c_playtime) {
		this.c_playtime = c_playtime;
	}
	
	
}
