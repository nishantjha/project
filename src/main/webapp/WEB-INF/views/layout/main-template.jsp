<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<style type="text/css">
	/* Global Links Top */
	#GlobalLinksTop{
	}
	#GlobalLinksTop div{
		width:900px;
		overflow:hidden;
		float:right;
	}
	#GlobalLinksTop ul{
		float:right;
		margin:0 -13px 3px 0;
	}
	#GlobalLinksTop li{
		display:block;
		float:left;
		text-transform:uppercase;
		font-weight:bold;
		padding:0 13px 0 12px;
	}
	#GlobalLinksTop li a{
		text-decoration:none;
		color:#000;
	}
	
	#Menu{
	}
	#Menu li{
		display:block;
		text-transform:uppercase;
		font-weight:bold;
		padding:0 13px 0 12px;
	}
	
	/* Form style table elements */
	.StickyTable{
		position:relative;
	}
	.StickyTable td,
	.StickyTable th{
		font-weight:normal;
		vertical-align:top;
		padding:5px 0 5px 0;
		background:none;
	}
	.StickyTable th{
		text-align:left;
		padding-right:12px;
	}
	.StickyTable th label{
		display:block;
		padding:0 0 0 0;
		position:relative;
	}
	.StickyTable th label span{
		position:absolute;
		right:-8px;
		top:0;
	}
	* html .StickyTable th label span{
		right:3px;
	}
	
</style>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sticky Notes</title>
</head>
<body>
	<table align="center">
		<tr>
			<td colspan="2">
				<tiles:insertAttribute name="globallinks"></tiles:insertAttribute>
			</td>
		</tr>
		
		<tr>
			<td colspan="2">
				<tiles:insertAttribute name="header"></tiles:insertAttribute>
			</td>
		</tr>
		
		<tr>
			<td width="20%">
				<tiles:insertAttribute name="menu"></tiles:insertAttribute>
			</td>
			<td>
				<tiles:insertAttribute name="body"></tiles:insertAttribute>
			</td>
		</tr>
		
		<tr>  
            <td colspan="2">
            	<tiles:insertAttribute name="footer"></tiles:insertAttribute>
            </td>  
        </tr>
	</table>
</body>
</html>