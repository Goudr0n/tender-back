package by.entity;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "tender_statuses")
public class TenderStatus {

    @Id
    @Column
    private int id;

    @Column
    private String value;

    @OneToMany(mappedBy = "status", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Tender> tenders;

    public TenderStatus() {
    }

    public TenderStatus(int id, String value) {
        this.id = id;
        this.value = value;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public List<Tender> getTenders() {
        return tenders;
    }

    public void setTenders(List<Tender> tenders) {
        this.tenders = tenders;
    }

    @Override
    public String toString() {
        return "TenderStatus{" +
                "id=" + id +
                ", value='" + value + '\'' +
                '}';
    }
}
