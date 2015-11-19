<!--#include file="../inc/config.asp"-->
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>后台管理系统</title>
<!-- CSS -->
<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">
<link rel="stylesheet" href="../inc/assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="../inc/assets/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="../inc/assets/css/form-elements.css">
<link rel="stylesheet" href="../inc/assets/css/style.css">
<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
<!-- Favicon and touch icons -->
<link rel="shortcut icon" href="../inc/assets/ico/favicon.png">
<link rel="apple-touch-icon-precomposed" sizes="144x144" href="../inc/assets/ico/apple-touch-icon-144-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="114x114" href="../inc/assets/ico/apple-touch-icon-114-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="72x72" href="../inc/assets/ico/apple-touch-icon-72-precomposed.png">
<link rel="apple-touch-icon-precomposed" href="../inc/assets/ico/apple-touch-icon-57-precomposed.png">
<script language="JavaScript">
<!--
function chk(theForm)
{
if (theForm.admin_name.value == "")
{
alert("用户名不能为空");
theForm.admin_name.focus();
return (false);
}
if (theForm.admin_pass.value == "")
{
alert("密码不能为空");
theForm.admin_pass.focus();
return (false);
}

return true;
}
//-->
</script>
<!--#include file=../images/ini.sys -->
</head>
<body>
<style type="text/css">
body{background: url("../inc/assets/img/backgrounds/1.jpg") center center no-repeat, url(images/weather-clouds.png) top left no-repeat, url("../inc/assets/img/backgrounds/1@2x.jpg") top right no-repeat;}
</style>

<!-- Top content -->
<div class="top-content">
	
    <div class="inner-bg">
<div class="container">
    <div class="row">
    </div>
    <div class="row">
<div class="col-sm-6 col-sm-offset-3 form-box">
	<div class="form-top">
		<div class="form-top-left">
			<h3>后台管理系统<h3>
    		<p></p>
		</div>
		<div class="form-top-right">
			<i class="fa fa-key"></i>
		</div>
    </div>
    <div class="form-bottom">
	<FORM action="../check.asp?action=login" method=post onSubmit="return chk(this)" class="login-form"><INPUt type="hidden" id=logtype name=logtype value="C1">
			    	<div class="form-group">
			    		<label class="sr-only" for="form-username">Username</label>
				<input type="text" name="admin_name" placeholder="Username..." class="form-username form-control" id="admin_name">
			</div>
			<div class="form-group">
				<label class="sr-only" for="form-password">Password</label>
				<input type="password" name="admin_pass" placeholder="Password..." class="form-password form-control" id="admin_pass">
			</div>
			<div class="form-group">
			<label class="sr-only" for="form-password">验证码</label>
				<input type="text" name="VerifyCode" placeholder="验证码" class="form-password form-control" id="VerifyCode">
				<img src="../yz.asp" border='0' width='100' onClick="this.src='../yz.asp'" alt='点击刷新' />
			</div>
			<button type="submit" class="btn">登入系统</button>
			    </form>
		    </div>
</div>
    </div>
    <div class="row">
    <!--
<div class="col-sm-6 col-sm-offset-3 social-login">
	<h3>...or login with:</h3>
	<div class="social-login-buttons">
		<a class="btn btn-link-1 btn-link-1-facebook" href="#">
			<i class="fa fa-facebook"></i> Facebook
		</a>
		<a class="btn btn-link-1 btn-link-1-twitter" href="#">
			<i class="fa fa-twitter"></i> Twitter
		</a>
		<a class="btn btn-link-1 btn-link-1-google-plus" href="#">
			<i class="fa fa-google-plus"></i> Google Plus
		</a>
	</div>
</div>-->
</div>
</div>
</div>
</div>
<!-- Javascript -->
<script src="../inc/assets/js/jquery-1.11.1.min.js"></script>
<script src="../inc/assets/bootstrap/js/bootstrap.min.js"></script>
<script src="../inc/assets/js/jquery.backstretch.min.js"></script>
<script src="../inc/assets/js/scripts.js"></script>
<!--[if lt IE 10]>
    <script src="../inc/assets/js/placeholder.js"></script>
<![endif]-->
</body>
</html>