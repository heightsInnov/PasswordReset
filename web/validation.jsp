<%-- 
    Document   : validation
    Created on : Aug 11, 2018, 10:29:16 PM
    Author     : aojinadu
--%>

<%@page import="com.unionbank.password.Dao.SecretDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="WEB-INF/jspf/header.jspf" %>
		<%
			try {
				SecretDao predata = (SecretDao) session.getAttribute("predata");
				if (predata != null) {
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
			function toggleVisibility(eventsender, idOfObjectToToggle) {
				var myNewState = "none";
				if (eventsender.checked === true) {
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
			<input type="hidden" name="command" value="validatereg"/>
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
									<div class="col-md-12 wow fadeInDown" data-wow-delay="0.2s">
										<!--Header for name and nickname-->
										<div class="row">
											<div class="panel-title">
												<h4><span class="icon-book-open"></span>${sessionScope.display} (${sessionScope.staffId})</h4>
											</div>
											<div class="person-content">
												<br/>
												<div class="row">
													<div class="col-md-4 col-md-8 col-sm-4">
														<img class="img-responsive" src="images/Olubusola.jpg" id="imgReg" name="imgReg"/>
													</div>
													<div class="col-md-8 col-md-8 col-sm-8">
														<div id="main-contact-form" class="contact-form">
															<input type="hidden" value="validate"/>
															<div class="row">
																<div class="col-md-12">
																	<div class="form-group">
																		<div class="row">
																			<div class="col-md-12">
																				<p><i>Check your email for One-Time-Password (OTP) to complete registration.</i></p>
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
																				<input type="password" required="required" name="code" placeholder="Enter One Time Password (OTP)" class="contact-name form-control" id="code"/>
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
																				<input type="password" required="required" name="respin" placeholder="Create 6-digit Reset pin" class="contact-name form-control" id="respin"/>
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
																				<input type="password" required="required" name="respinconf" placeholder="Retype Reset pin" class="contact-name form-control" id="respinconf"/>
																			</div>
																		</div>
																	</div>
																</div>
															</div>
															<div class="row">
																<div class="col-md-12">
																	<div class="form-group">
																		<div class="row">
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
