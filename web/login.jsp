<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="AEP - Login">
        <meta name="author" content="AEP">
        <meta name="keyword" content="">
        <link rel="shortcut icon" href="img/favicon.png">

        <title>Login || Password Reset</title>

        <!-- Bootstrap CSS -->    
        <link href="logincss/bootstrap.min.css" rel="stylesheet" />
        <!-- bootstrap theme -->
        <link href="logincss/bootstrap-theme.css" rel="stylesheet">
        <!--external css-->
        <!-- font icon -->
        <link href="logincss/elegant-icons-style.css" rel="stylesheet" />
        <link href="logincss/font-awesome.css" rel="stylesheet" />
        <!-- Custom styles -->
        <link href="logincss/style.css" rel="stylesheet">
        <link href="logincss/style-responsive.css" rel="stylesheet" />
    </head>
	<%@include file="WEB-INF/jspf/tags.jspf" %>
    <body class="login-img3-body">

        <div class="container">
			<%				String isContainEst = (String) request.getAttribute("message");

				//  String isContainEst = (String) session.getAttribute("msg-info-signin");
				System.out.println("isContainEst first pick <<>." + isContainEst);
				if (isContainEst == null) {
					isContainEst = "";
				}
				//   session.setAttribute("msg-info-signin", "");
				request.setAttribute("message", "");

				if (!isContainEst.equals("") && isContainEst.contains("Success!")) {
					System.out.println("in Upload :::yes message available<<>>" + isContainEst);
			%>
			<div class="alert alert-success text-center alert-dismissable sticky"><button class="close" aria-hidden="true" data-dismiss="alert" type="button">&times;</button><h4><%=isContainEst%></h4></div>
			<%                    } else if (!isContainEst.equals("") && isContainEst.contains("Error!")) {%>
			<div class="alert alert-danger text-center alert-dismissable sticky"><button class="close" aria-hidden="true" data-dismiss="alert" type="button">&times;</button><h4><%=isContainEst%></h4></div>
			<%
				} else {
					System.out.println("in Upload :::No message available<<>>" + isContainEst);
				}
			%>
            <form class="login-form" method="POST" action="supercontrol.jsp"> 
                <input type="hidden" name="command" id="command" value="auth"/>
                <div class="login-wrap">
                    <p class="login-img">Login</p>
                    <div class="input-group">
                        <span class="input-group-addon"><i class="icon_profile"></i></span>
                        <input name="txtusername" type="text" class="form-control" placeholder="Username" autofocus>
                    </div>
					<div class="input-group">
                        <span class="input-group-addon"><i class="icon_key_alt"></i></span>
                        <input name="txttoken" type="password" class="form-control" placeholder="Token">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon"><i class="icon_lock-open_alt"></i></span>
                        <input name="txtpassword" type="password" class="form-control" placeholder="Password">
                    </div>
                    <label class="checkbox">
                        <input type="checkbox" value="remember-me"> Remember me
                        <span class="pull-right"> <a href="#" id="fpass"> Forgot Password?</a></span>
                    </label>
                    <input type="submit" class="btn btn-primary btn-lg btn-block" value="Login">
                    <input type="submit" class="btn btn-info btn-lg btn-block" type="submit" value="Clear" formaction=""/>
                </div>
            </form>
        </div>
    </body>
</html>
