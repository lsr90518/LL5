package jp.ac.tokushima_u.is.ll.controller;

import java.sql.DriverManager;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import jp.ac.tokushima_u.is.ll.entity.Userinfo;
import jp.ac.tokushima_u.is.ll.entity.Users;
import jp.ac.tokushima_u.is.ll.form.ItemSearchCondForm;
import jp.ac.tokushima_u.is.ll.security.SecurityUserHolder;
import jp.ac.tokushima_u.is.ll.service.ItemService;
import jp.ac.tokushima_u.is.ll.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.Statement;


@Controller
@RequestMapping("/recommend")
public class RecommendController {
	
	@Autowired
    private ItemService itemService;
    @Autowired
    private UserService userService;
	
	
	@RequestMapping("/{nickname}/getSuggestion")
	public String GetSuggestion(@PathVariable String nickname, ModelMap model){
		Users user = userService.getById(SecurityUserHolder.getCurrentUser().getId());
    	model.addAttribute("user", user);
    	String natilanguage = "";
    	String jlpt = "";
    	String modelNo = "";
		try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = (Connection) DriverManager.getConnection("jdbc:mysql://ll.artsci.kyushu-u.ac.jp:3306/learninglog", "learninglog", "learn64uadmin");
            Statement stmt = (Statement) con.createStatement();
            // SQLを実行
            String findeUserByNickname = "SELECT * FROM s_userinfo where nickname='"+user.getNickname()+"'";
            ResultSet userRs = stmt.executeQuery(findeUserByNickname);
            //有结果
            if(userRs.next()){
            	natilanguage = userRs.getString("natilanguage");
            	jlpt = userRs.getString("jlpt");
                modelNo = userRs.getString("model");
                
                //similar users
                ArrayList<String> similarNickname = new ArrayList<String>();
                String findSimilarUsers = "select nickname from s_userinfo where natilanguage='"+natilanguage+"' and model='"+modelNo+"'";
                ResultSet similarRs = stmt.executeQuery(findSimilarUsers);
                while(similarRs.next()){
                	similarNickname.add(similarRs.getString("nickname"));
                }
                
                ArrayList<HashMap<String,Object>> similarContents = new ArrayList<HashMap<String,Object>>();
                //find content by users
                for(int i = 0;i<similarNickname.size();i++){
                	String findContentByUsers = "select "+
						"t_item.id,image,"+
						"en_title,"+
						"jp_title,"+
						"t_item.create_time"+
					" from "+
						"t_item "+
					"where "+
						"t_item.author_id in (select t_users.id from s_userinfo,t_users where s_userinfo.nickname=t_users.nickname "+
						"					and natilanguage='"+natilanguage+"' "+
						"					and model='"+modelNo+"') "+
						"and jp_title is not null "+
						"order by create_time";
                	PreparedStatement ps = (PreparedStatement) con.prepareStatement(findContentByUsers);
                	ResultSet similarContentRs = ps.executeQuery();
                	while(similarContentRs.next()){
                		HashMap<String,Object> tmpMap = new HashMap<String,Object>();
                		tmpMap.put("en_title", similarContentRs.getString("en_title"));
                		tmpMap.put("jp_title", similarContentRs.getString("jp_title"));
                		tmpMap.put("item_id", similarContentRs.getString("id"));
                		tmpMap.put("image", similarContentRs.getString("image"));
                		similarContents.add(tmpMap);
                	}
                }
                model.addAttribute("similarContents", similarContents);
                model.addAttribute("similarNickname", similarNickname);
            }

            // 接続を閉じる
            userRs.close();
            stmt.close();
            con.close();
        }catch (ClassNotFoundException e){
            System.out.println("not found class");
        }catch (Exception e){
            System.out.println("not found");
        }
		
//		List<Userinfo> userList = recommendService.findUserByNickname(nickname);
//		if(userList.size() < 1){
//			System.out.println("donnot exist!");
//			return "/";
//		} else {
//			String nati = userList.get(0).getNatilanguage();
//			String modelNo = userList.get(0).getModel();
//			HashMap<String, String> params = new HashMap<String, String>();
//
//			params.put("natilanguage", nati);
//			params.put("modelNo", modelNo);
//			
//			//find similar users
//			List<Userinfo> similarUserList = recommendService.findUsersByNatiModel(params);
//			
//			//find learning content
//			List<HashMap<String, Object>> similarContents = recommendService.findContentByUsers(params);
//			
////			
////			System.out.println(similarContents);
////			System.out.println(similarUserList);
//			model.addAttribute("similarContent", similarContents);
//			model.addAttribute("similarUserList", similarUserList);
//			
//			Users user = userService.findById(SecurityUserHolder.getCurrentUser().getId());
//			userService.addExperiencePoint(user.getId(), 0);
//
//			// ■wakebe 次のレベルまでの経験値取得
//			model.addAttribute("nextExperiencePoint", this.userService.getNextExperiencePoint(user.getId()));
//
//			// ■wakebe 現在の合計経験値取得
//			model.addAttribute("nowExperiencePoint", this.userService.getNowExperiencePoint(user.getId()));
//			
//			model.addAttribute("user", user);
			
			return "item/recommendList";
//			return "recommend/imageTest";
		}
		
	}
