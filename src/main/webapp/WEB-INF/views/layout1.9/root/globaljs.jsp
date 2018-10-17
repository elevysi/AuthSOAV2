<%@ include file="../../layout/taglib.jsp"%>
<c:url var="checkSessionValidityUrl" value="/ui/ajax/login/issessionvalid"/>
<c:url var="dialogLoginUrl" value="/ui/ajax/modal/login"/>
<c:url var="dialogLoginPostUrl" value="/ui/ajax/modal/doLogIn"/>
<c:url var ="logoutUrl" value="/logout"/>
<c:url var ="logoutSuccess" value="/ui/logout/success"/>

<script type="text/javascript">

var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

function confirmDelete(delForm, delUrl) { 
    if (confirm("Are you sure you want to delete?")) {
        delForm.action = delUrl;
        return true;                      
    }
    return false;                        
}

function showModalUIMessage(_msg, _reloadFlag){
	
	$('<div></div>').appendTo('body')
	  .html('<div><h6>'+_msg+'</h6></div>')
	  .dialog({
	      modal: true, title: 'Message', zIndex: 10000, autoOpen: true,
	      buttons: {
	          Close: function () {
		        	  if(_reloadFlag){
		        		  location.reload(true);
		        	  }
		        	  $(this).dialog("close");
	          }
	      },
	      close: function (event, ui) {
	          $(this).remove();
	      }
	});
	
}

$(document).ready(function(){
	$(".triggerRemove").click(function(e){
			e.preventDefault();
			$("#modalRemove .removeBtn").attr("href", $(this).attr("href"));
			$("#modalRemove").modal();
	});
	
	$(".logoutBtn").click(function(e){
		e.preventDefault();
		
		$.ajax({
			type: "POST",
			url: "${logoutUrl}",
			data: token,
	        beforeSend:function(xhr){
	             xhr.setRequestHeader(header, token);
	        },
			success: function(returnValue){
				window.location.href = "${logoutSuccess}";
			},
			error: function(data){
				console.log(data);
				alert("There was an error");
			}
		});
	});
});

//Global Variables needed all along

var checkusersessionlink = '${checkSessionValidityUrl}';
var dialogloginlink = '${dialogLoginUrl}';
var dialogloginPostLink = '${dialogLoginPostUrl}';

var dialogReferer = false;

var loginReferedFromMainWindow = false;
var loginReferedFromModalWindow = false;
var loginReferedFromSaveOfModalWindow = false;

var showSave = true;

$(document).ready(function(){
	
	$('#modalholder').on('hide.bs.modal', function () {
	    tinyMCE.editors=[];
    });
});

//Executed when button with class overlay is clicked, used to launch generic modal
$(document).on('click', '.modalOpen', function(e){
  e.preventDefault();
  var requestedLink = $(this).attr('href');
  
  if($(this).hasClass("noSave")){
	  showSave = false;
  } 
  
  dialogReferer = requestedLink;

  $.getJSON(checkusersessionlink, function(returnValue){
	  if(returnValue){
		  $("#modalholder .modal-body").html('');
		  $("#modalholder .modal-body").addClass('loader');
		  $("#modalholder #modalAdd").modal('show');
		  
		  	if (! showSave){
		  		$("#modalholder .saveBtn").hide();
			}

		  $.get(requestedLink, function(html){
		    $("#modalholder .modal-hrefLink").attr('href', requestedLink);
		    $("#modalholder .modal-body").removeClass('loader');
		    $("#modalholder .modal-body").html(html);
		    if (requestedLink.match('#')) {
		        if($('.nav-tabs a')){
		        	$('.nav-tabs a[href=#'+requestedLink.split('#')[1]+']').tab('show');
		        }
		    	
		    }
		  });
	  }else{
		  loginReferedFromModalWindow = true;
		  $("#loginmodalholder .modal-body").html('');
		  	$("#loginmodalholder .modal-body").addClass('loader');
			$("#loginmodalholder #dialog-login").modal('show');

		  $.get(dialogloginlink, function(html){
		    $("#loginmodalholder .modal-hrefLink").attr('href', dialogloginlink);
		    $("#loginmodalholder .modal-body").removeClass('loader');
		    $("#loginmodalholder .modal-body").html(html);
		  });

	  }
  });
});

//Global for AJAX POST

$(function(){

	//Used to ajax post content of the generic modal
  $("#modalholder #saveModal").click(function(e){
    e.preventDefault();
    
    var callingURL;
	if(showSave){
		callingURL = $(".modal-hrefLink").attr('href');
	}else{
		callingURL = $(this).attr('href');
	}

    $.getJSON(checkusersessionlink, function(returnValue){
    	if(returnValue){
    		
    		var addInput = $("<input>").attr("type", "hidden").attr("name", "_csrf.parameterName").val("${_csrf.token}");
    		tinyMCE.triggerSave();
    		
    		$('.modalForm').append($(addInput));
    		var _postindData = $('.modalForm').serialize();
    		
	    	if(callingURL){
    			if($(".modalForm").valid()){
    	    	
    	    		$.ajax({
	  	                  type: "POST",
	  	                  url: callingURL,
	  	                  data: _postindData,
	  	                  dataType: "json",
	  	                  beforeSend:function(xhr){
			  	 	         xhr.setRequestHeader(header, token)
			  	 	      },
	  	                  success: function(msg){
	  	                	  console.log(msg);
	  	                    location.reload(true);
	  	                  },
	  	                  error: function(){
	  	                      alert("Failed to save!");
	  	                  }
     				 });
    	    	}else{
    	    		$("#modalholder #modalAdd").modal('hide');
    	    	}
    	        

    	    }else{
    	    	//Just Hide Modal
    	    	$("#modalholder #modalAdd").modal('hide');
    	    }
		  }else{
			  	loginReferedFromSaveOfModalWindow = true;

				//Hide the modal to show the login modal
				$("#modalholder #modalAdd").modal('hide');
			  	
			  	$("#loginmodalholder .modal-body").html('');
			  	$("#loginmodalholder .modal-body").addClass('loader');
				$("#loginmodalholder #dialog-login").modal('show');

			  $.get(dialogloginlink, function(html){
			    $("#loginmodalholder .modal-hrefLink").attr('href', dialogloginlink);
			    $("#loginmodalholder .modal-body").removeClass('loader');
			    $("#loginmodalholder .modal-body").html(html);
			  });

		  }
    });
    
    });

	//For the login modal dialog post
  $("#loginmodalholder #modalLoginSubmitBtn").click(function(e){
	    e.preventDefault();
	   
	    if($(".modalSignIn").valid()){
	        $.ajax({
	                  type: "POST",
	                  url: dialogloginPostLink,	
	                  data: $('.modalSignIn').serialize(),
	                  dataType : "json",
	                  success: function(returned){
	                	  	                	  		                  
	                	  if(returned.responseCode === "SUCCESS"){ //if LdapAuth fails, weird happens due ldap->bind(), better off checking strings

							//Hide the Login Window
							$("#loginmodalholder #dialog-login").modal('hide');

							if(loginReferedFromModalWindow){
								 $("#modalholder .modal-body").html('');
		            			  $("#modalholder .modal-body").addClass('loader');
		            			  $("#modalholder #modalAdd").modal('show');

		            			  $.get(dialogReferer, function(html){
		            			    $("#modalholder .modal-hrefLink").attr('href', dialogReferer);
		            			    $("#modalholder .modal-body").removeClass('loader');
		            			    $("#modalholder .modal-body").html(html);
		            			  });
							}else if(loginReferedFromMainWindow){
								 $("#bottomCommunicationDiv").html("<div class=\"alert alert-success attentionVIP\">Login was successful, you may now continue to the next step.</div>");
								 $("#bottomCommunicationDiv").delay("5000").fadeOut("slow");
							}else if(loginReferedFromSaveOfModalWindow){
								console.log("Here");
								$("#modalholder #modalAdd").modal('show');
								$("#modalholder #modalFlashCommunications").html("<div class=\"alert alert-success attentionVIP\">Login was successful, you may now continue to the next step.</div>");
								$("#modalholder #modalFlashCommunications").delay("5000").fadeOut("slow");
							}

	                		 
							  
			              }else{
			            	  var _closeBtn = '<button class="close" aria-hidden="true" data-dismiss="alert" type="button">×</button>';
				              $("#communicationDiv").html("<div class=\"alert alert-danger attentionVIP\">"+_closeBtn+"Login Failed, please try again.</div>");
				              $("#communicationDiv").show();
			              }
		                  
	                   
	                      //$("#thanks").html(msg) //hide button and show thank you
	                      //$("#form-content").modal('hide'); //hide popup  
	                  },
	                  error: function(){
	                      alert("Failed to log you in.");
	                  }
	       });

	    }
	    
	    });

});


var FancyBox = function () {

    return {
            
        //Fancybox
        initFancybox: function () {
            jQuery(".fancybox").fancybox({
            groupAttr: 'data-rel',
            prevEffect: 'fade',
            nextEffect: 'fade',
            openEffect  : 'elastic',
            closeEffect  : 'fade',
            closeBtn: true,
            helpers: {
                title: {
                        type: 'float'
                    }
                }
            });
            
           /*  $('.ajaxFancyBox').on('click', function(e){
            	e.preventDefault();
                $.fancybox({
                   maxWidth    : 800,
                    maxHeight   : 600,
                    fitToView   : false,
                    width       : '70%',
                    height      : '70%',
                    autoSize    : false,
                    closeClick  : false,
                    closeEffect : 'fade',
                    openEffect  : 'elastic',
                    type: 'ajax',
                    href: $(this).attr("href"),
                });
            }); */

            $(".fbox-modal").fancybox({
                maxWidth    : 800,
                maxHeight   : 600,
                fitToView   : false,
                width       : '70%',
                height      : '70%',
                autoSize    : false,
                autoScale   : true,
                closeClick  : false,
                closeEffect : 'fade',
                openEffect  : 'elastic'
            });
        }

    };

}(); 
</script>