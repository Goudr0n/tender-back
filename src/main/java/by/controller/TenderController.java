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
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/tender")
public class TenderController {

    @RequestMapping("/createFinish")
    public String create(@ModelAttribute("tender") Tender tender, @RequestParam("currentUserLogin") String currentUserLogin, Model model) {
        User currentUser = User.getUserByLogin(currentUserLogin);
        tender.setOwner(currentUser);
        tender.setCurrentPrice(tender.getStartingPrice());
        tender.setStatus(new TenderStatus(1, "Открыт"));
        List<Tender> tenderList = Tender.getTenders();
        tenderList.sort((o1, o2) -> o2.getId() - o1.getId());
        Tender.saveTender(tender);

        model.addAttribute("currentUser", currentUser);
        model.addAttribute("tenders", tenderList);
        model.addAttribute("requestInfo", new RequestInfo());

        return "mainPage";
    }

    @RequestMapping("/open")
    public String open(@ModelAttribute("requestInfo") RequestInfo requestInfo, Model model) {
        try {
            String currentUserLogin = requestInfo.getCurrentUserLogin();

            Tender tender = Tender.getTenderById(requestInfo.getTenderId());
            User currentUser = User.getUserByLogin(currentUserLogin);

            boolean currentUserIsOwner = currentUserLogin.equals(tender.getOwner().getLogin());
            model.addAttribute("tender", tender);
            model.addAttribute("currentUser", currentUser);
            model.addAttribute("currentUserIsOwner", currentUserIsOwner);

            return "tenderPage";
        } catch (Exception e) {
            System.err.println("/open EXCEPTION: \n" + e.getMessage());
            return "tenderPage";
        }
    }

    @RequestMapping("/bid")
    public String bid(@ModelAttribute("requestInfo") RequestInfo requestInfo, Model model) {
        String currentUserLogin = requestInfo.getCurrentUserLogin();
        int newPrice = requestInfo.getNewPrice();
        try (SessionFactory sessionFactory = new Configuration()
                .configure()
                .addAnnotatedClass(User.class)
                .addAnnotatedClass(Tender.class)
                .addAnnotatedClass(TenderStatus.class)
                .buildSessionFactory();
             Session session = sessionFactory.getCurrentSession()) {

            session.beginTransaction();
            Tender tender = session.get(Tender.class, requestInfo.getTenderId());
            User currentUser = session.get(User.class, currentUserLogin);

            tender.setExecutant(currentUser);
            tender.setCurrentPrice(newPrice);
            session.getTransaction().commit();

            model.addAttribute("tender", tender);
            model.addAttribute("currentUser", currentUser);
            boolean currentUserIsOwner = currentUserLogin.equals(tender.getOwner().getLogin());
            model.addAttribute("currentUserIsOwner", currentUserIsOwner);
            model.addAttribute("isPriceUpdated", true);

            return "tenderPage";
        } catch (Exception e) {
            System.err.println("/bid EXCEPTION: \n" + e.getMessage());

            return "mainPage";
        }
    }

    @RequestMapping("/cancel")
    public String cancel(@ModelAttribute("requestInfo") RequestInfo requestInfo, Model model) {
        String currentUserLogin = requestInfo.getCurrentUserLogin();

        User currentUser = User.getUserByLogin(currentUserLogin);

        Tender updatedTender = Tender.cancel(requestInfo.getTenderId());

        model.addAttribute("tender", updatedTender);
        model.addAttribute("currentUser", currentUser);

        return "tenderPage";
    }

    @RequestMapping("/mainPage")
    public String openMainPage(@ModelAttribute("requestInfo") RequestInfo requestInfo, Model model) {

        String currentUserLogin = requestInfo.getCurrentUserLogin();
        try {
            User currentUser = User.getUserByLogin(currentUserLogin);
            List<Tender> tenderList = Tender.getTenders();
            tenderList.sort((o1, o2) -> o2.getId() - o1.getId());

            model.addAttribute("currentUser", currentUser);
            model.addAttribute("tenders", tenderList);
            return "mainPage";
        } catch (Exception e) {
            System.err.println("/bid EXCEPTION: \n" + e.getMessage());
            
            return "mainPage";
        }
    }
}
