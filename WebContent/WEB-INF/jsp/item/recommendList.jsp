<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="userId">
	<shiro:principal property="id" />
</c:set>
<!doctype html>
<c:import var="pageLinks" url="itempage.jsp">
	<c:param name="searchCond" value="${searchCond}" />
	<c:param name="page" value="${page}" />
</c:import>
<html>

<c:import url="../include/head.jsp">
	<c:param name="title" value="All Logs" />
	<c:param name="css">
		<style type="text/css">
#itemSearchFormLine th {
	border: none;
}

#itemSearchFormLine td {
	border: none;
}
</style>
	</c:param>


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
<script type="text/javascript">
	$(document).ready(function() {

		document.getElementById("alllog").className = "active";

	});
</script>
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
					<li role="presentation"><a role="menuitem" tabindex="-1"
						href="/LL5/item">All Logs</a></li>
					<li role="presentation"><a role="menuitem" tabindex="-1"
						href="/LL5/item?username=${user.nickname}">My Logs</a></li>
					<c:if test="${msg!='0'}">
						<li role="presentation"><a role="menuitem" tabindex="-1"
							href="/LL5/recommend/${user.nickname}/getSuggestion">Recommend
								Logs</a></li>
					</c:if>
				</ul>
			</div>
			<div class="col-xs-8 col-md-8" style="text-align: center;">
				<span class="titleSpan">Recommend Logs</span>
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

<body id="page_diary_list">
	<div id="Body">
		<div id="Container">
			<!-- Nav tabs -->
			<div class="row">
				<div class="col-xs-12">
					<ul class="nav nav-tabs">
						<li class="active" style="width:50%;text-align: center"><a  href="#home" data-toggle="tab">Logs</a></li>
						<li style="width:50%;text-align: center" ><a href="#profile" data-toggle="tab">Learner</a></li>
					</ul>
				</div>
			</div>

			<!-- Tab panes -->
			<div class="tab-content">
				<div class="tab-pane active" id="home">
					<div class="listBlock">
						<div class="list-group">
							<c:forEach items="${similarContents}" var="item">
								<a href="/LL5/item/${item.item_id}" class="list-group-item" style="margin-bottom: 5px;width:100%;float:left;line-height:64px"> 
								<img class="media-object pull-left" src="${staticserverUrl}/${projectName}/${item.image}_160x120.png" height="64" />
								${item.en_title}　/　${item.jp_title}</a>
							</c:forEach>
						</div>
					</div>
				</div>
				<div class="tab-pane" id="profile">
					<div class="listBlock">
						<div class="listBlock">
							<div class="list-group">
								<c:forEach items="${similarNickname}" var="similarNickname">
									<a href="/LL5/item?username=${similarNickname}" class="list-group-item" style="margin-bottom: 5px"　> ${similarNickname}</a>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
		<!-- Contents -->
	</div>
	<!-- Container -->
	</div>
	<!-- Body -->
	<style type="text/css">
				.activeTab{
					color: #f0ad4e;
					font-size:27px;
				}
				.notActiveTab{
					color:#999;
					font-size:27px;
				}
				.homeTab{
					color:white;
					font-size:25px;
				}
			</style>
<nav class="navbar navbar-default navbar-fixed-bottom" role="navigation" style="height:2%">
      <!-- We use the fluid option here to avoid overriding the fixed width of a normal container within the narrow content columns. -->
      <div class="container-fluid">
		<div class="row">
		  <div class="col-xs-2 col-md-2"><a class="btn-lg btn-block" style="text-align:center" href="#"><span class="glyphicon glyphicon-map-marker notActiveTab navTab"></span></a></div>
		  <div class="col-xs-2 col-md-2"><a class="btn-lg btn-block" style="text-align:center" href="/LL5/task"><span class="glyphicon glyphicon-tasks notActiveTab navTab"></span></a></div>
		  <div class="col-xs-4 col-md-4"><a class="btn-lg btn-block" style="text-align:center;background-color:#e67e22;" href="/LL5/item"><span class="glyphicon glyphicon-home notActiveTab homeTab navTab"></span></a></div>
		  <div class="col-xs-2 col-md-2"><a class="btn-lg btn-block" style="text-align:center" href="/LL5/quiz"><span class="glyphicon glyphicon-th-large notActiveTab navTab"></span></a></div>
		  <div class="col-xs-2 col-md-2"><a class="btn-lg btn-block" style="text-align:center" href="/LL5/profile"><span class="glyphicon glyphicon-user notActiveTab navTab"></span></a></div>
		</div>	
      </div>
    </nav>
</body>
</html>
