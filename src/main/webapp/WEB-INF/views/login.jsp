<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
<title>Login Page</title>

<link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/resources/css/jquery.ketchup.css" />">

    <script type="text/javascript" src="<c:url value="/resources/js/jquery-1.4.4.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/resources/js/jquery.ketchup.all.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/resources/js/jquery.validate.js"/>"></script>
<script type="text/javascript">
window.onload= initPage;
function initPage(){
$('#default-behavior').ketchup();
// Ketchup Validation Code ends
}


</script>


<link href="<c:url value="/resources/favicon.ico" /> rel="icon"> 
<link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">



    <!-- Custom styles for this template -->
<link href="<c:url value="/resources/css/signin.css" />" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="<c:url value="/resources/js/ie-emulation-modes-warning.js" />"></script>


    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
	<div class="container">
	<img src="<c:url value="/resources/images/Logo_sn.png" />" alt="Smiley face" height="290" width="400" id="logo">
	<form:form method="post" action="signinurl" modelAttribute="loginForm" class="form-signin" role="form" id="default-behavior">
		<h2 class="form-signin-heading">Please sign in</h2>
        <label for="inputEmail" class="sr-only">App Username</label>
        <form:input type="text" path="appUsername" id="inputEmail" class="form-control" placeholder="App Username" data-validate="validate(required)" />
        <label for="inputPassword" class="sr-only">App Password</label>
        <form:input type="password" path="appPassword" id="inputPassword" class="form-control" placeholder="App Password" data-validate="validate(required)"/>
        <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
		
		
	</form:form>
	<form:form action="givesignup" modelAttribute="loginForm" class="form-signin" role="form" method="post">
		
        <button class="btn btn-lg btn-primary btn-block" type="submit">New User? Sign Up</button>
		
		
	</form:form>
	</div>
	
	
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="<c:url value="/resources/js/ie10-viewport-bug-workaround.js" />"></script>
</body>
</html>