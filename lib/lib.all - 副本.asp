<%
'########## Stupboy 个人自定义函数库       #########
'########## UPDATE 2015.08.18              #########
'--函数汇总 及功能说明 [s]为过程--
'-01. SC              [s]输出函数-
'-02. caidan(a,b)     菜单输出函数,a为菜单名,b为"子菜单名$链接|子菜单$链接"的格式-
'-03. LimitCheck(a)   [s]权限检测函数，若无权限则终端输出-
'-04. qx(a,b)         判断是否有权限，返回boolen值 TRUE OR FALSE【b中是否包含a】-
'-05. str_x(x,y)      字符补位函数x为原字符,y为位数不足用0补齐-
'-06. date2str(x,y)   日期转字符函数，x为日期，y为类型，y为1则到日150801，y为2则到秒150801120025,3则返回8位日期如20150801-
'-07. DanHao(x)       单号生成函数，x为单号前缀，后连接当期日期【类型2】-
'-08. getip()         [s]获取IP函数-
'-09. date2week(x)    日期转星期1-7-
'-10. date_thisweek(x)获取当期日期所在周的周一日期-
'-11. date_preweek(x) 获取当期日期所在周上周周一日期-
'-12. re_char(x,y,z)  rechar(a,b,c)若a=b则输出c，否则输出a-
'-13. is_sku(a.b.c)   查找b表中是否包含字段c=a的值返回1和0-
'-13. is_skux(a,b,c,d)   查找b表中是否包含字段c=a的值返回1和0-
'-14. dbdo(x,y,z)     [s]数据库操作函数 x=1 待完善说明-
'-15. aspTips(x)      [s]弹窗警告 -
'-16. sctd(x)         [s]输出表格td-
'-待增加-
'-函数明细列表-
'-输出函数SC -
Sub sc(str)
Response.write str
End Sub
'-菜单下拉显示函数,a为菜单名称,b为菜“单名$链接”的格式-
function caidan(a,b)
 mx=split(b,"|")     '-b为菜单名称及链接，多个菜单用“|”区分开，用SPLIT函数拆为数组-
 ms=ubound(mx,1)     
 caidan1="<ul class='nav navbar-nav'>"&_  
        "<!--<li class='active'><a href='#'>Link <span class='sr-only'>(current)</span></a></li>-->"&_
        "<!--<li><a href='#'>刷新</a></li>-->"&_
        "<li class='dropdown'>"&_
        "<a href='#' class='dropdown-toggle' data-toggle='dropdown' role='button' aria-haspopup='true' aria-expanded='false'>"&a&"<span class='caret'></span></a>"&_
        "<ul class='dropdown-menu'>"
 for i = 0 to ms            '-循环输出数组中的菜单 For循环-
    mt=split(mx(i),"$")     '-用$区分菜单名和链接-
    caidan3=caidan3&"<li><a href='"&mt(1)&"' target='MainF'>"&mt(0)&"</a></li>"    '-菜单字符串的拼接-
 next                       '-循环输出结束-
 caidan2="<!--<li role='separator' class='divider'></li>-->"&_                     
        "<!--<li><a href='#'>One more separated link</a></li>-->"&_
        "</ul>"&_
        "</li>"&_
        "</ul>"
 caidan=caidan1&caidan3&caidan2                                                     '-字符串的拼接输出-
end function 
'-权限检测函数[中断输出]-
sub LimitCheck(a)                                         
 if instr(session("session(UserLimit)"),a)=0 and len(a&"0")>1 then         
  sc "没有权限，权限代码：" & a
  response.end                                            
 end if                                                   
end sub  
'-权限检测函数[输出返回值1为是0为否]                                                '-函数结束-
function qx(a,b)
if trim(b)="" then 
qx=false
else 
 if instr(b,a)>0 then 
   qx=true
 else
   qx=false
 end if   
end if 
end function 
'--字符转多位数--
function str_x(x,y)
 if len(trim(x))<y then
  dim a,b
  a=y-len(trim(x))
  for i = 1 to a
  b=b&"0"
  next 
  str_x=b&x
 else 
  str_x=x
 end if 
end function
'-日期转字符函数 1为到日 2为到秒-
function date2str(x,y) 
 a=right(year(x),2)
 if y=1 then 
 date2str=a&str_x(month(x),2)&str_x(day(x),2)
 elseif y=2 then 
 date2str=a&str_x(month(x),2)&str_x(day(x),2)&str_x(hour(x),2)&str_x(minute(x),2)&str_x(second(x),2)
 elseif y=3 then '-如果等于3则转为8位数日期格式年月日-
 date2str=year(x)&str_x(month(x),2)&str_x(day(x),2)
 end if 
end function
'-单号生成函数-
function DanHao(x)
 DanHao=x&date2str(now(),2)
end function 
'-IP获取函数-
Private Function getIP()   
Dim strIPAddr   
If Request.ServerVariables("HTTP_X_FORWARDED_FOR") = "" OR InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), "unknown") > 0 Then   
strIPAddr = Request.ServerVariables("REMOTE_ADDR")   
ElseIf InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ",") > 0 Then   
strIPAddr = Mid(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), 1, InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ",")-1)   
ElseIf InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ";") > 0 Then   
strIPAddr = Mid(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), 1, InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ";")-1)   
Else   
strIPAddr = Request.ServerVariables("HTTP_X_FORWARDED_FOR")   
End If   
getIP = Trim(Mid(strIPAddr, 1, 30))   
End Function
'-日期函数-
'-日期转星期-
Function date2week(a)
If weekday(a,1)=1 Then
xq=7
Else 
date2week=weekday(a,1)-1
End If 
End Function
'-本周起始日期-
Function date_thisweek(a)
If weekday(a,1)=2 Then
yy=a
Else
yy=a-date2week(a)+1
End If 
date_thisweek=date2str(yy,3)
End Function 
'-上周开始日期-
Function date_preweek(a)
If weekday(a,1)=2 Then
gg=a
Else
gg=a-date2week(a)+1
End If 
date_preweek=date2str(gg-7,3)
End Function 
'-判断值是否等于制定值，输出指定数值-
function re_char(x,y,z)
 dim a,b
 a=cstr(x)
 b=cstr(y)
 if a=b then 
  re_char=z
 else
  re_char=x
 end if
end function
'-查找数据库是否包含值-
Function is_sku(a,b,c)
temp=0
TiaoJian=""
mxa=split(a,"|")
mxc=split(c,"|")
mxs=ubound(mxa)

for k=0 to mxs
TiaoJian=TiaoJian&" and "&mxa(k)&" = "&mxc(k)
next 
TiaoJian=Trim(Mid(TiaoJian,5,99))
SQL="select * from "&b&" WHERE "&TiaoJian
set conn=server.CreateObject("adodb.connection")
'“.”为服务器地址、ST为连接数据库名称、sa为数据库用户名、PWD为数据库密码-
ConnStr="server=113.10.138.110;driver={sql server};database=cha;uid=sa;pwd=!@#$%asdfg"
conn.Open connstr
on error resume next 
set rs=server.createobject("adodb.recordset") 
rs.open sql,conn,1,1
if not rs.eof Then
  temp=1
 else
  temp=0
 end if
 Rs.close
set Rs=nothing
is_sku=temp
End Function 

Function is_skuX(a,b,c,d)
temp=0
TiaoJian=""
mxa=split(a,"|")
mxc=split(c,"|")
mxd=split(d,"|")
mxs=ubound(mxa)

for k=0 to mxs
 if mxd(k) =1 then 
 TiaoJian=TiaoJian&" and "&mxa(k)&" = "&mxc(k)
 elseif mxd(k)=2 then
 TiaoJian=TiaoJian&" and "&mxa(k)&" > "&mxc(k)
 elseif mxd(k)=3 then
 TiaoJian=TiaoJian&" and "&mxa(k)&" < "&mxc(k)
 end if 
next 
TiaoJian=Trim(Mid(TiaoJian,5,99))
SQL="select * from "&b&" WHERE "&TiaoJian
set conn=server.CreateObject("adodb.connection")
'“.”为服务器地址、ST为连接数据库名称、sa为数据库用户名、PWD为数据库密码-
ConnStr="server=113.10.138.110;driver={sql server};database=cha;uid=sa;pwd=!@#$%asdfg"
conn.Open connstr
'on error resume next 
'set rs=server.createobject("adodb.recordset") 
'rs.open sql,conn,1,1
'if not rs.eof Then
'  temp=1
' else
'  temp=0
' end if
' Rs.close
'set Rs=nothing
is_skux=sql
End Function
response.write is_skux("goodsid|customer|数量1","storedetail_sum","'红茶'|'张三'|1","1|1|2")&"s"
'response.write is_sku("Yname","Yuan_Info","'过滤网'")
'-数据库操作函数无返回值-
sub dbdo(x,y,z) '--
set conn=server.CreateObject("adodb.connection")
'“.”为服务器地址、ST为连接数据库名称、sa为数据库用户名、PWD为数据库密码-
ConnStr="server=113.10.138.110;driver={sql server};database=cha;uid=sa;pwd=!@#$%asdfg"
conn.Open connstr
'on error resume next 
if x= 1 then 
 mx=split(z,"-")
 mxa=split(mx(0),"|")
 mxb=split(mx(1),"|")
 mxs=ubound(mxa)
 for i = 0 to mxs
  zd=zd&","&mxa(i)
  nr=nr&","&mxb(i)
 next 
  zd=trim(mid(zd,2,999))
  nr=trim(mid(nr,2,999))
 sql="insert into "&y&" ("&zd&") values ("&nr&") "
 conn.execute(sql)
 'sc sql
elseif x=2 then 
 sql=y
 conn.execute(sql)
 'sc sql
end if 
end sub 
sub aspTips(x)
response.write "<script>alert("&x&");</script>"
end sub 
Sub sctd(x)
response.write "<td>"&x&"</td>"
End Sub
'-测试函数语句-
'sc esql("UserInfo","Username:stupboy|password:123456")
%>
