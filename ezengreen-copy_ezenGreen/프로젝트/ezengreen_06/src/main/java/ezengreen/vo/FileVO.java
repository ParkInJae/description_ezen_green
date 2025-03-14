package ezengreen.vo;

public class FileVO 
{
	private String fno; 	  // 첨부파일번호
	private String bno; 	  // 게시글번호
	private String pname; 	  // 물리파일명(저장되는이름)
	private String fname; 	  // 논리파일명(원래이름)
	
	public String getFno() { return fno;	 }
	public String getBno()   { return bno;   }
	public String getPname() { return pname; }
	public String getFname() { return fname; }
	
	public void setFno(String fno)     { this.fno   =  fno; }
	public void setBno(String bno) 	   { this.bno   = bno;	 }
	public void setPname(String pname) { this.pname = pname; }
	public void setFname(String fname) { this.fname = fname; }
}
