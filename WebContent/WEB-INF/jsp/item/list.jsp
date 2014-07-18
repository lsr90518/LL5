<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="userId"><shiro:principal property="id" /></c:set>
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
</style>
    <script type="text/javascript">
	$(document).ready(function() {

		document.getElementById("alllog").className = "active";
		
		
		
	});
</script>


    <body id="page_diary_list">
        <div id="Body">
            <div id="Container">
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

                <div id="Contents">
                    <div id="ContentsContainer">
                        <div id="LayoutA" class="Layout">
                        
                            <div id="Top">
                                <div id="information_21" class="parts informationBox">
                                    <div class="body">
                                    </div>
                                </div><!-- parts -->
                            </div> 
                                       
                            </div>
                            <div id="Center">
                                <div class="dparts searchResultList"><div class="parts">
                                        
                                        <div class="block">
                                            <c:forEach items="${itemPage.result}" var="item">
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
                        </div><!-- Layout -->
                        <div id="sideBanner">
                            <%--
                            <form action="/member/changeLanguage" method="post"><label for="language_culture">言語</label>:
                                <select name="language[culture]" onchange="submit(this.form)" id="language_culture">

                                    <option value="en">English</option>
                                    <option value="ja_JP" selected="selected">日本語 (日本)</option>
                                </select><input value="diary/index" type="hidden" name="language[next_uri]" id="language_next_uri" /></form>
                            --%>
                        </div><!-- sideBanner -->
                    </div><!-- ContentsContainer -->
                </div><!-- Contents -->
            </div><!-- Container -->
        </div><!-- Body -->
            
	<c:import url="../include/footer.jsp"></c:import>
    </body>
</html>
