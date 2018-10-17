<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../../layout/taglib.jsp"%>
<c:url var="formActionUrl" value="/ui/user/profile" />
<c:url var="emailCheckUrl" value="/ui/ajax/user/emailRegistered?update=${user.email}" />
<c:url var="usernameCheckUrl" value="/ui/ajax/user/usernameAvailable?update=${user.username}" />

<c:url var ="tinymceCss" value='/css/tinymce.css'/>

<h2>Update Account Details</h2>
	<form:form commandName="user" class="reg-page registrationForm" action="${formActionUrl}">
		<form:hidden path="id" />
		<input name="oldUsername" value="${user.username}" type="hidden"/>
		
		<div class="form-item">
			<label>First Name <span class="color-red">*</span> <form:errors path="first_name" /></label>
			<form:input path="first_name" cssClass="form-control margin-bottom-20" minlength="3" required="required"/>
		</div>

		<div class="form-item">
			<label>Last Name <span class="color-red">*</span> <form:errors path="last_name" /></label>
			<form:input path="last_name" cssClass="form-control margin-bottom-20" minlength="3" required="required"/>
		</div>

		<div class="form-item">
			<label>Email Address <span class="color-red">*</span> <form:errors path="email" /></label>
			<div class="input-group margin-bottom-20">
				<span class="input-group-addon"> <i class="fa fa-envelope"></i></span>
				<form:input path="email" cssClass="form-control margin-bottom-20" minlength="3" required="required" type="email"/>
				
			</div>
		</div>

		<div class="form-item">
			<label>Username <span class="color-red">*</span> <form:errors path="username" /></label>
			<div class="input-group margin-bottom-20">
				<span class="input-group-addon"><i class="fa fa-user"></i></span>
				<form:input path="username" cssClass="form-control margin-bottom-20" minlength="3" required="required"/>
				
			</div>
		</div>
		
		<div class="row">
			<div class="col-md-4 form-group g-mb-20">
			
				<div class="form-item">
					<label>Country <form:errors path="country" /></label>
					<form:input path="country" cssClass="form-control margin-bottom-20"/>
				</div>
			</div>
			
			<div class="col-md-4 form-group g-mb-20">
			
				<div class="form-item">
					<label>Country Code<form:errors path="country_code" /></label>
					<form:input path="country_code" cssClass="form-control margin-bottom-20"/>
				</div>
			</div>
			
			
			<div class="col-md-4 form-group g-mb-20">
			
				<div class="form-item">
					<label>State<form:errors path="state" /></label>
					<form:input path="state" cssClass="form-control margin-bottom-20"/>
				</div>
			</div>
		</div>
		
		<div class="row">
			<div class="col-md-6 form-group g-mb-20">
					<div class="form-item">
						<label>Town / City <form:errors path="town" /></label>
						<form:input path="town" cssClass="form-control margin-bottom-20"/>
					</div>
			</div>
			
			<div class="col-md-6 form-group g-mb-20">
				<div class="form-item">
					<label>Postal Code <form:errors path="postal_code" /></label>
					<form:input path="postal_code" cssClass="form-control margin-bottom-20"/>
				</div>
			</div>
		</div>
		
		
		<div class="row">
		
			<div class="col-md-6 form-group g-mb-20">
				<div class="form-item">
					<label>Street <form:errors path="street" /></label>
					<form:input path="street" cssClass="form-control margin-bottom-20"/>
				</div>
			</div>
			
			<div class="col-md-6 form-group g-mb-20">
					<div class="form-item">
						<label>Street Number <form:errors path="street_number" /></label>
						<form:input path="street_number" cssClass="form-control margin-bottom-20"/>
					</div>
			</div>
		</div>
		
		<div class="row">
			<div class="col-md-6 form-group g-mb-20">
				<div class="form-item">
					<label>Phone Code <form:errors path="phone_code" /></label>
					<form:input path="phone_code" cssClass="form-control margin-bottom-20" />
				</div>
			</div>
				
			<div class="col-md-6 form-group g-mb-20">
				<div class="form-item">
					<label>Phone Number <form:errors path="phone_number" /></label>
					<form:input path="phone_number" cssClass="form-control margin-bottom-20"/>
				</div>
			</div>
		</div>	
		
		<div class="row">
			<div class="form-item">
				<label>Bio <form:errors path="bio" /></label>
				<form:textarea path="bio" cssClass="editorTextarea form-control margin-bottom-20"/>
			</div>
		</div>
		
		<hr/>
			
		<div class="row">
			
			<div class="col-lg-6 text-right">
				<button class="btn-u" type="submit">Save</button>
			</div>
		</div>
		
	</form:form>

<script>
$(document).ready(function(){
	$(".modalForm").validate(
		{	
			rules :{
				username:{
					required : true,
					minlength : 3,
					remote : {
						url : "${usernameCheckUrl}",
						type : "GET",
						data : {
							username: function(){
								return $("#username").val();
							}
						}
					}
				},
				first_name: {
					required : true,
					minlength : 3
				},
				last_name: {
					required : true,
					minlength : 3
				},
				email: {
					required : true,
					email : true,
					remote : {
						url : "${emailCheckUrl}",
						type : "GET",
						data : {
							email: function(){
								return $("#email").val();
							}
						}
					}
				}
			},
			highlight:function(element){
				$(element).closest(".form-item").removeClass('has-success').addClass('has-error')
			},
			unhighlight:function(element){
				$(element).closest(".form-item").removeClass('has-error').addClass('has-success')
			},
			messages :{
				username : {
					remote : "Such a username already exists"
				}
			}
		}
	);
	
	
});

<!-- TinyMCE -->

tinymce.init({
	  mode : "specific_textareas",
      editor_selector : "editorTextarea",
	  height: 500,
	  theme: 'modern',
	  content_css : "${tinymceCss}",
	  plugins: [
	    'advlist autolink lists link image charmap print preview hr anchor pagebreak',
	    'searchreplace wordcount sh4tinymce visualblocks visualchars code fullscreen',
	    'insertdatetime media nonbreaking save table contextmenu directionality',
	    'emoticons template paste textcolor colorpicker textpattern imagetools'
	  ],
	  toolbar1: 'insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image',
	  toolbar2: 'print preview media | forecolor backcolor emoticons | sh4tinymce',
	  image_advtab: true,
	  templates: [
	    { title: 'Test template 1', content: 'Test 1' },
	    { title: 'Test template 2', content: 'Test 2' }
	  ]
	  
});

</script>



