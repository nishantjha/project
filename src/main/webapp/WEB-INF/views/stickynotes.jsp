<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>

<script type="text/javascript">
	function deleteFile(folderName, fileName) {
		var filesForm = document.forms['filesForm'];
		filesForm.method = "post";
		var name = fileName.substring(0, fileName.lastIndexOf('.'));
		var extns = fileName.substring(fileName.lastIndexOf('.') + 1, fileName.length);
		var url = "delete?folderName="+folderName+"&fileName="+name+"&extn="+extns;
		filesForm.action = url;
		filesForm.submit();
	}
	
	(function(document) {
		'use strict';

		var LightTableFilter = (function(Arr) {

			var _input;

			function _onInputEvent(e) {
				_input = e.target;
				var tables = document.getElementsByClassName(_input.getAttribute('data-table'));
				Arr.forEach.call(tables, function(table) {
					Arr.forEach.call(table.tBodies, function(tbody) {
						Arr.forEach.call(tbody.rows, _filter);
					});
				});
			}

			function _filter(row) {
				var text = row.textContent.toLowerCase(), val = _input.value.toLowerCase();
				row.style.display = text.indexOf(val) === -1 ? 'none' : 'table-row';
			}

			return {
				init: function() {
					var inputs = document.getElementsByClassName('light-table-filter');
					Arr.forEach.call(inputs, function(input) {
						input.oninput = _onInputEvent;
					});
				}
			};
		})(Array.prototype);

		document.addEventListener('readystatechange', function() {
			if (document.readyState === 'complete') {
				LightTableFilter.init();
			}
		});

	})(document);
	
</script>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome to Sticky Notes</title>
</head>
<body>
	<form:form modelAttribute="filesForm">
	
		<!-- <input type="hidden" name="_method" value="DELETE"/>  -->
		
		<div style="overflow-y: auto; overflow-x: auto; height: 376px;">
			<input type="search" class="light-table-filter" data-table="order-table" placeholder="Filter">
			<table class="order-table table">
				<tr>
					<td>
						<h4>Folders/Files</h4>
					</td>
					<td>
						<h4>Date Modified</h4>
					</td>
					<td>
						<h4>Type</h4>
					</td>
					<td>
						<h4>Size</h4>
					</td>
					<td>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
				
				<c:forEach var="dataFolder" items="${filesForm.filesToList}" varStatus="loop">    
					<c:if test="${!dataFolder.file}">
						<tr style="border: none; background-color: rgb(76, 153, 204); color: rgb(255, 255, 255);">
							<td>
								${dataFolder.name}
							</td>
							<td>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							</td>
							<td>
								${dataFolder.type}
							</td>
							<td>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							</td>
							<td>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							</td>
						</tr>
						
						<c:forEach var="nested" items="${dataFolder.nestedFolders}" varStatus="dataLoop">
							<tr style="border: none;">
								<td>
									${nested.name}
								</td>
								<td>
									${nested.lastModified}
								</td>
								<td>
									${nested.type}
								</td>
								<td>
									${nested.fileSize}
								</td>
								
								<td>
									<a href="javascript:deleteFile('${dataFolder.name}', '${nested.name}');">Delete</a>
								</td>
							</tr>
						</c:forEach>
					</c:if>
				</c:forEach>
				
				<tr>
					<td colspan="5">
						&nbsp;
					</td>
				</tr>
				
				<c:forEach var="dataFile" items="${filesForm.filesToList}" varStatus="fileLoop">    
					<c:if test="${dataFile.file}">
						<tr style="border: none;">
							<td>
								${dataFile.name}
							</td>
							<td>
								${dataFile.lastModified}
							</td>
							<td>
								${dataFile.type}
							</td>
							<td>
								${dataFile.fileSize}
							</td>
							<td>
								<a href="javascript:deleteFile('noFolder', '${dataFile.name}');">Delete</a>
							</td>
						</tr>
					</c:if>
				</c:forEach>
				
			</table>
		</div>
	</form:form>
	
	<script>
		document.documentElement.style.overflow=document.body.style.overflow='hidden';
    </script>
        
</body>
</html>