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
				<span class="titleSpan">Profile</span>
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
<style type="text/css">
.hero {
	background-color: #555;
	text-align: center;
}

.hero-block {
	padding-top: 5%;
	padding-bottom: 3%;
}

.hero-block h3 {
	color: white;
}
.exp-block{
	background-color: white;
}
.exp-tab{
	text-align: center;
	font-size:15px;
	color:#f0ad4e;
	padding-top:5px;
	padding-bottom:5px;
}

.bs-callout {
margin: 10px 0;
padding: 5px 5px 5px 20px;
border-left: 3px solid #eee;
background-color: #f4f8fa;
border-color: #5bc0de;
}

.bs-callout h4{
color: #5bc0de;
}
.row {
margin-left: 0px;
margin-right: 0px;
}

</style>
<body id="page_member_home">

	<div class="container">
		<div class="hero">
			<div class="hero-block">
				<c:choose>
					<c:when test="${empty user.avatar}">
						<a href=" <c:url value="/profile/avataredit"/>"><img class="img-thumbnail" alt="LearningUser"
							src="<c:url value="/images/no_image.gif" />" height="80"
							width="80" /></a>
					</c:when>
					<c:otherwise>
						<a href=" <c:url value="/profile/avataredit"/>"><img class="img-thumbnail" alt="LearningUser"
							src="<c:url value="${staticserverUrl}/${projectName}/${user.avatar.id}_320x240.png" />"
							height="80" /></a>
					</c:otherwise>
				</c:choose>
				<h3>${user.nickname}</h3>
			</div>
		</div><!-- hero -->
		
		<div class="row exp-block">
			<div class=" exp-tab col-xs-4">Level<br/>${user.userLevel}</div>
			<div class="exp-tab col-xs-4">EXP<br/>${nowExperiencePoint}</div>
			<div class="exp-tab col-xs-4">Next<br/>${nextExperiencePoint}</div>
		</div>
		
		<div class="profile-list">
			<div class="bs-callout">
				<h4>Email</h4>
				<p>${user.pcEmail}</p>
			</div>
		</div>
		<div class="profile-list">
			<div class="bs-callout">
				<h4>Nickname</h4>
				<p>${user.nickname}</p>
			</div>
		</div>
		<div class="profile-list">
			<div class="bs-callout">
				<h4>FirstName</h4>
				<p>${user.firstName}</p>
			</div>
		</div>
		<div class="profile-list">
			<div class="bs-callout">
				<h4>Given Name</h4>
				<p>${user.lastName}</p>
			</div>
		</div>
		<div class="profile-list">
			<div class="bs-callout">
				<h4>Interests</h4>
				<p>${form.interesting}</p>
			</div>
		</div>
		<div class="profile-list">
			<div class="bs-callout">
				<h4>
					Native Language
				</h4>
				<p><c:forEach items="${user.myLangs}" var="myLan" varStatus="lan">
					${myLan.name}
					</c:forEach></p>
			</div>
		</div>
		<div class="profile-list">
			<div class="bs-callout">
				<h4>Language of study(${status.count})</h4>
				<p><c:forEach items="${user.studyLangs}" var="slan"
										varStatus="status">
										${slan.name}
									</c:forEach></p>
			</div>
		</div>
		<div class="profile-list">
			<div class="bs-callout">
				<h4>Categories</h4>
				<p><ul><c:forEach items="${user.myCategoryList}" var="cat">
													<li <c:if test="${user.defaultCategory!=null && user.defaultCategory.id==cat.id}">style="font-weight:bold"</c:if>>
														${cat.name}</li>
												</c:forEach></ul></p>
			</div>
		</div>
		
	</div>

	<div id="Body">
		<div id="Container">
			<div id="Contents">
				<div id="ContentsContainer">
					<div id="LayoutA" class="Layout">
						<div id="Top">
							<div id="information_21" class="parts informationBox">
								<div class="body"></div>
							</div>
							<!-- parts -->
						</div>
						<!-- Left 
						<div id="Center">
							<div class="navbar navbar-inner" style="position: static;">
								<div class="navbar-primary">
									<h3
										style="font-size: 14px; font-weight: bolder; line-height: 150%">Profile</h3>
									&nbsp;<a href="<c:url value="/profile/edit" />">Edit</a>
								</div>
							</div>
							<div class="parts">
								<c:url value="/signup/${user.activecode}" var="signupFormUrl" />
								<table>
									<tr>
										<th><label for="pcEmail">Email</label></th>
										<td>${user.pcEmail}</td>
									</tr>
									<tr>
										<th><label for="nickname">Nickname</label></th>
										<td>${user.nickname}</td>
									</tr>
									<tr>
										<th><label for="firstName">Family Name</label></th>
										<td>${user.firstName}</td>
									</tr>
									<tr>
										<th><label for="lastName">Given Name</label></th>
										<td>${user.lastName}</td>
									</tr>
									<tr>
										<th><label for="interesting">Interests</label></th>
										<td>${form.interesting}</td>
									</tr>
									<c:forEach items="${user.myLangs}" var="myLan" varStatus="lan">
										<tr>
											<th>Native language(${lan.count})</th>
											<td>${myLan.name}</td>
										</tr>
									</c:forEach>
									<c:forEach items="${user.studyLangs}" var="slan"
										varStatus="status">
										<tr>
											<th><label>Language of study(${status.count})</label></th>
											<td>${slan.name}</td>
										</tr>
									</c:forEach>
									<tr>
										<th><label>Categories</label></th>
										<td>
											<ul>
												<c:forEach items="${user.myCategoryList}" var="cat">
													<li
														<c:if test="${user.defaultCategory!=null && user.defaultCategory.id==cat.id}">style="font-weight:bold"</c:if>>
														${cat.name}</li>
												</c:forEach>
											</ul>
										</td>
									</tr>
								</table>
							</div>
							
						</div>-->
						<!-- Center -->
					</div>
					<!-- Layout -->
				</div>
				<!-- Contents -->
			</div>
		</div>
		<!-- Container -->
	</div>
	<!-- Body -->
	<style type="text/css">
.activeTab {
	color: #f0ad4e;
	font-size: 27px;
}

.notActiveTab {
	color: #999;
	font-size: 27px;
}

.homeTab {
	color: white;
	font-size: 25px;
}
</style>
	<nav class="navbar navbar-default navbar-fixed-bottom"
		role="navigation" style="height: 2%">
		<!-- We use the fluid option here to avoid overriding the fixed width of a normal container within the narrow content columns. -->
		<div class="container-fluid">
			<div class="row">
				<div class="col-xs-2 col-md-2">
					<a class="btn-lg btn-block" style="text-align: center" href="#"><span
						class="glyphicon glyphicon-map-marker notActiveTab navTab"></span></a>
				</div>
				<div class="col-xs-2 col-md-2">
					<a class="btn-lg btn-block" style="text-align: center"
						href="/LL5/task"><span
						class="glyphicon glyphicon-tasks notActiveTab navTab"></span></a>
				</div>
				<div class="col-xs-4 col-md-4">
					<a class="btn-lg btn-block"
						style="text-align: center; background-color: #e67e22;"
						href="/LL5/item"><span
						class="glyphicon glyphicon-home notActiveTab homeTab navTab"></span></a>
				</div>
				<div class="col-xs-2 col-md-2">
					<a class="btn-lg btn-block" style="text-align: center" href="/LL5/quiz"><span
						class="glyphicon glyphicon-th-large notActiveTab navTab"></span></a>
				</div>
				<div class="col-xs-2 col-md-2">
					<a class="btn-lg btn-block" style="text-align: center"
						href="/LL5/profile"><span
						class="glyphicon glyphicon-user notActiveTab navTab"></span></a>
				</div>
			</div>
		</div>
	</nav>
</body>
</html>
