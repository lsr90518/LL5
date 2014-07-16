package jp.ac.tokushima_u.is.ll.controller;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import jp.ac.tokushima_u.is.ll.entity.Users;
import jp.ac.tokushima_u.is.ll.form.ItemSearchCondForm;
import jp.ac.tokushima_u.is.ll.security.SecurityUserHolder;
import jp.ac.tokushima_u.is.ll.service.ItemService;
import jp.ac.tokushima_u.is.ll.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gson.Gson;

/**
 *
 * @author houbin
 */
@Controller
public class IndexController {

    @Autowired
    private UserService userService;
    @Autowired
    private ItemService itemService;

    @RequestMapping(value = {"/", "/index"}, method = RequestMethod.GET)
    public String index(HttpServletRequest request, ModelMap model) {
        Users user = userService.getById(SecurityUserHolder.getCurrentUser().getId());
        model.addAttribute("user", user);
        model.addAttribute("uploadItemRanking", this.itemService.uploadRanking());
        model.addAttribute("answerRanking", this.itemService.answerRanking());

        //Entries awaiting your answers
        ItemSearchCondForm awaitCond = new ItemSearchCondForm();
        awaitCond.setToAnswerQuesLangs(user.getMyLangs());
        model.addAttribute("toAnswerItems", itemService.searchItemPageByCond(awaitCond));

        //New entries written in the language you are learning
        ItemSearchCondForm studyCond = new ItemSearchCondForm();
        studyCond.setToStudyQuesLangs(user.getStudyLangs());
        model.addAttribute("toStudyItems", itemService.searchItemPageByCond(studyCond));

        //Latest answered questions for you
        ItemSearchCondForm answeredCond = new ItemSearchCondForm();
        answeredCond.setHasAnswers(true);
        answeredCond.setUserId(user.getId());
        model.addAttribute("answeredItems", itemService.searchItemPageByCond(answeredCond));

        //Add Statistics
        Map<String, Long> stat = new LinkedHashMap<String, Long>();
        stat.put("Members", userService.findAllUserCount());
        stat.put("Learning Logs", itemService.findAllItemCount());
        stat.put("Views", itemService.findAllReadCount());
        stat.put("Tags", itemService.findAllTagCount());
        model.addAttribute("stat", stat);


		// ■wakebe 次のレベルまでの経験値取得
		model.addAttribute("nextExperiencePoint", this.userService.getNextExperiencePoint(user.getId()));

		// ■wakebe 現在の合計経験値取得
		model.addAttribute("nowExperiencePoint", this.userService.getNowExperiencePoint(user.getId()));

        return "index";
    }
}
