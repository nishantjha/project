<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<script type="text/javascript">
	function logout() {
		var confirmMsg = confirm("Do you want to Logout...?");
		if(confirmMsg) {
			document.execCommand("ClearAuthenticationCache");
			window.close();
		}
 	}
	
	function help() {
		alert("This is help...");
	}
</script>

<form:form modelAttribute="filesForm">
	<div id="GlobalLinksTop">
		<div>
		    <ul>
		    	<li>Welcome ${filesForm.loggedInUser}</li>
				<li><a href="#" onclick="javascript:logout();">Logout</a></li>
				<li><a href="#" onclick="javascript:help();">Help</a></li>
			</ul>
		</div>
	</div>
</form:form>