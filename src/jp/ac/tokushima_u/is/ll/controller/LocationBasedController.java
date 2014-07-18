package jp.ac.tokushima_u.is.ll.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

@Controller
@RequestMapping("/location")
public class LocationBasedController {
	
	@RequestMapping(value = "/{location}", method = RequestMethod.GET)
	@ResponseBody
    public String index(@PathVariable String location, ModelMap model) {
		//根据地点获取现在地点的名字列表，然后选择名字之后，根据选择名字的地点，
		System.out.println(location);
		Gson gson = new Gson();
		gson.toJson(location);
		return gson.toJson(location);
		
	}
}
