<%@page contentType="text/html" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html>
    <c:import url="include/head.jsp">
        <c:param name="title" value="Learning Log" />
    </c:import>


 
    <body id="page_member_home">
  
        <div id="Body">
         <c:import url="include/header.jsp" />
            
            <div id="Container">
               
                <div id="Contents">
                
                    <div id="ContentsContainer">
                     
                        <div id="LayoutA" class="Layout">
                      
                            <div id="Top">
                                <div id="information_21" class="parts informationBox">
                                    <div class="body">
                                    <p></p>
                                    </div>
                                </div><!-- parts -->
                            </div><!-- Top -->
                            <div id="Left">
                                <div id="memberImageBox_22" class="parts memberImageBox">
                                    <p class="photo">
                                        <c:choose>
                                            <c:when test="${empty user.avatar}">
                                                <img alt="LearningUser" src="<c:url value="/images/no_image.gif" />" height="180" width="180" />
                                            </c:when>
                                            <c:otherwise>
                                                <img alt="LearningUser" src="<c:url value="${staticserverUrl}/${projectName}/${user.avatar.id}_320x240.png" />" width="180" />
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                    <p class="text"><shiro:principal property="nickname" /></p>
                                    <p class="text">Level : ${user.userLevel}</p>
                                    <p class="text">EXP : ${nowExperiencePoint} / Next : ${nextExperiencePoint}</p>

                                    <div class="moreInfo">
                                    <%--
                                        <ul class="moreInfo">
                                            <li><a href=" <c:url value="/profile/avataredit"/>">Edit Photo</a></li>
                                            <li><a href="<c:url value='/profile' />">My Profile</a></li>
                                        </ul>
									--%>
                                    </div>
                                </div><!-- parts -->
                                <!-- <div id="rankingbox1" class="parts ranking">
                                <div class="navbar navbar-inner" style="position: static;">
									<div class="navbar-inverse">
                                    <div class="partsHeading"><h3>Upload Heroes</h3></div>
                                    <div class="partsInfo" style="color: navy">
                                    </div></div>
                                        <ul>
                                            <c:forEach items="${uploadItemRanking}" var="uploadRanking" end="9">
                                                <li><a href="<c:url value="/item"><c:param name="username" value="${uploadRanking[0].nickname}" /></c:url>">${uploadRanking[0].nickname}&nbsp;(${uploadRanking[1]})</a></li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </div>--><!-- parts -->
                                	<div id="rankingbox1" class="parts ranking"
								style="font-size: 14px; font-weight: bolder; line-height: 150%">
								<div class="navbar navbar-inner" style="position: static;">
									<div class="navbar-primary">
										<h3
											style="font-size: 14px; font-weight: bolder; line-height: 150%">Upload
											ALLs</h3></div></div>
									
								<div class="partsInfo" style="color: navy">
									
										 <ul>
                                            <c:forEach items="${uploadItemRanking}" var="uploadRanking" end="9">
                                                <li><a href="<c:url value="/item"><c:param name="username" value="${uploadRanking[0].nickname}" /></c:url>">${uploadRanking[0].nickname}&nbsp;(${uploadRanking[1]})</a></li>
                                            </c:forEach>
                                        
									</ul>
								</div>
							</div>
                                
                                
                                
                                <div id="rankingbox2" class="parts ranking">
                            
                                    
                                    <div class="navbar navbar-inner" style="position: static;">
									<div class="navbar-primary">
                                    <h3 style="font-size: 14px; font-weight: bolder; line-height: 150%">Answer Heroes</h3></div></div>
                                    <div class="partsInfo" style="color: navy">
                                        <ul>
                                            <c:forEach items="${answerRanking}" var="aRanking" end="9">
                                                <li><a href="<c:url value="/item"><c:param name="answeruser" value="${aRanking[0].nickname}" /></c:url>">${aRanking[0].nickname}&nbsp;(${aRanking[1]})</a></li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </div><!-- parts -->
                                <div id="rankingbox2" class="parts ranking">
                                    <div class="navbar navbar-inner" style="position: static;">
									<div class="navbar-primary"><h3 style="font-size: 14px; font-weight: bolder; line-height: 150%">Statistics</h3></div></div>
                                    <div class="partsInfo" style="color: navy">
                                        <ul>
                                        	<c:forEach items="${stat}" var="stat">
                                            	<li>${stat.key}&nbsp;(${stat.value})</li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </div><!-- parts -->
                            </div><!-- Left -->
                            <div id="Center">
                                <div id="homeRecentList_11" class="dparts homeRecentList"><div class="parts">
                                        <div class="navbar navbar-inner" style="position: static;">
									<div class="navbar-primary"><h3 style="font-size: 14px; font-weight: bolder; line-height: 150%">Entries awaiting your answers</h3></div></div>
                                        <div class="block">
                                            <ul class="articleList">
                                                <c:forEach items="${toAnswerItems.result}" var="item">
                                                    <li><span class="date"><fmt:formatDate value="${item.createTime}" type="date" pattern="yyyy/MM/dd"  /></span><a href="<c:url value = "/item/${item.id}"/>">${item.question.content}(${fn:length(item.question.answerSet)})</a> (${item.author.nickname}) </li>
                                                </c:forEach>
                                            </ul>
                                            <c:if test="${toAnswerItems.hasNext}">
                                            <div class="moreInfo">
                                                <ul class="moreInfo">
                                                	<c:url value="/item" var="toAnswerQuesItemUrl">
                                                    	<c:forEach items="${user.myLangs}" var="lang">
                                                    		<c:param name="toAnswerQuesLangsCode" value="${lang.code}" />
                                                    	</c:forEach>
                                                    </c:url>
                                                    <li><a href="${toAnswerQuesItemUrl}">More...</a></li>
                                                </ul>
                                            </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                                <div id="homeRecentList_12" class="dparts homeRecentList"><div class="parts">
                                        <div class="navbar navbar-inner" style="position: static;">
									<div class="navbar-primary"><h3 style="font-size: 14px; font-weight: bolder; line-height: 150%">New entries written in the language you are learning</h3></div></div>
                                        <div class="block">
                                            <ul class="articleList">
                                                <c:forEach items="${toStudyItems.result}" var="item">
                                                    <li><span class="date"><fmt:formatDate value="${item.updateTime}" type="date" pattern="yyyy/MM/dd" /></span><a href="<c:url value="/item/${item.id}"/>">${item.question.content}(${fn:length(item.question.answerSet)})</a> (${item.author.nickname}) </li>
                                                </c:forEach>
                                            </ul>
                                            <c:if test="${toStudyItems.hasNext}">
                                            <div class="moreInfo">
                                                    <c:url value="/item" var="toStudyQuesItemUrl">
                                                    	<c:forEach items="${user.studyLangs}" var="lang">
                                                    		<c:param name="toStudyQuesLangsCode" value="${lang.code}" />
                                                    	</c:forEach>
                                                    </c:url>
                                                <ul class="moreInfo">
                                                    <li><a href="${toStudyQuesItemUrl}">More...</a></li>
                                                </ul>
                                            </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                                <div id="homeRecentList_13" class="dparts homeRecentList"><div class="parts">
                                      <div class="navbar navbar-inner" style="position: static;">
									<div class="navbar-primary"><h3 style="font-size: 14px; font-weight: bolder; line-height: 150%">Latest answered questions for you</h3></div></div>
                                        <div class="block">
                                            <ul class="articleList">
                                                <c:forEach items="${answeredItems.result}" var="item">
                                                    <li>
                                                        <span class="date">
                                                            <fmt:formatDate value="${item.updateTime}" type="date" pattern="yyyy/MM/dd" />
                                                        </span>
                                                        <a href="<c:url value="/item/${item.id}"/>">${item.question.content}(${fn:length(item.question.answerSet)})</a>
                                                        (${item.author.nickname})
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                            <c:if test="${answeredItems.hasNext}">
                                            <div class="moreInfo">
                                                <c:url value="/item" var="answeredQuesItemUrl">
                                                	<c:param name="userId" value="${user.id}" />
                                                	<c:param name="hasAnswers" value="true" />
                                                </c:url>
                                                <ul class="moreInfo">
                                                    <li><a href="${answeredQuesItemUrl}">More...</a></li>
                                                </ul>
                                            </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                                <!--  
                                <div class="btn-group">
        <button class="btn dropdown-toggle" data-toggle="dropdown">Button <span class="caret"></span></button>
        <ul class="dropdown-menu">
            <li><a href="#">編集</a></li>
            <li><a href="#">削除</a></li>
            <li><a href="#">共有</a></li>
            <li class="divider"></li>
            <li><a href="#">Log out</a></li>
        </ul>
    </div>
    -->
                                
                            </div><!-- Center -->
                             
                        </div><!-- Layout -->
                    </div><!-- ContentsContainer -->
                </div><!-- Contents -->
                
            </div><!-- Container -->
        </div><!-- Body -->
        

<script type="text/javascript">

var _gaq = _gaq || [];
_gaq.push(['_setAccount', 'UA-16851731-2']);
_gaq.push(['_trackPageview']);

(function() {
var ga = document.createElement('script'); ga.type = 'text/javascript';
ga.async = true;
ga.src = ('https:' == document.location.protocol ? 'https://ssl' :
'http://www') + '.google-analytics.com/ga.js';
var s = document.getElementsByTagName('script')[0];
s.parentNode.insertBefore(ga, s);
})();

</script>    
<script type="text/javascript">
	$(document).ready(function() {
		

		document.getElementById("homework").className = "active";

	});
</script>

    </body>

</html>
<c:import url="include/Slidermenu.jsp" />
<c:import url="include/footer.jsp" />
