<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->  
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->  
<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->  
<head>
<%@ include file="taglib.jsp"%>
	<title><tiles:getAsString name="title" /></title>
   

    <!-- Meta -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Favicon -->
    <link rel="shortcut icon" href="favicon.ico">

    <!-- CSS Global Compulsory -->
    <link rel="stylesheet" href="<c:url value='/resources/plugins/bootstrap/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">

    <!-- CSS Implementing Plugins -->
    <link rel="stylesheet" href="<c:url value='/resources/plugins/line-icons/line-icons.css'/>">
    <link rel="stylesheet" href="<c:url value='/resources/plugins/font-awesome/css/font-awesome.min.css'/>">

    <!-- CSS Page Style -->    
    <link rel="stylesheet" href="<c:url value='/resources/css/pages/page_error4_404.css'/>">

    <!-- CSS Theme -->    
    <link rel="stylesheet" href="<c:url value='/resources/css/themes/default.css" id="style_color'/>">

    <!-- CSS Customization -->
    <link rel="stylesheet" href="<c:url value='/resources/css/custom.css'/>">
</head> 

<body>

    <!--=== Error V4 ===-->    
    <div class="container content">
        <!--Error Block-->
        <div class="row">
            <div class="col-md-8 col-md-offset-2">
                <div class="error-v4">
                    <a href="#"><img src="<c:url value='/resources/img/logo2-default.png" alt="'/>"></a>
                    <h1>404</h1>
                    <span class="sorry">Sorry, the page you were looking for could not be found!</span>
                    <div class="row">
                        <div class="col-md-6 col-md-offset-3">
                            <a href="<spring:url value="/"/>" class="btn-u btn-brd btn-u-light"> Go Back to Main Page</a>
                        </div> 
                    </div> 
                </div>
            </div>
        </div>
    </div><!--/container-->
    <!--End Error Block-->

    <!--=== Sticky Footer ===-->
    <div class="container sticky-footer">
        <p class="copyright-space">
            2015 &copy; Elevysi. ALL Rights Reserved. 
        </p>  
    </div>
    <!--=== End Sticky Footer ===-->

<!-- JS Global Compulsory -->           
<script type="text/javascript" src="<c:url value='/resources/plugins/jquery-1.10.2.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/plugins/jquery-migrate-1.2.1.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/plugins/bootstrap/js/bootstrap.min.js'/>"></script> 
<!-- JS Implementing Plugins -->           
<script type="text/javascript" src="<c:url value='/resources/plugins/back-to-top.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/plugins/backstretch/jquery.backstretch.min.js'/>"></script>
<script type="text/javascript">
    $.backstretch([
      "<c:url value='/resources/img/blur/img2.jpg'/>"
      ])
</script>
<!-- JS Page Level -->           
<script type="text/javascript" src="<c:url value='/resources/js/app.js'/>"></script>
<script type="text/javascript">
    jQuery(document).ready(function() {
        App.init();
    });
</script>
<!--[if lt IE 9]>
    <script src="<c:url value='/resources/plugins/respond.js'/>"></script>
    <script src="<c:url value='/resources/plugins/html5shiv.js'/>"></script>
<![endif]-->

</body>
</html> 