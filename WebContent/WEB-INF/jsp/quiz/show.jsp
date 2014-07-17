<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!doctype html>
<html>


    <c:import url="../include/head.jsp">
   <c:param name="javascript">
       
           <script type="text/javascript" src="<c:url value="/js/jquery/fancyzoom/js/fancyzoom.min.js" />"></script>
            <script type="text/javascript">
                $(function(){
                    $('a.zoom').fancyZoom({
                        directory:'<c:url value="/js/jquery/fancyzoom/images" />'
                    });
                });
            </script>
               <script type="text/javascript">
	$(document).ready(function() {

		document.getElementById("quiz").className = "active";

	});
</script>
        </c:param>
    </c:import>
	<script type="text/javascript">
	function fncPass() {
		$("#pass").val("1");
		$("#form").submit();
	}
	function fncEasy() {
		$("#pass").val("2");
		$("#form").submit();
	}
	function fncDifficult() {
		$("#pass").val("3");
		$("#form").submit();
	}
	
	function fncMore() {
		var myform  = document.getElementById("form");
		
		myform.method="get";
		myform.submit();  
	}

	function resizeImgX(img,iwidth,iheight)
	{
	   var _img = new Image();
	   _img.src = img.src;
	   if(_img.width > _img.height)
	   {
	      img.width = (_img.width > iwidth) ? iwidth : _img.width;
	      img.height = (_img.height / _img.width) * img.width;
	   }
	   else if(_img.width < _img.height)
	   {
	      img.height = (_img.height > iheight) ? iheight : _img.height;
	      img.width = (_img.width / _img.height) * img.height ;
	   }
	   else
	   {
	      img.height = (_img.height > iheight) ? iheight : _img.height;
	      img.width = (_img.width > iwidth) ? iwidth : _img.width;
	   }
	}
	
</script>
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
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

.contentPanel{
	background: white;
	margin: 5px 10px;
	position: relative;
	border-radius: 5px;
	-moz-border-radius: 5px;
	-webkit-border-radius: 5px;
	-moz-background-clip: padding;
	-webkit-background-clip: padding-box;
	-webkit-box-shadow: 0 1px 1px 0 #888;
	-moz-box-shadow: 0 1px 1px 0 #888;
	box-shadow: 0 1px 1px 0 #888;
	margin-bottom:20px;
}

.QuizContent{
	font-weight: bolder;
	font-size: larger;
	border-bottom: 1px solid #ccc;
	padding-left: 10px;
}

.AnswerContent{
	background-color: #f3f3f3;
}
.SubmitPanel{
	border-top: 1px solid #ccc;
	padding-top: 5px;
	text-align: center;
}
.SubmitPanel>input{
	box-shadow:0 1px 3px 0 #888;
	margin:10px;
	background-color:#326e99;
	color:white;
}

.scoreContent{
	background-color: #DBDBDB;
	margin: 1%;
	border-radius: 5%;
	text-align: center;
	padding: 10px;
	margin-top: 10px;
	margin-bottom: 20px;
}
.scoreSpan{
	font-size: 56px;
	color: white;
	font-weight: bold;
	margin-bottom: 5px;
	display: block;
}
.scoreTitle{
	margin: 0;
	font-weight: bold;
	color: #8d9aa5;
	line-height: 1.6;
}
.ImageContent{
	text-align: center;
}
</style>
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
					  <div class="col-xs-8 col-md-8" style="text-align: center;"><span class="titleSpan">Quiz</span></div>
					  <div class="col-xs-2 col-md-2"><a class="btn-lg btn-block topBtn" style="text-align:center" href="/LL5/item/add"><span class="glyphicon glyphicon-pencil navTab"></span></a></div>
					  
					  
					</div>
				  </div><!-- /.container-fluid -->
				</header>
    <body id="page_member_profile">
        <div id="Body">
      		 <div id="Container">
                 <div id="Contents">
                   	<div id="ContentsContainer">
					<div id="LayoutA" class="Layout">
					
					<div id="ImageContent" style="text-align: center;">
	                      		 <c:if test="${!empty quiz}">
	                      		      <c:if test="${quiz.questionType.id!=2}">
	                                <div id="memberImageBox_30" class="parts memberImageBox">
		                                    <p class="photo">
		                                        <a id="itemImage" class="zoom" data-toggle="modal" data-target="#itemImageZoom">
		                                            <c:choose>
		                                                <c:when test="${empty quiz.item.image}">
		                                                </c:when>
		                                                <c:otherwise>
		                                                    <img style="box-shadow:0px 1px 3px 0px #888" alt="" src="${staticserverUrl}/${projectName}/${quiz.item.image.id}_320x240.png" width="240px" />
		                                                </c:otherwise>
		                                            </c:choose>
		                                        </a>
		                                    </p>
		                                    <div id="itemImageZoom" class="modal fade" tabindex="-1" role="dialog"
							aria-labelledby="myModalLabel" aria-hidden="true">
		                                        <c:choose>
		                                            <c:when test="${empty quiz.item.image}">
		                                            </c:when>
		                                            <c:otherwise>
		                                                <img alt="" src="${staticserverUrl}/${projectName}/${quiz.item.image.id}_800x600.png" />
		                                            </c:otherwise>
		                                        </c:choose>
		                                    </div><!-- itemImageZoom -->
										</div><!-- memberImageBox_30 -->
										</c:if>
										<c:if test="${!empty quiz.item.itemLat && !empty quiz.item.itemLng && !empty quiz.item.itemZoom}">
	                                </c:if>
	                                </c:if>
	                            </div><!-- Left -->
					
					
						<div class="contentPanel">
						
							<div class="dparts homeRecentList">
								<div class="parts">
									<c:url value="/quiz" var="url" />
									<c:if test="${!empty quiz}">
										<form:form commandName="form" action="${url}" method="post"
											id="form">
											<form:hidden path="language" />
											<form:hidden path="pass" id="pass" />
											<input name="alarmtype" type="hidden" value="8" />
											<input type="hidden" name="quizid" value="${quiz.id}"></input>
											<c:if test="${quiz.questionType.id == 1}">
												<c:import url="textchoice.jsp" />
											</c:if>
											<c:if test="${quiz.questionType.id == 2}">
												<c:import url="imagechoice.jsp" />
											</c:if>
											<c:if test="${quiz.questionType.id == 3}">
												<c:import url="yesno.jsp" />
											</c:if>
										</form:form>

										<br />
									</c:if>
									<c:if test="${empty quiz}">
										<c:import url="noquiz.jsp" />
									</c:if>
								</div>
								<!-- parts -->
							</div>
							<!-- dparts homeRecentList -->
						</div>
						<!-- Center -->
					</div>
					<!-- LayoutA -->
					
					

					<!-- 										score										 -->
                            <div class="contentPanel">
                                <div class="row">
                                  <div class="col-xs-2 col-md-2 ">
								  </div>
								  <div class="col-xs-4 col-md-4 scoreContent">
								    <span class="scoreSpan">${quizinfos.scores}</span>
                            		<span class="scoreTitle">Today's Score</span>
								  </div>
								  <div class="col-xs-4 col-md-4 scoreContent">
								    <span class="scoreSpan">${quizinfos.allscores}</span>
                            		<span class="scoreTitle">Today's Score</span>
								  </div>
								  <div class="col-xs-2 col-md-2 ">
								  </div>
								</div>
	                        </div>   
	                        <!-- 										score										 -->
	                        
	                        
	                        
	                        
	                        <!-- 										map											 -->
					<div class="contentPanel">
						<div id="map" style="height: 90px;text-align:center">
							<img
								src="http://maps.google.com/maps/api/staticmap?size=400x90&sensor=false&center=${quiz.item.itemLat},${quiz.item.itemLng}&zoom=${quiz.item.itemZoom}&mobile=true&markers=${quiz.item.itemLat},${quiz.item.itemLng}" />
						</div>

						<c:if test="${!empty quiz.item.place}">
							<tr>
								<td>Place：${quiz.item.place}</td>
							</tr>
						</c:if>

					</div>
					<!-- contentPanel -->
					<!-- 										map											 -->       
                    </div><!-- ContentsContainer -->
				 </div><!-- Contents -->
            </div><!-- Container -->
        </div><!-- Body -->
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
