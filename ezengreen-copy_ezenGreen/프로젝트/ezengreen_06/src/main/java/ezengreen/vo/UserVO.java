package ezengreen.vo;

public class UserVO
{
	private String uno;        //회원번호
	private String uid; 	   //아이디
	private String upw; 	   //비밀번호
	private String uname; 	   //이름
	private String uemail; 	   //이메일
	private String ujoindate;  //가입일자
	private String admin;  	   //관리자확인
	

	public String getUno()       {if (uno == null)      {return "";}  return uno;      }
	public String getUid()       {if (uid == null)      {return "";}  return uid;      }
	public String getUpw()       {if (upw == null)      {return "";}  return upw;      }
	public String getUname()     {if (uname == null)    {return "";}  return uname;    }
	public String getUemail()    {if (uemail == null)   {return "";}  return uemail;   }
	public String getUjoindate() {if (ujoindate == null){return "";}  return ujoindate;}
	public String getAdmin()     {if (admin == null)    {return "0";} return admin;    }
	
	public void setUno(String uno) 			   { this.uno  	    = uno;   	 }
	public void setUid(String uid) 			   { this.uid 	    = uid; 		 }
	public void setUpw(String upw) 			   { this.upw       = upw; 		 }
	public void setUname(String uname) 		   { this.uname     = uname; 	 }
	public void setUemail(String uemail) 	   { this.uemail    = uemail; 	 }
	public void setUjoindate(String ujoindate) { this.ujoindate = ujoindate; }
	public void setAdmin(String admin) 		   { this.admin     = admin; 	 }
	
	
}
