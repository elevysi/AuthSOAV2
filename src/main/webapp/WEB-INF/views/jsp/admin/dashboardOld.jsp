<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../layout/taglib.jsp" %>
<c:url var="deleteUserUrl" value="/ui/ajax/admin/user/modalDelete" />
<c:url var="deleteRoleUrl" value="/ui/ajax/admin/role/modalDelete" />

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
	<!--/end row-->
	<!--End Service Block v3-->

	<hr>

	<div class="row margin-bottom-20">
		<!--Profile Post-->
		<div class="col-sm-6">
			<div class="panel panel-profile no-bg">
				<div class="panel-heading overflow-h">
					<h2 class="panel-title heading-sm pull-left">
						<i class="fa fa-pencil"></i>Notes
					</h2>
					<a href="#"><i class="fa fa-cog pull-right"></i></a>
				</div>
				<div id="scrollbar" class="panel-body no-padding mCustomScrollbar"
					data-mcs-theme="minimal-dark">
					<div class="profile-post color-one">
						<span class="profile-post-numb">01</span>
						<div class="profile-post-in">
							<h3 class="heading-xs">
								<a href="#">Creative Blog</a>
							</h3>
							<p>How to market yourself as a freelance designer</p>
						</div>
					</div>
					<div class="profile-post color-two">
						<span class="profile-post-numb">02</span>
						<div class="profile-post-in">
							<h3 class="heading-xs">
								<a href="#">Codrops Collective #117</a>
							</h3>
							<p>Web Design &amp; Development News</p>
						</div>
					</div>
					<div class="profile-post color-three">
						<span class="profile-post-numb">03</span>
						<div class="profile-post-in">
							<h3 class="heading-xs">
								<a href="#">Sketch Toolbox</a>
							</h3>
							<p>Basic prototype of a package manager for Sketch</p>
						</div>
					</div>
					<div class="profile-post color-four">
						<span class="profile-post-numb">04</span>
						<div class="profile-post-in">
							<h3 class="heading-xs">
								<a href="#">Amazing Portfolio</a>
							</h3>
							<p>Create a free online portfolio lookbook with Readz</p>
						</div>
					</div>
					<div class="profile-post color-five">
						<span class="profile-post-numb">05</span>
						<div class="profile-post-in">
							<h3 class="heading-xs">
								<a href="#">Discover New Features</a>
							</h3>
							<p>More than 100+ amazing add-ons coming soon...</p>
						</div>
					</div>
					<div class="profile-post color-six">
						<span class="profile-post-numb">06</span>
						<div class="profile-post-in">
							<h3 class="heading-xs">
								<a href="#">Corporation Plans</a>
							</h3>
							<p>Discussion of new corporation plans</p>
						</div>
					</div>
					<div class="profile-post color-seven">
						<span class="profile-post-numb">07</span>
						<div class="profile-post-in">
							<h3 class="heading-xs">
								<a href="#">Project Updates</a>
							</h3>
							<p>New features of coming update</p>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--End Profile Post-->

		<!--Profile Event-->
		<div class="col-sm-6 md-margin-bottom-20">
			<div class="panel panel-profile no-bg">
				<div class="panel-heading overflow-h">
					<h2 class="panel-title heading-sm pull-left">
						<i class="fa fa-briefcase"></i>Upcoming Events
					</h2>
					<a href="#"><i class="fa fa-cog pull-right"></i></a>
				</div>
				<div id="scrollbar2" class="panel-body no-padding mCustomScrollbar"
					data-mcs-theme="minimal-dark">
					<div class="profile-event">
						<div class="date-formats">
							<span>25</span> <small>05, 2014</small>
						</div>
						<div class="overflow-h">
							<h3 class="heading-xs">
								<a href="#">GitHub seminars in Japan.</a>
							</h3>
							<p>Lorem Ipsum is simply dummy text of the printing and
								typesetting industry printing.</p>
						</div>
					</div>
					<div class="profile-event">
						<div class="date-formats">
							<span>31</span> <small>06, 2014</small>
						</div>
						<div class="overflow-h">
							<h3 class="heading-xs">
								<a href="#">Bootstrap Update</a>
							</h3>
							<p>Lorem Ipsum is simply dummy text of the printing and
								typesetting industry printing.</p>
						</div>
					</div>
					<div class="profile-event">
						<div class="date-formats">
							<span>07</span> <small>08, 2014</small>
						</div>
						<div class="overflow-h">
							<h3 class="heading-xs">
								<a href="#">Apple Conference</a>
							</h3>
							<p>Lorem Ipsum is simply dummy text of the printing and
								typesetting industry printing.</p>
						</div>
					</div>
					<div class="profile-event">
						<div class="date-formats">
							<span>22</span> <small>10, 2014</small>
						</div>
						<div class="overflow-h">
							<h3 class="heading-xs">
								<a href="#">Backend Meeting</a>
							</h3>
							<p>Lorem Ipsum is simply dummy text of the printing and
								typesetting industry printing.</p>
						</div>
					</div>
					<div class="profile-event">
						<div class="date-formats">
							<span>14</span> <small>11, 2014</small>
						</div>
						<div class="overflow-h">
							<h3 class="heading-xs">
								<a href="#">Google Conference</a>
							</h3>
							<p>Lorem Ipsum is simply dummy text of the printing and
								typesetting industry printing.</p>
						</div>
					</div>
					<div class="profile-event">
						<div class="date-formats">
							<span>05</span> <small>12, 2014</small>
						</div>
						<div class="overflow-h">
							<h3 class="heading-xs">
								<a href="#">FontAwesome Update</a>
							</h3>
							<p>Lorem Ipsum is simply dummy text of the printing and
								typesetting industry printing.</p>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--End Profile Event-->
	</div>
	<!--/end row-->

	<hr>

	<!--Profile Blog-->
	<div class="panel panel-profile">
		<div class="panel-heading overflow-h">
			<h2 class="panel-title heading-sm pull-left">
				<i class="fa fa-tasks"></i>Contacts
			</h2>
			<a href="page_profile_users.html"
				class="btn-u btn-brd btn-brd-hover btn-u-dark btn-u-xs pull-right">View
				All</a>
		</div>
		<div class="panel-body">
			<div class="row">
				<div class="col-sm-6">
					<div class="profile-blog blog-border">
						<img class="rounded-x" src="<c:url value='/resources/img/testimonials/img1.jpg'/>"
							alt="">
						<div class="name-location">
							<strong>Mikel Andrews</strong> <span><i
								class="fa fa-map-marker"></i><a href="#">California,</a> <a
								href="#">US</a></span>
						</div>
						<div class="clearfix margin-bottom-20"></div>
						<p>Donec non dignissim eros. Mauris faucibus turpis volutpat
							sagittis rhoncus. Pellentesque et rhoncus sapien, sed ullamcorper
							justo.</p>
						<hr>
						<ul class="list-inline share-list">
							<li><i class="fa fa-bell"></i><a href="#">12
									Notifications</a></li>
							<li><i class="fa fa-group"></i><a href="#">54 Followers</a></li>
							<li><i class="fa fa-twitter"></i><a href="#">Retweet</a></li>
						</ul>
					</div>
				</div>

				<div class="col-sm-6">
					<div class="profile-blog blog-border">
						<img class="rounded-x" src="<c:url value='/resources/img/testimonials/img4.jpg'/>"
							alt="">
						<div class="name-location">
							<strong>Natasha Kolnikova</strong> <span><i
								class="fa fa-map-marker"></i><a href="#">Moscow,</a> <a href="#">Russia</a></span>
						</div>
						<div class="clearfix margin-bottom-20"></div>
						<p>Donec non dignissim eros. Mauris faucibus turpis volutpat
							sagittis rhoncus. Pellentesque et rhoncus sapien, sed ullamcorper
							justo.</p>
						<hr>
						<ul class="list-inline share-list">
							<li><i class="fa fa-bell"></i><a href="#">37
									Notifications</a></li>
							<li><i class="fa fa-group"></i><a href="#">46 Followers</a></li>
							<li><i class="fa fa-twitter"></i><a href="#">Retweet</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--End Profile Blog-->

	<hr>

	<div class="row">
		<!--Alert-->
		<div class="col-sm-7 sm-margin-bottom-30">
			<div class="panel panel-profile">
				<div class="panel-heading overflow-h">
					<h2 class="panel-title heading-sm pull-left">
						<i class="fa fa-send"></i> Alarm Notification
					</h2>
					<a href="#"><i class="fa fa-cog pull-right"></i></a>
				</div>
				<div id="scrollbar3" class="panel-body no-padding mCustomScrollbar"
					data-mcs-theme="minimal-dark">
					<div class="alert-blocks alert-blocks-pending alert-dismissable">
						<button aria-hidden="true" data-dismiss="alert" class="close"
							type="button">x</button>
						<img class="rounded-x" src="<c:url value='/resources/img/testimonials/img3.jpg'/>"
							alt="">
						<div class="overflow-h">
							<strong class="color-yellow">Pending... <small
								class="pull-right"><em>Just now</em></small></strong>
							<p>Your friend request has been sent.</p>
						</div>
					</div>
					<div class="alert-blocks alert-blocks-success alert-dismissable">
						<button aria-hidden="true" data-dismiss="alert" class="close"
							type="button">x</button>
						<img class="rounded-x" src="<c:url value='/resources/img/testimonials/img2.jpg'/>"
							alt="">
						<div class="overflow-h">
							<strong class="color-green">Accepted. <small
								class="pull-right"><em>7 hours ago</em></small></strong>
							<p>Your friend request has been accepted.</p>
						</div>
					</div>
					<div class="alert-blocks alert-blocks-info alert-dismissable">
						<button aria-hidden="true" data-dismiss="alert" class="close"
							type="button">x</button>
						<i class="icon-custom rounded-x icon-bg-blue fa fa-bolt"></i>
						<div class="overflow-h">
							<strong class="color-blue">Info <small
								class="pull-right"><em>2 days ago</em></small></strong>
							<p>Your friend request has been denied :)</p>
						</div>
					</div>
					<div class="alert-blocks alert-blocks-error alert-dismissable">
						<button aria-hidden="true" data-dismiss="alert" class="close"
							type="button">x</button>
						<img class="rounded-x" src="<c:url value='/resources/img/testimonials/img6.jpg'/>"
							alt="">
						<div class="overflow-h">
							<strong class="color-red">Denied! <small
								class="pull-right"><em>2 days ago</em></small></strong>
							<p>Your friend request has been denied.</p>
						</div>
					</div>
					<div class="alert-blocks alert-dismissable">
						<button aria-hidden="true" data-dismiss="alert" class="close"
							type="button">x</button>
						<i class="icon-custom rounded-x icon-bg-dark fa fa-magic"></i>
						<div class="overflow-h">
							<strong class="color-dark">Default <small
								class="pull-right"><em>Just now</em></small></strong>
							<p>
								<strong>Adam Johnson's</strong> friend request pending..
							</p>
						</div>
					</div>
					<div class="alert-blocks alert-blocks-pending alert-dismissable">
						<button aria-hidden="true" data-dismiss="alert" class="close"
							type="button">x</button>
						<i class="icon-custom rounded-x icon-bg-yellow fa fa-info"></i>
						<div class="overflow-h">
							<strong class="color-yellow">Pending <small
								class="pull-right"><em>Just now</em></small></strong>
							<p>
								<strong>Adam Johnson's</strong> friend request pending..
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--End Alert-->

		<div class="col-sm-5">
			<div class="panel panel-profile">
				<div class="panel-heading overflow-h">
					<h2 class="panel-title heading-sm pull-left">
						<i class="fa fa-comments-o"></i> Discussions
					</h2>
					<a href="page_profile_comments.html"
						class="btn-u btn-brd btn-brd-hover btn-u-dark btn-u-xs pull-right">View
						All</a>
				</div>
				<div id="scrollbar4" class="panel-body no-padding mCustomScrollbar"
					data-mcs-theme="minimal-dark">
					<div class="comment">
						<img src="<c:url value='/resources/img/testimonials/img6.jpg'/>" alt="">
						<div class="overflow-h">
							<strong>Taylor Lee<small class="pull-right"> 25m</small></strong>
							<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
							<ul class="list-inline comment-list">
								<li><i class="fa fa-heart"></i> <a href="#">23</a></li>
								<li><i class="fa fa-comments"></i> <a href="#">5</a></li>
							</ul>
						</div>
					</div>
					<div class="comment">
						<img src="<c:url value='/resources/img/testimonials/img2.jpg'/>" alt="">
						<div class="overflow-h">
							<strong>Miranda Clarsson<small class="pull-right">
									44m</small></strong>
							<p>Donec cursus, orci non posuere luctus, risus massa luctus
								nisi, sit amet cursus leo massa id arcu. Nunc tincidunt magna
								sit amet sapien congue.</p>
							<ul class="list-inline comment-list">
								<li><i class="fa fa-heart"></i> <a href="#">23</a></li>
								<li><i class="fa fa-comments"></i> <a href="#">5</a></li>
							</ul>
						</div>
					</div>
					<div class="comment">
						<img src="<c:url value='/resources/img/testimonials/img4.jpg'/>" alt="">
						<div class="overflow-h">
							<strong>Natasha Kolnikova<small class="pull-right">
									7h</small></strong>
							<p>Suspendisse est est, sollicitudin eget auctor et, pharetra
								eu sapien. Mauris mollis libero ac auctor iaculis.</p>
							<ul class="list-inline comment-list">
								<li><i class="fa fa-heart"></i> <a href="#">23</a></li>
								<li><i class="fa fa-comments"></i> <a href="#">5</a></li>
							</ul>
						</div>
					</div>
					<div class="comment">
						<img src="<c:url value='/resources/img/testimonials/img1.jpg'/>" alt="">
						<div class="overflow-h">
							<strong>Mikel Andrews<small class="pull-right">
									15h</small></strong>
							<p>Nam ut dolor cursus nibh aliquet bibendum in eget risus.</p>
							<ul class="list-inline comment-list">
								<li><i class="fa fa-heart"></i> <a href="#">20</a></li>
								<li><i class="fa fa-comments"></i> <a href="#">5</a></li>
							</ul>
						</div>
					</div>
					<div class="comment">
						<img src="<c:url value='/resources/img/testimonials/img7.jpg'/>" alt="">
						<div class="overflow-h">
							<strong>Edward Rooster<small class="pull-right">
									1d</small></strong>
							<p>Nam ut dolor cursus nibh aliquet bibendum in eget risus.
								Mauris mollis libero ac auctor iaculis.</p>
							<ul class="list-inline comment-list">
								<li><i class="fa fa-heart"></i> <a href="#">23</a></li>
								<li><i class="fa fa-comments"></i> <a href="#">5</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/end row-->

	<hr>

	<!--Table Search v1-->
	<div class="panel panel-grey margin-bottom-40">
		<div class="panel-heading">
			<h3 class="panel-title"><i class="fa fa-user"></i>Users</h3>
		</div>
		<div class="panel-body">
		
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
			
		</div>
		
	</div>
	<!--End Table Search v1-->
	
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

