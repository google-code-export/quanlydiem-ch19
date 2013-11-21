<%-- 
    Document   : hocKy
    Created on : Nov 21, 2013, 2:50:24 PM
    Author     : Long
--%>

<%@page import="java.util.Set"%>
<%@page import="proj.entity.LopMonHoc"%>
<%@page import="proj.entity.NienKhoaHocKy"%>
<%@page import="proj.dao.nienKhoaHocKyDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        
        <select name="idSV">
                <%
                 nienKhoaHocKyDAO dao=new nienKhoaHocKyDAO();
                 NienKhoaHocKy dsNKHK[]= dao.getNKHK();
                    for(int i=0;i<dsNKHK.length;i++)
                        out.println("<option value='"+dsNKHK[i].getIdNienKhoaHocKy()+"'>"+
                                "hoc ky: "+dsNKHK[i].getHocKy()+" - Nam hoc: "+dsNKHK[i].getNam1()+"-"+
                                dsNKHK[i].getNam2()
                                
                                +"</option>");
                %>
        </select>
        <br/><br/>
            <%
             for(int i=0;i<dsNKHK.length;i++){
                 NienKhoaHocKy nk = dsNKHK[i];
                 out.println(nk.getHocKy()+"-"+nk.getNam1()+"-"+nk.getNam2()+"<br/>");
                 Set<LopMonHoc> set =  nk.getLopMonHocs();
                 LopMonHoc [] lmhArr = new LopMonHoc[set.size()];
                 set.toArray(lmhArr);
                 for (int j = 0; j < lmhArr.length; j++) {
                         out.println("....."+lmhArr[j].getMonHoc().getTen()+"<br/>");
                     }
             }
                 
                    
            %>
    </body>
</html>
