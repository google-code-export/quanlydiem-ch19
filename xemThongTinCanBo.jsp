<%@page import="proj.dao.sinhVienDAO"%>
<%@page import="proj.entity.SinhVien"%>
<%@page import="proj.entity.KetQuaHoc"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : xemThongTinCanbo
    Created on : Oct 16, 2013, 10:21:27 AM
    Author     : Tu
--%>

<%@page import="proj.entity.LopMonHoc"%>
<%@page import="java.util.Set"%>
<%@page import="proj.entity.CanBo"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="css/metro-bootstrap.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <!-- Le styles -->
    <link rel="stylesheet" type="text/css" href="css/metro-bootstrap.css">
    <style>
        body
        {
            padding-top: 70px; /* 60px to make the container go all the way to the bottom of the topbar */
        }
    </style>
        <title>Nhập điểm</title>
    </head>
<body data-spy="scroll" data-target=".subnav" data-offset="50" screen_capture_injected="true">
     <!-- Navbar
    ================================================== -->
    <div class="navbar navbar-fixed-top">
        <div class="navbar-inner">
            <div class="container">
                <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
                </a><a class="brand" href="index.jsp">Quản lý điểm thi</a>
                <div class="nav-collapse collapse">
                   <ul class="nav">
                        <li class="active">
                        <li class=""><a href="Controller?action=Sinh viên">Sinh viên</a> </li>
                        <li class=""><a href="Controller?action=Nhập điểm">Giảng viên</a> </li>
                        <li class=""><a href="Controller?action=Quản trị">Quản trị</a> </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <c:set var="cb" value ="${requestScope.DATA}"/>
        <c:set  var="dsLopMonHoc" value="${cb.lopMonHocs}"/>
        <!-- danh sách môn học do cán bộ giảng dạy -->
        <h1>1. Nhập điểm cho môn dạy</h1> 
        <form name="Controller">
            <h3 >Chọn mã id lớp môn học: </h3>
            <select multiple="multiple" name="cbMonHoc">
                <c:forEach items="${dsLopMonHoc}" var = "lmh">
                    <c:if test="${lmh.trangThai == 0}">
                    <option value="${lmh.idLopMonHoc}">${lmh.idLopMonHoc} - ${lmh.monHoc.ten}</option>
                </c:if>
                </c:forEach>
            </select>
                 <input type="hidden" name="idCB" value="${cb.idCanBo}"/>
            <input type="hidden" name="cb" value="${cb.macb}"    />
            <input type="hidden" name="dong" value="1"/>
            <br/>
            <input class="btn btn-success" type="submit" name="action" value="Nhập điểm"/>
            <input class="btn btn-warning" type="submit" name="action" value="Xuất điểm Excel"/>
        </form>
        <h1>2. Xem điểm Sinh viên cố vấn</h1> 
        <form name="Controller">
            <h3 >Chọn mã SV muốn xem điểm: </h3>
            <select name="idSV">
                <%
                    sinhVienDAO dao=new sinhVienDAO();
                    CanBo cb= (CanBo)request.getAttribute("DATA");
                    int idCB=cb.getIdCanBo();
                    SinhVien [] svarr= dao.getSVByCB(idCB);
                    for(int i=0;i<svarr.length;i++)
                        out.println("<option value='"+svarr[i].getIdSinhVien()+"'>"+svarr[i].getMasv()+" ("+ svarr[i].getHoten() +")" + "</option>");
                %>
            </select>
            <br/>
            <input class="btn btn-success" type="submit" name="action" value="Xem điểm SV"/>
        </form>
    </div>
</body>
</html>
