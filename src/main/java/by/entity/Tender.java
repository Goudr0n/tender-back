package by.entity;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "tenders")
public class Tender {

    @Id
    @Column
    private int id;

    @ManyToOne(cascade = {CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH, CascadeType.DETACH})
    @JoinColumn(name = "owner")
    private User owner;

    @Column
    private String name;

    @Column
    private String description;

    @Column
    private String date;

    @Column(name = "starting_price")
    private int startingPrice;

    @Column(name = "current_price")
    private int currentPrice;

    @ManyToOne(cascade = {CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH, CascadeType.DETACH})
    @JoinColumn(name = "executant")
    private User executant;

    @ManyToOne(cascade = {CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH, CascadeType.DETACH})
    @JoinColumn(name = "status")
    private TenderStatus status;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public User getOwner() {
        return owner;
    }

    public void setOwner(User owner) {
        this.owner = owner;
    }

    public void setOwner(String ownerLogin) {
        this.owner = User.getUserByLogin(ownerLogin);
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public int getStartingPrice() {
        return startingPrice;
    }

    public void setStartingPrice(int startingPrice) {
        this.startingPrice = startingPrice;
    }

    public int getCurrentPrice() {
        return currentPrice;
    }

    public void setCurrentPrice(int currentPrice) {
        this.currentPrice = currentPrice;
    }

    public User getExecutant() {
        return executant;
    }

    public void setExecutant(User executant) {
        this.executant = executant;
    }

    public void setExecutant(String executantLogin) {
        this.executant = User.getUserByLogin(executantLogin);
    }

    public TenderStatus getStatus() {
        return status;
    }

    public void setStatus(TenderStatus status) {
        this.status = status;
    }

    public static List<Tender> getTenders() {
        try (SessionFactory sessionFactory = new Configuration()
                .configure()
                .addAnnotatedClass(User.class)
                .addAnnotatedClass(Tender.class)
                .addAnnotatedClass(TenderStatus.class)
                .buildSessionFactory();
             Session session = sessionFactory.getCurrentSession()) {

            session.beginTransaction();
            List<Tender> tenders = session.createQuery("from Tender", Tender.class).getResultList();
            session.getTransaction().commit();

            return tenders;
        }
    }

    public static Tender getTenderById(int id) {
        try (SessionFactory sessionFactory = new Configuration()
                .configure()
                .addAnnotatedClass(User.class)
                .addAnnotatedClass(Tender.class)
                .addAnnotatedClass(TenderStatus.class)
                .buildSessionFactory();
             Session session = sessionFactory.getCurrentSession()) {

            session.beginTransaction();
            Tender tender = session.get(Tender.class, id);
            session.getTransaction().commit();

            return tender;
        }
    }

    public static void saveTender(Tender tender) {
        try (SessionFactory sessionFactory = new Configuration()
                .configure()
                .addAnnotatedClass(User.class)
                .addAnnotatedClass(Tender.class)
                .addAnnotatedClass(TenderStatus.class)
                .buildSessionFactory();
             Session session = sessionFactory.getCurrentSession()) {

            session.beginTransaction();
            session.save(tender);
            session.getTransaction().commit();
        }
    }

    public static Tender cancel(int tenderId) {
        try (SessionFactory sessionFactory = new Configuration()
                .configure()
                .addAnnotatedClass(User.class)
                .addAnnotatedClass(Tender.class)
                .addAnnotatedClass(TenderStatus.class)
                .buildSessionFactory();
             Session session = sessionFactory.getCurrentSession()) {

            session.beginTransaction();
            Tender tender = session.get(Tender.class, tenderId);
            TenderStatus status = session.get(TenderStatus.class, 2);
            tender.setStatus(status);
//            session.save(this);
            session.getTransaction().commit();

            return tender;
        }
    }

    @Override
    public String toString() {
        return "Tender{" +
                "id=" + id +
                ", owner=" + owner +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", date='" + date + '\'' +
                ", startingPrice='" + startingPrice + '\'' +
                ", currentPrice='" + currentPrice + '\'' +
                ", executant=" + executant +
                ", status=" + status +
                '}';
    }
}
