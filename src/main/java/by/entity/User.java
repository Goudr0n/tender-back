package by.entity;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "users")
public class User {

    @Id
    @Column
    private String login;

    @Column
    private String password;

    @Column
    private String description;

    @OneToMany(mappedBy = "owner", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Tender> ownedTenders;

    @OneToMany(mappedBy = "executant", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Tender> executantTenders;

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<Tender> getOwnedTenders() {
        return ownedTenders;
    }

    public void setOwnedTenders(List<Tender> ownedTenders) {
        this.ownedTenders = ownedTenders;
    }

    public List<Tender> getExecutantTenders() {
        return executantTenders;
    }

    public void setExecutantTenders(List<Tender> executantTenders) {
        this.executantTenders = executantTenders;
    }

    @Override
    public String toString() {
        return "User{" +
                "login='" + login + '\'' +
                ", password='" + password + '\'' +
                ", description='" + description + '\'' +
                '}';
    }

    public static User getUserByLogin(String login) {
        try (SessionFactory sessionFactory = new Configuration()
                .configure()
                .addAnnotatedClass(User.class)
                .addAnnotatedClass(Tender.class)
                .addAnnotatedClass(TenderStatus.class)
                .buildSessionFactory();
             Session session = sessionFactory.getCurrentSession()) {

            session.beginTransaction();
            User user = session.get(User.class, login);
            session.getTransaction().commit();

            return user;
        }
    }
}
