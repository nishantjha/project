<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<script type="text/javascript">
	function setHiddenValue() {
		var selected = document.getElementById("selectedFolderName");
		document.getElementById("selectedFolder").value = selected.options[selected.selectedIndex].value;	
	}
</script>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Upload File</title>
</head>
<body>
	<form:form method="POST" enctype="multipart/form-data" action="/savefile" modelAttribute="filesForm">
		<input type="hidden" id="selectedFolder" name="selectedFolder" value="">
		<table>
			<tr>
				<td>
					Select Folder to Upload File:
				</td>
				<td>
					<form:select path="" id="selectedFolderName" onchange="javascript:setHiddenValue();">
						<form:option value="" label="--Select--" />
						<c:forEach var="data" items="${filesForm.filesToList}" varStatus="loop">    
							<c:if test="${!data.file}">
								<form:option value="${data.name}" label="${data.name}" />
							</c:if>
						</c:forEach>
					</form:select>
				</td>
			</tr>
				
			<tr>
				<td>
					File to upload:
				</td>
			</tr>
			<tr>
				<td>
					<input type="file" name="file">
				</td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="submit" value="Upload File">
				</td>
			</tr>
		</table>
		
	</form:form>
</body>
</html>