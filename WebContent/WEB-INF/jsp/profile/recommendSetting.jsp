<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<!doctype html>
<html>
<c:import url="../include/head.jsp">
	<c:param name="title" value="Profile" />
</c:import>
<script type="text/javascript">
	$(document).ready(function() {

		document.getElementById("setting").className = "active";

	});
</script>
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
					<li role="presentation" id="default_settings"><a
						role="menuitem" tabindex="-1" href="<c:url value="/category" />">Category</a></li>
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
<body>
	<div class="container">
		<form action="<c:url value="/recommendSetting/setuserinfo" />" method="get">
			<div class="form-group">
				<label class="control-label" for="inputSuccess1">Native
					Language</label>
				<c:forEach items="${user.myLangs}" var="myLan" varStatus="lan">
					<input name="" disabled type="text" class="form-control"
						value="${myLan.name}" />
					<input name="natilanguage" type="hidden" class="form-control"
						value="${myLan.name}" />
				</c:forEach>
			</div>
			<div class="form-group">
				<label class="control-label" for="inputSuccess1">gender</label> 
				<select name="gender"
					class="form-control">
					<option>${gender}</option>
					<option>female</option>
				</select>
			</div>
			<div class="form-group">
				<label class="control-label" for="inputSuccess1">JLPT Level</label>
				<select name="jlpt" class="form-control">
					<option>${jlpt}</option>
					<option>n4</option>
					<option>n3</option>
					<option>n2</option>
					<option>n1</option>
				</select>
			</div>
			<div class="form-group">
				<label class="control-label" for="inputSuccess1">month</label> 
				<select name="month"
					class="form-control">
					<option>${month}</option>
					<option>2</option>
					<option>3</option>
					<option>4</option>
					<option>5</option>
				</select>
			</div>
			<div class="form-group">
				<label class="control-label" for="inputSuccess1">major</label> 
				<select name="major"
					class="form-control">
					<option>${major}</option>
					<option>Computer sciences</option>
					<option>Life and Culture</option>
					<option>Education</option>
					<option>Social Science</option>
					<option>Human Science</option>
					<option>Technologies/ Engineering</option>
					<option>Natural Science</option>
				</select>
			</div>
			<div>
				<input type="submit" class="btn btn-block btn-success" value="Submit" />
			</div>
		</form>
	</div>
</body>
</html>