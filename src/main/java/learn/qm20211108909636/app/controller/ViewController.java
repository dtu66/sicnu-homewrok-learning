package learn.qm20211108909636.app.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ViewController {
    @RequestMapping({"/", "/index"})
    public String index() {
        return "index";
    }

    @RequestMapping("/login")
    public String login() {
        return "login";
    }

    @RequestMapping("/register")
    public String register() {
        return "register";
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        session.removeAttribute("user");
        return "index";
    }

    @RequestMapping("/user/profile")
    public String profile() {
        return "profile";
    }

    @RequestMapping("/content/{id}")
    public String content(@PathVariable String id, HttpSession session) {
        session.setAttribute("contentId", id);
        return "content";
    }

    @RequestMapping("/admin/login")
    public String adminLogin() {
        return "admin/login";
    }

    @RequestMapping({"/admin", "/admin/index"})
    public String adminIndex() {
        return "admin/index";
    }

    @RequestMapping("/admin/profile")
    public String adminProfile() {
        return "admin/profile";
    }

    @RequestMapping("/admin/user")
    public String adminUser() {
        return "admin/user";
    }

    @RequestMapping("/admin/records")
    public String adminRecords() {
        return "admin/records";
    }

    @RequestMapping("/admin/content")
    public String adminContent() {
        return "admin/content";
    }


}
