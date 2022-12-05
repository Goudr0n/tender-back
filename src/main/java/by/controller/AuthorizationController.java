package by.controller;

import by.entity.RequestInfo;
import by.entity.Tender;
import by.entity.TenderStatus;
import by.entity.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/authorization")
public class AuthorizationController {

    @RequestMapping("/login")
    public String login(@ModelAttribute("currentUser") User user, Model model) {
        try {
            User userDB = User.getUserByLogin(user.getLogin());
            if (userDB != null && user.getPassword().equals(userDB.getPassword())) {
                List<Tender> tenderList = Tender.getTenders();
                tenderList.sort((o1, o2) -> o2.getId() - o1.getId());

                model.addAttribute("currentUser", userDB);
                model.addAttribute("tenders", tenderList);
                model.addAttribute("requestInfo", new RequestInfo());

                return "mainPage";
            } else {
                model.addAttribute("currentUser", user);
                model.addAttribute("loginError", true);

                return "loginPage";
            }
        } catch (Exception e) {
            System.out.println("EXCEPTION ONE");
            System.err.println(e.getMessage());

            model.addAttribute("currentUser", user);
            model.addAttribute("loginErrorUnknown", true);

            return "loginPage";
        }
    }

    @RequestMapping(value = "/registrationFinish")
    public String register(@ModelAttribute("user") User user, Model model) {
        try (SessionFactory sessionFactory = new Configuration()
                .configure()
                .addAnnotatedClass(User.class)
                .addAnnotatedClass(Tender.class)
                .addAnnotatedClass(TenderStatus.class)
                .buildSessionFactory();
             Session session = sessionFactory.getCurrentSession()) {

            session.beginTransaction();
            session.save(user);
            List<Tender> tenderList = Tender.getTenders();
            tenderList.sort((o1, o2) -> o2.getId() - o1.getId());
            session.getTransaction().commit();

            model.addAttribute("currentUser", user);
            model.addAttribute("tenders", tenderList);
            model.addAttribute("requestInfo", new RequestInfo());

            return "mainPage";
        } catch (Exception e) {
            System.err.println(e);

            model.addAttribute("user", user);
            model.addAttribute("registrationError", true);
            return "registrationPage";
        }
    }
}
