<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../layout/taglib.jsp" %>
<div class="row">
	<div class="col-md-10 col-md-offset-1 col-sm-11 col-sm-offset-1">
	<form class="reg-page modalSignIn" action="<spring:url value="/ui/ajax/modal/doLogIn"/>" method="POST">
		
			<div class="reg-header">
				<h2><spring:message code="label.login.title" /></h2>
			</div>
			
			<div class="alert alert-warning">Your session has expired; please sign in again. <button class="close" aria-hidden="true" data-dismiss="alert" type="button">×</button></div>
			<div id="communicationDiv" style="display:none;">
				<button class="close" aria-hidden="true" data-dismiss="alert" type="button">×</button>
			</div>

			<div class="input-group margin-bottom-20">
				<span class="input-group-addon"><i class="fa fa-user"></i></span>
					<input type="text" class="form-control" placeholder='<spring:message code="label.login.usernamePlaceHolder" />' name="username">
			</div>
			<div class="input-group margin-bottom-20">
				<span class="input-group-addon"><i class="fa fa-lock"></i></span>
					<input type="password" class="form-control" placeholder='<spring:message code="label.login.passwordPlaceHolder" />' name="password">
			</div>

			<div class="row">
				<div class="col-md-6 checkbox">
					<label><input type="checkbox"> <spring:message code="label.login.remember" /></label>
				</div>
				<div class="col-md-6">
					
				</div>
			</div>

			<hr>

			<h4><spring:message code="label.login.passwordForgot.title" /></h4>
			<p>
				<spring:message code="label.login.passwordForgot.explanation1" /> <a class="color-green" href="#"><spring:message code="label.login.passwordForgot.explanationLink" /></a> <spring:message code="label.login.passwordForgot.explanation2" />
			</p>
<!-- 			<button type="submit" value="Submit">Submit form</button> -->
		</form>
	</div>
</div>
<!--/row-->