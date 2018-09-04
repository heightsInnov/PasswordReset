/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.unionbank.password.processor;

import com.unionbank.password.Dao.QuestionDao;
import com.union.gateway.SecretDao;
import com.unionbank.password.param.Settings;
import com.unionbank.webpay.utils.PBEncrytor;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.HashSet;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import oracle.jdbc.OracleTypes;
import java.util.Set;

/**
 *
 * @author aojinadu
 */
public class Supercontrol {

	private String questUser = "ALL";

	public String getQuestUser() {
		return questUser;
	}

	public void setQuestUser(String questUser) {
		this.questUser = questUser;
	}
	SecretDao secret = null;
	PBEncrytor Pb = new PBEncrytor();
	Settings setting = new Settings();
	String password = Pb.PBDecrypt(setting.getPropString("password-password"));
	String username = setting.getPropString("user-user");
	String host = setting.getPropString("host-host");
	String driver = setting.getPropString("DB_DRIVER");

	public String checkRegStatus(String user) {
		System.out.println("Username is >>>" + user);
		String reg = "";
		CallableStatement cll = null;
		//PreparedStatement pst = null;
		Connection conn = null;
		//ResultSet rs = null;

		try {
			Class.forName(driver).newInstance();
			conn = DriverManager.getConnection(host, username, password);
			String checkuser = "{? = call PASSWORDRESETPKG.CHECKUSERSTATUS(?)}";

			//String query = "select * from devops25.mtp_member";
			System.out.println("Connected, query is: " + checkuser);

			cll = conn.prepareCall(checkuser);
			cll.registerOutParameter(1, OracleTypes.VARCHAR);
			cll.setString(2, user);
			//cll.execute();

			if (cll.executeUpdate() != Statement.EXECUTE_FAILED) {
				reg = (String) cll.getString(1);
				if (reg == null) {
					reg = "N";
					System.out.println("Alredy registered >> " + reg);
				} else {
					System.out.println("Alredy registered >> " + reg);
				}
			}
		} catch (Exception e) {
			System.out.println("Error: " + e.getMessage());
			reg = "";
		} finally {
			closeConns(conn, cll);
		}
		return reg;
	}

	protected Object[] Random() {
		final Random r = new Random();
		final Set<Integer> s = new HashSet<>();
		for (int i = 0; i < 3; i++) {
			while (true) {
				int num = r.nextInt(5) + 1;
				if (s.contains(num) == false) {
					s.add(num);
					break;
				}
			}
		}
		return s.toArray();
	}

//	public static void main(String[] args) {
//		Supercontrol sp = new Supercontrol();
//		String Q1 = sp.Random()[0].toString();
//		String Q2 = sp.Random()[1].toString();
//		String Q3 = sp.Random()[2].toString();
//		System.out.println("Questions asked >> " + Q1 + ", " + Q2 + ", " + Q3);
//	}

	public List<QuestionDao> getquestion(String user) {
		this.setQuestUser(user.trim());
		List<QuestionDao> resp = new ArrayList<QuestionDao>();
		CallableStatement cll = null;
		Connection conn = null;
		ResultSet rs = null;
		String Q1 = Random()[0].toString();
		System.out.println("First is >>"+Q1);
		String Q2 = Random()[1].toString();
		String Q3 = Random()[2].toString();
		List<String> questns = new ArrayList<>();
		questns.add(Q1);
		questns.add(Q2);
		questns.add(Q3);
		System.out.println("Questions asked >> "+ questns.get(0));

		try {
			Class.forName(driver).newInstance();
			conn = DriverManager.getConnection(host, username, password);
			String getQuestion = "{? = call PASSWORDRESETPKG.GETQUESTIONS(?,?,?,?)}";

			cll = conn.prepareCall(getQuestion);
			cll.registerOutParameter(1, OracleTypes.CURSOR);
			cll.setString(2, this.getQuestUser());
			cll.setString(3, Q1);
			cll.setString(4, Q2);
			cll.setString(5, Q3);

			if (cll.executeUpdate() != Statement.EXECUTE_FAILED) {

				System.out.println("GetQuestion >> Connected");

				rs = (ResultSet) cll.getObject(1);
				while (rs.next()) {
					QuestionDao emp = new QuestionDao();
					emp.setQuestionID(rs.getString("QUESTIONID"));
					emp.setQuestion(rs.getString("QUESTION"));

					resp.add(emp);
				}
			}
		} catch (Exception e) {
			System.out.println("Error: " + e.getMessage());
		} finally {
			closeConns(conn, cll, rs);
		}
		return resp;
	}

	public boolean SaveToDB(SecretDao sec) {
		boolean response = false;
		String resp = "";
		secret = sec;
		CallableStatement cll = null;
		Connection conn = null;
		ResultSet rs = null;
		try {
			Class.forName(driver).newInstance();
			conn = DriverManager.getConnection(host, username, password);
			String newDet = "{? = call PASSWORDRESETPKG.STAFFPASSWORDREGISTER(?,?,?,?,?,?,?,?,?,?,?,?)}";

			cll = conn.prepareCall(newDet);

			cll.registerOutParameter(1, OracleTypes.VARCHAR);
			cll.setString(2, secret.getUsername());
			cll.setString(3, secret.getStaffId());
			cll.setString(4, secret.getSecret1());
			cll.setString(5, secret.getSecret2());
			cll.setString(6, secret.getSecret3());
			cll.setString(4, secret.getSecret4());
			cll.setString(4, secret.getSecret5());
			cll.setString(7, secret.getAnswer1());
			cll.setString(8, secret.getAnswer2());
			cll.setString(9, secret.getAnswer3());
			cll.setString(8, secret.getAnswer4());
			cll.setString(9, secret.getAnswer5());
			cll.setString(8, secret.getNSEmail());

			if (cll.executeUpdate() != Statement.EXECUTE_FAILED) {
				resp = (String) cll.getString(1);
				if (resp != null) {
					response = Boolean.valueOf(resp);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error: " + e.getMessage());
		} finally {
			closeConns(conn, cll, rs);
		}
		return response;
	}

	public SecretDao getDetails(String userid) {

		List<String> ldp = new ArrayList<>();
		CallableStatement pst = null;
		Connection conn = null;
		ResultSet rs = null;
		SecretDao sec = new SecretDao();

		try {
			Class.forName(driver).newInstance();
			conn = DriverManager.getConnection(host, username, password);
			String query = "{? = call PASSWORDRESETPKG.GETINITDETAIL(?)}";

			//System.out.println("Connected, query is: " + getTrainees);
			pst = conn.prepareCall(query);
			pst.registerOutParameter(1, OracleTypes.CURSOR);
			pst.setString(2, userid);

			if (pst.executeUpdate() != Statement.EXECUTE_FAILED) {

				System.out.println("GetDetails >> Connected");

				rs = (ResultSet) pst.getObject(1);
				while (rs.next()) {
					sec.setUsername(rs.getString("USERNAME"));
					sec.setSecret1(rs.getString("SECRET1"));
					sec.setSecret2(rs.getString("SECRET2"));
					sec.setSecret3(rs.getString("SECRET3"));
					sec.setSecret4(rs.getString("SECRET4"));
					sec.setSecret5(rs.getString("SECRET5"));
					sec.setAnswer1(rs.getString("ANSWER1"));
					sec.setAnswer2(rs.getString("ANSWER2"));
					sec.setAnswer3(rs.getString("ANSWER3"));
					sec.setAnswer4(rs.getString("ANSWER4"));
					sec.setAnswer5(rs.getString("ANSWER5"));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error: " + e.getMessage());
		} finally {
			closeConns(conn, pst, rs);
		}
		return sec;
	}

	public boolean validatePass(String pass, String passretype) {
		boolean valid = false;
		if (pass.length() < 6 || pass.length() > 6 || pass.isEmpty()) {
			valid = false;
		} else if (pass.length() == 6 && passretype == pass) {
			Pattern special = Pattern.compile("[!#$%*()_+=|<>?{}\\[\\]~-]");
			Matcher hasSpecial = special.matcher(pass);
			if (hasSpecial.find()) {
				valid = false;
			} else if (!hasSpecial.find()) {
				valid = true;
			}
		} else {
			valid = false;
		}
		return valid;
	}

	public String getFuncById(String deptid) {
		List<String> ldp = new ArrayList<>();
		String dpt = null;
		PreparedStatement pst = null;
		Connection conn = null;
		ResultSet rs = null;

		String returnval = "";

		try {
			Class.forName(driver).newInstance();
			conn = DriverManager.getConnection(host, username, password);
			String query = "SELECT func_id, function_name "
					+ "FROM MTP_FUNCTIONS "
					+ "WHERE dept_id ='" + deptid + "'"
					+ "order by function_name asc";

			System.out.println("My fetch query is>>>> " + query);
			pst = conn.prepareStatement(query);

			if (pst.execute()) {
				rs = pst.getResultSet();
			} else {
				throw new Exception("Empty Prepared Statement");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		int count = 0;
		try {
			String content = "<option value=\"-1\">--Choose Function--</option>";
			while (rs.next()) {
//                dpt = new Departments();
//                count++;
//                dpt.setFunc_id(rs.getString("FUNC_ID"));
//                dpt.setFunction(rs.getString("FUNCTION_NAME"));

				System.out.println("Function is >> ");
				content += " <option value=\"" + rs.getString("FUNC_ID") + "\">" + rs.getString("FUNCTION_NAME") + "</option>";

				ldp.add(dpt);
			}
			returnval = content;
			if (pst != null) {
				pst.close();
			}
			if (rs != null) {
				rs.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error: " + e.getMessage());
		} finally {
			closeConns(conn, pst, rs);
		}
		return returnval;
	}

	public boolean checkSignIn(String yr, String email) {
		boolean isMT = false;
		PreparedStatement pst = null;
		Connection conn = null;
		ResultSet rs = null;

		System.out.println("Name input >> " + email.trim());

		try {
			Class.forName(driver).newInstance();
			conn = DriverManager.getConnection(host, username, password);
			//String getMT = "{call MTPORTAL.CHECKMT(?,?,?)}";
			String query = "SELECT (FIRSTNAME || ' ' || LASTNAME)FNAME"
					+ " FROM MTP_MEMBER"
					+ " WHERE TEAM_ID = (SELECT TEAM_ID FROM MTP_TEAM WHERE YEAR_SET = '" + yr + "')"
					+ " AND EMAIL = '" + email + "'";

			System.out.println("My fetch query is>>>> " + query);
			pst = conn.prepareStatement(query);
			//pst.setString(1, yr);
			//pst.setString(2, email.trim());
			//pst.registerOutParameter(3, OracleTypes.VARCHAR);

			rs = pst.executeQuery();
			while (rs.next()) {
				System.out.println(" Name >> " + rs.getString("FNAME"));
				isMT = true;
			}
		} catch (Exception e) {
			System.out.println("Not MT >> Cant Update Profile");
		}
		return isMT;
	}

	public boolean saveDetails(String emp, String mtId) {
		boolean isSaved = false;
		PreparedStatement pst = null;
		Connection conn = null;
		String Interest = "";

		try {
			Class.forName(driver).newInstance();
			conn = DriverManager.getConnection(host, username, password);
			String query = "UPDATE MTP_MEMBER SET "
					+ "ALMAMATA = ?, "
					+ "SCHDEGREE = ?, "
					+ "QUOTE = ?, "
					+ "SKILLS = ?, "
					+ "INTEREST = ?, "
					+ "STAFFID = ?, "
					+ "GRADE = ? "
					+ "WHERE EMAIL = ?";
			pst.setString(8, mtId);

			System.out.println("Interest from List >> ");
			isSaved = pst.execute();

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error: " + e.getMessage());
		} finally {
			closeConns(conn, pst);
		}
		return isSaved;
	}

	public static String checkNull(String str) {
		String value = "";
		try {
			value = !str.isEmpty() ? str : "";
		} catch (Exception e) {
		}
		return value;
	}
	
	public void insertAuditLog(String login, String user, String task){
		CallableStatement cll = null;
		//PreparedStatement pst = null;
		Connection conn = null;
		ResultSet rs = null;
		try {
			Class.forName(driver).newInstance();
			conn = DriverManager.getConnection(host, username, password);
			String getQuestion = "{call PASSWORDRESETPKG.INSERTAUDITLOG(?,?,?)}";

			cll = conn.prepareCall(getQuestion);
			cll.setString(1, login);
			cll.setString(2, user);
			cll.setString(3, task);
			cll.executeQuery();
			
		} catch (Exception e) {
			System.out.println("Error in auditLog insert: " + e.getMessage());
		} finally {
			closeConns(conn, cll, rs);
		}
	}

	public static void closeConns(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		try {
			if (pstmt != null) {
				pstmt.close();
			}
			if (rs != null) {
				rs.close();
			}
			if (conn != null) {
				conn.close();
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
	}

	public static void closeConns(Connection conn, CallableStatement pstmt, ResultSet rs) {
		try {
			if (pstmt != null) {
				pstmt.close();
			}
			if (conn != null) {
				conn.close();
			}
			if (rs != null) {
				rs.close();
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
	}

	public static void closeConns(Connection conn, PreparedStatement pstmt) {
		try {
			if (pstmt != null) {
				pstmt.close();
			}
			if (conn != null) {
				conn.close();
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
	}

//	public static void main(String[] args) {
//		//List<AccountFromCustID> response = setFromId("006642191");
//		Supercontrol response = new Supercontrol();
//		//response.getEmployee("2017");
//	}
}
