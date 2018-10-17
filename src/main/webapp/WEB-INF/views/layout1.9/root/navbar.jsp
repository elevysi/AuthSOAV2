<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ include file="../../layout/taglib.jsp"%>
<!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse mega-menu navbar-responsive-collapse">
            <div class="container">
                <ul class="nav navbar-nav">
                    <!-- Home -->
                    <li><a href="<spring:url value="/"/>">Home</a></li>
                    <!-- End Home -->
					
                    
                    <security:authorize access="isAuthenticated()">
						<!-- Blog -->
						<li class="dropdown"><a href="javascript:void(0);"
							class="dropdown-toggle" data-toggle="dropdown"> Profile</a>
							<ul class="dropdown-menu">
								<li><a href="<spring:url value="/ui/user/profile/"/>">Home - <security:authentication property="principal.username" /> - Update Account</a></li>
								<li><a href="<spring:url value="/ui/user/updatePassword"/>">Password Update</a></li>
								
							</ul>
						</li>
						<!-- End Blog -->
					
					
	
						<security:authorize access="hasRole('ROLE_ADMIN')">
							
							<!-- Admin -->
							<li class="dropdown"><a href="javascript:void(0);"
								class="dropdown-toggle" data-toggle="dropdown"> Admin</a>
								<ul class="dropdown-menu">
									<li><a href="<spring:url value="/ui/admin/dashboard"/>">Dashboard</a></li>
								</ul>
							</li>
							<!-- End Admin -->
						</security:authorize>
						<c:url var="logoutPostUrl" value="/logout" />
						<li>
							<%-- <form action="<spring:url value="/logout"/>" method="post">
	                        		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	                        		<input type="submit" value="Sign Out">
                            </form> --%>
						
						
						<a class="logoutBtn" href="<spring:url value="/logout"/>">Sign out</a>
						
						</li>
						
					</security:authorize>
					
					<security:authorize access="!isAuthenticated()">
						<li><a href="<spring:url value="/auth/rqstd/login"/>">Sign in</a></li>
					</security:authorize>
                    

                    <!-- Search Block -->
                    <li>
                        <i class="search fa fa-search search-btn"></i>
                        <div class="search-open">
                        	<form action="<spring:url value="/public/search"/>" method="post">
                        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            	<div class="input-group animated fadeInDown">
									<input type="text" class="form-control" placeholder="Search" name="globalSearch">
	                                <span class="input-group-btn">
	                                    <input class="btn-u" type="submit" value="Go">
	                                </span>
                              
                            	</div>
                            </form>
                        </div>
                    </li>
                    <!-- End Search Block -->
                </ul>
            </div><!--/end container-->
        </div><!--/navbar-collapse-->