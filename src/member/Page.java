package member;

public class Page {
	
	String c_tableName;
	String c_tableName1;
	String c_tableName2;
	
	
	int startNo;
	int endNo;
	
	
	public String getC_tableName() {
		return c_tableName;
	}

	public void setC_tableName(String c_tableName) {
		this.c_tableName = "favorite_" + c_tableName;
	}

	public String getC_tableName1() {
		return c_tableName1;
	}
	public void setC_tableName1(String c_tableName1) {
		this.c_tableName1 = "viewingactivity_"+c_tableName1;
	}
	public String getC_tableName2() {
		return c_tableName2;
	}
	public void setC_tableName2(String c_tableName2) {
		this.c_tableName2 = "purchase_"+c_tableName2;
	}	
	
	
	public int getStartNo() {
		return startNo;
	}
	public void setStartNo(int startNo) {
		this.startNo = startNo;
	}
	public int getEndNo() {
		return endNo;
	}
	public void setEndNo(int endNo) {
		this.endNo = endNo;
	}
	
	
}
