<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : capNhatDiem
    Created on : Oct 16, 2013, 9:54:32 PM
    Author     : Long
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://digamma.ch/taglib/excel.tld" prefix="xls"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/metro-bootstrap.css"/>
        <title>Cập nhật điểm </title>
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
    
        <br/>
        <br/>
       <br/>
        <br/>
         <p align ="right"><font color="blue">Hi, ${sessionScope.DATA}</font></p>
        <table class="table table-striped">
            
            <tr>
                <td>STT </td>
                <td>Mã số sinh viên</td>
                <td>Họ tên </td>
                <td>Điểm số</td>
                <td>Điểm chữ</td>
                <td>Tích lũy</td>
                <td>--------</td>
            </tr>
                <script type="text/javascript">
                function validateForm()
                {
                    var x=document.forms["nhapDiem"]["txtDiemSo"].value;
                    
                    if (isNaN(x)){
                        alert('Điểm thi phải là số!');
                        return false;
                    }
                    else if( x< 0 || x>10){
                        alert("Điểm thi thuộc đoạn [0,10]")
                        return false;
                    }
                    return true;
        
                }
            </script>
        <c:set var="count" value="1"/>
            <c:forEach var="kqh" items="${requestScope.KQH}">
            <tr>
                <form action="Controller" name="nhapDiem" onsubmit="return validateForm()">
                    <td><label>${count}</label></td>
                <td><input type="text" name="txtIdSinhVien" value ="${kqh.id.idSinhVien}" readonly/> </td>
               
               <td><input type="text" name="txtHoten" value ="${kqh.sinhVien.hoten}" readonly/> </td>
                <td><input id="${count}" type="text" name="txtDiemSo" value="${kqh.diemSo}"  /> </td>
                <td><input type="text" name="txtDiemChu" value="${kqh.diemChu}" readonly/> </td>
                <c:if test="${kqh.tichLuy =='true'}">
                 <td><input type="checkbox" name="txtTichLuy" checked readonly/> </td>
                </c:if>
                <c:if test="${kqh.tichLuy != 'true'}">
                <td><input type="checkbox" name="txtTichLuy"  readonly/> </td>
                
                </c:if>
                <c:set var="idLMH" value="${kqh.id.idLopMonHoc}"/>
                <td><input type="image" src="img/save.png" height="16px" witdh="16px" value="Cập nhật điểm" name="action" /></td>
                <input type="hidden" name="idLMH" value="${kqh.id.idLopMonHoc}"/>
                <input type="hidden" name="idMH" value="${kqh.id.idMonHoc}"/>
                <input type="hidden" name="idCB" value="${requestScope.idCB}"/>  
                <input type="hidden" name="dong" value="${count}"/>
                </form>
            </tr>
              <c:set var="count" value="${count+1}"/>
        </c:forEach>
            <script>
                document.getElementById(${requestScope.dong}).focus();
            </script>
       </table>
            <br/>
          
       <h3 style="color: #149bdf">Nhập điểm từ Excel</h3>
       
        <form action="UploadFile" method="POST" enctype="multipart/form-data">
        
            <input type="file" name="filetoupload"/><br/>
            <input type="hidden" name="idLMH" value="${idLMH}"/>
            <input type="hidden" name="idCB" value="${requestScope.idCB}"/>
            <input type="submit" value="Upload File"/>
         </form>
     </div>
        
    </body>
</html>
