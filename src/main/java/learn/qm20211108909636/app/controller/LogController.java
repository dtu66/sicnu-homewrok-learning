package learn.qm20211108909636.app.controller;

import learn.qm20211108909636.app.entity.Log;
import learn.qm20211108909636.app.service.LogService;
import learn.qm20211108909636.app.utils.ResultUtil;
import learn.qm20211108909636.app.utils.StringUtil;
import learn.qm20211108909636.app.vo.LogVo;
import learn.qm20211108909636.app.vo.UserLogListVo;
import learn.qm20211108909636.app.vo.UserLogVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/log")
public class LogController {

    @Autowired
    private LogService logService;

    @GetMapping("/user/{id}")
    public String getUserLog(@PathVariable int id) {
        LogVo logVo = logService.selectUserLog(id);
        return ResultUtil.success(logVo);
    }

    @PostMapping("/admin/record/search")
    public String search(@RequestBody Map<String,String> map) {
        String username = StringUtil.isEmpty(map.get("username")) ? null : map.get("username");
        Integer page = StringUtil.isEmpty(map.get("page")) ? 1 : Integer.parseInt(map.get("page"));
        Integer size = StringUtil.isEmpty(map.get("size")) ? 10 : Integer.parseInt(map.get("size"));

        UserLogListVo logs = logService.search(username, page, size);
        return ResultUtil.success(logs);
    }

}
