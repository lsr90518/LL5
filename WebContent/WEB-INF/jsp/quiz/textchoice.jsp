<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:choose>
	<c:when test= "${answered}">
    <div class="alert <c:if test='${result}'>alert-success</c:if> <c:if test='${!result}'>alert-danger</c:if>">
    	<div class="NextQuizJudge">
	   			${comment}
   		</div>
   		<div class="NextQuizDiv">
   			<input type="button" class="buttonSubmit buttonSubmit btn btn-success" value="More Quiz" onclick="return fncMore();"/> 
   		</div>
   	</div>
  	</c:when>
</c:choose>
<div class="QuizContent">
	<img src="<c:url value='/images/system-help.png' />" alt="●"/>Select the right word <br/><span style="color:black">${quiz.content}</span>?
</div>

<table class="AnswerContent" style="border-style: none;">
	<c:forEach items="${quiz.quizChoices}" var="choice" varStatus="status">
		<ul
			style="list-style-image:url('<c:url value='/images/icon_arrow_2.gif' />');margin: 3px 20px; line-height: 30px;font-family: arial,meiryo,simsun,sans-serif; font-weight:bold; font-size: 18px; overflow: visible; color: green; vertical-align: baseline">
			<li><c:choose>
				<c:when test="${!answered}">
					<input id="answeroption${status.index}" type="radio" name="answer"
						value="${choice.number}"
						<c:if test= "${status.index == 0}"> checked="checked"</c:if> />
					<label for="answeroption${status.index}">${choice.content}</label>
				</c:when>
				<c:otherwise>
					<c:if test="${rightanswer == status.index+1}">
						<img src="<c:url value='/images/right_icon.png' />" alt="(Right)" />
					</c:if>					
					<c:if test="${!result && youranswer == status.index+1}">
						<img src="<c:url value='/images/wrong_icon.png' />" alt="(Wrong)" />
					</c:if>
					<c:url value="/item/${choice.item.id}" var="itemurl" />
					<a href="${itemurl}" target="_blank">${choice.content}</a> 
	                         ${choice.note}
	              </c:otherwise>
			</c:choose></li>
		</ul>
	</c:forEach>
</table>
<c:choose>
	<c:when test= "${!answered}">
	    <div class="SubmitPanel" >
			<div class="row" style="margin:0px;">
				<div class="col-xs-6 col-md-6 ">
					<input type="submit" class="btn" value="Answer"/>
				</div>
				<div class="col-xs-6 col-md-6 ">
					<input type="submit" class="btn" value="Too Easy" onclick="return fncEasy();"/>
				</div>
			</div>
			<div class="row" style="margin:0px;">
				<div class="col-xs-6 col-md-6 ">
					<input type="submit" class="btn" value="Too Difficult" onclick="return fncDifficult();"/>
				</div>
				<div class="col-xs-6 col-md-6 ">
					<input type="button" class="btn" value="No Good" onclick="return fncPass();"/>
				</div>
			</div>
		</div>
	</c:when>
</c:choose>