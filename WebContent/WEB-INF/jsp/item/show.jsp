<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="userId">
	<shiro:principal property="id" />
</c:set>
<!doctype html>
<html>

<c:import url="../include/head.jsp">
	<c:param name="title" value="オブジェクト" />
	<c:param name="javascript">
		<script
			src="<c:url value="/js/jQuery.jPlayer.2.0.0/jquery.jplayer.min.js" />"></script>
		<script src="<c:url value="/js/jquery/jquery.linkify-1.0-min.js"/>"></script>
		<script
			src="<c:url value='/js/mediaelement/mediaelement-and-player.min.js' />"></script>
		<script type="text/javascript"
			src="http://connect.facebook.net/en_US/all.js"></script>
		<script>
                $(function(){
                	$("video, audio").mediaelementplayer();
                    $(".description").linkify();
                });

                function speak(title, lang){
                	$("#ttsTitleArea").html("<div id=\"ttsTitle\"></div>");
                	$('#ttsTitle').jPlayer({
                		ready:function(){
                        	$('#ttsTitle').jPlayer("setMedia", {
            					mp3: "<c:url value="/api/translate/tts" />?ie=UTF-8&lang="+lang+"&text="+encodeURIComponent(title)
            				}).jPlayer("play");
                		},
                		ended: function(){
                			$("#ttsTitle").jPlayer("destroy");
                			$("#ttsTitleArea").html("");
                		},
                		swfPath:"<c:url value="/js/jQuery.jPlayer.2.0.0" />",
                		supplied: "mp3"
                	});
                }
            </script>
		<script
			src="<c:url value="/js/jquery/stars/jquery.ui.stars.min.js" />"></script>
		<script>
                <c:choose>
                    <c:when test="${ratingExist}">
                        $(function(){
                            $("#rat").children().not("select, #messages").hide();
                            $("#rating_title").text("Rating");
                            var $caption = $('<div id="caption"/>');
                            $("#rat").stars({
                                inputType: "select",
                                cancelShow: false,
                                disabled: true
                            });
                            $("#rat").stars("select", Math.round(${avg}));
                            var $caption = $('<div id="caption"/>');
                            $caption.text(" (" + ${votes} + " votes; " + ${avg} + ")");
                            $caption.appendTo("#rat");
                        });
                    </c:when>
                    <c:otherwise>
                        $(function(){
                            $("#rat").children().not("select, #messages").hide();
                            var $caption = $('<div id="caption"/>');
                            $("#rat").stars({
                                inputType: "select",
                                cancelShow: false,
                                captionEI: $("#caption"),
                                oneVoteOnly: true,
                                callback: function(ui,type,value){
                                    ui.disable();
                                    $("#messages").text("Saving...").stop().css("opacity", 1).fadeIn(30);

                                    $.post("<c:url value="/itemrating/${item.id}?format=json" />", {rate: value}, function(json){
                                        $("#rating_title").text("Rating");
                                        ui.select(Math.round(json.avg));
                                        $caption.text(" (" + json.votes + " votes; " + json.avg + ")");
                                        $("#messages").text("Rating saved (" + value + "). Thanks!").stop().css("opacity", 1).fadeIn(30);
                                        setTimeout(function(){
                                            $("#messages").fadeOut(1000);
                                        }, 2000);
                                    }, "json");
                                }
                            });
                            $("#rat").stars("selectID", -1);
                            $caption.appendTo("#rat");
                            $('<div id="messages"/>').appendTo("#rat");
                        });
                    </c:otherwise>
                </c:choose>
            </script>
		<script src="${baseURL}/js/jquery/jquery.nyroModal.custom.min.js"></script>
		<!--[if IE 6]>
				<script type="text/javascript" src="${baseURL}/js/jquery/jquery.nyroModal-ie6.min.js"></script>
			<![endif]-->
		<script>
	            $(function() {
	            	  function preloadImg(image) {
	            	    var img = new Image();
	            	    img.src = image;
	            	  }

	            	  preloadImg('${baseURL}/images/ajaxLoader.gif');
	            	  preloadImg('${baseURL}/images/prev.gif');
	            	  preloadImg('${baseURL}/images/next.gif');
	            	  preloadImg('${baseURL}/images/close.gif');
	            	  $('.nyroModal').nyroModal();
            	});
            </script>


		<!-- facebook post -->
		<script type="text/javascript">
FB.init({
appId:'338738616232992', cookie:true,
status:true, xfbml:true, oauth:true
});

function post_result(element_id) {
    FB.login(function(res) {
        if (res.session || res.authResponse) {
            var area = document.getElementById(element_id);
            FB.api('/me/feed', 'post', {
                message: '${item.defaultTitle} について学習しました。',
                source: 'http://ll.is.tokushima-u.ac.jp/learninglog/images/favicon.png',
                caption: 'SCROLLは日常生活で学習したことを記録・共有して更なる学習に役立てます。',
                link: 'http://ll.is.tokushima-u.ac.jp/learninglog/item/${item.id}',
                name: 'SCROLL - ${item.defaultTitle}'
            }, function(response) {
              if (!response || response.error) {
                alert('投稿できませんでした。 ' + response.error.message);
              } else {
                alert('投稿しました。 Post ID: ' + response.id);
              }
            });
        }
    }, { scope: 'publish_stream' })
}
</script>


	</c:param>
	<c:param name="css">
		<link rel="stylesheet" type="text/css" media="screen"
			href="${baseURL}/js/jquery/stars/jquery.ui.stars.min.css" />
		<link rel="stylesheet" type="text/css" media="screen"
			href="${baseURL}/js/mediaelement/mediaelementplayer.min.css" />
		<link rel="stylesheet" type="text/css" media="screen"
			href="${baseURL}/css/nyroModal.css" />
	</c:param>
</c:import>
<script type="text/javascript">
	$(document).ready(function() {

		document.getElementById("alllog").className = "active";

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
				<span class="titleSpan">Log Lists</span>
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

						<!--<c:url value="/item/${item.id}/delete" var="itemresourcedelete" />
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
						<div id="Center">
							<div class="specialop">
								<fieldset>
									<legend>Teacher Operations</legend>
									<div class="operation">
										<ul class="moreInfo button">
											<c:if test="${item.author.id != userId}">
												<c:choose>
													<c:when
														test="${item.teacherConfirm!=null && !item.teacherConfirm}">
														<li><button class="input_submit"
																onclick="$('#teacherConfirmForm').submit();">Confirm</button></li>
														<li><button class="input_submit"
																onclick="$('#teacherDelCfmStatusForm').submit();">Delete
																Status</button></li>
													</c:when>
													<c:when
														test="${item.teacherConfirm!=null && item.teacherConfirm}">
														<li><button class="input_submit"
																onclick="$('#teacherRejectForm').submit();">Corrections
																needed</button></li>
														<li><button class="input_submit"
																onclick="$('#teacherDelCfmStatusForm').submit();">Delete
																Status</button></li>
													</c:when>
													<c:otherwise>
														<li><button class="input_submit"
																onclick="$('#teacherConfirmForm').submit();">Confirm</button></li>
														<li><button class="input_submit"
																onclick="$('#teacherRejectForm').submit();">Corrections
																needed</button></li>
													</c:otherwise>
												</c:choose>
											</c:if>
											<shiro:hasRole name="admin">
												<li><button class="input_submit"
														onclick="location.href='<c:url value="/item/${item.id}/edit" />'">Edit</button></li>
												<li><button class="input_submit"
														onclick="if(confirm('Delete it?'))$('#itemDeleteForm').submit()">Delete</button></li>
											</shiro:hasRole>
										</ul>
									</div>
								</fieldset>
							</div>
							<div id="profile" class="dparts listBox">
								<div class="parts">
									<div class="navbar navbar-inner" style="position: static;">
										<div class="navbar-primary">
											<h3
												style="font-size: 14px; font-weight: bolder; line-height: 150%">Information</h3>
											<c:if test="${item.author.id eq userId}">
												<c:if test="${item.relogItem==null}">
                                                    &nbsp;<a
														href="<c:url value="/item/${item.id}/edit" />">Edit</a>
												</c:if>
                                                &nbsp;<a href="#"
													onclick="if(confirm('Delete it?'))$('#itemDeleteForm').submit()">Delete</a>
                                                &nbsp;<button
													onclick="javascript:post_result()"
													style="background: none; border: 0">
													<IMG src="<c:url value="/images/fb.png"/>" width="90"
														height="30" border="0">
												</button>
											</c:if>
										</div>
									</div>
									<c:if test="${relogable}">
										<div
											style="position: relative; float: right; top: -40px; right: 150px;">
											<input style="position: absolute" type="image"
												src="<c:url value="/images/relog-icon.png" />"
												onclick="$('#itemRelogForm').submit();" />
										</div>
									</c:if>
									<c:if test="${categoryPath!=null}">
										<div style="font-weight: bold; color: gray">
											Top
											<c:forEach items="${categoryPath}" var="cat">
                                           		&gt;&nbsp;${cat.name}
                                           	</c:forEach>
										</div>
									</c:if>
									<table>
										<c:if test="${item.teacherConfirm!=null}">
											<tr>
												<th></th>
												<td><c:choose>
														<c:when test="${item.teacherConfirm}">
															<span
																style="color: green; font-size: 16px; font-weight: bolder">Teacher
																Confirmed</span>
														</c:when>
														<c:otherwise>
															<span
																style="color: red; font-size: 16px; font-weight: bolder">Corrections
																needed</span>
														</c:otherwise>
													</c:choose></td>
											</tr>
										</c:if>
										<tr>
											<th id="rating_title">Rate this</th>
											<td><span id="caption"></span>
												<form id="rat" action="" method="post">
													<select id="itemrating">
														<option value="1">Not so good</option>
														<option value="2">Good</option>
														<option value="3">Quite ggood</option>
														<option value="4">Great!</option>
														<option value="5">Excellent!</option>
													</select> <input type="submit" value="Rate it!" />
												</form></td>
										</tr>
										<c:if test="${itemState != nulll}">
											<tr>
												<th id="exper_title">States</th>
												<td><c:if test="${itemState.experState == 1 }">
														<img class="tooltip" title="experienced"
															src="<c:url value="/images/experienced.png" />"
															width="30px" />
													</c:if> <c:if test="${itemState.rememberState == 1 }">
														<img class="tooltip" title="remembered"
															src="<c:url value="/images/remembered.png" />"
															width="30px" />
													</c:if></td>
											</tr>
										</c:if>
										<tr>
											<th style="width: 150px">Title</th>
											<td>
												<div id="ttsTitleArea" style="height: 0; width: 0"></div>
												<table>
													<c:forEach items="${item.titles}" var="title">
														<tr>
															<td style="width: 70px;">${title.language.name}</td>
															<td><button
																	onclick="speak('${title.content}','${title.language.code}');return false;">
																	<img src="<c:url value='/images/speaker.png' />" />
																</button>&nbsp;<c:out value="${title.content}" /></td>
														</tr>
													</c:forEach>
												</table>
											</td>
										</tr>
										<tr>
											<th>Description</th>
											<% pageContext.setAttribute("newLineChar", "\n");%>
											<td class="description">
												${fn:replace(item.note,newLineChar,'<br />')}</td>
										</tr>
										<c:if
											test="${!empty item.barcode || !empty item.qrcode || !empty item.rfid}">
											<tr>
												<th><label for="tag1">ID</label></th>
												<td>
													<table>
														<c:if test="${!empty item.barcode}">
															<tr>
																<td style="width: 70px;">Barcode</td>
																<td>${item.barcode}</td>
															</tr>
														</c:if>
														<c:if test="${!empty item.qrcode}">
															<tr>
																<td>QR Code</td>
																<td><c:if test="${!empty item.qrcode}">
																		<img
																			src="http://chart.apis.google.com/chart?cht=qr&chs=120x120&chl=${systemUrl}/instant/item?qrcode=${item.qrcode}" />
																	</c:if></td>
															</tr>
														</c:if>
														<c:if test="${!empty item.rfid}">
															<tr>
																<td>RFID</td>
																<td>${item.rfid}</td>
															</tr>
														</c:if>
													</table>
												</td>
											</tr>
										</c:if>
										<tr>
											<th>Author</th>
											<td><c:choose>
													<c:when test="${empty item.relogItem}">
														<a class="userlink" data-uid="${item.author.id}"
															data-uname="${item.author.nickname}"
															href="<c:url value="/item"><c:param name="username" value="${item.author.nickname}" /></c:url>"><c:out
																value="${item.author.nickname}" /></a>
													</c:when>
													<c:otherwise>
														<a href="<c:url value="/item/${item.relogItem.id}" />">ReLog</a> from <a
															href="<c:url value="/item"><c:param name="username" value="${item.relogItem.author.nickname}" /></c:url>"><c:out
																value="${item.relogItem.author.nickname}" /></a>
													</c:otherwise>
												</c:choose></td>
										</tr>
										<tr>
											<th>Created</th>
											<td><fmt:formatDate type="both"
													pattern="yyyy/MM/dd HH:mm" value="${item.createTime}" /></td>
										</tr>
										<tr>
											<th>Updated</th>
											<td><fmt:formatDate type="both"
													pattern="yyyy/MM/dd HH:mm" value="${item.updateTime}" /></td>
										</tr>
										<tr>
											<th>Tags</th>
											<td><c:forEach items="${item.itemTags}" var="tag">
													<a
														href="<c:url value="/item"><c:param name="tag" value="${tag.tag}" /></c:url>">${tag.tag}</a> &nbsp;
                                                    </c:forEach></td>
										</tr>
									</table>
								</div>
							</div>
							<!-- dparts 
							<c:if test="${!empty item.question}">
								<c:url value="/item/${item.id}/questionconfirm"
									var="questionConfirmUrl" />
								<form action="${questionConfirmUrl}" method="post"
									id="questionConfirmForm"></form>
								<div class="dparts homeRecentList">
									<div class="parts">
										<div class="partsHeading">
											<h3>Question</h3>
											<c:if
												test="${item.questionResolved !=null && item.questionResolved}">
                                                    &nbsp;<span
													style="color: red; font-weight: bold">(Resolved)</span>
											</c:if>
											<c:if
												test="${item.author.id == userId && item.question!=null && (item.questionResolved==null || item.questionResolved == false) && item.question.answerSet!=null && fn:length(item.question.answerSet)>0}">
												<button onclick="$('#questionConfirmForm').submit();">Confirm</button>
											</c:if>
										</div>
										<div class="block">
											<form action="<c:url value="/item/${item.id}/question" />"
												method="post">
												<table>
													<tr>
														<th style="width: 70px;"><label for="tag1">Question</label></th>
														<td>${item.question.content}</td>
													</tr>
													<c:forEach items="${item.question.answerSet}" var="answer">
														<tr>
															<td>${answer.author.nickname}&nbsp;</td>
															<td>${answer.answer} &nbsp;</td>
														</tr>
													</c:forEach>
													<tr>
														<th>Answer</th>
														<td><textarea name="content" style="width: 350px;"></textarea>
														</td>
													</tr>
													<tr>
														<th colspan="2"><input type="submit" value="Submit" />
														</th>
													</tr>
												</table>
											</form>
										</div>
									</div>
								</div>
							</c:if>
							<div class="new-share-info">
								<span>Read (<strong>${readCount}</strong>)
								</span><span>ReLog (<strong>${relogCount}</strong>)
								</span>
							</div>
							<c:if test="${fn:length(item.commentList)>0}">
								<div class="dparts commentList">
									<div class="parts">
										<div class="navbar navbar-inner" style="position: static;">
											<div class="navbar-primary">
												<h3
													style="font-size: 14px; font-weight: bolder; line-height: 150%">Comments&nbsp;(${fn:length(item.commentList)})</h3>
											</div>
										</div>
										<c:forEach items="${item.commentList}" var="comment">
											<dl>
												<dt>
													<c:choose>
														<c:when test="${empty comment.user.avatar}">
															<img alt="LearningUser"
																src="<c:url value="/images/no_image.gif" />" width="60"
																height="60" />
														</c:when>
														<c:otherwise>
															<img alt="LearningUser"
																src="<c:url value="/profile/${comment.user.id}/avatar" />"
																width="60" />
														</c:otherwise>
													</c:choose>
												</dt>
												<dd>
													<div class="title">
														${comment.user.nickname} &nbsp; (
														<fmt:formatDate value="${comment.createTime}" type="both"
															dateStyle="long" timeStyle="medium" />
														)
													</div>
													<div class="body">
														<c:out value="${comment.comment}" />
													</div>
												</dd>
											</dl>
										</c:forEach>
									</div>
								</div>
							</c:if>
							<div class="dparts form">
								<div class="parts">
									<div class="navbar navbar-inner" style="position: static;">
										<div class="navbar-primary">
											<h3
												style="font-size: 14px; font-weight: bolder; line-height: 150%">Post
												a comment</h3>
										</div>
									</div>
									<div class="block">
										<form action="<c:url value="/item/${item.id}/comment" />"
											method="post">
											<table>
												<tr>
													<th style="width: 100px;"><label for="tag1">Tag</label></th>
													<td><input type="text" name="tag" /></td>
												</tr>
												<tr>
													<th>Comment</th>
													<td><textarea cols="20" rows="4" name="comment"></textarea>
													</td>
												</tr>
											</table>
											<div class="operation">
												<ul class="moreInfo button">
													<li><input type="submit" value="Save"
														class="btn btn-info" /></li>
												</ul>
											</div>
										</form>
									</div>
									<div id="relatedBox" class="dparts nineTable">
										<div class="parts">
											<button style="width: 100%" class="btn btn-primary"
												onclick="window.location='<c:url value='/item/${item.id}/related' />'">Related
												Objects</button>
										</div>
										<!-- parts 
									</div>
									<!-- dparts 
									<div class="block">
										<ul class="articleList">
										</ul>
										<div class="moreInfo">
											<ul class="moreInfo">
												<li><a href="<c:url value="/item" />">Return to
														Object List</a></li>
											</ul>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- Layout -->
						<div class="block"></div>
					</div>
					<!-- ContentsContainer -->
				</div>
				<!-- Contents -->
			</div>
			<!-- Container -->
		</div>
		<!-- Body -->
	</div>

</body>
<script type="text/javascript">
	$(document).ready(function() {
		document.getElementById("alllog").className = "active";

	});
</script>

</html>
