

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import jxl.Sheet;
import jxl.Workbook;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import org.hibernate.Session;
import proj.dao.ketQuaHocDAO;
import proj.entity.KetQuaHocId;
//import org.apache.tomcat.util.http.fileupload.FileItem;

public class UploadFile extends HttpServlet {

    String saveFile="E:/upload/";
    private String url;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
         Session session = null;
        PrintWriter out = response.getWriter();
        int i=0;
        try {
          
            boolean ismultipart = ServletFileUpload.isMultipartContent(request);
            if(!ismultipart){
            
            }else{
                FileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload= new ServletFileUpload(factory);
                List items = null;
                try {
                    items = upload.parseRequest(request);
                } catch (Exception e) {
                }
                String []arr=new String[3];
                int k=0;
                Iterator itr= items.iterator();
                while(itr.hasNext()){
                    FileItem item = (FileItem)itr.next();
                    if(item.isFormField()){
                      arr[k]=item.getString();
                      k++;
                    }
                    else{
                        String itemname = item.getName();
                        if(itemname == null || itemname.equals("")){
                            continue;
                        }
                        String filename= FilenameUtils.getName(itemname);
                      
                        File f = checkExist(filename);
                        item.write(f);
                   
                    }
                }
                
        
             String filename =fileUpload;
             
            Workbook wrk1 =  Workbook.getWorkbook(new File(filename));
            Sheet sheet1 = wrk1.getSheet(0);
            int d=1;
            String url="Controller?cbMonHoc=";
            boolean tt=true;
            do{
                try {
                    
                       String idMH=sheet1.getCell(0,d).getContents();
                        String idSV=sheet1.getCell(1,d).getContents();
                        String idLMH=sheet1.getCell(2,d).getContents();
                    if(i==0){
                        i++;
                        url+=idLMH+"&idCB=5&cb=CB005&dong=1&action=Nhập+điểm";
                    }
                        String idDiemSo=sheet1.getCell(3,d).getContents();
                        if(idMH.equals("")){
                                tt=false;
                        }
                        else{
                           ketQuaHocDAO dao = new ketQuaHocDAO();
                           KetQuaHocId kqhID = new KetQuaHocId(Integer.parseInt(idMH),Integer.parseInt(idSV),Integer.parseInt(idLMH));
                           dao.update(Integer.parseInt(idDiemSo),kqhID);    
                        }
                        d++;   
                } catch (Exception e) {
                    tt=false;
                }
            }while(tt);
     //   RequestDispatcher rd= request.getRequestDispatcher("http://localhost:8084/Quan_Ly_Diem/");
      //  rd.forward(request, response);
        if(session != null)
        session.getTransaction().commit();
                
                
        }
    }
        catch(Exception e){
        
        }
        finally {            
            out.println("Đã nhập điểm xong!");
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
