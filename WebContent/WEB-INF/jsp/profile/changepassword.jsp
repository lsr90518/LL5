<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!doctype html>
<html>
<c:import url="../include/head.jsp">
	<c:param name="title" value="Change Password" />
</c:import>

<script
	src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
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

.input-table>tr>td{
	margin-top:10px;
}
</style>
<header class="navbar navbar-default navbar-fixed-top topNav"
	role="navigation">
	<div class="container topNav">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="row">
			<div class="col-xs-2 col-md-2">
				<a class="btn-lg btn-block topBtn dropdown-toggle"
					style="text-align: center" href="#" id="dropdownMenu1"
					data-toggle="dropdown"> <span
					class="glyphicon glyphicon-th-list navTab"></span>
				</a>
				<ul class="dropdown-menu" role="menu"
					aria-labelledby="dropdownMenu1">
					<li role="presentation" id="default__homepage"><a
						role="menuitem" tabindex="-1" href="<c:url value="/profile" />">Profile</a></li>
					<li role="presentation" id="default_settings"><a
						role="menuitem" tabindex="-1"
						href="<c:url value="/recommendSetting" />">Recommend Settings</a></li>
					<li role="presentation" id="default_password"><a
						role="menuitem" tabindex="-1"
						href="<c:url value="/profile/changepassword" />">Change
							Password</a></li>
				</ul>
			</div>
			<div class="col-xs-8 col-md-8" style="text-align: center;">
				<span class="titleSpan">${user.nickname}</span>
			</div>
			<div class="col-xs-2 col-md-2">
				<a class="btn-lg btn-block topBtn" style="text-align: center"
					href="/LL5/item/add"><span
					class="glyphicon glyphicon-pencil navTab"></span></a>
			</div>


		</div>
	</div>
	<!-- /.container-fluid -->
</header>

<body id="page_member_registerInput">
	<div id="Body">
		<div class="container">
			<div id="Contents">
				<div id="ContentsContainer">
					<div id="localNav"></div>
					<!-- localNav -->
					<div id="LayoutC" class="Layout">
						<div id="Center">
							<div id="RegisterForm" class="dparts form">
								<div class="parts">
									<c:url value="/profile/changepassword" var="profileEditFormUrl" />
									<form:form modelAttribute="form" action="${profileEditFormUrl}"
										method="post">
										<div id="Center" class="parts">
											<div class="partsHeading">
												<h3>Change password</h3>
											</div>
											<input type="hidden" name="userid" value="${user.id}" />
											<table class="input-table">
												<tr>
													<th><label for="password">Current password</label></th>
													<td><form:password path="oldpassword" class="form-control" /> <form:errors
															path="oldpassword" cssClass="error" /></td>
												</tr>
												<tr>
													<th><label for="password">New password</label></th>
													<td><form:password path="password" class="form-control" /> <form:errors
															path="password" cssClass="error" /></td>
												</tr>
												<tr>
													<th><label for="passwordConfirm">New
															password(Again)</label></th>
													<td><form:password path="passwordConfirm" class="form-control" /> <form:errors
															path="passwordConfirm" cssClass="error" /></td>
												</tr>
											</table>
											<input type="submit" class="btn btn-success" value="Update" />
										</div>
									</form:form>
								</div>
								<!-- parts -->
							</div>
							<!-- dparts -->
						</div>
						<!-- Center -->
					</div>
					<!-- Layout -->
					<div id="sideBanner">
						<%--
                            <form action="/member/changeLanguage" method="post"><label for="language_culture">言語</label>:
                                <select name="language[culture]" onchange="submit(this.form)" id="language_culture">
                                    <option value="en">English</option>
                                    <option value="ja_JP" selected="selected">日本語 (日本)</option>
                                </select><input value="member/registerInput" type="hidden" name="language[next_uri]" id="language_next_uri" /></form>
                            --%>
					</div>
					<!-- sideBanner -->
				</div>
				<!-- ContentsContainer -->
			</div>
			<!-- Contents -->
		</div>
		<!-- Container -->
		<c:import url="../include/footer.jsp"></c:import>
</body>
</html>
