<%
'########## Stupboy ¸öÈË×Ô¶¨Òåº¯Êý¿â       #########
'########## UPDATE 2015.08.18              #########
'--º¯Êý»ã×Ü ¼°¹¦ÄÜËµÃ÷ [s]Îª¹ý³Ì--
'-01. SC              [s]Êä³öº¯Êý-
'-02. caidan(a,b)     ²Ëµ¥Êä³öº¯Êý,aÎª²Ëµ¥Ãû,bÎª"×Ó²Ëµ¥Ãû$Á´½Ó|×Ó²Ëµ¥$Á´½Ó"µÄ¸ñÊ½-
'-03. LimitCheck(a)   [s]È¨ÏÞ¼ì²âº¯Êý£¬ÈôÎÞÈ¨ÏÞÔòÖÕ¶ËÊä³ö-
'-04. qx(a,b)         ÅÐ¶ÏÊÇ·ñÓÐÈ¨ÏÞ£¬·µ»ØboolenÖµ TRUE OR FALSE¡¾bÖÐÊÇ·ñ°üº¬a¡¿-
'-05. str_x(x,y)      ×Ö·û²¹Î»º¯ÊýxÎªÔ­×Ö·û,yÎªÎ»Êý²»×ãÓÃ0²¹Æë-
'-06. date2str(x,y)   ÈÕÆÚ×ª×Ö·ûº¯Êý£¬xÎªÈÕÆÚ£¬yÎªÀàÐÍ£¬yÎª1Ôòµ½ÈÕ150801£¬yÎª2Ôòµ½Ãë150801120025,3Ôò·µ»Ø8Î»ÈÕÆÚÈç20150801-
'-07. DanHao(x)       µ¥ºÅÉú³Éº¯Êý£¬xÎªµ¥ºÅÇ°×º£¬ºóÁ¬½Óµ±ÆÚÈÕÆÚ¡¾ÀàÐÍ2¡¿-
'-08. getip()         [s]»ñÈ¡IPº¯Êý-
'-09. date2week(x)    ÈÕÆÚ×ªÐÇÆÚ1-7-
'-10. date_thisweek(x)»ñÈ¡µ±ÆÚÈÕÆÚËùÔÚÖÜµÄÖÜÒ»ÈÕÆÚ-
'-11. date_preweek(x) »ñÈ¡µ±ÆÚÈÕÆÚËùÔÚÖÜÉÏÖÜÖÜÒ»ÈÕÆÚ-
'-12. re_char(x,y,z)  rechar(a,b,c)Èôa=bÔòÊä³öc£¬·ñÔòÊä³öa-
'-13. is_sku(a.b.c)   ²éÕÒb±íÖÐÊÇ·ñ°üº¬×Ö¶Îc=aµÄÖµ·µ»Ø1ºÍ0-
'-13. is_skux(a,b,c,d)   ²éÕÒb±íÖÐÊÇ·ñ°üº¬×Ö¶Îc=aµÄÖµ·µ»Ø1ºÍ0-
'-14. dbdo(x,y,z)     [s]Êý¾Ý¿â²Ù×÷º¯Êý x=1 ´ýÍêÉÆËµÃ÷-
'-15. aspTips(x)      [s]µ¯´°¾¯¸æ -
'-16. sctd(x)         [s]Êä³ö±í¸ñtd-
'-17. ztgs(x,y)       Ð¡±êÇ©¸ñÊ½Êä³öxÎªÄÚÈÝyÎª¸ñÊ½-
'-18. sctd1(x,y)      [s]Êä³ö´ø±êÌâtd-
'-´ýÔö¼Ó-
'-º¯ÊýÃ÷Ï¸ÁÐ±í-
'-Êä³öº¯ÊýSC -
Sub sc(str)
Response.write str
End Sub
'-²Ëµ¥ÏÂÀ­ÏÔÊ¾º¯Êý,aÎª²Ëµ¥Ãû³Æ,bÎª²Ë¡°µ¥Ãû$Á´½Ó¡±µÄ¸ñÊ½-
function caidan(a,b)
 mx=split(b,"|")     '-bÎª²Ëµ¥Ãû³Æ¼°Á´½Ó£¬¶à¸ö²Ëµ¥ÓÃ¡°|¡±Çø·Ö¿ª£¬ÓÃSPLITº¯Êý²ðÎªÊý×é-'-bÎª²Ëµ¥Ãû³Æ¼°Á´½Ó£¬¶à¸ö²Ëµ¥ÓÃ¡°|¡±Çø·Ö¿ª£¬ÓÃSPLITº¯Êý²ðÎªÊý×é-
 ms=ubound(mx,1)     
 caidan1="<ul class='nav navbar-nav'>"&_  
        "<!--<li class='active'><a href='#'>Link <span class='sr-only'>(current)</span></a></li>-->"&_
        "<!--<li><a href='#'>Ë¢ÐÂ</a></li>-->"&_
        "<li class='dropdown'>"&_
        "<a href='#' class='dropdown-toggle' data-toggle='dropdown' role='button' aria-haspopup='true' aria-expanded='false'>"&a&"<span class='caret'></span></a>"&_
        "<ul class='dropdown-menu'>"
 for i = 0 to ms            '-å¾ªçŽ¯è¾“å‡ºæ•°ç»„ä¸­çš„èœå• Forå¾ªçŽ¯-
    mt=split(mx(i),"$")     '-ç”?åŒºåˆ†èœå•åå’Œé“¾æŽ¥-
    caidan3=caidan3&"<li><a href='"&mt(1)&"' target='MainF'>"&mt(0)&"</a></li>"    '-èœå•å­—ç¬¦ä¸²çš„æ‹¼æŽ¥-
 next                       '-å¾ªçŽ¯è¾“å‡ºç»“æŸ-
 caidan2="<!--<li role='separator' class='divider'></li>-->"&_                     
        "<!--<li><a href='#'>One more separated link</a></li>-->"&_
        "</ul>"&_
        "</li>"&_
        "</ul>"
 caidan=caidan1&caidan3&caidan2                                                     '-å­—ç¬¦ä¸²çš„æ‹¼æŽ¥è¾“å‡º-
end function 
'-æƒé™æ£€æµ‹å‡½æ•°[ä¸­æ–­è¾“å‡º]-
sub LimitCheck(a)                                         
 if instr(session("session(UserLimit)"),a)=0 and len(a&"0")>1 then         
  sc "æ²¡æœ‰æƒé™ï¼Œæƒé™ä»£ç ï¼š" & a
  response.end                                            
 end if                                                   
end sub  
'-æƒé™æ£€æµ‹å‡½æ•°[è¾“å‡ºè¿”å›žå€?ä¸ºæ˜¯0ä¸ºå¦]                                                '-å‡½æ•°ç»“æŸ-
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
'--å­—ç¬¦è½¬å¤šä½æ•°--
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
'-æ—¥æœŸè½¬å­—ç¬¦å‡½æ•?1ä¸ºåˆ°æ—?2ä¸ºåˆ°ç§?
function date2str(x,y) 
 a=right(year(x),2)
 if y=1 then 
 date2str=a&str_x(month(x),2)&str_x(day(x),2)
 elseif y=2 then 
 date2str=a&str_x(month(x),2)&str_x(day(x),2)&str_x(hour(x),2)&str_x(minute(x),2)&str_x(second(x),2)
 elseif y=3 then '-å¦‚æžœç­‰äºŽ3åˆ™è½¬ä¸?ä½æ•°æ—¥æœŸæ ¼å¼å¹´æœˆæ—?
 date2str=year(x)&str_x(month(x),2)&str_x(day(x),2)
 end if 
end function
'-å•å·ç”Ÿæˆå‡½æ•°-
function DanHao(x)
 DanHao=x&date2str(now(),2)
end function 
'-IPèŽ·å–å‡½æ•°-
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
'-æ—¥æœŸå‡½æ•°-
'-æ—¥æœŸè½¬æ˜Ÿæœ?
Function date2week(a)
If weekday(a,1)=1 Then
xq=7
Else 
date2week=weekday(a,1)-1
End If 
End Function
'-æœ¬å‘¨èµ·å§‹æ—¥æœŸ-
Function date_thisweek(a)
If weekday(a,1)=2 Then
yy=a
Else
yy=a-date2week(a)+1
End If 
date_thisweek=date2str(yy,3)
End Function 
'-ä¸Šå‘¨å¼€å§‹æ—¥æœ?
Function date_preweek(a)
If weekday(a,1)=2 Then
gg=a
Else
gg=a-date2week(a)+1
End If 
date_preweek=date2str(gg-7,3)
End Function 
'-åˆ¤æ–­å€¼æ˜¯å¦ç­‰äºŽåˆ¶å®šå€¼ï¼Œè¾“å‡ºæŒ‡å®šæ•°å€?
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
'-æŸ¥æ‰¾æ•°æ®åº“æ˜¯å¦åŒ…å«å€?
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
'â€?â€ä¸ºæœåŠ¡å™¨åœ°å€ã€STä¸ºè¿žæŽ¥æ•°æ®åº“åç§°ã€saä¸ºæ•°æ®åº“ç”¨æˆ·åã€PWDä¸ºæ•°æ®åº“å¯†ç -
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
'â€?â€ä¸ºæœåŠ¡å™¨åœ°å€ã€STä¸ºè¿žæŽ¥æ•°æ®åº“åç§°ã€saä¸ºæ•°æ®åº“ç”¨æˆ·åã€PWDä¸ºæ•°æ®åº“å¯†ç -
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
'response.write is_skux("goodsid|customer|ÊýÁ¿1","storedetail_sum","'ÂÌ²è'|'ÕÅÈý'|601","1|1|2")
'response.write is_sku("Yname","Yuan_Info","'è¿‡æ»¤ç½?")
'-æ•°æ®åº“æ“ä½œå‡½æ•°æ— è¿”å›žå€?
sub dbdo(x,y,z) '--
set conn=server.CreateObject("adodb.connection")
'â€?â€ä¸ºæœåŠ¡å™¨åœ°å€ã€STä¸ºè¿žæŽ¥æ•°æ®åº“åç§°ã€saä¸ºæ•°æ®åº“ç”¨æˆ·åã€PWDä¸ºæ•°æ®åº“å¯†ç -
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
    Response.Write rs("ÊýÁ¿1") 
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
function ztgs(x,y)
if y=1 then 'ÂÌµ×°××Ö´ÖÌå
ztgs="<span style='color:#FFFFFF;background-color:#009900;'><strong>"&x&"</strong></span>"
elseif y=2 then 'ºìµ×°××Ö´ÖÌå
ztgs="<span style='color:#FFFFFF;background-color:#E53333;'><strong>"&x&"</strong></span>"
elseif y=3 then 'Ç³ÂÌºÚ×Ö´ÖÌå
ztgs="<span style='background-color:#B8D100;'><strong>"&x&"</strong></span>"
elseif y=4 then '³ÈÉ«ºÚ×Ö´ÖÌå
ztgs="<span style='background-color:#FF9900;'><strong>"&x&"</strong></span>"
else 
ztgs="<strong>"&x&"</strong>"
end if 
end function 
'-æµ‹è¯•å‡½æ•°è¯­å¥-
'sc esql("UserInfo","Username:stupboy|password:123456")
%>
