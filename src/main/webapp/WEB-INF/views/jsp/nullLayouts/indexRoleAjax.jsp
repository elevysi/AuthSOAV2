<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../layout/taglib.jsp" %>

<c:url var="deleteRoleUrl" value="/ui/ajax/admin/role/modalDelete" />
<c:url var="firstUrl" value="/ui/admin/role?page=1" />
<c:url var="lastUrl" value="/ui/admin/role?page=${usersLog.totalPages}" />
<c:url var="prevUrl" value="/ui/admin/role?page=${currentIndex - 1}" />
<c:url var="nextUrl" value="/ui/admin/role?page=${currentIndex + 1}" />


	<h3>List of Roles</h3>
	<hr />
	
	
	<div class="panel panel-grey margin-bottom-40">
		<div class="panel-heading">
			<h3 class="panel-title"><i class="fa fa-user"></i>Roles</h3>
		</div>
		<div class="panel-body">
		
			<table class="table table-striped">
				<thead>
					<tr>
						<th>Id</th>
						<th>Name</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
				
				
				<c:forEach items="${roles}" var="role">
					<tr>
						<td>
							${role.id}
						</td>
						<td>
							${role.name}
						</td>
						
						<td>
							<a href="<spring:url value='/ui/ajax/admin/role/modalEdit/${role.id}' />" class="btn-u btn-u-yellow btn-xs modalOpen"><i class="glyphicon glyphicon-pencil"></i> Edit</a>
							<a href="#" class="btn-u btn-u-red btn-xs" onclick="event.preventDefault(); deleteRole(${role.id})"><i class="glyphicon glyphicon-trash"></i> Delete</a>
							
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			
		</div>
		
	</div>
	
	<div class="text-center">
    <ul class="pagination">
        <c:choose>
            <c:when test="${currentIndex == 1}">
                <li class="disabled"><a href="#">&lt;&lt;</a></li>
                <li class="disabled"><a href="#">&lt;</a></li>
            </c:when>
            <c:otherwise>
                <li><a href="${firstUrl}">&lt;&lt;</a></li>
                <li><a href="${prevUrl}">&lt;</a></li>
            </c:otherwise>
        </c:choose>
        <c:forEach var="i" begin="${beginIndex}" end="${endIndex}">
            <c:url var="pageUrl" value="/ui/admin/role=?page=${i}" />
            <c:choose>
                <c:when test="${i == currentIndex}">
                    <li class="active"><a href="${pageUrl}"><c:out value="${i}" /></a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="${pageUrl}"><c:out value="${i}" /></a></li>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        <c:choose>
            <c:when test="${currentIndex == usersLog.totalPages}">
                <li class="disabled"><a href="#">&gt;</a></li>
                <li class="disabled"><a href="#">&gt;&gt;</a></li>
            </c:when>
            <c:otherwise>
                <li><a href="${nextUrl}">&gt;</a></li>
                <li><a href="${lastUrl}">&gt;&gt;</a></li>
            </c:otherwise>
        </c:choose>
    </ul>
</div>
	
	
	
	<hr/>
	<a href="<spring:url value='/ui/admin/role/add' />" class="btn btn-sm btn-primary"><i class="glyphicon glyphicon-plus"></i> New Role</a>
	
<script>

var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");


function deleteRole(roleID){
	
	var _deletedRole = false;
	var _message = "";
	
	$('<div></div>').appendTo('body')
	  .html('<div><h6>Are you sure you want to delete this Role?</h6></div>')
	  .dialog({
	      modal: true, title: 'Please Confirm', zIndex: 10000, autoOpen: true,
	      buttons: {
	          Yes: function () {
	        	  
	        		$.ajax({
	        			url : "${deleteRoleUrl}",
	        			beforeSend:function(xhr){
	       	             xhr.setRequestHeader(header, token);
	       	        },
	        			type : 'POST',
	        			data : {"roleID" : roleID, "_csrf.parameterName" : "${_csrf.token}"},
	        			dataType : "json",
	        			success: function(returnData){
	        				_message = returnData.message;
	        				if(returnData.code == 1){
	        					_deletedRole = true;
	        				}
	        			} ,
	        			error: function (data){
	        	    	   		alert("There was an error; the operation has failed.");
	        	       },
	        	       complete : function (data){
		        	    	   if(_deletedRole){
		        	    	 	  	showModalUIMessage(_message, true);
		        	    	 	}else{
		        	    		 	 showModalUIMessage(_message, false);
		        	    		}
		        	    	   
	        	       }
	        		});
		             
	          },
	          No: function () {
	              $(this).dialog("close");
	          }
	      },
	      close: function (event, ui) {
	          $(this).remove();
	      }
	});
		
}

</script>