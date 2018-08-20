<%-- 
    Document   : registrationpage
    Created on : Jul 26, 2018, 2:34:46 PM
    Author     : aojinadu
--%>

<%@page import="com.unionbank.password.Dao.SecretDao"%>
<%@page import="com.unionbank.password.Dao.QuestionDao"%>
<%@page import="java.util.List"%>
<%@page import="com.unionbank.password.processor.Supercontrol"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
	Supercontrol sp = new Supercontrol();
	List<QuestionDao> questions = null;
	String username = "";
	try {
		username = (String) session.getAttribute("username");
		if (username == null) {
			username = "";
		}
		questions = sp.getquestion("ALL");
		String isreg = sp.checkRegStatus(username);
		if (isreg.equalsIgnoreCase("Y")) {
			RequestDispatcher rd = request.getRequestDispatcher("resetdetails.jsp");
			rd.include(request, response);
		}
	} catch (Exception e) {
		System.out.println("Error on UpdateInfo");
	}
	//List<Departments> dept;
	//List<SkillSet> skl;
	//dept = sp.getDepts();
	//skl = sp.getKills();
%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="WEB-INF/jspf/header.jspf" %>
		<%
			try {
					SecretDao predata = (SecretDao) session.getAttribute("predata");
					if(predata != null){
						%>
						<script>
							document.getElementById("validform").style.display = "block";
						</script>
						<%
						}
				} catch (Exception e) {
			
				
			}
		%>
		<script>
			function toggleVisibility(eventsender, idOfObjectToToggle){
                var myNewState = "none";
                if (eventsender.checked === true){
                    myNewState = "block";
                }

                document.getElementById(idOfObjectToToggle).style.display = myNewState;
            } 
		</script>
    </head>
    <body>
		<%@include file="WEB-INF/jspf/tags.jspf" %>
		<%@include file="WEB-INF/jspf/nav.jspf" %>

		<section id="contact" class="space100">
			<input type="hidden" name="command" value="updateinfo"/>
			<div class="container">
				<div class="row">
					<div class="headingsyle">
						<h1><span>Register User</span></h1>
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
															<div class="row">
																<div class="col-md-12">
																	<div class="form-group">
																		<label class="sr-only" for="contact-name">
																			Question 2</label>
																		<select name="question1" class="contact-name form-control" id="question1">
																			<option value="">--Choose Question 1--</option>
																			<%
																				for (QuestionDao dp : questions) {
																			%>
																			<option value="<%=dp.getQuestionID()%>"><%= dp.getQuestion()%></option>
																			<%}%>
																		</select>
																	</div>
																</div>
															</div>
															<div class="row">
																<div class="col-md-12">
																	<div class="form-group">
																		<label class="sr-only" for="contact-name">Answer 1</label>
																		<textarea required="required" style="overflow: auto; resize: none;" name="answer1" placeholder="Answer1..." class="form-control" id="answer1"></textarea>
																	</div>
																</div>
															</div>
															<div class="row">
																<div class="col-md-12">
																	<div class="form-group">
																		<label class="sr-only" for="contact-name">
																			Question 2</label>
																		<select name="question2" class="contact-name form-control" id="question2">
																			<option value="">--Choose Question 2--</option>
																			<%
																				for (QuestionDao dp : questions) {
																			%>
																			<option value="<%=dp.getQuestionID()%>"><%= dp.getQuestion()%></option>
																			<%}%>
																		</select>
																	</div>
																</div>
															</div>
															<div class="row">
																<div class="col-md-12">
																	<div class="form-group">
																		<label class="sr-only" for="contact-name">Answer 2</label>
																		<textarea required="required" style="overflow: auto; resize: none;" name="answer2" placeholder="Answer2..." class="contact-message form-control" id="answer2"></textarea>
																	</div>
																</div>
															</div>
															<div class="row">
																<div class="col-md-12">
																	<div class="form-group">
																		<label class="sr-only" for="contact-name">
																			Question 3</label>
																		<select name="question3" class="contact-name form-control" id="question3">
																			<option value="">--Choose Question 3--</option>
																			<%
																				for (QuestionDao dp : questions) {
																			%>
																			<option value="<%=dp.getQuestionID()%>"><%= dp.getQuestion()%></option>
																			<%}%>
																		</select>
																	</div>
																</div>
															</div>
															<div class="row">
																<div class="col-md-12">
																	<div class="form-group">
																		<label class="sr-only" for="contact-name">Answer 3</label>
																		<textarea required="required" style="overflow: auto; resize: none;" name="answer3" placeholder="Answer3..." class="contact-message form-control" id="answer3"></textarea>
																	</div>
																</div>
															</div>
															<div class="row">
																<div class="col-md-12">
																	<div class="form-group">
																		<label class="sr-only" for="contact-name">
																			Question 4</label>
																		<select name="question4" class="contact-name form-control" id="question4">
																			<option value="">--Choose Question 4--</option>
																			<%
																				for (QuestionDao dp : questions) {
																			%>
																			<option value="<%=dp.getQuestionID()%>"><%= dp.getQuestion()%></option>
																			<%}%>
																		</select>
																	</div>
																</div>
															</div>
															<div class="row">
																<div class="col-md-12">
																	<div class="form-group">
																		<label class="sr-only" for="contact-name">Answer 4</label>
																		<textarea required="required" style="overflow: auto; resize: none;" name="answer4" placeholder="Answer4..." class="contact-message form-control" id="answer4"></textarea>
																	</div>
																</div>
															</div>
															<div class="row">
																<div class="col-md-12">
																	<div class="form-group">
																		<label class="sr-only" for="contact-name">
																			Question 5</label>
																		<select name="question5" class="contact-name form-control" id="question5">
																			<option value="">--Choose Question 5--</option>
																			<%
																				for (QuestionDao dp : questions) {
																			%>
																			<option value="<%=dp.getQuestionID()%>"><%= dp.getQuestion()%></option>
																			<%}%>
																		</select>
																	</div>
																</div>
															</div>
															<div class="row">
																<div class="col-md-12">
																	<div class="form-group">
																		<label class="sr-only" for="contact-name">Answer 5</label>
																		<textarea required="required" style="overflow: auto; resize: none;" name="answer5" placeholder="Answer5..." class="contact-message form-control" id="answer5"></textarea>
																	</div>
																</div>
															</div>
															<div class="row">
																<div class="col-md-12">
																	<div class="form-group">
																		<div class="row">
																			<div class="col-md-12">
																				<input type="checkbox" class="" id="newstaff" onclick="JavaScript:toggleVisibility(this,'newstaffDiv');"/>&nbsp;&nbsp;Click here if you are a new staff
																			</div>
																		</div>
																		<div class="row" id="newstaffDiv" style="display: none">
																			<br/>
																			<div class="col-md-12">
																				<input type="text" id="newstaffTxt" name="newstaffTxt" class="form-control" placeholder="supply personal email.."/>
																			</div>
																		</div>
																	</div>
																</div>
															</div>
															<div class="row">
																<div class="col-md-3">
																	<input type="submit" class="btn btn-default" value="Submit"/>
																</div>
															</div>
														</form>
														<br/>
														<form method="post" action="supercontrol.jsp" id="validform" style="display: none">
															<input type="hidden" value="validate"/>
																<div class="row">
																	<div class="col-md-12">
																		<div class="form-group">
																			<div class="row">
																				<div class="col-md-12">
																					<p><i>Check your email for One-Time-Password (OTP) to proceed to next phase of registration.</i></p>
																					<label class="" for="contact-message">Supply Authorization Pin: </label>
																				</div>
																			</div>
																		</div>
																	</div>
																</div>
																<div class="row">
																	<div class="col-md-12">
																		<div class="form-group">
																			<div class="row">
																				<div class="col-md-8">
																					<input type="password" required="required" name="code" placeholder="Enter 6 digit pin.." class="contact-name form-control" id="code"/>
																				</div>
																				<div class="col-md-4">
																					<input type="submit" class="btn btn-primary" value="Submit" onclick="verify_clicks(skills)"/>
																				</div>
																			</div>
																		</div>
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
				</div>
			</div>
		</section>
		<%@include 	file="WEB-INF/jspf/footer.jspf" %>
		<script>
			$('#question1').on('change', function () {
				$(this).find('option').prop('disabled', false);
				var val = $(this).val();
				//var prof = val.split("-");

				//$('#question2').find('option[value*=' + prof[0] + ']').prop('disabled', true);
				$('#question2').find('option[value=' + val + ']').prop('disabled', true);
				$('#question3').find('option[value=' + val + ']').prop('disabled', true);
				$('#question4').find('option[value=' + val + ']').prop('disabled', true);
				$('#question5').find('option[value=' + val + ']').prop('disabled', true);
			});
		</script>
		<script>
			$('#question2').on('change', function () {
				$(this).find('option').prop('disabled', false);
				var val = $(this).val();
				//var prof = val.split("-");

				$('#question3').find('option[value=' + val + ']').prop('disabled', true);
				$('#question4').find('option[value=' + val + ']').prop('disabled', true);
				$('#question5').find('option[value=' + val + ']').prop('disabled', true);
			});
		</script>
		<script>
			$('#question3').on('change', function () {
				$(this).find('option').prop('disabled', false);
				var val = $(this).val();
				//var prof = val.split("-");

				$('#question4').find('option[value=' + val + ']').prop('disabled', true);
				$('#question5').find('option[value=' + val + ']').prop('disabled', true);
			});
		</script>
		<script>
			$('#question4').on('change', function () {
				$(this).find('option').prop('disabled', false);
				var val = $(this).val();
				//var prof = val.split("-");

				$('#question5').find('option[value=' + val + ']').prop('disabled', true);
			});
		</script>
    </body>
</html>
