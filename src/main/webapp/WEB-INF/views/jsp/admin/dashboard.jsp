<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../layout/taglib.jsp" %>
<c:url var="deleteUserUrl" value="/ui/ajax/admin/user/modalDelete" />
<c:url var="deleteRoleUrl" value="/ui/ajax/admin/role/modalDelete" />

<c:url var="searchUrl" value="/ui/admin/searchUser" />


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

<div class="row">
	<!--Service Block v3-->
	<div class="row margin-bottom-10">
		<div class="col-sm-6 sm-margin-bottom-20">
			<div class="service-block-v3 service-block-u">
				<i class="icon-users"></i> <span class="service-heading">Overall
					Visits</span> <span class="counter">52,147</span>

				<div class="clearfix margin-bottom-10"></div>

				<div class="row margin-bottom-20">
					<div class="col-xs-6 service-in">
						<small>Last Week</small>
						<h4 class="counter">1,385</h4>
					</div>
					<div class="col-xs-6 text-right service-in">
						<small>Last Month</small>
						<h4 class="counter">6,048</h4>
					</div>
				</div>
				<div class="statistics">
					<h3 class="heading-xs">
						Statistics in Progress Bar <span class="pull-right">67%</span>
					</h3>
					<div class="progress progress-u progress-xxs">
						<div style="width: 67%" aria-valuemax="100" aria-valuemin="0"
							aria-valuenow="67" role="progressbar"
							class="progress-bar progress-bar-light"></div>
					</div>
					<small>11% less <strong>than last month</strong></small>
				</div>
			</div>
		</div>

		<div class="col-sm-6">
			<div class="service-block-v3 service-block-blue">
				<i class="icon-screen-desktop"></i> <span class="service-heading">Overall
					Page Views</span> <span class="counter">324,056</span>

				<div class="clearfix margin-bottom-10"></div>

				<div class="row margin-bottom-20">
					<div class="col-xs-6 service-in">
						<small>Last Week</small>
						<h4 class="counter">26,904</h4>
					</div>
					<div class="col-xs-6 text-right service-in">
						<small>Last Month</small>
						<h4 class="counter">124,766</h4>
					</div>
				</div>
				<div class="statistics">
					<h3 class="heading-xs">
						Statistics in Progress Bar <span class="pull-right">89%</span>
					</h3>
					<div class="progress progress-u progress-xxs">
						<div style="width: 89%" aria-valuemax="100" aria-valuemin="0"
							aria-valuenow="89" role="progressbar"
							class="progress-bar progress-bar-light"></div>
					</div>
					<small>15% higher <strong>than last month</strong></small>
				</div>
			</div>
		</div>
	</div>
	
	
	<div class="panel panel-grey margin-bottom-40" id="">
		<div class="panel-heading">
			<h3 class="panel-title"><i class="fa fa-user"></i>Users</h3>
		</div>
		<div class="panel-body">
			<div id="pageContainer">
				<%@ include file="../nullLayouts/indexUserAjax.jsp"%>
			</div>
			
			<c:url var="baseUrl" value="/ui/ajax/admin/user?page=" />
			<tiles:putAttribute name="basePaginationUrl" value="${baseUrl}" cascade="true"/>
			<tiles:insertAttribute name="paginationAjax" ignore="true"/>
			
		</div>
		
	</div>
	
	<hr/>
	<a href="<spring:url value='/ui/admin/user/add' />" class="btn btn-sm btn-primary"><i class="glyphicon glyphicon-plus"></i> New User</a>
	<hr/>
	
	<!-- Begin Table Search v2 -->
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
	<!-- End Table Search v2 -->
	
	<hr/>
	<a href="<spring:url value='/ui/admin/role/add' />" class="btn btn-sm btn-primary"><i class="glyphicon glyphicon-plus"></i> New Role</a>
	<hr/>
</div>

<script type="text/javascript">

var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");


$(document).ready(function(){
	$(".loadPageBtn").on("click", function(e){
		
		e.preventDefault();
		var _clickedLink = $(this).attr("href");
		console.log("clicked link is "+_clickedLink);
		//load the conteent in the container
		
		$.ajax({
			url : _clickedLink,
			beforeSend:function(xhr){
  	             xhr.setRequestHeader(header, token);
  	        },
			dataType : "html",
			type : "GET",
			success : function(htmlData){
				
				$("#pageContainer").empty();
				$("#pageContainer").html(htmlData);
				
			},
			error : function(data){
				alert("There was an error; please reload the page");
			}
		});
		
	});
});



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

function deleteUser(userID){
	
	var _deletedUser = false;
	var _message = "";
	
	$('<div></div>').appendTo('body')
	  .html('<div><h6>Are you sure you want to delete this User?</h6></div>')
	  .dialog({
	      modal: true, title: 'Please Confirm', zIndex: 10000, autoOpen: true,
	      buttons: {
	          Yes: function () {
	        	  
	        		$.ajax({
	        			url : "${deleteUserUrl}",
	        			beforeSend:function(xhr){
	       	             xhr.setRequestHeader(header, token);
	       	        },
	        			type : 'POST',
	        			data : {"userID" : userID, "_csrf.parameterName" : "${_csrf.token}"},
	        			dataType : "json",
	        			success: function(returnData){
	        				_message = returnData.message;
	        				if(returnData.code == 1){
	        					_deletedUser = true;
	        				}
	        			} ,
	        			error: function (data){
	        	    	   		alert("There was an error; the operation has failed.");
	        	       },
	        	       complete : function (data){
		        	    	   if(_deletedUser){
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

