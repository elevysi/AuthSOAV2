<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<h1>Authentication Server</h1>
<%@ include file="../../layout/taglib.jsp"%>
<security:authorize access="!isAuthenticated()">
	<h3>Please <a href="<spring:url value="/login"/>">Login</a>.</h3>
</security:authorize>

<security:authorize access="isAuthenticated()">
	<h3>Hello <security:authentication property="principal.username" />, please follow the <a href="<spring:url value="/ui/user/profile"/>">link</a> </h3>
</security:authorize>

