<%
'网站动作处理
dz=request.querystring("dz")
select case dz
 case "a001"
  response.redirect "action/goods.asp?action=list"
 case else
  response.redirect "logout.asp"
end select 
%>