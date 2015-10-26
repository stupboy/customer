<!--#include file="inc/right.asp"--> 
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="css/main.css" rel="stylesheet" type="text/css">
<title><%=sysConfig%></title>
</head>
<frameset rows="108,*,30" cols="*" frameborder="No" border="0" framespacing="0">
  <frame src="top.asp" name="topFrame" scrolling="No" noresize="noresize" id="topFrame" title="topFrame" />
  <frameset rows="*" cols="130,*" framespacing="0" frameborder="no" border="0">
    <frame src="left.asp" name="leftFrame" scrolling="No" noresize="noresize" id="leftFrame" title="leftFrame" />
    <frame src="Main.asp" name="mainFrame" scrolling="yes" noresize="noresize" id="mainFrame" title="mainFrame" />
  </frameset>
  <frame src="bottom.asp" name="bottomFrame" scrolling="No" noresize="noresize" id="bottomFrame" title="bottomFrame" />
</frameset>
<noframes>
<body>
</body>
</noframes>
</html>
