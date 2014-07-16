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
                            <div id="Left">
                      		 <c:if test="${!empty quiz}">
                      		      <c:if test="${quiz.questionType.id!=2}">
                                <div id="memberImageBox_30" class="parts memberImageBox">
	                                    <p class="photo">
	                                        <a id="itemImage" class="zoom" href="#itemImageZoom">
	                                            <c:choose>
	                                                <c:when test="${empty quiz.item.image}">
	                                                    <img width="240px" alt="" src="<c:url value="/images/no_image.gif" />" />
	                                                </c:when>
	                                                <c:otherwise>
	                                                    <img alt="" src="${staticserverUrl}/${projectName}/${quiz.item.image.id}_320x240.png" width="240px" />
	                                                </c:otherwise>
	                                            </c:choose>
	                                        </a>
	                                    </p>
	                                    <div id="itemImageZoom">
	                                        <c:choose>
	                                            <c:when test="${empty quiz.item.image}">
	                                                <img width="240px" alt="" src="<c:url value="/images/no_image.gif" />" />
	                                            </c:when>
	                                            <c:otherwise>
	                                                <img alt="" src="${staticserverUrl}/${projectName}/${quiz.item.image.id}_800x600.png" />
	                                            </c:otherwise>
	                                        </c:choose>
	                                    </div><!-- itemImageZoom -->
	                                    <p class="text"></p>
	                                    <div class="moreInfo">
	                                        <ul class="moreInfo">
	                                            <li><a class="zoom" href="#itemImageZoom">もっと写真を見る</a></li>
	                                        </ul>
	                                    </div><!-- moreInfo -->
									</div><!-- memberImageBox_30 -->
									</c:if>
									<c:if test="${!empty quiz.item.itemLat && !empty quiz.item.itemLng && !empty quiz.item.itemZoom}">
	                                <div id="mapbox" class="dparts nineTable">
                                    <div class="parts">
                                        <div class="navbar navbar-inner" style="position: static;">
									<div class="navbar-primary"><h3 style="font-size: 14px; font-weight: bolder; line-height: 150%">Map</h3></div></div>
                                        <table>
                                            <tr>
                                                <td>
                                                    <div id="map" style="height: 200px;">
                                                        <img src="http://maps.google.com/maps/api/staticmap?size=260x200&sensor=false&center=${quiz.item.itemLat},${quiz.item.itemLng}&zoom=${quiz.item.itemZoom}&mobile=true&markers=${quiz.item.itemLat},${quiz.item.itemLng}" />
                                                    </div>
                                                </td>
                                            </tr>
                                            <c:if test="${!empty quiz.item.place}"><tr><td>Place：${quiz.item.place}</td></tr></c:if>
                                        </table>
                                    </div><!-- parts -->
                                </div><!-- dparts -->
                                </c:if>
                                </c:if>
                            </div><!-- Left -->
                            <div id="Center">
                                <div class="dparts homeRecentList">
                                    <div class="parts">
                                        <div class="navbar navbar-inner" style="position: static;">
									<div class="navbar-primary"><h3 style="font-size: 14px; font-weight: bolder; line-height: 150%">Quiz</h3></div></div>
                                          <c:url value="/quiz" var="url" />
                                         <c:if test="${!empty quiz}">
                                          <form:form commandName="form" action="${url}" method="post" id="form">
                                          	 <form:hidden path="language"/>
                                          	 <form:hidden path="pass" id="pass"/>
                                          	 <input name="alarmtype" type="hidden" value="8"/>
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
                                          <br/>
                                          <!-- 
                                          <form:form commandName="form"  action="${url}" method="get">
	                                          <c:if test= "${answered}">
                                             <table>
                                                 <tr class="main-table" >
                                                     <td width="120" style="text-align:center;">
                                                     	 <input type="submit" value="More Quizzes" class="buttonSubmit"></input>
                                                         Learning Language:
                                                        <form:select path="language" itemLabel="name" itemValue="code" items="${languages}" ></form:select>
                                                     </td>
                                             </table>
                                             </c:if>
                                         </form:form>
                                          -->
                                        </c:if>
                                   	    <c:if test="${empty quiz}">
                                   	     <c:import url="noquiz.jsp" />
                                      </c:if>
                                     </div> <!-- parts -->
                                </div><!-- dparts homeRecentList -->
                            </div><!-- Center -->
                      	</div><!-- LayoutA -->
                            <div style="text-align: center;">
                               <span style="font-family: arial,meiryo,simsun,sans-serif;font-size: 17px; font-weight:bold; ">
                               			<br/>
                                      	Today's Score:<br><br/>&nbsp;<font color="green" size="30px">${quizinfos.scores}</font><br/><br/>
	                                  	Your All Score:<br><br/>&nbsp;<font color="green" size="30px">${quizinfos.allscores}</font>
	                                  </span>
	                        </div>          
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
