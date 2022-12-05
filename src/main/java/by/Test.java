package by;

import by.entity.Tender;
import by.entity.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

import java.util.List;

public class Test {

    public static void main(String[] args) {

        try (SessionFactory sessionFactory = new Configuration()
                .configure()
                .addAnnotatedClass(User.class)
                .addAnnotatedClass(Tender.class)
                .buildSessionFactory();
        Session session=sessionFactory.getCurrentSession()){

            session.beginTransaction();
            List<Tender> tenders = session.createQuery("from Tender").getResultList();
            session.getTransaction().commit();

            tenders.forEach(System.out::println);

        }

    }
}
