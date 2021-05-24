package homework.copy;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletContext;

import model1.board.BoardDTO;


public class MembershipDAO {
	//DAO의 기본 멤버변수
		Connection con; //DB연결
		Statement stmt; //정적 쿼리 전송 및 실행
		PreparedStatement psmt; //동적 쿼리 전송 및 실행
		ResultSet rs; //select 결과반환
		
		/*
		인자생성자1 : JSP에서 web.xml에 등록된 컨텍스트 초기화 파라미터를
			가져와서 생성자 호출시 파라미터로 전달하여 DB에 연결한다.
		 */
		public MembershipDAO(String driver, String url) {
			
			try {
				
				Class.forName(driver);
				String id = "kosmo";
				String pass = "1234";
				con =DriverManager.getConnection(url,id,pass);
				System.out.println("Oracle 연결됨");
				
			}
			catch(Exception e) {
				System.out.println("Oracle 연결실패");
				e.printStackTrace();
			}
		}
		/*
		인자생성자2 : JSP에서 인수로 인달했던 초기화 파라미터를
			생성자 내에서 가져오기 위해 JSP에서는 application 내장객체를
			매개변수로 전달한다. 그러면 메소드 내에서 web.xml에
			접근할 수 있다.
		 */
		public MembershipDAO(ServletContext application) {
			
			try {
				String drv = application.getInitParameter("JDBCDriver");
				String url = application.getInitParameter("ConnectionURL");
				String id = application.getInitParameter("OracleId");
				String pwd = application.getInitParameter("OraclePwd");
							
				Class.forName(drv);
				con =DriverManager.getConnection(url,id,pwd);
				System.out.println("JDBC 연결성공");
				
			}
			catch(Exception e) {
				System.out.println("JDBC 연결시 예외발생");
				e.printStackTrace();
			}
		}
		/*
		데이터베이스 연결을 해체할 때 사용하는 메소드
		한정된 자원을 사용하므로 사용을 마쳤다면 반드시 
		연결을 해제해야 한다.
		 */
		public void close() {
			try {
				if(rs!=null) rs.close();
				if(psmt!=null) psmt.close();
				if(con!=null) con.close();
			}
			catch(Exception e) {
				System.out.println("Oracle 자원반납시 예외발생");
			}
		}
		public int selectCount(Map<String, Object>map) {
			
			int totalCount = 0;
			//count() 그룹함수를 통해 쿼리문 작성
			String query = "SELECT COUNT(*) FROM membershio";
			
			//검색 파라미터가 있는 경우라면 where절을 추가한다.
			if(map.get("searchWord")!=null) {
				query += " WHERE "+ map.get("searchField") + " "
						+ " LIKE '%"+ map.get("searchWord") +"%'";
			}
			try {
				//Statement객체를 생성
				stmt = con.createStatement();
				//쿼리문 실행 및 결과 반환
				rs = stmt.executeQuery(query);
				//결과를 읽기 위해 커서 이동
				rs.next();
				//count(*)를 통한 쿼리의 결과는 무조건 정수이므로 getInt()로 읽어옴.
				totalCount = rs.getInt(1);
			}
			catch(Exception e) {
				System.out.println("게시물 카운트중 예외발생");
				e.printStackTrace();
			}
			return totalCount;
		}
		
		
		
		public List<MembershipDTO> selectListPage(Map<String,Object> map){
			
			List<MembershipDTO> bbs = new Vector<MembershipDTO>();
			/*
			목록의 페이지 처리를 위해 레코드의 구간을 between으로 정해 조회함.
			1번 : board테이블의 게시물을 일련번호의 내림차순으로 정렬
			2번 : 1번의 조회결과에 rownum(순차적인 가상번호)를 부여함
			3번 : 2번의 조회결과를 between으로 구간을 정해 조회함.
			※만약 게시판이 아닌 다른 테이블을 조회하고 싶다면 1번 쿼리문에서
			테이블명만 변경하면 된다.
			 */
			String query = " "
					+" SELECT * FROM ( "
				    +"	SELECT Tb.*, ROWNUM rNum FROM ( "
				    +"  	SELECT * FROM membership ";
			if(map.get("searchWord")!=null) {
				query += " WHERE "+map.get("searchField")+ " "
						+" LIKE '%"+ map.get("searchWord")+ "%' ";
			}
			query += " "
					+ "		ORDER BY num DESC "
					+ "		) Tb "
					+ " ) "
					+ " WHERE rNum BETWEEN ? AND ?";
			System.out.println(query);
			
			try { 
				psmt = con.prepareStatement(query);
				//between 절의 start와 end값을 인파라미터 설정
				psmt.setString(1, map.get("start").toString());
				psmt.setString(2, map.get("end").toString());
				rs = psmt.executeQuery();
				while(rs.next()) {
					MembershipDTO dto = new MembershipDTO(); 
					
					dto.setNum(rs.getString("num"));
					dto.setId(rs.getString("id"));
					dto.setPass(rs.getString("pass"));
					dto.setName(rs.getString("name"));
					dto.setBday(rs.getString("bday"));
					dto.setcPhone(rs.getString("cPhone"));
					dto.settPhone(rs.getString("tPhone"));
					dto.setEmail(rs.getString("email"));
					dto.setAddrNum(rs.getString("addrNum"));
					dto.setAddr(rs.getString("addr"));
					dto.setRegidate(rs.getDate("regidate"));
					
					bbs.add(dto);
				}
			}
			catch(Exception e) {
				System.out.println("게시물 조회중 예외발생");
				e.printStackTrace();
			}
			return bbs;
		
		}
		
		public MembershipDTO selectView(String num) {
			//조회한 하나의 레코드를 저장할 DTO객체 생성
			MembershipDTO dto = new MembershipDTO();
			//회원테이블과 게시판 테이블을 조인하여 조회함. 회언의 이름을
			//가져오기 위함.
			String query = "SELECT B.*, M.name " 
					+ " FROM member M INNER JOIN board B "
					+ "	ON M.id=B.id "
					+ " WHERE num=?";
			try {
				psmt = con.prepareStatement(query);
				psmt.setString(1, num);
				rs = psmt.executeQuery();
				/*
				매개변수로 전달된 일련번호를 통해 조회하므로
				결과는 무조건 1개만 나오게 된다. 따라서 if문으로
				변환된 결과가 있는지만 확인하면 된다.
				 */
				if(rs.next()) {
					dto.setNum(rs.getString("num"));
					dto.setId(rs.getString("id"));
					dto.setPass(rs.getString("pass"));
					dto.setName(rs.getString("name"));
					dto.setBday(rs.getString("bday"));
					dto.setcPhone(rs.getString("cPhone"));
					dto.settPhone(rs.getString("tPhone"));
					dto.setEmail(rs.getString("email"));
					dto.setAddrNum(rs.getString("addrNum"));
					dto.setAddr(rs.getString("addr"));
					dto.setRegidate(rs.getDate("regidate"));
					
				}
			}
			catch(Exception e) {
				System.out.println("게시물 상세보기 중 예외발생");
				e.printStackTrace();
			}
			return dto;
		}
		
		public int insertWrite(MembershipDTO dto) {
			int result=0;
			try {
				//인파라미터가 있는 insert 쿼리문 작성
				String query = "INSERT INTO membership ( "
						+ " NUM, ID, PASS ,NAME, BDAY, "
						+ " C_PHONE, T_PHONE, EMAIL, ADDR_NUM, "
						+ " ADDR )"
						+ " VALUES ( "
						+ " seq_board_num.NEXTVAL, ?, ?, ?, ?, "
						+ " ?, ?, ?, ?, ? )";
				//prepare 객체 생성 후 인파라미터 설정
				psmt = con.prepareStatement(query);
				psmt.setString(1, dto.getId());
				psmt.setString(2, dto.getPass());
				psmt.setString(3, dto.getName());
				psmt.setString(4, dto.getBday());
				psmt.setString(5, dto.getcPhone());
				psmt.setString(6, dto.gettPhone());
				psmt.setString(7, dto.getEmail());
				psmt.setString(8, dto.getAddrNum());
				psmt.setString(9, dto.getAddr());
				//쿼리문 실행
				result = psmt.executeUpdate();
			}
			catch(Exception e) {
				System.out.println("게시물 입력중 예외발생");
				e.printStackTrace();
			}
			return result;
		}
}
