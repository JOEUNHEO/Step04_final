package com.gura.step04.users.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.gura.step04.users.dto.UsersDto;
import com.gura.step04.users.service.UsersService;

@Controller
public class UsersController {
	//의존 객체
	@Autowired
	private UsersService service;
	
	//회원가입 폼 요청 처리
	@RequestMapping("/users/signup_form")
	public String singupForm(){
		
		return "users/signup_form";
	}
	
	//아이디 중복 확인 요청 처리
	@RequestMapping("/users/checkid")
	@ResponseBody
	public Map<String, Object> checkid(@RequestParam String inputId){
		//서비스를 이요해서 사용가능 여부를 boolean type 으로 리턴받기
		boolean canUse = service.canUseId(inputId);
		//Map 에 담는다.
		Map<String, Object> map = new HashMap<>();
		map.put("canUse", canUse);
		//Map 리턴하기
		return map;
	}
	
	// 회원 가입 요청 처리
	@RequestMapping("/users/signup")
	public ModelAndView signup(@ModelAttribute UsersDto dto){
		//전달되는 인자에 회원 가입 정보가 들어 있다.
		ModelAndView mView = service.signup(dto);
		
		mView.setViewName("users/signup_result");
		
		return mView;
	}
	//로그인 폼 요청 처리
	@RequestMapping("/users/loginform")
	public ModelAndView loginForm(ModelAndView mView, HttpServletRequest request){
		// url 이라는 파라미터로 전달된 문자열 읽어오기
		String url = request.getParameter("url");
		if(url == null){
			url = request.getContextPath()+"/";
		}
		// 로그인후 이동할 url 정보를 ModelAndView 객체에 넣고
		mView.addObject("url", url);
		// view 페이지 정보를 담고
		mView.setViewName("users/loginform");
		// ModelAndView 객체를 리턴해준다.
		return mView;
	}
	
	@RequestMapping("/users/login")
	public ModelAndView login(@ModelAttribute UsersDto dto, HttpServletRequest request){
		
		ModelAndView mView = service.login(dto, request);
		mView.setViewName("users/login_result");
		return mView;
	}
	
	@RequestMapping("/users/logout")
	public ModelAndView logout(HttpSession session, ModelAndView mView){
		String id= (String)session.getAttribute("id");
		session.invalidate();
		mView.addObject("msg", id+" 님 로그 아웃 되었습니다.");
		mView.setViewName("users/logout_result");
		
		return mView;
	}
	
	@RequestMapping("/users/info")
	public ModelAndView authInfo(HttpServletRequest request){
		
		HttpSession session = request.getSession();
		//로그인 된 아이디를 읽어온다.
		String id = (String)session.getAttribute("id");
		//사용자 정보가 담긴 ModelAndView 객체를 리턴받고
		ModelAndView mView = service.detail(id);
		//view 페이지 정보를 설정하고
		mView.setViewName("users/info");
		return mView; //리턴한다.
	}
	
	@RequestMapping("/users/delete")
	public ModelAndView authDelete(HttpServletRequest request){
		
		HttpSession session = request.getSession();
		
		ModelAndView mView = service.delete(session);
		mView.setViewName("users/delete_result");
		return mView;
	}
	
	@RequestMapping("/users/updateform")
	public ModelAndView authUpdateForm(HttpServletRequest request){
		
		HttpSession session = request.getSession();
		
		String id = (String)session.getAttribute("id");
		
		ModelAndView mView = service.detail(id);
		mView.setViewName("users/updateform");
		
		return mView;
	}
	@RequestMapping("/users/update")
	public ModelAndView authUpdate(@ModelAttribute UsersDto dto, HttpServletRequest request){
		
		service.update(dto);
		ModelAndView mView = new ModelAndView();
		mView.setViewName("redirect:/users/info.do");
		
		return mView;
	}
	
}
