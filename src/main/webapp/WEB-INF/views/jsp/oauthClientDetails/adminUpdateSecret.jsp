<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../../layout/taglib.jsp"%>
<c:url var="clientPassUpdateUrl" value="/ui/admin/oauthClientDetail/updateSecret" />

<h3>Admin Update Password for Oauth Client - ${oauthClientDetail.client_id}</h3>

<form:form method="post" class="reg-page updatePassForm" action="${clientPassUpdateUrl}">
	<input  value="${oauthClientDetail.id}" name="id" type="hidden"/>
	<div class="reg-header">
		<h2>Update your password</h2>
		
	</div>

	<div class="row">
		<div class="col-sm-6 form-item">
			<label>Secret <span class="color-red">*</span></label>
			<div class="input-group margin-bottom-20">
				<span class="input-group-addon"> <i class="fa fa-lock"></i></span>
				<input type="password" id="newSecret" name="newSecret" class="form-control margin-bottom-20" minlength="5" required="required"/>
				
			</div>
		</div>
		<div class="col-sm-6 form-item">
			<label>Confirm Secret <span class="color-red">*</span></label>
			<div class="input-group margin-bottom-20">
				<span class="input-group-addon"> <i class="fa fa-key"></i></span> <input
					type="password" name="secretAgain" id="secretAgain"
					class="form-control margin-bottom-20">
			</div>
		</div>
	</div>

	<hr>
	
	<div class="row">
		
		<div class="col-lg-6 text-right">
			<button class="btn-u" type="submit">Update</button>
		</div>
	</div>

</form:form>


<script>
$(document).ready(function(){
	$(".updatePassForm").validate(
		{	
			rules : {
				newPassword: {
					required : true,
					minlength : 5
				},
				secretAgain: {
					required : true,
					minlength : 5,
					equalTo : "#newSecret"
				}
			},
			highlight:function(element){
				$(element).closest(".form-item").removeClass('has-success').addClass('has-error')
			},
			unhighlight:function(element){
				$(element).closest(".form-item").removeClass('has-error').addClass('has-success')
			}
		}
	);
});

</script>




