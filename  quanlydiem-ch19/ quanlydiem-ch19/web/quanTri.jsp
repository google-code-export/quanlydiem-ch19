<%-- 
    Document   : quanTri
    Created on : Oct 18, 2013, 9:56:02 PM
    Author     : Long
--%>

<%@page import="proj.entity.LopMonHoc"%>
<%@page import="java.util.Set"%>
<%@page import="proj.dao.nienKhoaHocKyDAO"%>
<%@page import="proj.entity.NienKhoaHocKy"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trang Quản trị</title>
            <link rel="stylesheet" type="text/css" href="css/metro-bootstrap.css">

    </head>
    <style>
        body
        {
            padding-top: 70px; /* 60px to make the container go all the way to the bottom of the topbar */
        }
    </style>
   
    
<body data-spy="scroll" data-target=".subnav" data-offset="50" screen_capture_injected="true">
   <!-- Navbar
    ================================================== -->
    <div class="navbar navbar-fixed-top">
        <div class="navbar-inner">
            <div class="container">
                <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
                </a><a class="brand" href="index.jsp">Quản lý điểm thi</a>
               <ul class="nav">
                        <li class="active">
                        <li class=""><a href="Controller?action=Sinh viên">Sinh viên</a> </li>
                        <li class=""><a href="Controller?action=Giảng viên">Giảng viên</a> </li>
                        <li class=""><a href="Controller?action=Quản trị">Quản trị</a> </li>
                    </ul>
            </div>
        </div>
    </div>
    <div class="container">
   
      <p align ="right"><font color="blue">Hi, ${sessionScope.DATA}</font></p> 
      <form name="Controller">
          <h1>Mở lớp & Khóa lớp</h1>
            <h3 >Chọn niên khóa và học kỳ muốn xem: </h3>

     <select name="idSV">
    <!--%
       nienKhoaHocKyDAO dao= new nienKhoaHocKyDAO();
       NienKhoaHocKy arr[]=dao.getNKHK();
          for(int i=0;i<arr.length;i++){
       out.println("<option value='"+arr[i].getIdNienKhoaHocKy()+"'>"+
                                "HK: "+arr[i].getHocKy()+" - Năm học: "+arr[i].getNam1()+"-"+
                                arr[i].getNam2()
                                
                                +"</option>");
       %-->
     <%
                 nienKhoaHocKyDAO dao=new nienKhoaHocKyDAO();
                 NienKhoaHocKy arr[]= dao.getNKHK();
                    for(int i=0;i<arr.length;i++)
                        out.println("<option value='"+arr[i].getIdNienKhoaHocKy()+"'>"+
                                "hoc ky: "+arr[i].getHocKy()+" - Nam hoc: "+arr[i].getNam1()+"-"+
                                arr[i].getNam2()
                                
                                +"</option>");
                %>
         </select>
            <br/>
            <input class="btn btn-success" type="submit" name="action" value="Quản trị"/>
        </form>
      
    <!--%   NienKhoaHocKy nk=arr[i];
       Set<LopMonHoc> set= nk.getLopMonHocs();
       LopMonHoc [] lmharr=new LopMonHoc[set.size()];
       set.toArray(lmharr);
       
       out.print("<table class='table table-stripep'><thead><tr><td>ID</td><td>Mã lớp</td><td>Môn học</td> <td>Giảng viên</td><td>Số SV Max </td> <td>Khóa lớp</td> </thead>");
        out.print("<tbody>");
        for(int k=0;k<lmharr.length;k++){
         out.print("<form action='Controller'>"
                 + "<tr>"
                 + "<td width='15%'>"+lmharr[k].getIdLopMonHoc()+"</td>"+
                 "<td width='15%'>"+lmharr[k].getMa()+"</td>"+       
                 "<td width='40%'>"+lmharr[k].getMonHoc().getTen()+"</td>"+       
                 "<td width='15%'>"+lmharr[k].getCanBo().getMacb()+ "</td>"+
                 "<td width='15%' >"+lmharr[k].getSoSvMax()+ "</td>"
                 );

         if(lmharr[k].getTrangThai()==0)
             out.print("<td width='15%'>"
                     + "<input type='hidden' name='txtID' value='"+lmharr[k].getIdLopMonHoc()+ "'/>"
                     + "<input type='submit' value='Khóa' name='action' />"
                     
                     + "</tr></form>");
         else
             out.print("<td>"
                     + "<input type='hidden' name='txtID' value='"+lmharr[k].getIdLopMonHoc()+ "'/>"
                     + "<input type='submit' value='Mở' name='action'/></td></tr></form>");
        }
        out.print("</tbody></table>");
       }
                %-->
       
   
    <!--
       nienKhoaHocKyDAO dao= new nienKhoaHocKyDAO();
       NienKhoaHocKy[] arr=dao.getNKHK();
          for(int i=0;i<arr.length;i++){
       out.print("<h2>ID: "+ arr[i].getIdNienKhoaHocKy()+", Năm học: " +arr[i].getNam1()+"-"+arr[i].getNam2()+" Học kỳ: "+ arr[i].getHocKy() +  "</h2>");
       NienKhoaHocKy nk=arr[i];
       Set<LopMonHoc> set= nk.getLopMonHocs();
       LopMonHoc [] lmharr=new LopMonHoc[set.size()];
       set.toArray(lmharr);
       
        out.print("<table class='table table-stripep'><thead><tr><td>ID</td><td>Mã lớp</td><td>Môn học</td> <td>Giảng viên</td><td>Số SV Max </td> <td>Khóa lớp</td> </thead>");
        out.print("<tbody>");
        for(int k=0;k<lmharr.length;k++){
         out.print("<form action='Controller'>"
                 + "<tr>"
                 + "<td width='15%'>"+lmharr[k].getIdLopMonHoc()+"</td>"+
                 "<td width='15%'>"+lmharr[k].getMa()+"</td>"+       
                 "<td width='40%'>"+lmharr[k].getMonHoc().getTen()+"</td>"+       
                 "<td width='15%'>"+lmharr[k].getCanBo().getMacb()+ "</td>"+
                 "<td width='15%' >"+lmharr[k].getSoSvMax()+ "</td>"
                 );

         if(lmharr[k].getTrangThai()==0)
             out.print("<td width='15%'>"
                     + "<input type='hidden' name='txtID' value='"+lmharr[k].getIdLopMonHoc()+ "'/>"
                     + "<input type='submit' value='Khóa' name='action' />"
                     
                     + "</tr></form>");
         else
             out.print("<td>"
                     + "<input type='hidden' name='txtID' value='"+lmharr[k].getIdLopMonHoc()+ "'/>"
                     + "<input type='submit' value='Mở' name='action'/></td></tr></form>");
        }
        out.print("</tbody></table>");
       }
    -->
    </div>
        <label></label>
    </body>
</html>
