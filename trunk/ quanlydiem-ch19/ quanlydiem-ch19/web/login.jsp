<%-- 
    Document   : login
    Created on : Oct 17, 2013, 8:30:12 PM
    Author     : Long
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="en">
<head>
	  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Đăng nhập</title>
	
	<!-- Stylesheets -->
	<link href='http://fonts.googleapis.com/css?family=Droid+Sans:400,700' rel='stylesheet'>
	<link rel="stylesheet" href="css/style.css">

	<!-- Optimize for mobile devices -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>  
</head>
<body>

	<!-- TOP BAR -->
	<div id="top-bar">
		
		<div class="page-full-width">
		
			<a href="index.jsp" class="round button dark ic-left-arrow image-left ">Về trang chủ</a>

		</div> <!-- end full-width -->	
	
	</div> <!-- end top-bar -->
	
	
	
	<!-- HEADER -->
	<div id="header">
		
		<div class="page-full-width cf">
	
			<div id="login-intro" class="fl">
			
				<h1>Đăng nhập vào hệ thống Quản lý điểm thi</h1>
				<h5>Nhập thông tin tài khoản vào bên dưới</h5>
			
			</div> <!-- login-intro -->
			
			<!-- Change this image to your own company's logo -->
			<!-- The logo will automatically be resized to 39px height. -->
                        <a href="https://sites.google.com/site/nbhung/about-me" id="company-branding" class="fr"><img src="img/Ngo Ba Hung.jpg" width="40" height="150" alt="Blue Hosting" /></a>
			
		</div> <!-- end full-width -->	

	</div> <!-- end header -->

	<!-- MAIN CONTENT -->
	<div id="content">
       
            <script >
                function validateForm()
                {
                    var us = document.forms['login']['username'].value;
                    var pw = document.forms['login']['password'].value;
                    if(us.length == 0 || pw.length == 0)
                    {
                        var c =document.getElementById('loi'); 
                        c.style.display="";
                        c.innerHTML = 'Tên đăng nhập và mật khẩu không được bỏ trống!';
                        return false;
                    }
                    return true;
               }
            </script>
            <form action="Controller" onsubmit="return validateForm()" method="POST" id="login-form" name="login">
		
			<fieldset>

				<p>
                                    <label for="login-username">Mã số </label>
					<input type="text" name="username" class="round full-width-input" autofocus />
				</p>

				<p>
					<label for="login-password">Mật khẩu</label>
					<input type="password" name="password" class="round full-width-input" />
				</p>
                                <input type="submit" value="Login" name="action"/>
				
			</fieldset>

			<br/>
                        <div  style='display:none' id="loi" class="information-box round" name="divLoi">
                               <c:set var ="chk" value="${requestScope.error}"/>
                                <c:if test='${chk != null}'/> 
                                Vui lòng nhập tên đăng nhập và mật khẩu
                                <script>
                                    document.getElementById('loi').style.display="";
                                </script>
                           </c:if>
                        </div>
     	</form>
		
	</div> <!-- end content -->
	
	
	
	<!-- FOOTER -->
	<div id="footer">

		<p>Quản lý điểm thi</p>
		
	
	</div> <!-- end footer -->

</body>
</html>
