/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package proj.dao;

import java.util.List;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import proj.entity.CanBo;
import proj.util.HibernateUtil;

/**
 *
 * @author Long
 */
public class canBoDAO {
  private Session session;
  public canBoDAO(){
      SessionFactory factory = HibernateUtil.getSessionFactory();
      session = factory.getCurrentSession();
  }
  public CanBo[] getAll(){
      try {
        session.getTransaction().begin();
        String sql = "from CanBo";
        Query query=session.createQuery(sql);
        List lst=query.list();
        CanBo[] canboArray=new CanBo[lst.size()];
        lst.toArray(canboArray);
          
        session.flush();
        session.getTransaction().commit();
        return canboArray;
          
      } catch (Exception e) {
          if(session.getTransaction().isActive()){
            session.getTransaction().rollback();
          }
      }
      return null;
  }
  
}
