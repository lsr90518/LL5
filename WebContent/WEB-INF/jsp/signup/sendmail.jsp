<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!doctype html>
<html>
    <c:import url="../include/head.jsp">
        <c:param name="title" value="Signup" />
    </c:import>
    
    <script
	src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<style type="text/css">
body {
	padding-top: 45px;
	background-color: #ecf0f1;
	font-size: large;
	padding-bottom: 55px;
}

.navbar>.container {
background-color: #FAB937;
}

.media-object {
	display: block;
	margin: 10px;
}

.list-group {
	margin-bottom: 5px;
}

.titleSpan {
	line-height: 40px;
	color: white;
	padding: 5px;
}

.topNav {
	min-height: 33px;
}

.topBtn {
	padding: 8px;
}

.media-object {
	display: block;
	margin: 0px 10px 0px 0px;
}

.container {
	padding-left: 5px;
	padding-right: 5px;
}

.navTab {
	color: white;
}

.pushedTab {
	color: black;
}
</style>
<header class="navbar navbar-default navbar-fixed-top topNav"
	role="navigation">
	<div class="container topNav">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="row">
			<div class="col-xs-2 col-md-2">
				<a class="btn-lg btn-block topBtn" style="text-align: center"
					href="/LL5"><span
					class="glyphicon glyphicon-chevron-left navTab"></span></a>
			</div>
			<div class="col-xs-8 col-md-8" style="text-align: center;">
				<span class="titleSpan">Sign In</span>
			</div>
			


		</div>
	</div>
	<!-- /.container-fluid -->
</header>

    <body id="page_member_login">
    <div id="container">
    		<div class="col-xs-1 col-md-1"></div>
			<div id="MailAddressLogin" class="loginForm col-xs-10 col-md-10" style="margin-top: 20px">
				<c:url value="/signup/sendmail" var="sendmailUrl" />
				<form:form commandName="emailForm" action="${sendmailUrl}"
					method="post">
					<form:input path="email" class="form-control" id="mailAddr" placeholder="Email address" /> 
					<form:errors cssStyle="color:red" path="email" class="form-control" />
					<input type="submit" class="btn btn-primary btn-block" style="margin-top: 20px" value="Send" />
				</form:form>
			</div>
			<div class="col-xs-1 col-md-1"></div>
	</div><!-- Body -->
    </body>
</html>
