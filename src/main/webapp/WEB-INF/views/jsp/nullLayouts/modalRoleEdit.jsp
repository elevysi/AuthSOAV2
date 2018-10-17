<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../../layout/taglib.jsp"%>
<c:url var="formActionUrl" value="/ui/ajax/role/modalEdit/${role.id}" />

	<form:form commandName="role" class="modalForm" action="${formActionUrl}">
		<form:hidden path="id" />
		<div class="form-item">
			<label>Name <span class="color-red">*</span> <form:errors path="name" /></label>
			<form:input path="name" cssClass="form-control margin-bottom-20" minlength="3" required="required"/>
		</div>
		
	</form:form>


<script>
$(document).ready(function(){});
</script>



