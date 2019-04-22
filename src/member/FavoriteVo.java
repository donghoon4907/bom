package member;

public class FavoriteVo {
	int rn;
	String bom_movie = "bom_movie";
	String c_tableName;
	
	
	
	int c_serial;
	int c_playtime;
	int v_playtime;
	String c_movie_subject;
	String c_movie_subject_eng;
	
	
	
	public String toJSON(){
		String json = String.format("{'c_serial':'%d','c_playtime':'%d','v_playtime':'%d','c_movie_subject_eng':'%s'}", 
									   c_serial,c_playtime,v_playtime,c_movie_subject_eng);
		json = json.replaceAll("\'", "\""); 
		
		return json;
	}
	
	public String getBom_movie() {
		return bom_movie;
	}	
	public String getC_tableName() {
		return c_tableName;
	}

	public void setC_tableName(String c_tableName) {
		this.c_tableName = "favorite_" + c_tableName;
	}

	public int getC_serial() {
		return c_serial;
	}

	public void setC_serial(int c_serial) {
		this.c_serial = c_serial;
	}

	public int getC_playtime() {
		return c_playtime;
	}

	public void setC_playtime(int c_playtime) {
		this.c_playtime = c_playtime;
	}

	public int getV_playtime() {
		return v_playtime;
	}

	public void setV_playtime(int v_playtime) {
		this.v_playtime = v_playtime;
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


	
}
