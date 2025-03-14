package ezengreen.dto;

import java.util.*;

import ezengreen.dao.*;
import ezengreen.vo.*;

public class ReplyDTO extends DBManager
{
	//댓글을 등록한다.
		//리턴값 : true - 등록성공, false - 등록실패
		public boolean Insert(ReplyVO vo)
		{
			if( this.DBOpen() == false )
			{
				return false;
			}
			
			//Reply 테이블에 자료를 등록한다.
			String sql = "";
			sql  = "insert into reply (bno,uno,rcontent) ";
			sql += "values (";
			sql += "'" + vo.getBno() + "',";
			sql += "'" + vo.getUno() + "',";
			sql += "'" + this._R(vo.getRcontent()) + "'";
			sql += ")";
			this.RunSQL(sql);
			
			//등록된 댓글 번호를 얻는다.
			sql = "select last_insert_id() as rno ";
			this.OpenQuery(sql);
			this.GetNext();
			String rno = this.GetValue("rno");
			vo.setRno(rno);
			
			this.DBClose();
			return true;
		}
		
		//댓글을 삭제한다.
		//리턴값 : true - 삭제성공, false - 삭제실패	
		public boolean Delete(String rno)
		{
			if( this.DBOpen() == false )
			{
				return false;
			}
			
			String sql = "";
			sql = "delete from reply where rno = " + rno;
			this.RunSQL(sql);
			
			this.DBClose();
			return true;
		}
		
		//댓글 목록을 조회한다.
		public ArrayList<ReplyVO> GetList(String bno)
		{
			ArrayList<ReplyVO> list = new ArrayList<ReplyVO>();
			
			if( this.DBOpen() == false )
			{
				return list;
			}
			
			String sql = "";
			sql  = "select rno,uno,rcontent,date(rwdate) as rwdate, ";
			sql += "(select uname from user where uno = reply.uno) as uname ";
			sql += "from reply ";
			sql += "where bno = " + bno + " ";
			sql += "order by rno desc ";
			this.OpenQuery(sql);
			while(this.GetNext() == true)
			{
				ReplyVO vo = new ReplyVO();
				vo.setRno(this.GetValue("rno"));
				vo.setRcontent(this.GetValue("rcontent"));
				vo.setRwdate(this.GetValue("rwdate"));			
				vo.setUno(this.GetValue("uno"));
				vo.setUname(this.GetValue("uname"));
				list.add(vo);
			}
			
			this.DBClose();
			return list;
		}
}
