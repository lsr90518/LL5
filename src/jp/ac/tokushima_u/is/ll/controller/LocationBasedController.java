package jp.ac.tokushima_u.is.ll.controller;

import jp.ac.tokushima_u.is.ll.form.LocationForm;


import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import jp.ac.tokushima_u.is.ll.entity.GooglePlacesModel;
import jp.ac.tokushima_u.is.ll.util.HttpRequest;
import java.net.URL;  
import java.util.ArrayList;
@Controller
@RequestMapping("/location")
public class LocationBasedController {
	
	@RequestMapping(value = "getPlaceName", method = RequestMethod.POST)
    public String index(@ModelAttribute LocationForm form, ModelMap model) throws Exception {
		//根据地点获取现在地点的名字列表，然后选择名字之后，根据选择名字的地点，
		System.out.println(form.getLocation());
		//get place name by location
		//https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&radius=500&types=food&name=harbour&sensor=false&key=AIzaSyBNn3OuDYtqGNQi6qQHz_D5oOyrt1gvMfg
		//return name list
		String s = HttpRequest.sendGet("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location="+form.getLocation()+"&radius=200&sensor=true&key=AIzaSyAe8XE3B_f6i2Wf8vyg1VVBKumsk5XfBgQ","");
		System.out.println(s);
        Gson gson = new Gson();
        
        GooglePlacesModel gpm = gson.fromJson(s, GooglePlacesModel.class);
        
        System.out.println(gpm.getStatus());
        ArrayList<String> namelist = new ArrayList<String>();
        for(int i = 0;i<gpm.getResults().size();i++){
        	System.out.println(gpm.getResults().get(i).getName() + "  " + gpm.getResults().get(i).getIcon());
        	
        	namelist.add(gpm.getResults().get(i).getName());
        }
		
        model.addAttribute("results", gpm.getResults());
		
		return "location/placeList";
		
	}
}
