<!--#include file="inc/right.asp"-->
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�˵��б�</title>
<!--#include file="lib/lib.all.asp"-->
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	background-color: #E6F0F7;
}
.dtree {
	font-family: Verdana, Geneva, Arial, Helvetica, sans-serif;
	font-size: 12px;
	color: #0000ff;
	white-space: nowrap;
}
.dtree img {
	border: 0px;
	vertical-align: middle;
}
.dtree a {
	color: #333;
	text-decoration: none;
}
.dtree a.node, .dtree a.nodeSel {
	white-space: nowrap;
	padding: 1px 2px 1px 2px;
}
.dtree a.node:hover, .dtree a.nodeSel:hover {
	color: #0000ff;
}
.dtree a.nodeSel {
	background-color: #AED0F4;
}
.dtree .clip {
	overflow: hidden;
}
-->
</style>
<link href="images/main.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="images/dtree.js"></script>
</head>
<body>
<table width="96%"  border="0" cellpadding="10" cellspacing="0" align=center >
  <tr>
   <td valign="top" >
   <div class=menu style="overflow:auto;">
    <table width="100%"  border="0" cellpadding="0" cellspacing="0">
     <tr>
      <td height=25><a href="javascript: d.openAll();"><img src="images/view_detailed.gif" width="15" height="15" border="0" align="absmiddle" alt="չ���б�"></a> <a href="javascript: d.closeAll();"><img src="images/view_tree.gif" width="15" height="15" border="0" align="absmiddle" alt="�����б�"></a> |  <a href="main.asp" target="mainFrame">ϵͳ��ҳ</a> | </td>
     </tr>
     <tr>
      <td>
	  <script type="text/javascript">
	  <!--
	  d = new dTree('d');
	  d.config.target="mainFrame";
	  d.add(0,-1,' ��վ���ݹ���');
	  <% if qx("C1",session("Limit")) then %>
	  d.add(1, 0, ' ϵͳ����', '');
      d.add(10, 1, ' �û�����', 'action.asp?dz=a002');
	  //d.add(16, 1, ' ΢������', 'action.asp?dz=a014');
	  <% end if %>
	  <% if qx("C1",session("Limit")) then %>
	  d.add(2, 0, ' ��Ӫ����', '');
	  d.add(21, 2, ' ��������', '');
	  d.add(210, 21, ' ��Ʒ����', 'action.asp?dz=a001');
	  d.add(211, 21, ' ԭ�ϵ���', 'action.asp?dz=a006');
	  d.add(212, 21, ' ��Ʒ���', 'action.asp?dz=a009');
	  d.add(213, 21, ' �ͻ�����', 'action.asp?dz=a005');
	  d.add(20, 2, ' ��������', '');
	  d.add(201, 20, ' �����µ�', 'action.asp?dz=a020');
	  d.add(205, 20, ' �����µ�', 'action.asp?dz=a021');
	  d.add(204, 20, ' �����µ�', 'action.asp?dz=a003');
	  d.add(202, 20, ' ��������', 'action.asp?dz=a013');
	  d.add(203, 20, ' ��������', 'action.asp?dz=a016');
	  d.add(22, 2, ' �����ѯ', '');
	  d.add(220, 22, ' ��������', 'action.asp?dz=a016');
	  <% end if %>
	  <% if qx("C1",session("Limit")) or qx("K1",session("Limit")) then %>
	  d.add(3, 0, ' �ֿ����', '');
	  d.add(30, 3, ' ��������', 'action.asp?dz=a011');
	  d.add(35, 3, ' �������', 'action.asp?dz=a015');
	  d.add(36, 3, ' ԭ�����', 'action.asp?dz=a007');
	  d.add(34, 3, ' ԭ�Ͽ��', 'action.asp?dz=a010');
	  d.add(31, 3, ' ��Ʒ���', 'action.asp?dz=a012');
	  <% end if %>
	  <% if qx("C1",session("Limit")) then %>
	  d.add(4, 0, ' �����ѯ', '');
	  d.add(40, 4, ' ���񱨱�', 'action.asp?dz=a017');
	  <% end if %>
	  d.add(9, 0, ' ���˹���', '');
	  d.add(91, 9, ' �˳�����', 'logout.asp');		
	  document.write(d);
	  //-->
	  </script>
	  </td>
     </tr>
    </table>
   </div>
   </td>
  </tr>
</table>
</body>
</html>