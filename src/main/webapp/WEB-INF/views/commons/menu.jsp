<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
	function getAllFiles() {
		var filesForm = document.forms['filesForm'];
		filesForm.method = "get";
		filesForm.action = "getFiles";
		filesForm.submit();
	}
	
	function uploadFile() {
		var filesForm = document.forms['filesForm'];
		filesForm.method = "get";
		filesForm.action = "upload";
		filesForm.submit();
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Menu</title>
</head>
<body>
	<form:form modelAttribute="filesForm">
		<div id="Menu">
			<ul>
				<li id="menu1" onclick="javascript:getAllFiles();"><a  href="#">Get all Files</a></li>
				<li id="menu2" onclick="javascript:uploadFile();"><a href="#">Upload</a></li>
			</ul>
		</div>
	</form:form>
</body>
</html>