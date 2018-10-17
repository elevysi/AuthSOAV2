<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../../layout/taglib.jsp"%>
<c:url var ="tinymceCss" value='/css/tinymce.css'/>

<div class="col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
	<form:form commandName="user" class="reg-page registrationForm">
		<div class="reg-header">
			<h2>Add a new user</h2>
			
		</div>

		<label>First Name <span class="color-red">*</span></label>
		<form:input path="first_name" cssClass="form-control margin-bottom-20" />
		<form:errors path="first_name" />


		<label>Last Name <span class="color-red">*</span></label>
		<form:input path="last_name" cssClass="form-control margin-bottom-20" />
		<form:errors path="last_name" />


		<label>Email Address <span class="color-red">*</span></label>
		<div class="input-group margin-bottom-20">
			<span class="input-group-addon"> <i class="fa fa-envelope"></i></span>
			<form:input path="email" cssClass="form-control margin-bottom-20" />
			<form:errors path="email" />
		</div>

		<label>Username <span class="color-red">*</span></label>
		<div class="input-group margin-bottom-20">
			<span class="input-group-addon"><i class="fa fa-user"></i></span>
			<form:input path="username" cssClass="form-control margin-bottom-20" />
			<form:errors path="username" />
		</div>

		<div class="row">
			<div class="col-sm-6">
				<label>Password <span class="color-red">*</span></label>
				<div class="input-group margin-bottom-20">
					<span class="input-group-addon"> <i class="fa fa-lock"></i></span>
					<form:password path="password"
						cssClass="form-control margin-bottom-20" />
					<form:errors path="password" />
				</div>
			</div>
			<div class="col-sm-6">
				<label>Confirm Password <span class="color-red">*</span></label>
				<div class="input-group margin-bottom-20">
					<span class="input-group-addon"> <i class="fa fa-key"></i></span> <input
						type="password" name="passwordAgain" id="passwordAgain"
						class="form-control margin-bottom-20">
				</div>
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



		<div class="row">
			<form:checkboxes path="roles" element="label class='checkbox'"
				items="${roles}" itemValue="id" itemLabel="name" />
			<form:errors path="roles" cssClass="error" />
		</div>


		<hr>

		<div class="row">
			
			<div class="col-lg-6 text-right">
				<button class="btn-u" type="submit">Add</button>
			</div>
		</div>
	</form:form>
</div>

<script>
	$(document).ready(
			function() {
				$(".registrationForm").validate(
						{
							rules : {
								username : {
									required : true,
									minlength : 3,
								/* remote : {
									url : "<spring:url value='/register/available.html'/>",
									type : "GET",
									data : {
										username: function(){
											return $("#name").val();
										}
									}
								} */
								},
								email : {
									required : true,
									email : true
								},
								password : {
									required : true,
									minlength : 5
								},
								passwordAgain : {
									required : true,
									minlength : 5,
									equalTo : "#password"
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