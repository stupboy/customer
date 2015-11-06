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
'-17. ztgs(x,y)       小标签格式输出x为内容y为格式-
'-18. sctd1(x,y)      [s]输出带标题td-
'-19. db_log(x,y,z)   记录系统日志x用户y语句z备注-
'-待增加-
'-函数明细列表-
'-输出函数SC -
Sub sc(str)
Response.write str
End Sub
'-菜单下拉显示函数,a为菜单名称,b为菜“单名$链接”的格式-
function caidan(a,b)
 mx=split(b,"|")     '-b为菜单名称及链接，多个菜单用“|”区分开，用SPLIT函数拆为数组-'-b为菜单名称及链接，多个菜单用“|”区分开，用SPLIT函数拆为数组-
 ms=ubound(mx,1)     
 caidan1="<ul class='nav navbar-nav'>"&_  
        "<!--<li class='active'><a href='#'>Link <span class='sr-only'>(current)</span></a></li>-->"&_
        "<!--<li><a href='#'>刷新</a></li>-->"&_
        "<li class='dropdown'>"&_
        "<a href='#' class='dropdown-toggle' data-toggle='dropdown' role='button' aria-haspopup='true' aria-expanded='false'>"&a&"<span class='caret'></span></a>"&_
        "<ul class='dropdown-menu'>"
 for i = 0 to ms            '-寰幆杈撳嚭鏁扮粍涓殑鑿滃崟 For寰幆-
    mt=split(mx(i),"$")     '-鐢?鍖哄垎鑿滃崟鍚嶅拰閾炬帴-
    caidan3=caidan3&"<li><a href='"&mt(1)&"' target='MainF'>"&mt(0)&"</a></li>"    '-鑿滃崟瀛楃涓茬殑鎷兼帴-
 next                       '-寰幆杈撳嚭缁撴潫-
 caidan2="<!--<li role='separator' class='divider'></li>-->"&_                     
        "<!--<li><a href='#'>One more separated link</a></li>-->"&_
        "</ul>"&_
        "</li>"&_
        "</ul>"
 caidan=caidan1&caidan3&caidan2                                                     '-瀛楃涓茬殑鎷兼帴杈撳嚭-
end function 
'-鏉冮檺妫�娴嬪嚱鏁癧涓柇杈撳嚭]-
sub LimitCheck(a)                                         
 if instr(session("session(UserLimit)"),a)=0 and len(a&"0")>1 then         
  sc "娌℃湁鏉冮檺锛屾潈闄愪唬鐮侊細" & a
  response.end                                            
 end if                                                   
end sub  
'-鏉冮檺妫�娴嬪嚱鏁癧杈撳嚭杩斿洖鍊?涓烘槸0涓哄惁]                                                '-鍑芥暟缁撴潫-
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
'--瀛楃杞浣嶆暟--
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
'-鏃ユ湡杞瓧绗﹀嚱鏁?1涓哄埌鏃?2涓哄埌绉?
function date2str(x,y) 
 a=right(year(x),2)
 if y=1 then 
 date2str=a&str_x(month(x),2)&str_x(day(x),2)
 elseif y=2 then 
 date2str=a&str_x(month(x),2)&str_x(day(x),2)&str_x(hour(x),2)&str_x(minute(x),2)&str_x(second(x),2)
 elseif y=3 then '-濡傛灉绛変簬3鍒欒浆涓?浣嶆暟鏃ユ湡鏍煎紡骞存湀鏃?
 date2str=year(x)&str_x(month(x),2)&str_x(day(x),2)
 end if 
end function
'-鍗曞彿鐢熸垚鍑芥暟-
function DanHao(x)
 DanHao=x&date2str(now(),2)
end function 
'-IP鑾峰彇鍑芥暟-
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
'-鏃ユ湡鍑芥暟-
'-鏃ユ湡杞槦鏈?
Function date2week(a)
If weekday(a,1)=1 Then
xq=7
Else 
date2week=weekday(a,1)-1
End If 
End Function
'-鏈懆璧峰鏃ユ湡-
Function date_thisweek(a)
If weekday(a,1)=2 Then
yy=a
Else
yy=a-date2week(a)+1
End If 
date_thisweek=date2str(yy,3)
End Function 
'-涓婂懆寮�濮嬫棩鏈?
Function date_preweek(a)
If weekday(a,1)=2 Then
gg=a
Else
gg=a-date2week(a)+1
End If 
date_preweek=date2str(gg-7,3)
End Function 
'-鍒ゆ柇鍊兼槸鍚︾瓑浜庡埗瀹氬�硷紝杈撳嚭鎸囧畾鏁板�?
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
'-鏌ユ壘鏁版嵁搴撴槸鍚﹀寘鍚�?
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
'鈥?鈥濅负鏈嶅姟鍣ㄥ湴鍧�銆丼T涓鸿繛鎺ユ暟鎹簱鍚嶇О銆乻a涓烘暟鎹簱鐢ㄦ埛鍚嶃�丳WD涓烘暟鎹簱瀵嗙爜-
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
'鈥?鈥濅负鏈嶅姟鍣ㄥ湴鍧�銆丼T涓鸿繛鎺ユ暟鎹簱鍚嶇О銆乻a涓烘暟鎹簱鐢ㄦ埛鍚嶃�丳WD涓烘暟鎹簱瀵嗙爜-
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
is_skux=temp
End Function
'response.write is_skux("goodsid|customer|数量1","storedetail_sum","'绿茶'|'张三'|601","1|1|2")
'response.write is_sku("Yname","Yuan_Info","'杩囨护缃?")
'-鏁版嵁搴撴搷浣滃嚱鏁版棤杩斿洖鍊?
sub dbdo(x,y,z) '--
set conn=server.CreateObject("adodb.connection")
'鈥?鈥濅负鏈嶅姟鍣ㄥ湴鍧�銆丼T涓鸿繛鎺ユ暟鎹簱鍚嶇О銆乻a涓烘暟鎹簱鐢ㄦ埛鍚嶃�丳WD涓烘暟鎹簱瀵嗙爜-
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
 'sc sql
 conn.execute(sql)
 
elseif x=2 then 
 sql=y
 conn.execute(sql)
elseif x=3 then 
 mx=split(z,"-")
 mxa=split(mx(0),"|")
 mxb=split(mx(1),"|")
 mxs=ubound(mxa)
   Tiaojian=""
 for i = 0 to mxs
  Tiaojian=TiaoJian&" and "&mxa(i)&" = "&mxb(i)
  'zd=zd&","&mxa(i)
  'nr=nr&","&mxb(i)
 next 
TiaoJian=Trim(Mid(TiaoJian,5,99))

set rs = Server.CreateObject("ADODB.recordset")
rs.Open "SELECT * FROM "&y&" where "&Tiaojian, conn
do until rs.EOF
  'for each x in rs.Fields
    'Response.Write(x.name)
    'Response.Write(" = ")
    Response.Write rs("数量1") 
  'next
  'Response.Write("<br />")
  rs.MoveNext
loop
rs.close

end if 
end sub 
sub aspTips(x)
response.write "<script>alert("&x&");</script>"
end sub 
Sub sctd(x)
response.write "<td>"&x&"</td>"
End Sub
Sub sctd1(x,y)
response.write "<td title='"&y&"'>"&x&"</td>"
End Sub

Function look_db(x,y,z,w)
'mx=split(z,"-")
 mxa=split(z,"|")
 mxb=split(w,"|")
 mxs=ubound(mxa)
   Tiaojian=""
 for i = 0 to mxs
  Tiaojian=TiaoJian&" and "&mxa(i)&" = '"&mxb(i)&"'"
  'zd=zd&","&mxa(i)
  'nr=nr&","&mxb(i)
 next 
TiaoJian=Trim(Mid(TiaoJian,5,99))

set rs = Server.CreateObject("ADODB.recordset")
rs.Open "SELECT * FROM "&y&" where "&Tiaojian, conn
do until rs.EOF
  'for each x in rs.Fields
  'Response.Write(x.name)
  'Response.Write(" = ")
  look_db=rs(x) 
  'next
  'Response.Write("<br />")
  rs.MoveNext
loop
rs.close
end function 
'-字体颜色格式函数-
function ztgs(x,y)
if y=1 then '绿底白字粗体
ztgs="<span style='color:#FFFFFF;background-color:#009900;'><strong>"&x&"</strong></span>"
elseif y=2 then '红底白字粗体
ztgs="<span style='color:#FFFFFF;background-color:#E53333;'><strong>"&x&"</strong></span>"
elseif y=3 then '浅绿黑字粗体
ztgs="<span style='background-color:#B8D100;'><strong>"&x&"</strong></span>"
elseif y=4 then '橙色黑字粗体
ztgs="<span style='background-color:#FF9900;'><strong>"&x&"</strong></span>"
else 
ztgs="<strong>"&x&"</strong>"
end if 
end function 

sub db_log(x,y,z)
set conn=server.CreateObject("adodb.connection")
ConnStr="server=113.10.138.110;driver={sql server};database=cha;uid=sa;pwd=!@#$%asdfg"
conn.Open connstr
y=replace(y,"'","$")
sql="insert into sys_log (RealName,DOsql,DOnote) values ('"&x&"','"&y&"','"&z&"')"
conn.execute(sql)
end sub 
'-娴嬭瘯鍑芥暟璇彞-
'sc esql("UserInfo","Username:stupboy|password:123456")
%>
