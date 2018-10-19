<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../../layout/taglib.jsp"%>
<c:url var="formActionUrl" value="/ui/admin/oauthClientDetail/add" />
<c:url var="clientIDCheckUrl" value="/ui/ajax/oauthClientDetail/clientIDAvailable" />


<div class="col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
	<form:form commandName="oauthClientDetail" id="addClientForm" action="${formActionUrl}">
		<div class="form-item">
			<label>Client ID <span class="color-red">*</span> <form:errors path="client_id" /></label>
			<form:input path="client_id" cssClass="form-control margin-bottom-20" minlength="3" required="required"/>
		</div>
		
		<div class="row">
			<div class="col-sm-6">
				<label>Secret <span class="color-red">*</span></label>
				<div class="input-group margin-bottom-20">
					<span class="input-group-addon"> <i class="fa fa-lock"></i></span>
					<form:password path="client_secret"
						cssClass="form-control margin-bottom-20" />
					<form:errors path="client_secret" />
				</div>
			</div>
			<div class="col-sm-6">
				<label>Confirm Secret <span class="color-red">*</span></label>
				<div class="input-group margin-bottom-20">
					<span class="input-group-addon"> <i class="fa fa-key"></i></span> <input
						type="password" name="secretAgain" id="secretAgain"
						class="form-control margin-bottom-20">
				</div>
			</div>
		</div>
		
		<div class="form-item">
			<label>Reosource IDs <form:errors path="resource_ids" /></label>
			<form:input path="resource_ids" cssClass="form-control margin-bottom-20" />
		</div>
		
		<div class="form-item">
			<label>Scope <form:errors path="scope" /></label>
			<form:input path="scope" cssClass="form-control margin-bottom-20" />
		</div>
		
		<div class="form-item">
			<label>Authorized Grant Types <form:errors path="authorized_grant_types" /></label>
			<form:input path="authorized_grant_types" cssClass="form-control margin-bottom-20" />
		</div>
		
		<div class="form-item">
			<label>Authorities<form:errors path="authorities" /></label>
			<form:input path="authorities" cssClass="form-control margin-bottom-20" />
		</div>
		
		<div class="form-item">
			<label>Access Token Validity<form:errors path="access_token_validity" /></label>
			<form:input path="access_token_validity" cssClass="form-control margin-bottom-20" />
		</div>
		
		<div class="form-item">
			<label>Refresh Token Validity<form:errors path="refresh_token_validity" /></label>
			<form:input path="refresh_token_validity" cssClass="form-control margin-bottom-20" />
		</div>
		
		<div class="form-item">
			<label>Autoapprove<form:errors path="autoapprove" /></label>
			<form:input path="autoapprove" cssClass="form-control margin-bottom-20" />
		</div>
		
		<div class="form-item">
			<label>Additional Information<form:errors path="additional_information" /></label>
			<form:textarea path="additional_information" cssClass="form-control margin-bottom-20" />
		</div>
		
		<div class="row">
			
			<div class="col-lg-6 text-right">
				<button class="btn-u" type="submit">Add</button>
			</div>
		</div>
	</form:form>
</div>


<script>
	$(document).ready(function(){
			$("#addClientForm").validate(
				{
					rules : {
						client_id:{
							required : true,
							minlength : 3,
							remote : {
								url : "${clientIDCheckUrl}",
								type : "GET",
								data : {
									client_id: function(){
										return $("#client_id").val();
									}
								}
							}
						},
						secret : {
							required : true,
							minlength : 5
						},
						secretAgain : {
							required : true,
							minlength : 5,
							equalTo : "#client_secret"
						}
					},
					highlight : function(element) {
						$(element).closest(".form-group").removeClass(
								'has-success').addClass('has-error')
					},
					unhighlight : function(element) {
						$(element).closest(".form-group").removeClass(
								'has-error').addClass('has-success')
					},
					messages : {
						name : {
							remote : "Such a username already exists"
						}
					}
				});
	});
</script>




