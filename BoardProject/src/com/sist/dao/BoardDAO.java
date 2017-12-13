package com.sist.dao;

import java.sql.*;
import java.util.*;

public class BoardDAO {
	// 연결객체
	private Connection conn;
	// SQL 전송객체
	private PreparedStatement ps;
	// Oracle URL
	private final String URL = "jdbc:oracle:thin:@localhost:1521:ORCL";

	// 드라이버 등록
	public BoardDAO() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			// 리플렉션
			/*
			 * 클래스 : 이름 => 클래스에 대한 모든 정보를 읽어오는것 => 메모리 할당 메소드 : 메소드 이름없이 호출이가능
			 */
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
		}
	}

	// 오라클 연결
	public void getConnection() {
		try {
			conn = DriverManager.getConnection(URL, "scott", "1234");

		} catch (Exception ex) {
			System.out.println(ex.getMessage());
		}
	}

	// 오라클 해제
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
			// 정상수행처리
			// 연결
			getConnection();
			String sql = "SELECT no,subject,name,regdate,hit FROM board ORDER BY no DESC";
			ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			int i = 0; // 10개씩 나눠주는 변수
			int j = 0; // while 의 횟수
			int pagecnt = (page * 10) - 10; // 시작점
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
			// 에러 예외처리
			System.out.println(ex.getMessage());

		} finally {
			// try,catch상관없이 무조건 수행문장
			disConnection();
		}
		return list;
	}

	// 기능1 : 목록출력 => 결과값(List<BoardVO>), 요청값(int page)
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

	// 기능2 : 내용보기 => 결과값(BoardVO), 요청값(int to)
	public BoardVO boardContentData(int no) {
		BoardVO vo = new BoardVO();
		try {
			getConnection();
			// 조회수 증가
			String sql = "UPDATE board SET hit=hit+1 WHERE no=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, no); // => 1번째 물음표에 no 값을 채워라 라는 뜻
			ps.executeUpdate(); // commit

			sql = "SELECT no,name,subject,content,regdate,hit FROM board WHERE no=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, no);
			ResultSet rs = ps.executeQuery();
			rs.next();

			// 값을 받기
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

	// 기능3 : 추가 => 결과값(void), 요청값(BoardVo)
	public void boardInsert(BoardVO vo) {
		try {
			getConnection();
			String sql = "INSERT INTO board(no,name,subject,content,pwd) VALUES(board_no_seq.nextval,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			// ? 에 들어갈 값 채우기
			ps.setString(1, vo.getName());
			ps.setString(2, vo.getSubject());
			ps.setString(3, vo.getContent());
			ps.setString(4, vo.getPwd());

			ps.executeUpdate(); // commit 도 같이 날라간다
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
		} finally {
			disConnection();
		}
	}

	// 기능4 : 수정 => 결과값(void), 요청값(BoardVO)
	public BoardVO boardUpData(int no) {
		BoardVO vo = new BoardVO();
		try {
			getConnection();
			// 조회수 증가
			String sql = "SELECT name,subject,content FROM board WHERE no=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, no);
			ResultSet rs = ps.executeQuery();
			rs.next();

			// 값을 받기
			
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
	
	// 기능5 : 삭제 => 결과값(boolean), 요청값(int no)
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
	// 기능6 : 찾기 => 결과값(List<BoardVo>), 요청값(String s,String f)
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
	// where (COLUMN) like '%data%" 컴럼명 , 찾는데이터 이렇게 2가지가 들어가서 2개가들어간다
}
