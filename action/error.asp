<!--#include file="../inc/right.asp"--> 
<!--#include file="../inc/conn.asp"-->
<!--#include file="../inc/md5.asp"-->
<!--#include file="../lib/lib.all.asp"-->
<html>
<head>
<title><%=sysConfig%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../images/main.css" rel="stylesheet" type="text/css">
<script language="Javascript">
function check()
{

  if (document.add.Username.value=="")
     {
      alert("请输入帐户名！")
      document.add.Username.focus()
      document.add.Username.select()
      return
     }
  if (document.add.RealName.value=="")
     {
      alert("请输入姓名！")
      document.add.RealName.focus()
      document.add.RealName.select()
      return
     }
  if (document.add.Password1.value=="")
     {
      alert("请输入您的密码！")
      document.add.Password1.focus()
      document.add.Password1.select()		
      return
     }
  if (document.add.Password1.value.length<6)
     {
      alert("请填写管理员密码(字符数在6-16位之间)！")
      document.add.Password1.focus()
      document.add.Password1.select()		
      return
     }
  if (document.add.Password1.value.length>16)
     {
      alert("请填写管理员密码(字符数在6-16位之间)！")
      document.add.Password1.focus()
      document.add.Password1.select()		
      return
     }
  if (document.add.Password1.value!=document.add.Password2.value)
     {
      alert("您输入的两次密码不相同！")
      document.add.Password2.focus()
      document.add.Password2.select()		
      return
     }
     document.add.submit()
}
</script>
</head>
<body>
无权限！
</body>
</html>