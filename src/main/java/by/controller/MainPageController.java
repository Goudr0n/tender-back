package by.controller;

import by.entity.RequestInfo;
import by.entity.Tender;
import by.entity.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/main")
public class MainPageController {

    @RequestMapping("/createStart")
    public String createTender(@ModelAttribute("requestInfo") RequestInfo requestInfo, Model model) {
        User currentUser = User.getUserByLogin(requestInfo.getCurrentUserLogin());
        Tender tender = new Tender();
        tender.setOwner(currentUser);

        model.addAttribute("currentUser", currentUser);
        model.addAttribute("tender", tender);

        return "newTenderPage";
    }
}
