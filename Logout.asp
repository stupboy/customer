<!--#include file="lib/lib.all.asp"-->
<%
if qx("C1",session("Limit")) then 
session.Abandon()
response.redirect "../customer/admin"
elseif qx("K1",session("Limit")) then  
session.Abandon()
response.redirect "../customer/store"
elseif qx("Y1",session("Limit")) then  
session.Abandon()
response.redirect "../customer/manager"
end if 
%>