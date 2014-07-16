<%@page contentType="text/html" pageEncoding="UTF-8"
	trimDirectiveWhitespaces="true"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!doctype html>
<html>
<c:import url="../include/head.jsp">
	<c:param name="title" value="Add a new object" />
	<c:param name="content">
		<style>
.titleLangName {
	width: 70px;
}

.titleMap {
	width: 70%;
}

#titleTable button {
	width: 20%;
}

.optional {
	display: none
}
</style>

		<script type="text/javascript"
			src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
		<script type="text/javascript"
			src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/jquery-ui.min.js"></script>
		<script type="text/javascript"
			src="<c:url value="/js/jquery/jquery.contextMenu.js" />"></script>
		<script type="text/javascript"
			src="<c:url value="/js/jquery/jquery.form.js"/>"></script>

		<script src="http://www.google.com/jsapi"></script>
		<script src="http://maps.google.com/maps/api/js?sensor=true"></script>
		<script src="<c:url value='/js/LLMap.js' />"></script>
		<script>
			function translateTitle(code) {
				var translateTitleUri = "${baseURL}/api/translate/itemTitle";
				var titles = "{";
				$.each($(".titleMap"), function(i, item) {
					titles += $(item).attr("lang") + ":\"" + $(item).val()
							+ "\"";
					if (i < $(".titleMap").length - 1)
						titles += ",";
				});
				titles += "}";
				var inputdata = {
					'target' : code,
					'titles' : titles
				};
				$.get(translateTitleUri, inputdata, function(data) {
					$("#inputTitle_" + code).val(data);
				});
			}

			function translateQuestion() {
				var translateTitleUri = "${baseURL}/api/translate/text";
				var inputdata = {
					'src' : $("#transFrom").val(),
					'dest' : $("#transTo").val(),
					'text' : $("#question").val()
				};
				$.get(translateTitleUri, inputdata,
						function(data) {
							$("#question").val(
									$("#question").val() + "{" + data + "}");
						});
			}

			var map;
			$(function() {
				map = new LLMap("map", {
					onchange : function(lat, lng, zoom) {
						$("#itemLat").val(lat);
						$("#itemLng").val(lng);
						$("#itemZoom").val(zoom);
					}
				});

				$(document)
						.on(
								"change",
								"#addLangSelect",
								function() {
									var code = $("#addLangSelect").val();
									if (code == null && code == -1)
										return;
									var name = $("#addLangSelect").find(
											"option:selected").text();
									$(
											"<tr><td class=\"titleLangName\">"
													+ name
													+ "</td><td><input name=\"titleMap['"+code+"']\" id=\"inputTitle_"+code+"\" class=\"titleMap\" lang=\""+code+"\" />&nbsp;<button onclick=\"translateTitle('"
													+ code
													+ "');return false;\">Translate</button></td></tr>")
											.appendTo($("#titleTable"));
									$(
											"#addLangSelect option[value='"
													+ code + "']").remove();
									if ($("#addLangSelect option").length <= 1) {
										$("#addLangSelect").parent().hide();
									}
								})
						.on("click", "#showMoreButton", function() {
							if ($(".optional:first").is(":hidden")) {
								$(".optional").show();
								$("#showMoreButton").text("Hide Details");
							} else {
								$(".optional").hide();
								$("#showMoreButton").text("Show Details");
							}
						})
						.on(
								"click",
								"#generateQrcode",
								function() {
									if ($("#qrcode").val() != "") {
										if (!confirm("Generate a new QR code?")) {
											return;
										}
									}
									$
											.get(
													"<c:url value="/api/qrcode/generate" />",
													function(data) {
														$("#qrcode").val(data);
														$("#qrcodeArea")
																.html(
																		"<img src=\"http://chart.apis.google.com/chart?cht=qr&chs=120x120&chl="
																				+ data
																				+ "\"/>");
													});
									return false;
								})
						.on("click", "#clearQrcode", function() {
							$("#qrcode").val("");
							$("#qrcodeArea").html("");
						})
						.on(
								"click",
								"#printQrcode",
								function() {
									$
											.get(
													"<c:url value="/api/qrcode/generate" />",
													function(data) {
														$("#qrcode").val(data);
														$("#qrcodeArea")
																.html(
																		"<img src=\"http://chart.apis.google.com/chart?cht=qr&chs=120x120&chl="
																				+ data
																				+ "\"/>");
														window
																.open(
																		"<c:url value='/qrcodeprint?content=' />"
																				+ $(
																						"#qrcode")
																						.val(),
																		"",
																		"height=170, width=170");
													});
								}).on(
								"change",
								"#qrcode",
								function() {
									if ($.trim($("#qrcode").val()) == "") {
										$("#qrcodeArea").html("");
										return;
									}
									$("#qrcodeArea").html(
											"<img src=\"http://chart.apis.google.com/chart?cht=qr&chs=120x120&chl="
													+ $("#qrcode").val()
													+ "\"/>");
								});
			});
		</script>


		<script type="text/javascript">
			function getUrlVars() {
				var vars = [], hash;
				var hashes = window.location.href.slice(
						window.location.href.indexOf('?') + 1).split('&');
				for ( var i = 0; i < hashes.length; i++) {
					hash = hashes[i].split('=');
					vars.push(hash[0]);
					vars[hash[0]] = hash[1];
				}
				return vars;
			}

			$(document).ready(
					function() {
						var vars = getUrlVars();
						if (vars["langlist"] === void 0)
							return;
						var lang = vars["langlist"].split("|");
						$.each(lang, function(i, val) {
							if (vars[val + "_title"] !== void 0) {
								$("#inputTitle_" + val).val(
										decodeURI(vars[val + "_title"]));
							}
						});
					});
		</script>

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
					<a class="btn-lg btn-block topBtn dropdown-toggle"
						style="text-align: center;" href="/LL5/item"> <span
						class="glyphicon glyphicon-chevron-left navTab"></span>
					</a>
				</div>
				<div class="col-xs-8 col-md-8" style="text-align: center;">
					<span class="titleSpan" style="color:white">Add New Log</span>
				</div>
				<div class="col-xs-2 col-md-2">
					
				</div>


			</div>
		</div>
		<!-- /.container-fluid -->
	</header>
<body>
	<div class="container-fluid">


		<c:url value="/item" var="itemUrl" />
		<form:form commandName="item" action="${itemUrl}" method="post"
			enctype="multipart/form-data">

			<c:forEach items="${langs}" var="lang">
				<div class="row" style="margin-bottom: 10px">
					<div class="col-xs-12">
						<div class="input-group">
							<form:input path="titleMap['${lang.code}']"
								id="inputTitle_${lang.code}" cssClass="titleMap form-control"
								lang="${lang.code}" placeholder="${lang.name}" />
							<span class="input-group-btn">
								<button onclick="translateTitle('${lang.code}');return false;"
									class="btn btn-danger" type="button">Translate</button>
							</span>
						</div>
						<!-- /input-group -->
					</div>
					<!-- /.col-xs-12 -->

				</div>
				<!-- row -->
			</c:forEach>
			<div style="margin-bottom: 5px">
					<select id="addLangSelect">
						<option value="-1">--Add a new language--</option>
						<c:forEach items="${langList}" var="lang">
							<c:if test="${!langs.contains(lang)}">
								<option id="addLang_${lang.code}" value="${lang.code}">${lang.name}</option>
							</c:if>
						</c:forEach>
					</select>
			</div>
			
			<div style="margin-bottom:10px">
				<input type="file" name="image" id="image" class="input_file" /><form:errors cssClass="error" path="image" />
			</div>
			
			<!-- <tr>
                                                    <th><label for="photo">Photo|Video<br />Audio|PDF</label></th>
                                                    <td>
                                                        <input type="file" name="image" id="image" class="input_file" /><form:errors cssClass="error" path="image" />
                                                    </td>
                                                </tr> -->
					<form:hidden path="itemLat" id="itemLat" />
			<form:hidden path="itemLng" id="itemLng" />
			<form:hidden path="itemZoom" id="itemZoom" />
			
			<div id="map" style="width: 98%; height: 200px; margin-bottom: 5px;"></div>
			<div>
				<input type="submit" class="btn btn-block btn-success" value="Save" />
			</div>
					
		</form:form>

	</div>
	<!-- container -->
</body>
</html>
