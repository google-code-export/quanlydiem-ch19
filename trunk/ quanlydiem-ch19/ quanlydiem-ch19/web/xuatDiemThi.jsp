<%@page import="proj.entity.CanBo"%>
<%@page import="proj.dao.canBoDAO"%>
<%@page import="proj.entity.KetQuaHoc"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : capNhatDiem
    Created on : Oct 16, 2013, 9:54:32 PM
    Author     : Long
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/metro-bootstrap.css"/>
        <title>Xuất điểm thi</title>
    </head>
    <body data-spy="scroll" data-target=".subnav" data-offset="50" screen_capture_injected="true">
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
    <%
        String exportToExcel = request.getParameter("exportToExcel");
        if (exportToExcel != null
                && exportToExcel.toString().equalsIgnoreCase("YES")) {
             response.setContentType("text/html; charset=utf-8");

            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-Disposition", "inline; filename="
                    + "excel.xls");
 
        }
    %>
    <h2>Bảng điểm môn ${sessionScope.tenMH}</h2>
    <h3>Giảng viên: ${sessionScope.maCB}</h3>
      <table border="2">
            <tr bgcolor="lightgray">
                <td>STT </td>
                <td>Mã số sinh viên</td>
                <td>Điểm số</td>
                <td>Điểm chữ</td>
                <td>Tích lũy</td>
             
            </tr>
        <c:set var="count" value="1"/>
        <c:set var="cTL" value="0"/>
        <c:set var="cKTL" value="0"/>
            <c:forEach var="kqh" items="${sessionScope.KQH}">
                <c:if test="${count % 2 == 0}">
                    <tr bgcolor="lightblue">
                </c:if>
                <c:if test="${count % 2 != 0}">
                    <tr>
                </c:if>
                 <td>${count}</td>
                <td>${kqh.id.idSinhVien}</td>
                <td>${kqh.diemSo}</td>
                <td>${kqh.diemChu}</td>
              <c:if test="${kqh.tichLuy=='true'}">
                    <td>Đạt</td>
                    <c:set var="cTL" value="${cTL+1}"/>
                </c:if>
                <c:if test="${kqh.tichLuy=='false'}">
                    <td>Rớt</td>
                    <c:set var="cKTL" value="${cKTL+1}"/>
                </c:if>
            </tr>
              <c:set var="count" value="${count+1}"/>
            </c:forEach>
       </table>
            <br/>
            <table width="100%">
                <tr ><td width="10%">Tổng số SV đậu:</td><td>${cTL}</td></tr>
                <tr ><td width="10%">Tổng số SV rớt:</td><td>${cKTL}</td></tr>
                  <tr ><td width="10%">Tổng số SV:</td><td>${cTL+cKTL}</td></tr>
            </table>
       
      
            <%
        if (exportToExcel == null) {
    %>
    <br/>
    <a href="xuatDiemThi.jsp?exportToExcel=YES">Xuất file Excel</a>
    <%
        }
    %>
    </div>
    </body>
</html>
