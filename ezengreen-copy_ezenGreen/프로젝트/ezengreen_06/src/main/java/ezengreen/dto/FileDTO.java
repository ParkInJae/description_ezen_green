package ezengreen.dto;

import java.util.*;

import ezengreen.dao.*;
import ezengreen.vo.*;

public class FileDTO extends DBManager
{
	public boolean FileUpload(FileVO vo, String bno)
	{
		if( this.DBOpen() == false )
		{
			return false;
		}
		
		
		//첨부파일을 등록한다.
		if(vo.getFname() != null && !vo.getFname().equals(""))
		{
			String sql = "";			
			sql  = "insert into file (bno,pname,fname) ";
			sql += "values (";
			sql += "'" + bno + "',";
			sql += "'" + vo.getPname() + "',";
			sql += "'" + vo.getFname() + "'";
			sql += ") ";
			this.RunSQL(sql);	
		}	
		
		this.DBClose();
		return true;		
	}
	

	
	
	public ArrayList<FileVO> FileRead(String bno)
	{
		if( this.DBOpen() == false )
		{
			return null;
		}
		
		ArrayList<FileVO> files = new ArrayList<>();  
		String sql ="select fno, bno, pname, fname from file where bno = " + bno;
		System.out.println(sql);
		this.OpenQuery(sql);
		// 반복문으로 GetNext true일때에
		while(this.GetNext() == true)
		{
			FileVO fvo = new FileVO();
			fvo.setFno(this.GetValue("fno"));
			fvo.setBno(bno);
			fvo.setFname(this.GetValue("fname"));
			fvo.setPname(this.GetValue("Pname"));
			files.add(fvo);
		}
		this.DBClose();
		return files;
	}
	public FileVO FileReadOne(String fno)
	{
		if( this.DBOpen() == false )
		{
			return null;
		}
		
		String sql ="select fno, bno, pname, fname from file where fno = " + fno;
		System.out.println(sql);
		this.OpenQuery(sql);
		FileVO fvo = null;
		// 반복문으로 GetNext true일때에
		if(this.GetNext() == true)
		{
			fvo = new FileVO();
			fvo.setFno(this.GetValue("fno"));
			fvo.setBno(this.GetValue("bno"));
			fvo.setFname(this.GetValue("fname"));
			fvo.setPname(this.GetValue("Pname"));
		}
		this.DBClose();
		return fvo;
	}
	
	public boolean FileDelete(String f)
	{
		if( this.DBOpen() == false )
		{
			return false;
		}
		
		//out.println("fno:" + f + "<br>");
		String sql = "delete from file where fno = '" + f + "' ";
		System.out.println(sql);
		this.RunSQL(sql);	
		
		this.DBClose();
		return true;		
	}
	
}
