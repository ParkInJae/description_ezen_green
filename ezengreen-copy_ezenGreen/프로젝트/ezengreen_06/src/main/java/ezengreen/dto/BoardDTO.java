package ezengreen.dto;

import java.util.*;

import ezengreen.dao.*;
import ezengreen.vo.*;


public class BoardDTO extends DBManager
{
//-------------------------------------게시물등록--------------------------------
	
		//리턴값 : true - 등록성공, false - 등록실패	
		public boolean Insert(BoardVO vo)
		{
			if( this.DBOpen() == false )
			{
				return false;
			}
			
			//Board 테이블에 자료를 등록한다.
			String sql = "";
			sql  = "insert into board (uno,btitle,bkind,bcontent) ";
			sql += "values (";
			sql += "'" + vo.getUno() + "',";
			sql += "'" + this._R(vo.getBtitle()) + "',";
			sql += "'" + vo.getBkind() + "',";
			sql += "'" + this._R(vo.getBcontent()) + "'";
			sql += ")";
			this.RunSQL(sql);

			//등록된 게시물의 번호를 얻는다.
			sql = "select last_insert_id() as bno ";
			this.OpenQuery(sql);
			this.GetNext();
			String bno = this.GetValue("bno");
			vo.setBno(bno);
			
			this.DBClose();
			return true;
		}
		
//-------------------------------------게시물삭제--------------------------------
		
		//게시물을 삭제한다.
		//리턴값 : true - 삭제성공, false - 삭제실패	
		public boolean Delete(String bno)
		{
			if( this.DBOpen() == false )
			{
				return false;
			}
			
			//첨부파일 삭제 -> 댓글 삭제 -> 게시물 삭제
			String sql = "";
			sql = "delete from file where bno = " + bno;
			this.RunSQL(sql);

			sql = "delete from reply where bno = " + bno;
			this.RunSQL(sql);

			sql = "delete from board where bno = " + bno;
			this.RunSQL(sql);
			
			this.DBClose();
			return true;		
		}
		
//-------------------------------------게시물변경(수정)------------------------------
		
		//리턴값 : true - 변경성공, false - 변경실패	
		public boolean Update(BoardVO vo)
		{
			if( this.DBOpen() == false )
			{
				return false;
			}
			
			//Board 테이블에 자료를 변경한다.
			String sql = "";
			sql  = "update board ";
			sql += "set ";
			sql += "btitle = '" + this._R(vo.getBtitle()) + "', ";
			sql += "bkind = '" + vo.getBkind() + "', ";
			sql += "bcontent = '" + this._R(vo.getBcontent()) + "' ";
			sql += "where bno = '" + vo.getBno() + "' ";
			this.RunSQL(sql);
						
			this.DBClose();
			return true;		
		}
		
//-------------------------------------게시물불러오기------------------------------		
		
		public BoardVO Read(String bno,boolean ishit)
		{
			if( this.DBOpen() == false )
			{
				return null;
			}
			
			String sql = "";
			//해당 게시물 번호에 대한 정보를 조회한다.
			sql  = "select btitle,bkind,bcontent,bhit,uno,date(bwdate) as bwdate, ";
			sql += "(select uname from user where uno = board.uno) as uname, ";
			sql += "(select count(rno) from reply where bno = board.bno) as rno ";
			sql += "from board ";
			sql += "where bno = " + bno;
			this.OpenQuery(sql);
			if(this.GetNext() == false)
			{
				//해당 게시물 없음.
				this.DBClose();
				return null;
			}
		
			BoardVO vo = new BoardVO();
			vo.setBno(bno);
			vo.setUno(this.GetValue("uno"));
			vo.setBtitle(this.GetValue("btitle"));
			vo.setBkind(this.GetValue("bkind"));
			vo.setBcontent(this.GetValue("bcontent"));
			vo.setBwdate(this.GetValue("bwdate"));
			vo.setBhit(this.GetValue("bhit"));
			vo.setUname(this.GetValue("uname"));
			vo.setRno(this.GetValue("rno"));
			
			if(ishit == true)
			{
				//조회수를 증가시킨다.
				sql  = "update board set bhit = bhit + 1 ";
				sql += "where bno = " + bno;
				this.RunSQL(sql);
			}
			
			this.DBClose();
			return vo;
		}

//-------------------------------------검색------------------------------
		
		//전체 게시물 갯수를 얻는다.
		//kind: 구분
		//type : T - 제목에서 검색, N - 내용에서 검색 , 빈값 : 제목+내용에서 검색   
		//keyword : 검색어 
		public int GetTotal( String kind,String type,String keyword)
		{
			int total = 0;
			if( this.DBOpen() == false )
			{
				return total;
			}
			
			//게시물의 갯수를 얻는다.
			String sql = "";
			sql  = "select count(*) as count "; 
			sql += "from board ";
			sql += "where bkind = '" + kind + "' ";
			if(!keyword.equals(""))
			{
				if(type.equals("T"))
				{
					//제목에서 검색 
					sql += "and btitle like '%" + keyword + "%' ";
					System.out.println(sql);
				}else if(type.equals("N"))
				{
					//내용에서 검색 
					sql += "and bcontent like '%" + keyword + "%' ";
					System.out.println(sql);
				}else
				{
					//작성자에서 검색 
					sql += "and uno in (select uno from user where uname like '%" + keyword + "%') ";
					System.out.println(sql);
				}
			}
			this.OpenQuery(sql);
			this.GetNext();
			total = this.GetInt("count");
			this.CloseQuery();
			
			this.DBClose();
			return total;
		}
		
//-------------------------------------페이징------------------------------		
		
		//게시물 목록을 조회한다.
		//kind: 구분
		//type : T - 제목에서 검색, N - 내용에서 검색 , 빈값 : 제목+내용에서 검색   
		//keyword : 검색어 	
		public ArrayList<BoardVO> GetList(int pageno, String kind,String type,String keyword)
		{
			ArrayList<BoardVO> list = new ArrayList<BoardVO>();
			
			if( this.DBOpen() == false )
			{
				return list;
			}		
			
			//게시물 목록을 얻는다.
			String sql = "";
			sql  = "select bno,btitle,date(bwdate) as bwdate,bhit, ";
			sql += "(select uname from user where uno = board.uno) as uname, ";
			sql += "(select count(rno) from reply where bno = board.bno) as rno "; 
			sql += "from board ";
			sql += "where bkind = '" + kind + "' ";
			if(!keyword.equals(""))
			{
				if(type.equals("T"))
				{
					//제목에서 검색 
					sql += "and btitle like '%" + keyword + "%' ";
				}else if(type.equals("N"))
				{
					//내용에서 검색 
					sql += "and bcontent like '%" + keyword + "%' ";
				}else
				{
					//작성자에서 검색 
					sql += "and uno in (select uno from user where uname like '%" + keyword + "%') ";
				}
			}		
			
			//최근게시물로 정렬
			sql += "order by bno desc ";
			
			//페이지당 10개씩 가져오도록 limit 를 처리한다.
			int startno = 10 * (pageno - 1);
			sql += "limit " + startno + ",10 ";
			
			this.OpenQuery(sql);		
			while(this.GetNext())
			{
				BoardVO vo = new BoardVO();
				
				vo.setBno(this.GetValue("bno"));
				vo.setBtitle(this.GetValue("btitle"));
				vo.setBwdate(this.GetValue("bwdate"));
				vo.setBhit(this.GetValue("bhit"));
				vo.setUname(this.GetValue("uname"));
				vo.setRno(this.GetValue("rno"));
				
				list.add(vo);
			}
			
			this.DBClose();
			return list;
		}
		
		//-------------------------------------갤러리페이징------------------------------		
		
			//게시물 목록을 조회한다.
			//kind: 구분
			//type : T - 제목에서 검색, N - 내용에서 검색 , 빈값 : 제목+내용에서 검색   
			//keyword : 검색어 	
			public ArrayList<BoardVO> GetList_G(int pageno, String kind,String type,String keyword)
			{
				ArrayList<BoardVO> list = new ArrayList<BoardVO>();
				
				if( this.DBOpen() == false )
				{
					return list;
				}		
				

				//게시물 목록을 조회하는 SQL을 실행한다.
				String sql  = "select bno, btitle, date(bwdate) as bwdate, bhit, ";
				sql += "(select uname from user where uno = board.uno) as uname, ";
				sql += "(select count(rno) from reply where bno = board.bno) as rno, ";
				sql += "(select pname from file where bno = board.bno limit 0,1) as pname, ";
				sql += "(select pname from file where bno = board.bno limit 1,1) as pname, ";
				sql += "(select pname from file where bno = board.bno limit 2,1) as pname, ";
				sql += "(select fno from file where bno = board.bno limit 0,1) as fno ";
				sql += "from board ";
				sql += "where bkind ='" + "G" + "' ";
				if(!keyword.equals(""))
				{
					if(type.equals("T"))
					{
						//제목에서 검색 
						sql += "and btitle like '%" + keyword + "%' ";
					}else if(type.equals("N"))
					{
						//내용에서 검색 
						sql += "and bcontent like '%" + keyword + "%' ";
					}else
					{
						//작성자에서 검색 
						sql += "and uno in (select uno from user where uname like '%" + keyword + "%') ";
					}
				}						
				
				//최근게시물로 정렬
				sql += "order by bno desc ";
				
				//페이지당 10개씩 가져오도록 limit 를 처리한다.
				int startno = 6 * (pageno - 1);
				sql += "limit " + startno + ",6 ";
				
				this.OpenQuery(sql);		
				while(this.GetNext())
				{
					BoardVO vo = new BoardVO();
					
					vo.setBno(this.GetValue("bno"));
					vo.setBtitle(this.GetValue("btitle"));
					vo.setBwdate(this.GetValue("bwdate"));
					vo.setBhit(this.GetValue("bhit"));
					vo.setRno(this.GetValue("rno"));
					vo.setUname(this.GetValue("uname"));
					vo.setPname(this.GetValue("pname"));
					
					
					list.add(vo);
				}
				
				this.DBClose();
				return list;
			}
			
			//-------------------------------------스케쥴페이징------------------------------		
			
			//게시물 목록을 조회한다.
			//kind: 구분
			//type : T - 제목에서 검색, N - 내용에서 검색 , 빈값 : 제목+내용에서 검색   
			//keyword : 검색어 	
			public ArrayList<BoardVO> GetList_S( String bkind, int cur_year, int cur_month, int i )
			{
				ArrayList<BoardVO> list = new ArrayList<BoardVO>();
				
				if( this.DBOpen() == false )
				{
					return list;
				}		
				
				String sql = "";
				sql  = "select bno, btitle, date(bwdate) as bwdate, bhit, ";
				sql += "(select uname from user where uno = board.uno) as uname, ";
				sql += "(select count(rno) from reply where bno = board.bno) as rno ";
				sql += "from board ";
				sql += "where bkind ='" + bkind + "' ";
				sql += "and date(bwdate) ='" + cur_year + "." + cur_month + "." + i + "' ";
				sql += "order by bno desc ";
				
				this.OpenQuery(sql);		
				while(this.GetNext())
				{
					BoardVO vo = new BoardVO();
					
					vo.setBno(this.GetValue("bno"));
					vo.setBtitle(this.GetValue("btitle"));
					vo.setBwdate(this.GetValue("bwdate"));
					vo.setBhit(this.GetValue("bhit"));
					vo.setRno(this.GetValue("rno"));
					vo.setUname(this.GetValue("uname"));						
					
					list.add(vo);
				}
				
				this.DBClose();
				return list;
			}
			
			//스케쥴 게시물 등록
			public boolean Insert_S(BoardVO vo,String year, String month, String day)
			{
				if( this.DBOpen() == false )
				{
					return false;
				}
				
				//Board 테이블에 자료를 등록한다.
				String sql = "";
				sql  = "insert into board (uno,btitle,bkind,bcontent,bwdate) ";
				sql += "values (";
				sql += "'" + vo.getUno() + "',";
				sql += "'" + vo.getBtitle().replace("'","''") + "',";
				sql += "'" + vo.getBkind() + "',";
				sql += "'" + vo.getBcontent().replace("'","''")  + "',";
				sql += "date('" + year+"." + month +"." +day +"')";
				sql += ")";
				System.out.println(sql);
				this.RunSQL(sql);

				//등록된 게시물의 번호를 얻는다.
				sql = "select last_insert_id() as bno ";
				this.OpenQuery(sql);
				this.GetNext();
				String bno = this.GetValue("bno");
				vo.setBno(bno);
				
				this.DBClose();
				return true;
			}
	
}
