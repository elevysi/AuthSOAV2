<%@ include file="../../layout/taglib.jsp"%>


<table class="table table-striped">
	<tbody>
	
		<tr>
			<th>ID</th>
			<td>
				<c:out value="${client.id}"/>
			</td>
		</tr>
		<tr>
			<th>Client ID</th>
			<td>
				<c:out value="${client.client_id}"/>
			</td>
		</tr>
		<tr>
			<th>Resource IDs</th>
			<td>
				<c:out value="${client.resource_ids}"/>
			</td>
		</tr>
		<tr>
			<th>Scope</th>
			<td>
				<c:out value="${client.scope}"/>
			</td>
		</tr>
		<tr>
			<th>Authorized Grant Types</th>
			<td>
				<c:out value="${client.authorized_grant_types}"/>
			</td>
		</tr>
		<tr>
			<th>Web Redirect URI</th>
			<td>
				<c:out value="${client.web_server_redirect_uri}"/>
			</td>
		</tr>
		<tr>
			<th>Authorities</th>
			<td>
				<c:out value="${client.authorities}"/>
			</td>
		</tr>
		<tr>
			<th>Access Token Validity</th>
			<td>
				<c:out value="${client.access_token_validity}"/>
			</td>
		</tr>
		<tr>
			<th>Refresh Token Validity</th>
			<td>
				<c:out value="${client.refresh_token_validity}"/>
			</td>
		</tr>
		<tr>
			<th>Auto-Approve</th>
			<td>
				<c:out value="${client.autoapprove}"/>
			</td>
		</tr>
		<tr>
			<th>Additional Information</th>
			<td>
				<c:out value="${client.additional_information}"/>
			</td>
		</tr>
		<tr>
			<th>Created</th>
			<td>
				<c:out value="${client.modified}"/>
			</td>
		</tr>
		<tr>
			<th>Modified</th>
			<td>
				<c:out value="${client.created}"/>
			</td>
		</tr>	
	</tbody>
</table>