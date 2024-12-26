package learn.qm20211108909636.app.controller;

import jakarta.servlet.http.HttpSession;
import learn.qm20211108909636.app.Enum.StatusCode;
import learn.qm20211108909636.app.entity.Userinfo;
import learn.qm20211108909636.app.service.UserService;
import learn.qm20211108909636.app.utils.FileUtil;
import learn.qm20211108909636.app.utils.ResultUtil;
import learn.qm20211108909636.app.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Map;

@RestController
@RequestMapping("/api/user")
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("/is-login")
    public String isLogin(HttpSession session) {
        Userinfo user = (Userinfo) session.getAttribute("user");
        if (user == null)
            return ResultUtil.error();
        return ResultUtil.success(user);
    }

    @PostMapping("/login")
    public String login(@RequestParam String username, @RequestParam String password, HttpSession session) {
        Userinfo userinfo = userService.login(username, password);
        if (userinfo == null)
            return ResultUtil.error(StatusCode.WRONG_CREDENTIALS);
        session.setAttribute("user", userinfo);
        return ResultUtil.success(userinfo);
    }

    @PostMapping("/logout")
    public String logout(HttpSession session) {
        session.removeAttribute("userinfo");
        return ResultUtil.success();
    }

    @PostMapping("/admin/login")
    public String adminLogin(@RequestParam String username, @RequestParam String password, HttpSession session) {
        Userinfo userinfo = userService.login(username, password);
        if (userinfo == null)
            return ResultUtil.error(StatusCode.WRONG_CREDENTIALS);
        if (!userinfo.getRole().equals("admin"))
            return ResultUtil.error(StatusCode.FORBIDDEN);
        session.setAttribute("user", userinfo);
        return ResultUtil.success(userinfo);
    }

    @PostMapping()
    public String register(Userinfo userinfo) {
        userinfo.setRole("user");
        userinfo.setHeadImage("default.jpg");
        int result = userService.register(userinfo);
        if (result > 0)
            return ResultUtil.success();
        else if (result == -1) {
            return ResultUtil.error(StatusCode.USERNAME_EXISTS);
        }
        return ResultUtil.error();
    }

    @PutMapping()
    public String update(@RequestBody Map<String, String> map,
                         HttpSession session) throws IOException {
        Integer id = StringUtil.isEmpty(map.get("id")) ? null : Integer.parseInt(map.get("id"));
        String username = StringUtil.isEmpty(map.get("username")) ? null : map.get("username");
        String headImage = StringUtil.isEmpty(map.get("headImage")) ? null : map.get("headImage");

        Userinfo user = (Userinfo) session.getAttribute("user");
        if (user == null || !user.getId().equals(id))
            return ResultUtil.error(StatusCode.FORBIDDEN);

        if (!StringUtil.isEmpty(username))
            user.setUsername(username);

        if (!StringUtil.isEmpty(headImage)) {
            user.setHeadImage(headImage);
        }

        int result = userService.update(user);

        if (result > 0) {
            session.setAttribute("user", user);
            return ResultUtil.success();
        }
        return ResultUtil.error();
    }

    @PostMapping("/password")
    public String updatePassword(@RequestParam("id") Integer id,
                                 @RequestParam("oldPassword") String oldPassword,
                                 @RequestParam("newPassword") String newPassword,
                                 HttpSession session) {
        Userinfo user = (Userinfo) session.getAttribute("user");
        if (user == null || !user.getId().equals(id))
            return ResultUtil.error(StatusCode.FORBIDDEN);

        if (!user.getPassword().equals(oldPassword))
            return ResultUtil.error(StatusCode.WRONG_CREDENTIALS);

        user.setPassword(newPassword);
        int result = userService.update(user);

        if (result > 0) {
            session.setAttribute("user", user);
            return ResultUtil.success();
        }
        return ResultUtil.error();
    }

    @PostMapping("/admin/search")
    public String search(@RequestBody Map<String,String> map) {
        String username = StringUtil.isEmpty( map.get("username")) ? null :  map.get("username");
        String role = StringUtil.isEmpty( map.get("role")) ? null :  map.get("role");
        Integer page = StringUtil.isEmpty( map.get("page")) ? 1 : Integer.parseInt(map.get("page"));
        Integer size = StringUtil.isEmpty(map.get("size")) ? 10 : Integer.parseInt(map.get("size"));

        return ResultUtil.success(userService.searchByPage(username,role, page, size));

    }

    @GetMapping("/admin/most-study")
    public String mostStudy() {
        return ResultUtil.success(userService.mostStudy(3));
    }

    @GetMapping("/admin/latest-study")
    public String latestStudy() {
        return ResultUtil.success(userService.latestStudy(3));
    }

    @PutMapping("/admin/user/role")
    public String updateRole(@RequestBody Map<String, String> map,
                             HttpSession session) {
        Integer id = StringUtil.isEmpty(map.get("id")) ? null : Integer.parseInt(map.get("id"));
        String role = StringUtil.isEmpty(map.get("role")) ? null : map.get("role");
        if (id == null || role == null)
            return ResultUtil.error(StatusCode.PARAM_ERROR);
        Userinfo user = (Userinfo) session.getAttribute("user");
        if (user == null || !user.getRole().equals("admin"))
            return ResultUtil.error(StatusCode.FORBIDDEN);

        Userinfo target = userService.selectById(id);
        if (target == null)
            return ResultUtil.error(StatusCode.NOT_FOUND);

        target.setRole(role);
        int result = userService.update(target);

        if (result > 0)
            return ResultUtil.success();
        return ResultUtil.error();
    }

    @DeleteMapping("/admin/user/avatar")
    public String deleteAvatar(@RequestBody Map<String, Integer> map,
                               HttpSession session) {
        Integer id = map.get("id");
        if (id == null)
            return ResultUtil.error(StatusCode.PARAM_ERROR);
        Userinfo user = (Userinfo) session.getAttribute("user");
        if (user == null || !user.getRole().equals("admin"))
            return ResultUtil.error(StatusCode.FORBIDDEN);

        Userinfo target = userService.selectById(id);
        if (target == null)
            return ResultUtil.error(StatusCode.NOT_FOUND);

        target.setHeadImage("/profile/default.jpg");
        int result = userService.update(target);

        if (result > 0)
            return ResultUtil.success();
        return ResultUtil.error();
    }

    @DeleteMapping("/admin/user")
    public String deleteUser(@RequestBody Map<String, Integer> map,
                             HttpSession session) {
        Integer id = map.get("id");
        if (id == null)
            return ResultUtil.error(StatusCode.PARAM_ERROR);
        Userinfo user = (Userinfo) session.getAttribute("user");
        if (user == null || !user.getRole().equals("admin"))
            return ResultUtil.error(StatusCode.FORBIDDEN);

        int result = userService.delete(id);

        if (result > 0)
            return ResultUtil.success();
        return ResultUtil.error();
    }


}
