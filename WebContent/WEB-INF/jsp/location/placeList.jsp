<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="userId">
	<shiro:principal property="id" />
</c:set>
<html>

    <c:import url="../include/head.jsp">
        <c:param name="title" value="All Logs" />
        <c:param name="css">
            <style type="text/css">
                #itemSearchFormLine th{border:none;}
                #itemSearchFormLine td{border:none;}
            </style>
        </c:param>
        
        
    </c:import>
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
    <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
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
	margin-left: 5px;
	margin-right: 5px;
	box-shadow: 0px 1px 1px 0px #ccc;
	border-radius: 2%;
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

.btn-pager{
	color: gray;
	
}
.icon-img {
	height:35px;
}
.list-group>a{
	margin-bottom:5px;
	box-shadow:0px 1px 3px 0px #888;
}
.place-name{
	font-weight:bolder;
}
.type-span{
	font-size: 15px;
	color:#aaa;
}
</style>
    <script type="text/javascript">
	$(document).ready(function() {

		document.getElementById("alllog").className = "active";
		
		
		
	});
</script>

<body>
<header class="navbar navbar-default navbar-fixed-top topNav" role="navigation">
				  <div class="container topNav">
				    <!-- Brand and toggle get grouped for better mobile display -->
				    <div class="row">
				    	<div class="col-xs-2 col-md-2">
					  	<a class="btn-lg btn-block topBtn dropdown-toggle" style="text-align:center" href="#"  id="dropdownMenu1" data-toggle="dropdown">
					  		<span class="glyphicon glyphicon-th-list navTab"></span>
					  	</a>
					  	<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
						    <li role="presentation"><a role="menuitem" tabindex="-1" href="/LL5/item">All Logs</a></li>
						    <li role="presentation"><a role="menuitem" tabindex="-1" href="/LL5/item?username=${user.nickname}">My Logs</a></li>
						    <c:if test="${msg!='0'}">
						    <li role="presentation"><a role="menuitem" tabindex="-1" href="/LL5/recommend/${user.nickname}/getSuggestion">Recommend Logs</a></li>
						    </c:if>
						  </ul>
					  </div>
					  <div class="col-xs-8 col-md-8" style="text-align: center;"><span class="titleSpan">Log Lists</span></div>
					  <div class="col-xs-2 col-md-2"><a class="btn-lg btn-block topBtn" style="text-align:center" href="/LL5/item/add"><span class="glyphicon glyphicon-pencil navTab"></span></a></div>
					  
					  
					</div>
				  </div><!-- /.container-fluid -->
				</header>
	<div class="list-group">
		<c:forEach items="${results}" var="result">
		 	 <a href="#" class="list-group-item placeItem">
		 	 	<img class="icon-img" src="${result.icon}" alt="...">
		 	 	<span class="place-name">${result.name}</span><br/>
		 	 	<span class="type-span"><c:forEach items="${result.types}" var="type">${type},</c:forEach></span>
		 	 	<input type="hidden" class="location-input" value="${result.geometry.location.lat},${result.geometry.location.lng}" />
		 	 </a>
		</c:forEach>	
	</div>
	
	<script type="text/javascript">
		$(document).ready(function(){
			$(".placeItem").click(function(){
				$(this).children().each(function(){
					console.log($(this));
				});
			});
		});
	</script>
</body>
</html>