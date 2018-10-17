<%@ include file="../../layout/taglib.jsp"%>

<div class="panel panel-grey margin-bottom-40">
		<div class="panel-heading">
			<h3 class="panel-title"><i class="fa fa-user"></i>List of Users</h3>
		</div>
		<div class="panel-body">
		
			<table class="table table-striped">
				<thead>
					<tr>
						<th>Id</th>
						<th>First Name</th>
						<th>Last Name</th>
						<th>Username</th>
						<th>Address</th>
						<th>Bio</th>
						<th>Roles</th>
						
						
					</tr>
				</thead>
				<tbody>
				
				
				<tr>
					<td>
						<c:out value="${user.id}" />
					</td>
					<td>
						<c:out value="${user.first_name}" />
					</td>
					<td>
						<c:out value="${user.last_name}" />
					</td>
					
					<td>
						<c:out value="${user.username}" />
					</td>
					
					<td>
					
						<c:out value="${user.street}" /> <c:out value="${user.street_number}" />
						<c:out value="${user.town}" />
						<c:out value="${user.country}" /> <c:out value="${user.country_code}" />
						
						<c:out value="${user.phone_code}" /> <c:out value="${user.phone_number}" />
						
					</td>
					
					<td>
						<c:out value="${user.bio}" escapeXml="false" />
					</td>
					
					<td>	
						<ul class="list">
						<c:forEach items="${user.roles}" var="role">
							<li><c:out value="${role.name}"></c:out></li>
						</c:forEach>
						</ul>
					</td>
					
				</tr>
				
				</tbody>
			</table>
			
		</div>
		
	</div>