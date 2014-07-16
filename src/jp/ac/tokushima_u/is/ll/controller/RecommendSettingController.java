package jp.ac.tokushima_u.is.ll.controller;

import java.sql.DriverManager;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import jp.ac.tokushima_u.is.ll.entity.Users;
import jp.ac.tokushima_u.is.ll.form.RecommendSettingForm;
import jp.ac.tokushima_u.is.ll.security.SecurityUserHolder;
import jp.ac.tokushima_u.is.ll.service.LanguageService;
import jp.ac.tokushima_u.is.ll.service.ProfileService;
import jp.ac.tokushima_u.is.ll.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.Statement;

@Controller
@RequestMapping("/recommendSetting")
public class RecommendSettingController {

	@Autowired
	private UserService userService;
	@Autowired
	private ProfileService profileService;
	@Autowired
	private LanguageService languageService;

	@RequestMapping
	public String index(ModelMap model) {
		Users user = userService.getById(SecurityUserHolder.getCurrentUser()
				.getId());
		model.addAttribute("user", user);
		String gender = "male";
		String jlpt= "n5";
		String month = "1";
		String major = "Language";
		
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = (Connection) DriverManager.getConnection(
					"jdbc:mysql://ll.artsci.kyushu-u.ac.jp:3306/learninglog",
					"learninglog", "learn64uadmin");
			Statement stmt = (Statement) con.createStatement();
			// SQLを実行
			String findModel = "select * from s_userinfo where nickname='"+user.getNickname()+"'";
			ResultSet modelRs = stmt.executeQuery(findModel);
			
			if(modelRs.next()){
				gender = modelRs.getString("gender");
				jlpt = modelRs.getString("jlpt");
				month = modelRs.getString("month");
				major = modelRs.getString("major");
			} 
			
			
			// 接続を閉じる
			modelRs.close();
			stmt.close();
			con.close();
		} catch (ClassNotFoundException e) {
			System.out.println("not found class");
		} catch (Exception e) {
			System.out.println("not found");
		}
		model.addAttribute("gender", gender);
		model.addAttribute("jlpt", jlpt);
		model.addAttribute("month", month);
		model.addAttribute("major", major);
		
		return "profile/recommendSetting";
	}

	@RequestMapping(value = "/setuserinfo", method = RequestMethod.GET)
	public String setInfo(@RequestParam("natilanguage") String natilanguage,
			@RequestParam("gender") String gender,
			@RequestParam("jlpt") String jlpt,
			@RequestParam("month") String month,
			@RequestParam("major") String major, Model model) {

		Users user = userService.getById(SecurityUserHolder.getCurrentUser()
				.getId());
		model.addAttribute("user", user);

		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = (Connection) DriverManager.getConnection(
					"jdbc:mysql://ll.is.tokushima-u.ac.jp:3306/learninglog",
					"learninglog", "learn64uadmin");
			Statement stmt = (Statement) con.createStatement();
			// SQLを実行
			String findModel = "SELECT model FROM s_userinfo where natilanguage='"
					+ natilanguage
					+ "' and gender='"
					+ gender
					+  "' and month='" + month + "' ";
			ResultSet modelRs = stmt.executeQuery(findModel);
			// 有结果
			int modelNo = 0;
			if (modelRs.next()) {
				modelNo = modelRs.getInt("model");
			}
			//insert into database
			String insertSQL = "insert into s_userinfo(nickname,natilanguage,gender,jlpt,month,major,model) values('"+user.getNickname()+"','"+natilanguage+"','"+gender+
					"','"+jlpt+"','"+month+"','"+major+"',"+modelNo+")";
			System.out.println(insertSQL);
			stmt.execute(insertSQL);
			
			// 接続を閉じる
			modelRs.close();
			stmt.close();
			con.close();
		} catch (ClassNotFoundException e) {
			System.out.println("not found class");
		} catch (Exception e) {
			System.out.println("not found");
		}

		return "profile/index";
	}
}
