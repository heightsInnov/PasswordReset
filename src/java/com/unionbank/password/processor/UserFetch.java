/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.unionbank.password.processor;

import com.unionbank.password.Dao.QuestionDao;
import com.unionbank.password.services.AdValidate;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.datacontract.schemas._2004._07.ubn_security.UserProfile;

/**
 *
 * @author aojinadu
 */
public class UserFetch extends HttpServlet {

	/**
	 * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
	 *
	 * @param request servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException if an I/O error occurs
	 */

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()) {
			/* TODO output your page here. You may use following sample code. */
			String userid = request.getParameter("user");
			try {
				AdValidate ad = new AdValidate();
				Supercontrol sc = new Supercontrol();
				UserProfile usp = ad.getUserProfile(userid, "UserProfileMgmt");
				List<QuestionDao> questUser = sc.getquestion(userid);

				System.out.println("Profile gotten! Display is >>" + usp.getDisplayName().getValue());

				String loginuser = (String) session.getAttribute("username");
				request.setAttribute("UserSet", usp);
				session.setAttribute("uname", userid);
				request.setAttribute("quest", questUser);
				sc.insertAuditLog(loginuser, userid, "ResetDetails => UserFetch");
				getServletContext().getRequestDispatcher("/resetdetails.jsp").forward(request, response);
			} catch (Exception e) {
				request.setAttribute("message", "Invalid Username, check and try again!");
				getServletContext().getRequestDispatcher("/resetdetails.jsp").forward(request, response);
			}
		}
	}

	public void RouteUser(String isreg, HttpServletResponse response)
			throws ServletException, IOException {
		switch (isreg) {
			case "Y":
				response.sendRedirect("resetdetails.jsp");
				break;
			case "N":
				response.sendRedirect("registrationpage.jsp");
				break;
			case "S":
				response.sendRedirect("validation.jsp");
				break;
			default:
				response.sendRedirect("registrationpage.jsp");
		}
	}

	// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
	/**
	 * Handles the HTTP <code>GET</code> method.
	 *
	 * @param request servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException if an I/O error occurs
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	/**
	 * Handles the HTTP <code>POST</code> method.
	 *
	 * @param request servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException if an I/O error occurs
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	/**
	 * Returns a short description of the servlet.
	 *
	 * @return a String containing servlet description
	 */
	@Override
	public String getServletInfo() {
		return "Short description";
	}// </editor-fold>

}
