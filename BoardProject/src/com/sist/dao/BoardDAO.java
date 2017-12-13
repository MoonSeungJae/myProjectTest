package com.sist.dao;

import java.sql.*;
import java.util.*;

public class BoardDAO {
	// ���ᰴü
	private Connection conn;
	// SQL ���۰�ü
	private PreparedStatement ps;
	// Oracle URL
	private final String URL = "jdbc:oracle:thin:@localhost:1521:ORCL";

	// ����̹� ���
	public BoardDAO() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			// ���÷���
			/*
			 * Ŭ���� : �̸� => Ŭ������ ���� ��� ������ �о���°� => �޸� �Ҵ� �޼ҵ� : �޼ҵ� �̸����� ȣ���̰���
			 */
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
		}
	}

	// ����Ŭ ����
	public void getConnection() {
		try {
			conn = DriverManager.getConnection(URL, "scott", "1234");

		} catch (Exception ex) {
			System.out.println(ex.getMessage());
		}
	}

	// ����Ŭ ����
	public void disConnection() {
		try {
			if (ps != null)
				ps.close();
			if (conn != null)
				conn.close();
		} catch (Exception ex) {

		}

	}

	public List<BoardVO> boardListData(int page) {
		List<BoardVO> list = new ArrayList<BoardVO>();
		try {
			// �������ó��
			// ����
			getConnection();
			String sql = "SELECT no,subject,name,regdate,hit FROM board ORDER BY no DESC";
			ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			int i = 0; // 10���� �����ִ� ����
			int j = 0; // while �� Ƚ��
			int pagecnt = (page * 10) - 10; // ������
			/*
			 * 1page : 0~9 2page : 10~19 3page : 20~29
			 */
			while (rs.next()) {
				if (i < 10 && j >= pagecnt) {
					BoardVO vo = new BoardVO();
					vo.setNo(rs.getInt(1));
					vo.setSubject(rs.getString(2));
					vo.setName(rs.getString(3));
					vo.setRegdate(rs.getDate(4));
					vo.setHit(rs.getInt(5));
					list.add(vo);
					i++;
				}
				j++;
			}
		} catch (Exception ex) {
			// ���� ����ó��
			System.out.println(ex.getMessage());

		} finally {
			// try,catch������� ������ ���๮��
			disConnection();
		}
		return list;
	}

	// ���1 : ������ => �����(List<BoardVO>), ��û��(int page)
	public int boardTotalPage() {
		int total = 0;
		try {
			getConnection();
			String sql = "SELECT CEIL(COUNT(*)/10) FROM board";
			ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			rs.next();
			total = rs.getInt(1);
			rs.close();
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
		} finally {
			disConnection();
		}
		return total;
	}

	// ���2 : ���뺸�� => �����(BoardVO), ��û��(int to)
	public BoardVO boardContentData(int no) {
		BoardVO vo = new BoardVO();
		try {
			getConnection();
			// ��ȸ�� ����
			String sql = "UPDATE board SET hit=hit+1 WHERE no=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, no); // => 1��° ����ǥ�� no ���� ä���� ��� ��
			ps.executeUpdate(); // commit

			sql = "SELECT no,name,subject,content,regdate,hit FROM board WHERE no=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, no);
			ResultSet rs = ps.executeQuery();
			rs.next();

			// ���� �ޱ�
			vo.setNo(rs.getInt(1));
			vo.setName(rs.getString(2));
			vo.setSubject(rs.getString(3));
			vo.setContent(rs.getString(4));
			vo.setRegdate(rs.getDate(5));
			vo.setHit(rs.getInt(6));
			rs.close();
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
		} finally {
			disConnection();
		}
		return vo;
	}

	// ���3 : �߰� => �����(void), ��û��(BoardVo)
	public void boardInsert(BoardVO vo) {
		try {
			getConnection();
			String sql = "INSERT INTO board(no,name,subject,content,pwd) VALUES(board_no_seq.nextval,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			// ? �� �� �� ä���
			ps.setString(1, vo.getName());
			ps.setString(2, vo.getSubject());
			ps.setString(3, vo.getContent());
			ps.setString(4, vo.getPwd());

			ps.executeUpdate(); // commit �� ���� ���󰣴�
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
		} finally {
			disConnection();
		}
	}

	// ���4 : ���� => �����(void), ��û��(BoardVO)
	public BoardVO boardUpData(int no) {
		BoardVO vo = new BoardVO();
		try {
			getConnection();
			// ��ȸ�� ����
			String sql = "SELECT name,subject,content FROM board WHERE no=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, no);
			ResultSet rs = ps.executeQuery();
			rs.next();

			// ���� �ޱ�
			
			vo.setName(rs.getString(1));
			vo.setSubject(rs.getString(2));
			vo.setContent(rs.getString(3));
			
			rs.close();
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
		} finally {
			disConnection();
		}
		return vo;
	}

	public boolean boardUpdate(BoardVO vo) {
		boolean bCheck=false;
		try {
			getConnection();
			String sql = "SELECT pwd FROM board WHERE no=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, vo.getNo());
			ResultSet rs = ps.executeQuery();
			rs.next();
			String db_pwd = rs.getString(1);
			rs.close();
			ps.close();
			if(db_pwd.equals(vo.getPwd())) {
				bCheck=true;
				sql="UPDATE board SET name=?,subject=?,content=? WHERE no=?";
				ps=conn.prepareStatement(sql);
				ps.setString(1, vo.getName());
				ps.setString(2, vo.getSubject());
				ps.setString(3, vo.getContent());
				ps.setInt(4, vo.getNo());
				ps.executeUpdate();
			}
		}catch(Exception ex) {
			System.out.println(ex.getMessage());
		}finally {
			disConnection();
		}
		return bCheck;
	}
	
	// ���5 : ���� => �����(boolean), ��û��(int no)
	public boolean boardDelete(int no, String pwd) {
		boolean bCheck = false;
		try {
			getConnection();
			String sql = "SELECT pwd FROM board WHERE no=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, no);
			ResultSet rs = ps.executeQuery();
			rs.next();
			String db_pwd = rs.getString(1);
			rs.close();
			if (db_pwd.equals(pwd)) {
				bCheck = true;
				sql = "DELETE FROM board WHERE no=?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, no);
				ps.executeUpdate();
			}
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
		} finally {

		}
		return bCheck;
	}
	// ���6 : ã�� => �����(List<BoardVo>), ��û��(String s,String f)
	public List<BoardVO> boardFindData(String fs,String ss){
		List<BoardVO> list = new ArrayList<BoardVO>();
		try {
			getConnection();
			String sql="SELECT no,subject,name,regdate,hit FROM board WHERE " + fs +" LIKE '%'||?||'%' ";
			ps=conn.prepareStatement(sql);
			ps.setString(1, ss);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				BoardVO vo = new BoardVO();
				vo.setNo(rs.getInt(1));
				vo.setSubject(rs.getString(2));
				vo.setName(rs.getString(3));
				vo.setRegdate(rs.getDate(4));
				vo.setHit(rs.getInt(5));
				list.add(vo);
			}
			rs.close();
		}catch(Exception ex) {
			System.out.println(ex.getMessage());
		}finally {
			disConnection();
		}
		return list;
	}
	// where (COLUMN) like '%data%" �ķ��� , ã�µ����� �̷��� 2������ ���� 2��������
}
