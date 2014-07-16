<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<jsp:useBean id="pageParameter" class="java.util.LinkedHashMap" />
<c:set target="${pageParameter}" property="title"
	value="${searchCond.title}" />
<c:set target="${pageParameter}" property="lang"
	value="${searchCond.lang}" />
<c:set target="${pageParameter}" property="username"
	value="${searchCond.username}" />
<c:set target="${pageParameter}" property="answeruserId"
	value="${searchCond.answeruserId}" />
<%--<c:set target="${pageParameter}" property="group" value="${searchCond.group}" />--%>
<c:set target="${pageParameter}" property="dateFrom"
	value="${searchCond.dateFrom}" />
<c:if test="${searchCond.mapenabled}">
	<c:set target="${pageParameter}" property="mapenabled"
		value="${searchCond.mapenabled}" />
	<c:set target="${pageParameter}" property="x1" value="${searchCond.x1}" />
	<c:set target="${pageParameter}" property="x2" value="${searchCond.y1}" />
	<c:set target="${pageParameter}" property="y1" value="${searchCond.x2}" />
	<c:set target="${pageParameter}" property="y2" value="${searchCond.y2}" />
</c:if>
<c:set target="${pageParameter}" property="questionStatus"
	value="${searchCond.questionStatus}" />
<c:set target="${pageParameter}" property="teacherConfirm"
	value="${searchCond.teacherConfirm}" />
<c:forEach items="${searchCond.toAnswerQuesLangsCode}" var="code">
	<c:set target="${pageParameter}" property="toAnswerQuesLangsCode"
		value="${code}" />
</c:forEach>
<c:forEach items="${searchCond.toStudyQuesLangsCode}" var="code">
	<c:set target="${pageParameter}" property="toStudyQuesLangsCode"
		value="${code}" />
</c:forEach>
<c:set target="${pageParameter}" property="userId"
	value="${searchCond.userId}" />
<c:set target="${pageParameter}" property="hasAnswers"
	value="${searchCond.hasAnswers}" />

<c:set var="shownPageNum" value="8" />
<c:set var="startPage" value="1" />
<c:set var="endPage" value="${itemPage.totalPages}" />
<c:if test="${itemPage.totalPages>shownPageNum}">
	<c:set var="startPage"
		value="${itemPage.pageNo-(shownPageNum-shownPageNum%2)/2}" />
	<c:set var="endPage" value="${startPage+shownPageNum-1}" />

	<c:if test="${startPage<1}">
		<c:set var="pageOffset" value="${1-startPage}" />
		<c:set var="startPage" value="${startPage+pageOffset}" />
		<c:set var="endPage" value="${endPage+pageOffset}" />
	</c:if>
	<c:if test="${endPage>itemPage.totalPages}">
		<c:set var="pageOffset" value="${endPage-itemPage.totalPages}" />
		<c:set var="startPage" value="${startPage-pageOffset}" />
		<c:set var="endPage" value="${endPage-pageOffset}" />
	</c:if>
</c:if>

<c:if test="${itemPage.hasPre}">
	<c:url var="prevUrl" value="/item">
		<c:param name="page" value="1" />
		<c:forEach items="${pageParameter}" var="p">
			<c:if test="${!empty p.value}">
				<c:param name="${p.key}" value="${p.value}" />
			</c:if>
		</c:forEach>
	</c:url>
	<a style="display:none" href="${prevUrl}">&laquo;</a>
</c:if>
<c:forEach begin="${startPage}" end="${endPage}" var="pageNo">
	<c:choose>
		<c:when test="${pageNo eq itemPage.pageNo}">
			<span style="display:none" class="now-page">${pageNo}</span>
		</c:when>
		<c:otherwise>
			<c:url var="pageNumUrl" value="/item">
				<c:param name="page" value="${pageNo}" />
				<c:forEach items="${pageParameter}" var="p">
					<c:if test="${!empty p.value}">
						<c:param name="${p.key}" value="${p.value}" />
					</c:if>
				</c:forEach>
			</c:url>
			<c:if test="${pageNo eq itemPage.pageNo-1}">
				<a style="display:none" class="back" href="${pageNumUrl}">${pageNo}</a>
			</c:if>
			<c:if test="${pageNo eq itemPage.pageNo+1}">
				<a style="display:none" class="next" href="${pageNumUrl}">${pageNo}</a>
			</c:if>
		</c:otherwise>
	</c:choose>
</c:forEach>
<c:if test="${itemPage.hasNext}">
	<c:url var="nextUrl" value="/item">
		<c:param name="page" value="${itemPage.totalPages}" />
		<c:forEach items="${pageParameter}" var="p">
			<c:if test="${!empty p.value}">
				<c:param name="${p.key}" value="${p.value}" />
			</c:if>
		</c:forEach>
	</c:url>
	<a style="display:none" href="${nextUrl}">&raquo;</a>
</c:if>
<input type="hidden" id="totalPage" value="${itemPage.totalPages}" />
<style type="text/css">
	.pagerDiv{
		height:30px;
	}
</style>
<div class="pagerDiv">
	<div class="col-xs-3 col-md-3">
		<button onclick="goBack()" class="btn btn-default btn-block btn-pager"><<</button>
	</div>
	<div class="col-xs-6 col-md-6">
		<button id="currentBtn" class="btn btn-default btn-block btn-pager">${itemPage.pageNo}/${itemPage.totalPages}</button>
	</div>
	<div class="col-xs-3 col-md-3">
		<button onclick="goNext()" class="btn btn-default btn-block btn-pager">>></button>
	</div>
</div>

<script type="text/javascript">
	function goBack(){
		var now = $(".now-page").html();
		if(now == "1"){
			return;
		} else {
			window.location.href=$(".back").attr("href");
		}
	}
	function goNext(){
		var now = $(".now-page").html();
		var total = $("#totalPage").val();
		if(now == total){
			return;
		} else {
			window.location.href=$(".next").attr("href");
		}
		
	}
</script>
