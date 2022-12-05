package by.controller;

import by.entity.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UtilityController {

    @RequestMapping("/")
    public String showLoginPage(Model model) {
        model.addAttribute("currentUser", new User());

        return "loginPage";
    }

    @RequestMapping("/registerStart")
    public String showRegistrationPage(Model model) {
        model.addAttribute("user", new User());

        return "registrationPage";
    }
}
