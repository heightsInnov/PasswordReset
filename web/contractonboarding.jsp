<%-- 
    Document   : contractonboarding
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
						<h1><span>Staff profile Update</span></h1>
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
														<div class="row">
															<div class="col-md-12">
																<img class="img-responsive" src="images/noprofile_lg.gif" id="imgReg" name="imgReg"/>
															</div>
														</div>
														<br/>
														<div class="row">
															<div class="col-md-12">
																<input type="file" id="passFile" name="passFile" class="form-control"/>
															</div>
														</div>
													</div>
													<div class="col-md-8">
														<div id="main-contact-form" class="contact-form">
															<div class="row">
																<div class="col-md-6">
																	<div class="form-group">
																		<label class="sr-only" for="contact-name">Employee Number</label>
																		<input type="text" required="required" name="empNo" placeholder="Employee Number" class="form-control" id="empNo"/>
																	</div>
																</div>
																<div class="col-md-6">
																	<div class="form-group">
																		<label class="sr-only" for="contact-name">Entry Date</label>
																		<input type="text" required="required" name="entryDate" placeholder="Entry Date" class="form-control" id="entryDate"/>
																	</div>
																</div>
															</div>
															<div class="row">
																<div class="col-md-6">
																	<div class="form-group">
																		<label class="sr-only" for="contact-name">First Name</label>
																		<input type="text" required="required" name="firstname" placeholder="First Name" class="form-control" id="firstname"/>
																	</div>
																</div>
																<div class="col-md-6">
																	<div class="form-group">
																		<label class="sr-only" for="contact-name">Last Name</label>
																		<input type="text" required="required" name="lastname" placeholder="Last Name" class="form-control" id="lastname"/>
																	</div>
																</div>
															</div>
															<div class="row">
																<div class="col-md-6">
																	<div class="form-group">
																		<label class="sr-only" for="contact-name">Middle Name</label>
																		<input type="text" required="required" name="middlename" placeholder="Middle Name" class="form-control" id="middlename"/>
																	</div>
																</div>
																<div class="col-md-6">
																	<div class="form-group">
																		<label class="sr-only" for="contact-name">Preferred Name</label>
																		<input type="text" required="required" name="preferred" placeholder="Preferred Name" class="form-control" id="preferred"/>
																	</div>
																</div>
															</div>
															<div class="row">
																<div class="col-md-6">
																	<div class="form-group">
																		<label class="sr-only" for="contact-name">Branch/Dept</label>
																		<input type="text" required="required" name="brndpt" placeholder="Branch/Dept" class="form-control" id="brndpt"/>
																	</div>
																</div>
																<div class="col-md-6">
																	<div class="form-group">
																		<label class="sr-only" for="contact-name">Job Role</label>
																		<input type="text" required="required" name="jobrole" placeholder="Job Role" class="form-control" id="jobrole"/>
																	</div>
																</div>
															</div>
															<div class="row">
																<div class="col-md-6">
																	<div class="form-group">
																		<label class="sr-only" for="contact-name">Grade</label>
																		<input type="text" required="required" name="grade" placeholder="Grade" class="form-control" id="grade"/>
																	</div>
																</div>
																<div class="col-md-6">
																	<div class="form-group">
																		<label class="sr-only" for="contact-name">Account Number</label>
																		<input type="text" required="required" name="accNo" placeholder="Account Number" class="form-control" id="accNo"/>
																	</div>
																</div>
															</div>
															<div class="row">
																<div class="col-md-6">
																	<div class="form-group">
																		<label class="sr-only" for="contact-name">Date of Birth</label>
																		<input type="text" required="required" name="dob" placeholder="Date of Birth" class="form-control" id="dob"/>
																	</div>
																</div>
																<div class="col-md-6">
																	<div class="form-group">
																		<label class="sr-only" for="contact-name">Marital Status</label>
																		<input type="text" required="required" name="marStat" placeholder="Marital Status" class="form-control" id="marStat"/>
																	</div>
																</div>
															</div>
															<div class="row">
																<div class="col-md-6">
																	<div class="form-group">
																		<label class="sr-only" for="contact-name">Email</label>
																		<input type="text" required="required" name="email" placeholder="Email" class="form-control" id="email"/>
																	</div>
																</div>
																<div class="col-md-6">
																	<div class="form-group">
																		<label class="sr-only" for="contact-name">Nationality</label>
																		<input type="text" required="required" name="nationality" placeholder="Nationality" class="form-control" id="nationality"/>
																	</div>
																</div>
															</div>
															<div class="row">
																<div class="col-md-6">
																	<div class="form-group">
																		<label class="sr-only" for="contact-name">Next of Kin</label>
																		<input type="text" required="required" name="nok" placeholder="Next of Kin" class="form-control" id="nok"/>
																	</div>
																</div>
																<div class="col-md-6">
																	<div class="form-group">
																		<label class="sr-only" for="contact-name">Address of Next of Kin</label>
																		<input type="text" required="required" name="nokAdd" placeholder="Address of Next of Kin" class="form-control" id="nokAdd"/>
																	</div>
																</div>
															</div>
															<div class="row">
																<div class="col-md-6">
																	<div class="form-group">
																		<label class="sr-only" for="contact-name">Next of Kin Phone</label>
																		<input type="text" required="required" name="nokPhone" placeholder="Next of Kin Phone Number" class="form-control" id="nokPhone"/>
																	</div>
																</div>
																<div class="col-md-6">
																	<div class="form-group">
																		<label class="sr-only" for="contact-name">Previous Last Name</label>
																		<input type="text" required="required" name="pLastName" placeholder="Previous Last Name" class="form-control" id="pLastName"/>
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
