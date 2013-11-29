/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package proj.servlet;

import java.io.File;
import java.io.PrintWriter;
import java.util.Set;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import proj.dao.canBoDAO;
import proj.dao.ketQuaHocDAO;
import proj.dao.lopMonHocDAO;
import proj.dao.sinhVienDAO;
import proj.entity.CanBo;
import proj.entity.KetQuaHoc;
import proj.entity.KetQuaHocId;
import proj.entity.LopMonHoc;
import proj.entity.SinhVien;
import java.io.IOException;
import java.util.Date;


/**
 *
 * @author Long
 */
@WebServlet(name = "Controller", urlPatterns = {"/Controller"})
public class Controller extends HttpServlet {
String saveFile="C:/upload/";
        private String url;
        String username;
        String password;
        Boolean isLogin=false;
        Boolean isAdmin=false;
        Boolean isSinhVien=false;
        Boolean isGiangVien=false;
        Boolean dangNhapDiem=false;
        String chucnang="";
        CanBo cbtemp;
        KetQuaHoc []kQHtemp;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
          String action = request.getParameter("action");
          String url ="";
        //  Session session = null;
          if(action.equals("Login")){
              username=request.getParameter("username");
              password=request.getParameter("password");
              if(username.contains("CB") || username.contains("Admin")){
                canBoDAO dao=new canBoDAO();
                CanBo cb=dao.dangNhap(username, password);
                if(cb!=null){
                       HttpSession session = request.getSession(true);
                       session.setAttribute("DATA", username);
                      // request.setAttribute("DATA", cb);
                        isLogin=true;
                        if(cb.getMacb().equals("Admin"))
                            isAdmin=true;
                        else if(cb.getMacb().contains("CB")){
                            isGiangVien=true;
                        }
                        if(chucnang.equals("Giảng viên"))
                            url="Controller?action=Giảng viên";
                        else if(chucnang.equals("Quản trị"))
                            url="Controller?action=Quản trị";
                        else if(chucnang.equals("Xem điểm SV"))
                            url="Controller?action=Xem điểm SV";
                        else{
                            url="login.jsp?error=LoiDangNhap";
                        }
                 }
                else{
                    url="login.jsp?error=LoiDangNhap";
                }
              }
              else{
                  sinhVienDAO dao=new sinhVienDAO();
                  SinhVien sv=dao.dangNhap(username, password);
                  if(sv!=null){
                     HttpSession session = request.getSession(true);
                      session.setAttribute("DATA", username);
                     // request.setAttribute("DATA", sv);
                      isLogin=true;
                      isSinhVien=true;
                      if(chucnang.equals("Sinh viên")){
                          url="Controller?action=Sinh viên";
                      }
                      else
                          url="login.jsp?error=LoiDangNhap";
                  }
                      else{
                  
                      url="login.jsp?error=LoiDangNhap";
                  }
                          
                          
                }
          }
          
          else if(action.equals("Sinh viên")){
              chucnang="Sinh viên";
              if(isSinhVien){
                  isGiangVien=isAdmin=false;
                  sinhVienDAO dao=new sinhVienDAO();
                  SinhVien sv = dao.getSVbyMa(username);
                 // HttpSession httpsession=request.getSession(true);
                //httpsession.setAttribute("DATA", sv);
               HttpSession session = request.getSession(true);
                session.setAttribute("DATA", sv); 
                  //request.setAttribute("DATA", sv);
                  url="sinhVien.jsp";
              }
              else{
                  url="login.jsp?error=LoiDangNhap";
              }
          }
          else if (action.equals("Lọc môn rớt")){
              chucnang="Lọc môn rớt";
              if(isSinhVien){
                  isGiangVien=isAdmin=false;
                  sinhVienDAO dao=new sinhVienDAO();
                  SinhVien sv = dao.getSVbyMa(username);
                 // HttpSession httpsession=request.getSession(true);
                  //httpsession.setAttribute("DATA", sv);
                 // httpsession.setAttribute("Rot", true);
                   HttpSession session = request.getSession(true);
                session.setAttribute("DATA", sv);
                session.setAttribute("Rot", true);
                  url="sinhVien.jsp";
              }
              else{
                  url="login.jsp?error=LoiDangNhap";
              }
          }
          else if(action.equals("Giảng viên")){
              chucnang="Giảng viên";
                if(isGiangVien){
                    isSinhVien=isAdmin=false;
                        canBoDAO daocanbo=new canBoDAO();
                        CanBo cb = daocanbo.getCBbyMa(username);
                        request.setAttribute("DATA", cb);
                        url="xemThongTinCanBo.jsp";
                }
                else{
                    url="login.jsp?error=LoiChucNang";
                }
          }
          else if(action.equals("Nhập điểm")){
                chucnang="Nhập điểm";
                if(isGiangVien){
                    try {
                    isSinhVien=isAdmin=false;
                    int idCB =Integer.parseInt(request.getParameter("idCB"));
                    int dong =Integer.parseInt(request.getParameter("dong"));
                    int idlopmon = Integer.parseInt(request.getParameter("cbMonHoc"));
                    lopMonHocDAO daoLMH = new lopMonHocDAO();
                    LopMonHoc lmh = daoLMH.getLMH(idlopmon);
                    Set<KetQuaHoc> setKQH = lmh.getKetQuaHocs();
                    KetQuaHoc []arrKQH = new KetQuaHoc[setKQH.size()];
                    setKQH.toArray(arrKQH);
                    String macb = request.getParameter("cb");
                    canBoDAO daocanbo=new canBoDAO();
                    CanBo cb = daocanbo.getCBbyMa(macb);
                    cbtemp=cb;
                    kQHtemp = arrKQH;
                    request.setAttribute("idLMH",idlopmon);
                    request.setAttribute("KQH", arrKQH);
                    request.setAttribute("idCB", idCB);
                    request.setAttribute("dong", dong);
                    request.setAttribute("DATA", cb);
                   // HttpSession httpsession=request.getSession(true);
                     HttpSession session=request.getSession(true);
                    sinhVienDAO daoSV=new sinhVienDAO();
                    SinhVien [] svList= daoSV.getSVByCB(cb.getIdCanBo());
                     //httpsession.setAttribute("svLIST", svList);
                     session.setAttribute("svLIST", svList);
                    url="capNhatDiem.jsp";
                    } catch (Exception e) {
                        url="Controller?action=Giảng viên";
                    }
              }
                else{
                  url="login.jsp?error=LoiChucNang";
                }
          }
           else if(action.equals("Cập nhật điểm")){
               chucnang="Cập nhật điểm";
                if(isGiangVien){
                    isSinhVien=isAdmin=false;
                    int idCB =Integer.parseInt(request.getParameter("idCB"));
                    int idLMH=Integer.parseInt( request.getParameter("idLMH"));
                    int idMH=Integer.parseInt(request.getParameter("idMH"));
                    int idSinhVien = Integer.parseInt(request.getParameter("txtIdSinhVien"));
                    int txtDiemSo = Integer.parseInt(request.getParameter("txtDiemSo"));
                    int dong=Integer.parseInt(request.getParameter("dong"))+1;
                    ketQuaHocDAO dao = new ketQuaHocDAO();
                    KetQuaHocId kqhID = new KetQuaHocId(idMH,idSinhVien,idLMH);
                    dao.update(txtDiemSo,kqhID);
                    
                    url="Controller?action=Nhập điểm&idCB"+idCB+"&dong="+dong+"&cbMonHoc="+idLMH+"&cb="+username;
                }
                else
                    url="login.jsp?error=LoiChucNang";
            }
           
           else if(action.equals("Xuất điểm Excel")){
               chucnang="Xuất điểm Excel";
               if(isGiangVien){
                   isSinhVien=isAdmin=false;
                   try {
                       int idlopmon = Integer.parseInt(request.getParameter("cbMonHoc"));
                       lopMonHocDAO daoLMH = new lopMonHocDAO();
                       LopMonHoc lmh = daoLMH.getLMH(idlopmon);
                       Set<KetQuaHoc> setKQH = lmh.getKetQuaHocs();
                       KetQuaHoc []arrKQH = new KetQuaHoc[setKQH.size()];
                       setKQH.toArray(arrKQH);
                       canBoDAO daocanbo=new canBoDAO();
                       CanBo cb = daocanbo.getCBbyMa(username);
                       cbtemp=cb;
                       kQHtemp = arrKQH;
                       request.setAttribute("idLMH",idlopmon);
                       request.setAttribute("KQH", arrKQH);
                      // HttpSession httpsession=request.getSession(true);
                      // httpsession.setAttribute("KQH", arrKQH);
                      // httpsession.setAttribute("tenMH", arrKQH[0].getMonHoc().getTen());
                       HttpSession session=request.getSession(true);
                       session.setAttribute("KQH", arrKQH);
                       session.setAttribute("tenMH", arrKQH[0].getMonHoc().getTen());
                       request.setAttribute("DATA", cb);
                      // httpsession.setAttribute("maCB", cb.getMacb());
                       session.setAttribute("maCB", cb.getMacb());
                       sinhVienDAO daoSV=new sinhVienDAO();
                       SinhVien [] svList= daoSV.getSVByCB(cb.getIdCanBo());
                      // httpsession.setAttribute("svLIST", svList);
                        session.setAttribute("svLIST", svList);
                       url="xuatDiemThi.jsp";
                        
                   } catch (Exception e) {
                       url="Controller?action=Giảng viên";
                   }
               }
               else{
                   url="login.jsp?error=LoiChucNang";
               }
          }
          else if(action.equals("Xem điểm SV")){
               chucnang="Xem điểm SV";
                if(isGiangVien){
                    isSinhVien=isAdmin=false;
                    int masv =Integer.parseInt(request.getParameter("idSV"));
                    sinhVienDAO dao=new sinhVienDAO();
                    KetQuaHoc[] kqh= dao.getKQHbyID(masv);
                 //  HttpSession httpsession=request.getSession(true);
                   // httpsession.setAttribute("KQH", kqh);
                   // httpsession.setAttribute("maSV", masv);
                    HttpSession session=request.getSession(true);
                    session.setAttribute("KQH", kqh);
                    session.setAttribute("maSV", masv);
                    url="xemDiemSV.jsp";
                }   
                else
                    url="login.jsp?error=LoiChucNang";
          }
        else if(action.equals("Quản trị")){
               chucnang="Quản trị";
                if(isAdmin){
                    isGiangVien=isSinhVien=false;
                    canBoDAO daocanbo=new canBoDAO();
                    CanBo cb = daocanbo.dangNhap(username,password);
                    if(cb!=null && cb.getMacb().equals("Admin")){
                        cbtemp=cb;
                        request.setAttribute("idCB", cb.getMacb());
                        url="quanTri.jsp";
                    }
                    else{
                        url="Controller?action=Login";
                        chucnang="Quản trị";
                    }
               }
               else
                       url="login.jsp?error=LoiChucNang";
           }
           else if(action.equals("Khóa") || action.equals("Mở")){
               if(isAdmin){
                isGiangVien= isSinhVien=false;
                int id=Integer.parseInt(request.getParameter("txtID"));
                int Lock=0;
                if(action.equals("Khóa"))
                    Lock=1;
                else
                    Lock=0;
                lopMonHocDAO dao=new lopMonHocDAO();
                dao.updateTrangThai(Lock, id);
                url="quanTri.jsp";
               }
               else
                       url="login.jsp?error=LoiChucNang";
        }
        RequestDispatcher rd= request.getRequestDispatcher(url);
        rd.forward(request, response);
      //  if(session != null)
       //  session.getTransaction().commit();
        }
        
        catch(Exception e){
        e.printStackTrace();
        } 
        finally {
            out.close();
        }
    }
 
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

 public String fileUpload;
    private File checkExist(String filename) {
        File f = new File(saveFile+"/"+filename);
        if(f.exists()){
            StringBuilder sb = new StringBuilder(filename);
            sb.insert(sb.lastIndexOf("."),"-"+new Date().getTime());
            f = new File(saveFile+"/"+sb.toString());
            fileUpload=saveFile+"/"+sb.toString();
        }
        else
            fileUpload=saveFile+"/"+filename;
        return f;
    }
}
