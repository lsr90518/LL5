<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="userId"><shiro:principal property="id" /></c:set>
<!doctype html>
<html>
    <c:import url="../include/head.jsp">
        <c:param name="title" value="Related Objects" />
        <c:param name="javascript">
            <script type="text/javascript" src="<c:url value='/js/mediaelement/mediaelement-and-player.min.js' />"></script>
            <script type="text/javascript">
                $(function(){
                	$("video, audio").mediaelementplayer();
                });
            </script>
        </c:param>
        <c:param name="css">
            <link rel="stylesheet" type="text/css" media="screen" href="<c:url value="/js/jquery/stars/ui.stars.min.css"/>" />
            <link rel="stylesheet" type="text/css" media="screen" href="<c:url value='/js/mediaelement/mediaelementplayer.min.css' />" />
        </c:param>
    </c:import>
    <script type="text/javascript">
	$(document).ready(function() {

		document.getElementById("mylog").className = "active";

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
				<a class="btn-lg btn-block topBtn" style="text-align: center"
					onclick="history.go(-1);"><span
					class="glyphicon glyphicon-chevron-left navTab"></span></a>

			</div>
			<div class="col-xs-8 col-md-8" style="text-align: center;">
				<span class="titleSpan">Related Logs</span>
			</div>
			<div class="col-xs-2 col-md-2">
				<a class="btn-lg btn-block topBtn dropdown-toggle"
					style="text-align: center" href="#" id="dropdownMenu1"
					data-toggle="dropdown"> <span
					class="glyphicon glyphicon-align-right navTab"></span>
				</a>
				<ul class="dropdown-menu" role="menu"
					aria-labelledby="dropdownMenu1" style="left: auto; right: 0;">
					<li role="presentation"><a
						onclick="$('#itemRelogForm').submit();">Relog</a></li>
					<li role="presentation"><a onclick="javascript:post_result()">Share
							to Facebook</a></li>
					<li role="presentation"><a href="/LL5/item/${item.id}/related">Related
							Words</a></li>
					<c:if test="${item.author.id eq userId}">
						<li role="presentation"><a href="#"
							onclick="if(confirm('Delete it?'))$('#itemDeleteForm').submit()">Delete</a>
							<form:form id="itemDeleteForm" method="post"
								action="${itemresourcedelete}" /></li>
					</c:if>
				</ul>

			</div>


		</div>
	</div>
	<!-- /.container-fluid -->
</header>
<style type="text/css">
#Left {
	background-color: white;
	margin-left: 10px;
	margin-right: 10px;
	box-shadow: 0px 1px 1px 0px #888;
	border-radius: 1%;
}

.nicknameSpan {
	line-height: 40px;
}

.authorDiv {
	margin: 5px;
	padding-top: 10px;
}

.content-list {
	border: 0px;
}

.list-group-item {
	border: 0px;
}

.description-link {
	
}

.description-div {
	margin: 5px;
}

.panel-default>.panel-heading {
	color: #aaa;
	background-color: #fff;
	border-color: #ddd;
}

.panel-title>a {
	color: inherit;
	padding-right: 95%;
}

.panel-body {
	background-color: #F6f6f6;
	font-size: medium;
	color: #777
}

.operation-penal {
	border-top: 1px solid #ddd;
}

.operation-button {
	width: 100%
}

.operation-button>button {
	width: 25%;
	border: 0px;
	border-right: 1px dashed #ddd;
	height: 40px;
	color: steelblue;
}

.btn-group .btn+.btn,.btn-group .btn+.btn-group,.btn-group .btn-group+.btn,.btn-group .btn-group+.btn-group
	{
	margin-left: 0px;
}

.btn-group>.btn:last-child:not (:first-child ),.btn-group>.dropdown-toggle:not
	(:first-child ) {
	border-bottom-left-radius: 0;
	border-top-left-radius: 0;
	border-right: 0px;
}

#comment-div{
	background-color: white;
	margin:10px;
	box-shadow: 0px 1px 1px 0px #888;
	border-radius: 1%;
}

#comment-title {
border-bottom: 1px solid #ddd;
padding: 5px;
padding-left:10px;
background-color: #F7F7F7;
}

.comment-list{
  
}

.comment-object {
	padding: 10px;
	border-bottom: 1px solid #d6d6d6;
	box-shadow: 0px 1px 1px 0px #d1d1d1;
}

#commentArea{
	width: 100%;
	border: 0px;
	padding: 0px;
	margin: 0px;
}

.operation{
  text-align: right;
  margin-top: 10px;
}

body{
	padding-bottom:0px;
}
</style>

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
</style>
<body id="page_member_profile">
	<div id="Body">
		<div id="Container">
			<div id="Contents">
				<div id="ContentsContainer">
					<div id="localNav"></div>
					<!-- localNav -->
					<div id="LayoutA" class="Layout">
						<div id="Top"></div>
						<!-- Top -->
						<div id="Left">
							<div class="row authorDiv">
								<div class="list-group">
									<h5 class="list-group-item-heading">
										<div class="media">
											<img class="media-object pull-left" alt="LearningUser"
												src="${staticserverUrl}/${projectName}/${item.author.avatar.id}_320x240.png"
												width="30" />
											<h5 class="media-body media-heading">${item.author.nickname}</h5>
											<font color="#f0ad4e" size="1px"><fmt:formatDate
													type="both" pattern="yyyy/MM/dd HH:mm"
													value="${item.createTime}" /></font>
										</div>
									</h5>
								</div>
							</div>

							<!--                                   image                                     -->
							<div id="memberImageBox_30" class="parts memberImageBox"
								style="text-align: center">
								<c:choose>
									<c:when test="${fileType eq 'image'}">
										<p class="photo">
											<a id="itemImage" class="nyroModal" data-toggle="modal" data-target="#imageModal">
												<img alt=""
												src="${staticserverUrl}/${projectName}/${item.image.id}_320x240.png"
												width="100%" />
											</a>
										</p>
										<p class="text"></p>
									</c:when>
									<c:when test="${fileType eq 'video'}">
										<video id="itemvideo" width="240" height="100%"
											controls="controls" preload="none"
											poster="${staticserverUrl}/${projectName}/${item.image.id}_320x240.png">
											<source
												src="${staticserverUrl}/${projectName}/${item.image.id}_320x240.mp4"></source>
										</video>
									</c:when>
									<c:when test="${fileType eq 'audio'}">
										<audio controls="controls" style="width: 240">
											<source
												src="${staticserverUrl}/${projectName}/${item.image.id}.mp3"></source>
											<source
												src="${staticserverUrl}/${projectName}/${item.image.id}.ogg"></source>
										</audio>
									</c:when>
									<c:when test="${fileType eq 'pdf'}">
										<p class="photo">
											<a id="itemImage"
												href="${staticserverUrl}/${projectName}/${item.image.id}.pdf">
												<img alt=""
												src="${staticserverUrl}/${projectName}/${item.image.id}_320x240.png"
												width="100%" />
											</a>
										</p>
									</c:when>
									<c:otherwise>
										<!-- 					 no photo 					 
										<p class="photo">
											<img width="240px" alt=""
												src="<c:url value="/images/no_image.gif" />" />
										</p>-->
									</c:otherwise>
								</c:choose>
							</div>
							<!-- parts -->

							<!-- 									contents										 -->
							<ul class="list-group content-list">
								<c:forEach items="${item.titles}" var="title">
									<li class="list-group-item">
										<button class="badge"
											onclick="speak('${title.content}','${title.language.code}');return false;">
											${title.language.name}</button> &nbsp;<c:out value="${title.content}" />
									</li>
								</c:forEach>
							</ul>

							<!-- 									description											 -->
							<div class="panel-group" id="accordion">
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<a class="collapsed" data-toggle="collapse"
												data-parent="#accordion" href="#collapseOne">
												Description </a>
										</h4>
									</div>
									<div id="collapseOne" class="panel-collapse collapse">
										<div class="panel-body">
											${fn:replace(item.note,newLineChar,'<br />')}<br />
											<c:forEach items="${item.itemTags}" var="tag">
												<a
													href="<c:url value="/item"><c:param name="tag" value="${tag.tag}" /></c:url>">#${tag.tag}#</a> &nbsp;
                                                    </c:forEach>
										</div>
									</div>
								</div>
							</div>
							<!-- 									operation-penal											 -->

							<div class="operation-penal">
								<div class="btn-group operation-button">
									<button type="button" class="btn btn-default"
										onclick="$('#itemRelogForm').submit();">
										<i class="glyphicon glyphicon-share"></i>Relog
									</button>
									<button type="button" class="btn btn-default"
										data-toggle="modal" data-target="#mapModal">
										<i class="glyphicon glyphicon-map-marker"></i>Map
									</button>
									<button type="button" class="btn btn-default"
										data-toggle="modal" data-target="#rateModal">
										<i class="glyphicon glyphicon-star-empty"></i>Rate
									</button>
									<button type="button" class="btn btn-default"
										data-toggle="modal" data-target="#commentModal">
										<i class="glyphicon glyphicon-comment"></i>Comment
									</button>
								</div>

							</div>
						</div>
						<!-- Left -->
						
						<!-- 										comment list											 -->
						
							<c:if test="${fn:length(item.commentList)>0}">
								<div id="comment-div">
								    <div id="comment-title">
								      Comment(${fn:length(item.commentList)})
								    </div>
									<ul class="media-list comment-list" >
									  <c:forEach items="${item.commentList}" var="comment">
										  <li class="media comment-object">
										    <a class="pull-left" href="#">
										    	<c:choose>
													<c:when test="${empty comment.user.avatar}">
														<img class="media-object" alt="LearningUser"
															src="<c:url value="/images/no_image.gif" />" width="60"
															height="60" />
													</c:when>
													<c:otherwise>
														<img class="media-object" alt="LearningUser"
															src="<c:url value="/profile/${comment.user.id}/avatar" />"
															width="60" />
													</c:otherwise>
												</c:choose>
											</a>
										    <div class="media-body">
										      <h4 class="media-heading">${comment.user.nickname} &nbsp; (
														<fmt:formatDate value="${comment.createTime}" type="both"
															dateStyle="long" timeStyle="medium" />
														)</h4>
										      <c:out value="${comment.comment}" />
										    </div>
										  </li>
									  </c:forEach>
									</ul>
								</div>
							</c:if>
							
							<!-- image Modal -->
												
						<div class="modal fade" id="imageModal" tabindex="-1" role="dialog"
							aria-labelledby="myModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-body">
										
										<c:choose>
									<c:when test="${fileType eq 'image'}">
										<p class="photo">
												<img src="${staticserverUrl}/${projectName}/${item.image.id}_800x600.png" width="100%" />
										</p>
										<p class="text"></p>
									</c:when>
									<c:when test="${fileType eq 'video'}">
										<video id="itemvideo" width="240" height="100%"
											controls="controls" preload="none"
											poster="${staticserverUrl}/${projectName}/${item.image.id}_320x240.png">
											<source
												src="${staticserverUrl}/${projectName}/${item.image.id}_320x240.mp4"></source>
										</video>
									</c:when>
									<c:when test="${fileType eq 'audio'}">
										<audio controls="controls" style="width: 240">
											<source
												src="${staticserverUrl}/${projectName}/${item.image.id}.mp3"></source>
											<source
												src="${staticserverUrl}/${projectName}/${item.image.id}.ogg"></source>
										</audio>
									</c:when>
									<c:when test="${fileType eq 'pdf'}">
										<p class="photo">
											<a id="itemImage"
												href="${staticserverUrl}/${projectName}/${item.image.id}.pdf">
												<img alt=""
												src="${staticserverUrl}/${projectName}/${item.image.id}_320x240.png"
												width="100%" />
											</a>
										</p>
									</c:when>
									<c:otherwise>
										<!-- 					 no photo 					 
										<p class="photo">
											<img width="240px" alt=""
												src="<c:url value="/images/no_image.gif" />" />
										</p>-->
									</c:otherwise>
								</c:choose>
									</div>
								</div>
							</div>
						</div>						
						<!-- 												map modal										 -->
						<div class="modal fade" id="mapModal" tabindex="-1" role="dialog"
							aria-labelledby="myModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal">
											<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
										</button>
										<h4 class="modal-title" id="myModalLabel">Location</h4>
									</div>
									<div class="modal-body">
										<!-- map -->
										<c:if
											test="${!empty item.itemLat && !empty item.itemLng && !empty item.itemZoom}">
											<div id="mapbox" class="dparts nineTable">
												<div class="parts">
													<table>
														<tr>
															<td>
																<div id="map" style="height: 100%">
																	<img
																		src="http://maps.google.com/maps/api/staticmap?size=520x400&sensor=false&center=${item.itemLat},${item.itemLng}zoom=${item.itemZoom}&mobile=true&markers=${item.itemLat},${item.itemLng}"
																		width="100%" />
																</div>
															</td>
														</tr>
														<c:if test="${!empty item.place}">
															<tr>
																<td>Place：${item.place}</td>
															</tr>
														</c:if>
													</table>
												</div>
												<!-- parts -->
											</div>
											<!-- dparts -->
										</c:if>
									</div>
								</div>
							</div>
						</div>

						<!-- 									rate modal 													 -->

						<div class="modal fade" id="rateModal" tabindex="-1" role="dialog"
							aria-labelledby="myModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal">
											<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
										</button>
										<h4 class="modal-title" id="myModalLabel">Rate</h4>
									</div>
									<div class="modal-body">
										<form id="rat" action="" method="post">
											<select id="itemrating">
												<option value="1">Not so good</option>
												<option value="2">Good</option>
												<option value="3">Quite ggood</option>
												<option value="4">Great!</option>
												<option value="5">Excellent!</option>
											</select> <input type="submit" value="Rate it!" />
										</form>
									</div>
								</div>
							</div>
						</div>

						<!-- 									comment modal 													 -->

						<div class="modal fade" id="commentModal" tabindex="-1"
							role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal">
											<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
										</button>
										<h4 class="modal-title" id="myModalLabel">Comment</h4>
									</div>
									<div class="modal-body">
										<form action="<c:url value="/item/${item.id}/comment" />"
											method="post">
											<textarea id="commentArea" cols="80" rows="4" name="comment" placeholder="..."></textarea>
											<hr/>
											<input class="form-control input-sm" type="text" name="tag" placeholder="tags">
											
											<div class="operation">
												<input type="submit" value="Comment" class="btn btn-success btn-sm">
											</div>
										</form>
									</div>
								</div>
							</div>
						</div>

						<c:url value="/item/${item.id}/delete" var="itemresourcedelete" />
						<form:form id="itemDeleteForm" method="post"
							action="${itemresourcedelete}" />
						<c:url value="/item/${item.id}/relog" var="relogUrl" />
						<form:form id="itemRelogForm" method="post" action="${relogUrl}" />
						<c:url value="/item/${item.id}/teacherconfirm"
							var="teacherConfirmUrl" />
						<form:form id="teacherConfirmForm" action="${teacherConfirmUrl}"
							method="post" />
						<c:url value="/item/${item.id}/teacherreject"
							var="teacherRejectUrl" />
						<form:form id="teacherRejectForm" action="${teacherRejectUrl}"
							method="post" />
						<c:url value="/item/${item.id}/teacherdelcfmstatus"
							var="teacherDelCfmUrl" />
						<form:form id="teacherDelCfmStatusForm"
							action="${teacherDelCfmUrl}" method="post" />
                            
                            
                            
                            <!--                                       related words                                   -->
                            <div id="Center">
                                <div class="dparts searchResultList"><div class="parts">
                                        
                                        <div class="block">
                                            <c:forEach items="${relatedItemList.result}" var="item">
                                            	<c:set var="privateFlg" value="false" />
                                            	<c:if test="${item.shareLevel=='PRIVATE' && userId!=item.author.id}">
                                            		<c:set var="privateFlg" value="true" />
                                            	</c:if>
                                                <div class="list-group">
                                                    <a href="<c:url value="/item/${item.id}" />" class="list-group-item">
                                                    
                                                    <h5 class="list-group-item-heading">
													    <div class="media">
														    <img class="media-object pull-left" alt="LearningUser" src="${staticserverUrl}/${projectName}/${item.author.avatar.id}_320x240.png" width="30" />
														    <h5 class="media-body media-heading">${item.author.nickname}</h5>
														    <font color="#f0ad4e" size="1px"><fmt:formatDate type="both" pattern="yyyy/MM/dd HH:mm" value="${item.createTime}" /></font>
														</div>
												    	
												    </h5>
												    
												    <p class="list-group-item-text">
														<c:choose>
															<c:when test="${empty item.titles}">NO NAME</c:when>
															<c:otherwise>
																		<c:forEach items="${item.titles}" var="title">${title.content}|
																		</c:forEach>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${!privateFlg}">
																<c:choose>
																	<c:when test="${empty item.image}">
																		
																	</c:when>
																	<c:otherwise>
																		<img class="media-object"
																			src="${staticserverUrl}/${projectName}/${item.image.id}_160x120.png" />
																	</c:otherwise>
																</c:choose>
																<br />
															</c:when>
															<c:otherwise>
																<img class="media-object"
																	src="<c:url value="/images/locked.png" />" title="Private" />Details<img alt="photo" src="<c:url value="/images/icon_camera.gif" />" />
															</c:otherwise>
														</c:choose>
														<!--<img class="media-object"  src="http://ll.is.tokushima-u.ac.jp/static/learninglog/ff808181445a3687014490b6d8c34162_160x120.png">-->
													
												  </p>
                                                    </a>
                                                </div>
                                            </c:forEach>
                                        </div>
                                        
                                        <div class="pagerRelative">
											${pageLinks}
											<p class="number"><!--7件中 1～7件目を表示--></p>
                                        </div>
                                    </div></div>
                            </div><!-- Center -->
                            <div class="block">
                            </div>
                            <div id="sideBanner">
                            </div><!-- sideBanner -->
                        </div><!-- ContentsContainer -->
                    </div><!-- Contents -->
                </div><!-- Container -->
            </div><!-- Body -->
        </div>
        
        <c:import url="../include/footer.jsp"></c:import>
    </body>
</html>