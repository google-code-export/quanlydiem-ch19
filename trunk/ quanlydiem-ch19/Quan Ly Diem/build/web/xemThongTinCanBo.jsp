<%-- 
    Document   : xemThongTinCanBo
    Created on : Oct 15, 2013, 10:02:52 PM
    Author     : Long
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trang xem thông tin cán bộ</title>
    </head>
    <body>
        <c:set var="list" value="${requestScope.DATA}"/>
        <c:if test="${not empty list}">
            <table border="1">
                <thead>
                    <tr>
                        <th>idCanBo</th>
                        <th>macb</th>
                        <th>idConNguoi</th>
                        <th>idLoaiCanBo</th>
                        <th>tdVanHoa</th>
                        <th>idHocVi</th>
                        <th>idHocHam</th>
                        <th>idNgach</th>
                        <th>bac</th>
                        <th>heSo</th>
                        <th>idTrinhDoNgoaiNgu</th>
                        <th>gioNghiaVu</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${list}" var="cb">
                        <tr>
                            <td>${cb.idCanBo}</td>
                            <td>${cb.macb}</td>
                            <td>${cb.idConNguoi}</td>
                            <td>${cb.idLoaiCanBo}</td>
                            <td>${cb.tdVanHoa}</td>
                            <td>${cb.idHocVi}</td>
                            <td>${cb.idHocHam}</td>
                            <td>${cb.idNgach}</td>
                            <td>${cb.bac}</td>
                            <td>${cb.heSo}</td>
                            <td>${cb.idTrinhDoNgoaiNgu}</td>
                            <td>${cb.gioNghiaVu}</td>
                            
                        </tr>
                    </c:forEach>    
                </tbody>
            </table>
        </c:if>
    </body>
</html>
