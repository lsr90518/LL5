<%@page contentType="text/html" pageEncoding="UTF-8"
	trimDirectiveWhitespaces="true"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style type="text/css">
.activeTab {
	color: #f0ad4e;
	font-size: 27px;
}

.notActiveTab {
	color: #999;
	font-size: 27px;
}

.homeTab {
	color: white;
	font-size: 25px;
}
</style>
<nav class="navbar navbar-default navbar-fixed-bottom" role="navigation"
	style="height: 2%">
	<!-- We use the fluid option here to avoid overriding the fixed width of a normal container within the narrow content columns. -->
	<div class="container-fluid">
		<div class="row">
			<div class="col-xs-2 col-md-2">
				<a class="btn-lg btn-block" style="text-align: center" href="#"
					onclick="getWordsByLocation()"><span
					class="glyphicon glyphicon-map-marker notActiveTab navTab"></span></a>
			</div>
			<div class="col-xs-2 col-md-2">
				<a class="btn-lg btn-block" style="text-align: center"
					href="http://ll.artsci.kyushu-u.ac.jp/learninglog2"><span
					class="glyphicon glyphicon-tasks notActiveTab navTab"></span></a>
			</div>
			<div class="col-xs-4 col-md-4">
				<a class="btn-lg btn-block"
					style="text-align: center; background-color: #e67e22;"
					href="/LL5/item"><span
					class="glyphicon glyphicon-home notActiveTab homeTab navTab"></span></a>
			</div>
			<div class="col-xs-2 col-md-2">
				<a class="btn-lg btn-block" style="text-align: center"
					href="/LL5/quiz"><span
					class="glyphicon glyphicon-th-large notActiveTab navTab"></span></a>
			</div>
			<div class="col-xs-2 col-md-2">
				<a class="btn-lg btn-block" style="text-align: center"
					href="/LL5/profile"><span
					class="glyphicon glyphicon-user notActiveTab navTab"></span></a>
			</div>
		</div>
	</div>
</nav>

<script type="text/javascript">
	function getWordsByLocation() {
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(showPosition);
		} else {
			alert("Geolocation is not supported by this browser.");
		}
	}
	function showPosition(position) {
		var location =  position.coords.longitude;
		alert(location);
		$.get("/LL5/location/"+location,function(data){
			alert(data);
		});
	}
</script>