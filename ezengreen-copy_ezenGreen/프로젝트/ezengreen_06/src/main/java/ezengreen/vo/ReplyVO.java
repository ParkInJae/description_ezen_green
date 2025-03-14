package ezengreen.vo;

public class ReplyVO
{
	private String rno; 	  // 댓글번호
	private String bno; 	  // 게시물번호
	private String uno; 	  // 작성자번호
	private String rcontent;  // 댓글내용
	private String rwdate; 	  // 댓글작성일
	private String uname; 	  // 작성자명
	
	
	public String getRno() 		{ return rno;	   }
	public String getBno() 		{ return bno;	   }
	public String getUno() 		{ return uno;	   }
	public String getRcontent() { return rcontent; }
	public String getRwdate()   { return rwdate;   }
	public String getUname() 	{ return uname;	   }
	
	public void setRno(String rno)			 { this.rno 	 = rno;		 }
	public void setBno(String bno) 			 { this.bno 	 = bno;		 }
	public void setUno(String uno) 			 { this.uno 	 = uno;	 	 }
	public void setRcontent(String rcontent) { this.rcontent = rcontent; }
	public void setRwdate(String rwdate) 	 { this.rwdate 	 = rwdate;	 }
	public void setUname(String uanme) 		 { this.uname 	 = uanme;	 }
}
