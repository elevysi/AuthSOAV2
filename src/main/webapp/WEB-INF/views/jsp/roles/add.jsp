<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../../layout/taglib.jsp"%>

<div class="col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
	<form:form commandName="role" class="reg-page registrationForm">
		<div class="reg-header">
			<h2>Add a new role</h2>
			
		</div>

		<label>Name <span class="color-red">*</span></label>
		<form:input path="name" cssClass="form-control margin-bottom-20" />
		<form:errors path="name" />

		<hr>

		<div class="row">
			
			<div class="col-lg-6 text-right">
				<button class="btn-u" type="submit">Add</button>
			</div>
		</div>
	</form:form>
</div>


<script>
	$(document).ready(function() {});
</script>




