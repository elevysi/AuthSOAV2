<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../../layout/taglib.jsp"%>
<c:url var="formActionUrl" value="/ui/ajax/oauthClientDetail/modalEdit/${oauthClientDetail.id}" />
<c:url var="clientIDCheckUrl" value="/ui/ajax/oauthClientDetail/clientIDAvailable?update=${oauthClientDetail.client_id}" />

	<form:form commandName="oauthClientDetail" class="modalForm" action="${formActionUrl}">
		<form:hidden path="id" />
		<div class="form-item">
			<label>Client ID <span class="color-red">*</span> <form:errors path="client_id" /></label>
			<form:input path="client_id" cssClass="form-control margin-bottom-20" minlength="3" required="required"/>
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
		
	</form:form>


<script>
$(document).ready(function(){
	
	$(".modalForm").validate(
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
						equalTo : "#secret"
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



