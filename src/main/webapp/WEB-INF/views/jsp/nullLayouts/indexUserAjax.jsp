<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../layout/taglib.jsp" %>

<table class="table table-striped">
	<thead>
		<tr>
			<th>Id</th>
			<th>First Name</th>
			<th>Last Name</th>
			<th>Username</th>
			<th>Active</th>
			<th>Roles</th>
			<th>Actions</th>
		</tr>
	</thead>
	<tbody>
	
	
	<c:forEach items="${users}" var="user">
		<tr>
			<td>
				${user.id}
			</td>
			<td>
				${user.first_name}
			</td>
			<td>
				${user.last_name}
			</td>
			
			<td>
				${user.username}
			</td>
			
			<td>
				${user.active}
			</td>
			
			<td>	
				<ul class="list">
				<c:forEach items="${user.roles}" var="role">
					<li><c:out value="${role.name}"></c:out></li>
				</c:forEach>
				</ul>
			</td>
			
			<td>
				<a href="<spring:url value='/ui/ajax/admin/user/modalView/${user.id}' />" class="btn-u btn-u-blue btn-xs modalOpen noSave"><i class="glyphicon glyphicon-hand-right"></i> View</a>
				<a href="<spring:url value='/ui/ajax/admin/user/modalEdit/${user.id}' />" class="btn-u btn-u-yellow btn-xs modalOpen"><i class="glyphicon glyphicon-pencil"></i> Edit</a>
				<a href="<spring:url value='/ui/admin/updatePassword/${user.username}' />" class="btn-u btn-u-brown btn-xs"><i class="glyphicon glyphicon-lock"></i> Password</a>
				<a href="#" class="btn-u btn-u-red btn-xs triggerRemoveUser" onclick="event.preventDefault(); deleteUser(${user.id})"><i class="glyphicon glyphicon-trash"></i> Delete</a>
				
				<%-- <form action="<spring:url value="/ui/admin/user/delete/${user.id}"/>" method="post">

                      		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                      		<input type="submit" value="Delete" class="btn-u btn-u-red btn-xs triggerRemove">
                         </form> --%>
				
				
			</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
