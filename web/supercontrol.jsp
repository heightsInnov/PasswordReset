<%-- 
    Document   : supercontrol
    Created on : 02-May-2018, 15:43:57
    Author     : aojinadu
--%>

<%@page import="com.unionbank.password.services.SecurityService"%>
<%@page import="com.unionbank.password.Dao.SecretDao"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.unionbank.password.processor.Supercontrol"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.unionbank.webpay.utils.PBEncrytor"%>
<%@page import="org.datacontract.schemas._2004._07.ubn_security.UserProfile"%>
<%@page import="com.unionbank.password.services.AdValidate"%>
<%@page import="com.unionbank.password.param.Settings"%>


<%@include file="WEB-INF/jspf/tags.jspf" %>

<%  response.setHeader("pragma", "no-cache");
	SecurityService sserv = new SecurityService();
	Supercontrol ctrl = new Supercontrol();
	PBEncrytor pb = new PBEncrytor();
	Settings setting = new Settings();
	String moduleid = setting.getPropString("module");
	String func = "", EmName = "", username = "", staffId = "";
	Boolean isMT;
	AdValidate ad = new AdValidate();

	if (!moduleid.isEmpty() && moduleid != null) {

		String command = request.getParameter("command");
		if (command == null) {
			command = "";
		}

		if (command.equalsIgnoreCase("auth")) {
			username = request.getParameter("txtusername").trim();
			if (username == null) {
				username = "";
			}

			String password = request.getParameter("txtpassword").trim();
			if (password == null) {
				password = "";
			}

			String token = pb.PBEncrypt(request.getParameter("txttoken").trim());
			if (password == null) {
				password = "";
			}

			if (ad.validate(username, "DevOps20182August", moduleid)) { //&& ad.TwoFactor(username, token, moduleid) != 99) {
				System.out.println("AdAuthenticate login >>" + username);
				try {
					UserProfile usP = new UserProfile();
					usP = ad.getUserProfile(username, moduleid);

					EmName = usP.getADUserID().getValue();
					String sID = usP.getEmployeeId().getValue();
					String disName = usP.getDisplayName().getValue();

					try {
						session.setAttribute("username", EmName);
						session.setAttribute("staffId", sID);
						session.setAttribute("display", disName);

						String isreg = ctrl.checkRegStatus(username);
						if (isreg.equalsIgnoreCase("Y")) {
							response.sendRedirect("resetdetails.jsp");
//							RequestDispatcher rd = request.getRequestDispatcher("resetdetails.jsp");
//							rd.include(request, response);
						} else {
							response.sendRedirect("registrationpage.jsp");
						}

						System.out.println("FullName >> " + EmName);

					} catch (Exception e) {
						e.getMessage();
					}
				} catch (Exception e) {
					e.printStackTrace();
				}

			} else {
				request.setAttribute("message", "Invalid Login Details");
				RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
				rd.include(request, response);
			}

		} else if (command.equalsIgnoreCase("comboSelect")) {

			String uname = (String) session.getAttribute("username");
			String yr = request.getParameter("comboSet");

			if (yr == null) {
				yr = "";
			}
			if (ctrl.checkSignIn(yr, uname)) {
				session.setAttribute("isMT", true);
				System.out.println("isMT >> True");
			}
			session.setAttribute("year", yr);

			System.out.println("comboSet yr value >> " + yr);

			RequestDispatcher req = request.getRequestDispatcher("employeegallery.jsp");
			req.forward(request, response);
		} else if (command.equalsIgnoreCase("getuser")) {
			String usr = request.getParameter("staffname");
			//func = ctrl.getFuncById(deptId.trim());
			try {
				UserProfile usP = new UserProfile();
				usP = ad.getUserProfile(usr, moduleid);
			} catch (Exception ex) {
				ex.printStackTrace();
			}

		} else if (command.equalsIgnoreCase("signout")) {
			session.removeAttribute("username");
			session.invalidate();
			response.sendRedirect("login.jsp");
		} else if (command.equalsIgnoreCase("ADBtn")) {
			System.out.println("Button pressed >> " + command);
		} else if (command.equalsIgnoreCase("RDBtn")) {
			System.out.println("Button pressed >> " + command);
		} else if (command.equalsIgnoreCase("ASBtn")) {
			System.out.println("Button pressed >> " + command);
		} else if (command.equalsIgnoreCase("RSBtn")) {
			System.out.println("Button pressed >> " + command);
		} else if (command.equalsIgnoreCase("btnMem")) {
			System.out.println("Button pressed >> " + command);
		} else if (command.equalsIgnoreCase("updateinfo")) {
			System.out.println("Got here >>");
			SecretDao sec = new SecretDao();
			username = (String) session.getAttribute("username");
			if (username != null) {
				try {
					System.out.println("Got here 2 >>");
					staffId = (String) session.getAttribute("staffId");
					String display = (String) session.getAttribute("disName");

					sec.setStaffId(staffId);
					sec.setUsername(username);
					sec.setDisplayName(display);

					sec.setSecret1(pb.PBEncrypt(ctrl.checkNull(request.getParameter("question1"))));
					sec.setAnswer1(pb.PBEncrypt(ctrl.checkNull(request.getParameter("answer1"))));

					sec.setSecret2(pb.PBEncrypt(ctrl.checkNull(request.getParameter("question2"))));
					sec.setAnswer2(pb.PBEncrypt(ctrl.checkNull(request.getParameter("answer2"))));

					sec.setSecret3(pb.PBEncrypt(ctrl.checkNull(request.getParameter("question3"))));
					sec.setAnswer3(pb.PBEncrypt(ctrl.checkNull(request.getParameter("answer3"))));

					sec.setSecret4(pb.PBEncrypt(ctrl.checkNull(request.getParameter("question4"))));
					sec.setAnswer4(pb.PBEncrypt(ctrl.checkNull(request.getParameter("answer4"))));

					sec.setSecret5(pb.PBEncrypt(ctrl.checkNull(request.getParameter("question5"))));
					sec.setAnswer5(pb.PBEncrypt(ctrl.checkNull(request.getParameter("answer5"))));

					System.out.println("Got here 3 >>");

					request.setAttribute("compSecurity", sec);
					System.out.println("Got here, Done this.. >>");

					try {
						if (sserv.generateOTP(sec.getUsername(), sec.getDisplayName())) {
							System.out.println("Now this.. >>");
							RequestDispatcher rf = request.getRequestDispatcher("validation.jsp");
							rf.include(request, response);
						} else {
							response.sendRedirect("reegistrationpage.jsp");
						}

					} catch (Exception e) {
					}
				} catch (Exception e) {
					System.out.println("Error: User not logged in...");
					session.invalidate();
					response.sendRedirect("login.jsp");
				}

			}

		}
		out.print(func);

	} else {
		System.out.println("Unable to get moduleid" + moduleid);
	}
%>