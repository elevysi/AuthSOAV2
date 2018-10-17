<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../layout/taglib.jsp"%>

<!--=== Search Block Version 2 ===-->
 <div class="search-block-v2">
    <div class="container">
        <div class="col-md-6 col-md-offset-3">
            <h2>Search again</h2>
            <form action="<spring:url value="/ui/admin/user/search"/>" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <div class="input-group">
            
                <input type="text" class="form-control" placeholder="Search users" name="term">
                
                <span class="input-group-btn">
                    <button class="btn-u" type="submit"><i class="fa fa-search"></i></button>
                </span>
            </div>
            </form>
        </div>
    </div>
</div><!--/container-->
<!--=== End Search Block Version 2 ===-->

<hr />

<c:choose>
	<c:when test="${not empty users}">
		
		<span class="results-number"><c:out value="${fn:length(users)}"/> results for <c:out value="${term}"></c:out></span>
		
		<hr />
		
		<div class="panel panel-grey margin-bottom-40" id="">
			<div class="panel-heading">
				<h3 class="panel-title"><i class="fa fa-user"></i>Matching Users</h3>
			</div>
			<div class="panel-body">
				<div id="pageContainer"><%@ include file="../nullLayouts/indexUserAjax.jsp"%></div>
				
				<c:url var="baseUrl" value="/ui/admin/user/search?term=${term}&page=" />
				<tiles:putAttribute name="basePaginationUrl" value="${baseUrl}" cascade="true"/>
				<tiles:insertAttribute name="paginationAjax" ignore="true"/>
				
			</div>
			
		</div>
		
	</c:when>
	
	<c:otherwise>
		<p class="alert alert-danger">
			No results found for term "<c:out value="${term}" />
			"
		</p>
	</c:otherwise>
</c:choose>