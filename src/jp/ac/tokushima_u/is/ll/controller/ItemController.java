package jp.ac.tokushima_u.is.ll.controller;

import java.io.IOException;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jp.ac.tokushima_u.is.ll.common.orm.Page;
import jp.ac.tokushima_u.is.ll.entity.C2DMessage;
import jp.ac.tokushima_u.is.ll.entity.Category;
import jp.ac.tokushima_u.is.ll.entity.FileData;
import jp.ac.tokushima_u.is.ll.entity.Item;
import jp.ac.tokushima_u.is.ll.entity.ItemTitle;
import jp.ac.tokushima_u.is.ll.entity.Language;
import jp.ac.tokushima_u.is.ll.entity.QuestionType;
import jp.ac.tokushima_u.is.ll.entity.Users;
import jp.ac.tokushima_u.is.ll.form.ItemCommentForm;
import jp.ac.tokushima_u.is.ll.form.ItemEditForm;
import jp.ac.tokushima_u.is.ll.form.ItemSearchCondForm;
import jp.ac.tokushima_u.is.ll.form.validator.ItemEditFormValidator;
import jp.ac.tokushima_u.is.ll.security.SecurityUserHolder;
import jp.ac.tokushima_u.is.ll.service.C2DMessageService;
import jp.ac.tokushima_u.is.ll.service.GoogleMapService;
import jp.ac.tokushima_u.is.ll.service.ItemRatingService;
import jp.ac.tokushima_u.is.ll.service.ItemService;
import jp.ac.tokushima_u.is.ll.service.LanguageService;
import jp.ac.tokushima_u.is.ll.service.LogService;
import jp.ac.tokushima_u.is.ll.service.PropertyService;
import jp.ac.tokushima_u.is.ll.service.UserService;
import jp.ac.tokushima_u.is.ll.util.Constants;
import jp.ac.tokushima_u.is.ll.util.FilenameUtil;
import jp.ac.tokushima_u.is.ll.util.SerializeUtil;
import jp.ac.tokushima_u.is.ll.util.TagCloudConverter;
import jp.ac.tokushima_u.is.ll.visualization.ReviewHistoryService;
import jp.ac.tokushima_u.is.ll.ws.service.model.ItemForm;

import org.apache.commons.lang.StringUtils;
import org.hibernate.Hibernate;
import org.hibernate.ObjectNotFoundException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;

@Controller
@RequestMapping("/item")
public class ItemController {

    private static final Logger logger = LoggerFactory.getLogger(ItemController.class);
    @Autowired
    private ItemService itemService;
    @Autowired
    private GoogleMapService googleMapService;
    @Autowired
    private LanguageService languageService;
    @Autowired
    private LogService logService;
    @Autowired
    private ItemRatingService itemRatingService;
    @Autowired
    private UserService userService;
	@Autowired
	private PropertyService propertyService;
	@Autowired
	private ReviewHistoryService reviewHistoryService;
	
	@Autowired
	private C2DMessageService c2dmMessageService;

    @ModelAttribute("langList")
    public List<Language> populateLanguageList() {
    	List<Language> langList = languageService.searchAllLanguage();
    	Hibernate.initialize(langList);
        return langList;
    }

    @ModelAttribute("googleMapApi")
    public String googleApiKey() {
        return googleMapService.getGoogleMapApi();
    }

    @ModelAttribute("systemUrl")
    public String systemUrl(){
    	return propertyService.getSystemUrl();
    }

    @ModelAttribute("questionTypes")
    public List<QuestionType> searchQuestionTypes(){
    	return itemService.searchAllQuestionTypes();
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }

    @RequestMapping
    public String index(@ModelAttribute("searchCond") ItemSearchCondForm form, ModelMap model) {
    	
    	Users user = userService.getById(SecurityUserHolder.getCurrentUser().getId());
    	model.addAttribute("user", user);
    	
    	String msg = "";
        try {
            // ドライバロード
            Class.forName("com.mysql.jdbc.Driver");
            // MySQLに接続
            Connection con = (Connection) DriverManager.getConnection("jdbc:mysql://ll.artsci.kyushu-u.ac.jp:3306/learninglog", "learninglog", "learn64uadmin");
            // ステートメント生成
            Statement stmt = (Statement) con.createStatement();
            // SQLを実行
            String sqlStr = "SELECT * FROM s_userinfo where nickname='"+user.getNickname()+"'";
            ResultSet rs = stmt.executeQuery(sqlStr);
            // 結果行をループ
            if(rs.next()){
            	msg = "1";
                // レコードの値
                int id = rs.getInt("id");
                String modelNo = rs.getString("model");
            }else {
            	msg="0";
            }

            // 接続を閉じる
            rs.close();
            stmt.close();
            con.close();
        }catch (ClassNotFoundException e){
            msg = "ドライバのロードに失敗しました";
            System.out.println(msg);
        }catch (Exception e){
            msg = "0";
            System.out.println(msg);
        }
        model.addAttribute("msg",msg);
//        model.addAttribute("itemList", itemService.searchAllItemsByCond(form));
        model.addAttribute("itemPage", itemService.searchItemPageByCond(form));
        addTagCloud(model);
//        Page<Item> itemPage = (Page<Item>)model.get("itemPage");
        return "item/list";
    }

    private void addTagCloud(ModelMap model) {
    	Map<String, Integer> tagCloud = TagCloudConverter.convert(itemService.findTagCloud());
    	model.addAttribute("tagCloud", tagCloud);
	}

	@RequestMapping(value = "/search", method = RequestMethod.POST)
	public String test(@ModelAttribute("searchCond") ItemSearchCondForm form, ModelMap model, HttpServletResponse response) {
		model.clear();
    	Page<Item> page = itemService.searchItemPageByCond(form);
    	Gson gson = new Gson();
    	if(page!=null&&page.getResult()!=null&&page.getResult().size()>0)
    	{
    		List<Item>results = page.getResult();
    		List<ItemForm>forms = new ArrayList<ItemForm>();
    		for(Item item:results){
//    			String photoUrl = null;
//    			if(item.getImage()!=null)
//    				photoUrl = staticServerService.getImageFileURL(item.getImage().getId(), form.getImageLevel());

    			ItemForm itemform = new ItemForm(item);
    			forms.add(itemform);
    		}
    		model.addAttribute("items", forms);
//    		response.setContentType("text/plain;charset=UTF-8"); 
//    		try{
//    			String json = gson.toJson(forms);
//    			response.getWriter().print(json);
//    		}catch(IOException e){
//    			e.printStackTrace();
//    		}
    	}
    	return "index";
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String show(@PathVariable String id, ModelMap model) {
        Item item = itemService.findById(id);
        Users user = SecurityUserHolder.getCurrentUser();

        if (item == null || (item.getShareLevel() == Item.ShareLevel.PRIVATE && !item.getAuthor().getId().equals(user.getId()))) {
            return "redirect:/item";
        }
        model.addAttribute("item", item);

        //FileType{video, image}
        FileData fileData = item.getImage();
        String fileType = "";
        if(fileData!=null && !StringUtils.isBlank(fileData.getOrigName())){
        	fileType = FilenameUtil.checkMediaType(fileData.getOrigName());
        }
        model.addAttribute("fileType", fileType);

        boolean ratingExist = itemRatingService.ratingExist(id);
        model.addAttribute("ratingExist", ratingExist);
        if (ratingExist) {
            model.put("votes", itemRatingService.countVotesNumber(item));
            model.put("avg", itemRatingService.avgRating(item));
        }
        model.addAttribute("relogable", itemService.isRelogable(item, user));

        //Category Path
        if(item.getCategory()!=null){
        	Category category = item.getCategory();
        	List<Category> rvCatList = new ArrayList<Category>();
        	Category node = category;
        	while(node!=null){
        		rvCatList.add(node);
        		node = node.getParent();
        	}
        	List<Category> catList = new ArrayList<Category>();
        	for(int i = rvCatList.size()-1;i>=0;i--){
        		catList.add(rvCatList.get(i));
        	}
        	model.addAttribute("categoryPath", catList);
        }
        logService.logUserReadItem(item, user, null, null,null);
        model.addAttribute("readCount", itemService.findReadCount(item.getId()));
        model.addAttribute("relogCount", itemService.findRelogCount(item.getId()));

//        model.addAttribute("itemState", reviewHistoryService.searchUserItemState(user, item.getId()));
        model.addAttribute("itemState", reviewHistoryService.searchUserItemState(user, item));
        return "item/show";
    }

    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String add(@ModelAttribute("item") ItemEditForm form, ModelMap model) {
    	Users user = userService.getById(SecurityUserHolder.getCurrentUser().getId());
    	model.addAttribute("user", user);

    	List<Language> langs = new ArrayList<Language>();
    	for(Language lang: user.getMyLangs()){
    		if(!langs.contains(lang))langs.add(lang);
    	}
    	for(Language lang: user.getStudyLangs()){
    		if(!langs.contains(lang))langs.add(lang);
    	}
    	Language english = languageService.findUniqueLangByCode("en");
    	if(!langs.contains(english))langs.add(english);

    	model.addAttribute("langs", langs);
    	if(user.getDefaultCategory()!=null) form.setCategoryId(user.getDefaultCategory().getId());

        return "item/add";
    }

    @RequestMapping(method = RequestMethod.POST)
    public String create(@ModelAttribute("item") ItemEditForm form, BindingResult result, ModelMap model) {
        new ItemEditFormValidator().validate(form, result);
        if (result.hasErrors()) {
        	return this.add(form, model);
        }
        try {
            Item item = this.itemService.createByForm(form);

            Users user = userService.getById(SecurityUserHolder.getCurrentUser().getId());

        	HashMap<String,String[]>params = new HashMap<String,String[]>();
    		C2DMessage c2dmessage = new C2DMessage();
    		c2dmessage.setCollapse(Constants.COLLAPSE_KEY_SYNC);
    		c2dmessage.setIsDelayIdle(new Integer(0));
    		try{
    			c2dmessage.setParams(SerializeUtil.serialize(params));
    		}catch(Exception e){

    		}
    		this.c2dmMessageService.addMessage(c2dmessage,user);


    		// ■wakebe ULLO登録による経験値取得 (値要修正)
            userService.addExperiencePoint(user.getId(), 10);


            return "redirect:/item/" + item.getId() + "/related?fromcreated=true";
        } catch (IOException ex) {
            logger.error("Error occurred when create item", ex);
        }

        return "redirect:/item";
    }

    @RequestMapping(value = "/{id}/edit", method = RequestMethod.GET)
    public String edit(@PathVariable String id, @ModelAttribute("form") ItemEditForm form, ModelMap model) {
        Item item = itemService.findById(id);
        if (item == null || (!SecurityUserHolder.getCurrentUser().getId().equals(item.getAuthor().getId()) && !SecurityUserHolder.getCurrentUser().getAuth().equals(Users.UsersAuth.ADMIN))) {
            return "redirect:/item";
        }
        form = new ItemEditForm(item);

    	List<ItemTitle> titles = item.getTitles();
    	HashMap<String, String> titleMap = new HashMap<String, String>();
    	for(ItemTitle title: titles){
    		titleMap.put(title.getLanguage().getCode(), title.getContent());
    	}
    	form.setTitleMap(titleMap);

        model.addAttribute("item", item);
        model.addAttribute("form", form);

        //FileType{video, image}
        FileData fileData = item.getImage();
        String fileType = "";
        if(fileData!=null && !StringUtils.isBlank(fileData.getOrigName())){
        	fileType = FilenameUtil.checkMediaType(fileData.getOrigName());
        }
        model.addAttribute("fileType", fileType);

    	Users user = userService.getById(SecurityUserHolder.getCurrentUser().getId());
    	model.addAttribute("user", user);

       	List<Language> langs = new ArrayList<Language>();
    	for(ItemTitle t:item.getTitles()){
    		if(!langs.contains(t))langs.add(t.getLanguage());
    	}
    	for(Language lang: user.getMyLangs()){
    		if(!langs.contains(lang))langs.add(lang);
    	}
    	for(Language lang: user.getStudyLangs()){
    		if(!langs.contains(lang))langs.add(lang);
    	}
    	Language english = languageService.findUniqueLangByCode("en");
    	if(!langs.contains(english))langs.add(english);
    	model.addAttribute("langs", langs);


    	if(item.getCategory()!=null) form.setCategoryId(item.getCategory().getId());
        return "item/edit";
    }

    @RequestMapping(value = "/{id}/edit", method = RequestMethod.POST)
    public String update(@PathVariable String id, @ModelAttribute("form") ItemEditForm form, BindingResult result, ModelMap model) {
        Item item = itemService.findById(id);
        if (item == null || (!SecurityUserHolder.getCurrentUser().getId().equals(item.getAuthor().getId()) && !SecurityUserHolder.getCurrentUser().getAuth().equals(Users.UsersAuth.ADMIN))) {
            return "redirect:/item";
        }
        if (item.getImage() != null) {
            form.setFileExist(true);
        }
        new ItemEditFormValidator().validate(form, result);
        if (result.hasErrors()) {
            return "item/" + id + "/edit";
        }
        try {
            this.itemService.updateByForm(id, form);

            Users user = userService.getById(SecurityUserHolder
    				.getCurrentUser().getId());

        	HashMap<String,String[]>params = new HashMap<String,String[]>();
    		C2DMessage c2dmessage = new C2DMessage();
    		c2dmessage.setCollapse(Constants.COLLAPSE_KEY_SYNC);
    		c2dmessage.setIsDelayIdle(new Integer(0));
    		try{
    			c2dmessage.setParams(SerializeUtil.serialize(params));
    		}catch(Exception e){

    		}
    		this.c2dmMessageService.addMessage(c2dmessage,user);

        } catch (IOException ex) {
            logger.error("Error occurred when create item", ex);
        }
        return "redirect:/item/" + id;
    }

    @RequestMapping(value = "/{id}/delete", method = RequestMethod.POST)
    public String delete(@PathVariable String id) {
        Item item = itemService.findById(id);
        if (item == null || (!SecurityUserHolder.getCurrentUser().getId().equals(item.getAuthor().getId()) && !SecurityUserHolder.getCurrentUser().getAuth().equals(Users.UsersAuth.ADMIN))) {
            return "redirect:/item";
        }
        this.itemService.delete(item);
        return "redirect:/item";
    }

    @RequestMapping(value = "/{id}/related", method = RequestMethod.GET)
    public String related(@PathVariable String id, String fromcreated, ModelMap model) {
        Item item = itemService.findById(id);
        if (item == null) {
            return "redirect:/item";
        }
        model.addAttribute("item", item);
        model.addAttribute("relatedItemList", itemService.searchRelatedItemList(id));
        model.addAttribute("latestItems", itemService.searchLatestItems(item.getId(), null, 5));
        if(item.getItemLat()!=null && item.getItemLng()!=null){
        	model.addAttribute("nearestItems", itemService.searchNearestItems(item.getId(), item.getItemLat(), item.getItemLng(), 1, null, 5));
        }
        if(!StringUtils.isBlank(fromcreated)){
        	model.addAttribute("fromcreated", true);
        }else{
        	model.addAttribute("fromcreated", false);
        }

        //FileType{video, image}
        FileData fileData = item.getImage();
        String fileType = "";
        if(fileData!=null && !StringUtils.isBlank(fileData.getOrigName())){
        	fileType = FilenameUtil.checkMediaType(fileData.getOrigName());
        }
        model.addAttribute("fileType", fileType);
        return "item/related";
    }

    @RequestMapping(value = "/{id}/comment", method = RequestMethod.POST)
    public String submitComment(@PathVariable String id, @ModelAttribute ItemCommentForm form) {
        this.itemService.createCommentByForm(id, form);
        return "redirect:/item/" + id;
    }

    @RequestMapping(value = "/{id}/question", method = RequestMethod.POST)
    public String submitQuestion(@PathVariable String id, HttpServletRequest request) {
        String content = request.getParameter("content");
        this.itemService.createAnswerByForm(id, content);
        return "redirect:/item/" + id;
    }

    @RequestMapping(value = "/moretoanswer", method = RequestMethod.GET)
    public String toAnswerMore(@ModelAttribute("searchCond") ItemSearchCondForm form, ModelMap model) {
        model.addAttribute("itemList", itemService.searchAllToAnswer());
        addTagCloud(model);
        return "item/list";
    }

    @RequestMapping(value = "/{id}/relog", method = RequestMethod.POST)
    public String relog(@PathVariable String id) {
        Item item = itemService.findById(id);
        if (item == null) {
            return "redirect:/item/" + id;
        }
        Users user = userService.getById(SecurityUserHolder.getCurrentUser().getId());
        if (user == null) {
            return "redirect:/item/" + id;
        }
        Item reItem = this.itemService.relog(item, user);
        return "redirect:/item/" + reItem.getId();
    }

    @RequestMapping(value = "/{id}/questionconfirm", method = RequestMethod.POST)
    public String questionConfirm(@PathVariable String id) {
        Item item = itemService.findById(id);
        if (item == null) {
            return "redirect:/item/" + id;
        }
        Users user = userService.getById(SecurityUserHolder.getCurrentUser().getId());
        if (user == null) {
            return "redirect:/item/" + id;
        }
        if (!item.getAuthor().getId().equals(user.getId()) || item.getQuestion() == null || item.getQuestion().getAnswerSet() == null || item.getQuestion().getAnswerSet().size() == 0) {
            return "redirect:/item/" + id;
        }
        itemService.questionConfirm(item, user);
        return "redirect:/item/" + id;
    }

    @RequestMapping(value = "/{id}/teacherconfirm", method = RequestMethod.POST)
    public String teacherConfirm(@PathVariable String id) {
        Item item = itemService.findById(id);
        if (item == null) {
            return "redirect:/item/" + id;
        }
        Users user = userService.getById(SecurityUserHolder.getCurrentUser().getId());
//        if (user == null || user.getAuth() != Users.UsersAuth.ADMIN) {
//            return "redirect:/item/" + id;
//        }
        itemService.teacherConfirm(item, user);
        return "redirect:/item/" + id;
    }

    @RequestMapping(value = "/{id}/teacherreject", method = RequestMethod.POST)
    public String teacherReject(@PathVariable String id) {
        Item item = itemService.findById(id);
        if (item == null) {
            return "redirect:/item/" + id;
        }
        Users user = userService.getById(SecurityUserHolder.getCurrentUser().getId());
        itemService.teacherReject(item, user);
        return "redirect:/item/" + id;
    }

    @RequestMapping(value = "/{id}/teacherdelcfmstatus", method = RequestMethod.POST)
    public String teacherDeleteStatus(@PathVariable String id) {
        Item item = itemService.findById(id);
        if (item == null) {
            return "redirect:/item/" + id;
        }
        Users user = userService.getById(SecurityUserHolder.getCurrentUser().getId());
        itemService.teacherDeleteStatus(item, user);
        return "redirect:/item/" + id;
    }

    @RequestMapping(value="/view", method=RequestMethod.GET)
    public String view(String id, Double latitude,Double longitude, Float speed, ModelMap model){
    	Users user = userService.getById(SecurityUserHolder.getCurrentUser().getId());
    	model.clear();
    	Item item = null;
    	if(id!=null)
    		item = this.itemService.findById(id);
    	try{
    		if(item!=null&&item.getId()!=null){
    			this.logService.logUserReadItem(item, user, latitude, longitude, speed);
    		}
    	}catch(ObjectNotFoundException e){

    	}
    	return null;
    }
}
