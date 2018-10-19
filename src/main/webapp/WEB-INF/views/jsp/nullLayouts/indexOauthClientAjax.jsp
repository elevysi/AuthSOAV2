<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../layout/taglib.jsp" %>

<table class="table table-striped">
	<thead>
		<tr>
			<th>Client ID</th>
			<th>Resource Ids</th>
			<th>Scope</th>
			<th>Auto-Approve</th>
			<th>Actions</th>
		</tr>
	</thead>
	<tbody>
	
	
	<c:forEach items="${oauthClients}" var="client">
		<tr>
			<td>
				${client.client_id}
			</td>
			<td>
				${client.resource_ids}
			</td>
			<td>
				${client.scope}
			</td>
			
			<td>
				${client.autoapprove}
			</td>
			
			<td>
				<a href="<spring:url value='/ui/ajax/admin/oauthClientDetail/modalView/${client.id}' />" class="btn-u btn-u-blue btn-xs modalOpen noSave"><i class="glyphicon glyphicon-hand-right"></i> View</a>
				<a href="<spring:url value='/ui/ajax/admin/oauthClientDetail/modalEdit/${client.id}' />" class="btn-u btn-u-yellow btn-xs modalOpen"><i class="glyphicon glyphicon-pencil"></i> Edit</a>
				<a href="<spring:url value='/ui/admin/oauthClientDetail/updateSecret/${client.id}' />" class="btn-u btn-u-brown btn-xs"><i class="glyphicon glyphicon-lock"></i> Password</a>
				<a href="#" class="btn-u btn-u-red btn-xs triggerRemoveUser" onclick="event.preventDefault(); deleteClient(${client.id})"><i class="glyphicon glyphicon-trash"></i> Delete</a>
				
			</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
