package com.hj.ssm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hj.ssm.bean.Department;
import com.hj.ssm.bean.Msg;
import com.hj.ssm.service.DepartmentService;

/**
 * 部门的Controller
 * @author Administrator
 *
 */
@Controller
public class DepartmentController {

	//注入DepartmentService
	@Autowired
	DepartmentService departmentService;
	
	@SuppressWarnings("static-access")
	@RequestMapping(value="/deps",method=RequestMethod.GET)
	@ResponseBody
	public Msg getDeps(){
		List<Department> deps = departmentService.getDeps();
		return new Msg().success().add("deps", deps);
	}
}
