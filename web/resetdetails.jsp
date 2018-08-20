<%-- 
    Document   : resetdetails
    Created on : Jul 20, 2018, 4:06:17 PM
    Author     : aojinadu
--%>

<%@page import="java.util.List"%>
<%@page import="com.unionbank.password.Dao.QuestionDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="WEB-INF/jspf/header.jspf" %>
        <%
			Supercontrol sp = new Supercontrol();
			String username = "";
			try {
				username = (String) session.getAttribute("username");
				String isreg = sp.checkRegStatus(username);
				if (!isreg.equalsIgnoreCase("Y")) {
					response.sendRedirect("registrationpage.jsp");
				}
			} catch (Exception e) {
			}

		%>
    </head>
    <body>
		<%@include file="WEB-INF/jspf/tags.jspf" %>
		<%@include file="WEB-INF/jspf/nav.jspf" %>

		<section id="contact" class="space100">
			<input type="hidden" name="command" value="updateinfo"/>
			<div class="container">
				<div class="row">
					<div class="headingsyle">
						<h1><span>Reset Password</span></h1>
					</div>
				</div>
				<div class="row">
					<div class="col-md-1 col-xs-1"></div>
					<div class="col-md-10">
						<div class="col-md-12 col-sm-12">
							<div class="row">
								<div class="col-md-12">
									<label class="alert-warning" id="alert" name="alert">${sessionScope.alert}</label>
								</div>
							</div>
							<div class="feature-content">
								<div class="row">
									<div class="col-sm-12 wow fadeInDown" data-wow-delay="0.2s">
										<!--Header for name and nickname-->
										<div class="row">
											<div class="panel-title">
												<h4><span class="icon-book-open"></span>${sessionScope.display} (${sessionScope.staffId})</h4>
											</div>
											<div class="person-content">
												<br/>
												<div class="row">
													<div class="col-md-4">
														<img class="img-responsive" src="images/Olubusola.jpg" id="imgReg" name="imgReg"/>
													</div>
													<div class="col-md-8">
														<div id="main-contact-form" class="contact-form">
															<!-- form -->
															<div class="row">
																<div class="col-md-8">
																	<div class="form-group">
																		<label class="sr-only" for="contact-email">Username</label>
																		<% String uname = "";
																			uname = (String) request.getAttribute("uname");
																			if (uname == null) {
																				uname = "";
																			}
																		%>
																		<input required="required" type="text" autocomplete="off" name="user" placeholder="staff username" class="contact-email form-control" id="user" value="<%= uname%>">
																	</div>
																</div>
																<div class="col-md-4">
																	<div class="form-group">
																		<input type="submit" class="btn btn-primary" value="Verify" onclick="form.action = 'UserFetch';"/>
																	</div>
																</div>
															</div>
															<%
																String dispname = "", dept = "", quest1 = "", quest2 = "", quest3 = "";
																try {
																	UserProfile usp = (UserProfile) request.getAttribute("UserSet");
																	dispname = usp.getDisplayName().getValue();
																	dept = usp.getJobTitle().getValue();

																	List<QuestionDao> quest = (List<QuestionDao>) request.getAttribute("questUser");
																	quest1 = quest.get(0).getQuestion().toString();
																	quest2 = quest.get(1).getQuestion().toString();
																	quest3 = quest.get(2).getQuestion().toString();
																} catch (Exception e) {
																}
																if (dispname == null) {
																	dispname = "";
																}
																if (dept == null) {
																	dept = "";
																}
																if (dispname != "") {
															%>
															<div class="row">
																<div class="col-md-3 col-sm-3">
																	<h5 class="hh5">Name: </h5>
																</div>
																<div class="col-md-8 col-sm-8">
																	<h5><span>
																			<label name="name" id="almamata"><%= dispname%></label></span></h5>
																</div>
															</div>
															<%}
																if (dept != "") {%>
															<div class="row">
																<div class="col-md-3 col-sm-3">
																	<h5 class="hh5">Department: </h5>
																</div>
																<div class="col-md-8 col-sm-8">
																	<h5><span><label name="dept" id="dept"><%= dept%></label></span></h5>
																</div>
															</div>
															<%}%>
															<div class="row">
																<div class="col-md-3 col-sm-3">
																	<h5 class="hh5">Question 1: </h5>
																</div>
																<div class="col-md-8 col-sm-8">
																	<h5><span><label name="sq1" id="sq1"><%= quest1%></label></span></h5>
																</div>
															</div>
															<div class="row ">
																<div class="col-md-12">
																	<label class="sr-only" for="contact-name">Answer 1</label>
																	<input type="text" name="answer1" placeholder="Answer 1..." class="contact-name form-control" id="answer1"/>
																</div>
															</div>
															<div class="row">
																<div class="col-md-3 col-sm-3">
																	<h5 class="hh5">Question 2: </h5>
																</div>
																<div class="col-md-8 col-sm-8">
																	<h5><span><label name="sq2" id="sq1"><%= quest2%></label></span></h5>
																</div>
															</div>
															<div class="row ">
																<div class="col-md-12">
																	<label class="sr-only" for="contact-name">Answer 2</label>
																	<input type="text" name="answer2" placeholder="Answer 2..." class="contact-name form-control" id="answer2"/>
																</div>
															</div>
															<div class="row">
																<div class="col-md-3 col-sm-3">
																	<h5 class="hh5">Question 3: </h5>
																</div>
																<div class="col-md-8 col-sm-8">
																	<h5><span><label name="sq3" id="sq1"><%= quest3%></label></span></h5>
																</div>
															</div>
															<div class="row ">
																<div class="col-md-12">
																	<label class="sr-only" for="contact-name">Answer 3</label>
																	<input type="text" name="answer3" placeholder="Answer 3..." class="contact-name form-control" id="answer3"/>
																</div>
															</div>
															<br/>
															<div class="row">
																<div class="col-md-12">
																	<div class="form-group">
																		<div class="row">
																			<div class="col-md-6">
																				<input type="password" name="pass" placeholder="Enter new password" class="contact-name form-control" id="pass"/>
																			</div>
																			<div class="col-md-6">
																				<input type="password" name="confpass" placeholder="Confirm new password" class="contact-name form-control" id="confpass"/>
																			</div>
																		</div>
																	</div>
																</div>
															</div>
															<br/>
															<div class="row">
																<div class="col-md-12">
																	<div class="form-group">
																		<div class="row">
																			<div class="col-md-4">
																				<label class="" for="contact-message">Supply Authorization Pin: </label>
																			</div>
																			<div class="col-md-8">
																				<input type="password" name="code" placeholder="Enter 6 digit pin.." class="contact-name form-control" id="code"/>
																			</div>
																		</div>
																	</div>
																</div>
															</div>
														</div>
														<br/>
														<div class="row">
															<div class="col-md-3">
																<input type="submit" class="btn btn-large" value="Submit" onclick="verify_clicks(skills)"/>
															</div>
														</div>
														<br/>
														<!-- ./form -->
													</div>
												</div>
												<br/>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<%@include file="WEB-INF/jspf/footer.jspf" %>
</body>
</html>