package com.hj.ssm.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hj.ssm.bean.Employee;
import com.hj.ssm.bean.Msg;
import com.hj.ssm.service.EmployeeService;

/**
 * Employee员工的Controller类
 * @author Administrator
 *
 */

@Controller
public class EmployeeController {
	
	//注入EmployeeService
	@Autowired
	private EmployeeService employeeService;
	
	private Msg msg = new Msg();
	
	
	/**
	 * 查询所有的员工并返回json数据 
	 * @return
	 */
	@SuppressWarnings({ "static-access", "unchecked", "rawtypes" })
	@RequestMapping(value="/emps",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmpsJson(@RequestParam(value="cp",defaultValue="1") Integer currentPage,Model model){
		
		//使用分页插件，传入当前页数和每页要显示的数量  
		PageHelper.startPage(currentPage, 10);
		List<Employee> list = employeeService.getAll("emp_id");
		
		//使用PageInfo包装查询结果 ,它里面有页面需要分页参数
		PageInfo page = new PageInfo(list,10);
		
		
		return msg.success().add("page", page);
	}
	
	
	
	/**
	 * 添加员工信息
	 * @param employee
	 * @param result
	 * @return
	 */
	@SuppressWarnings("static-access")
	@RequestMapping(value="/emps",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee,BindingResult result){
		//判断是否有校验错误
		if(result.hasErrors()){
			//有，将错误信息存入map并返回失败
			Map<String,Object> map  = new HashMap<String,Object>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return msg.fail().add("errors", map);
		}else{
			//没有，执行保存并返回成功
			employeeService.saveEmp(employee);
			return msg.success();
		}
		
	}
	
	
	
	/**
	 * 更新员工信息
	 * @param employee
	 * @return
	 */
	@SuppressWarnings("static-access")
	@RequestMapping(value="/emps/{empId}",method=RequestMethod.PUT)
	@ResponseBody
	public Msg updateEmp(Employee employee){
		//System.out.println(employee);
		employeeService.updateEmp(employee);
		return msg.success();
	}
	
	
	
	/**
	 * 删除单个或多个员工
	 * @param id
	 * @return
	 */
	@SuppressWarnings("static-access")
	@RequestMapping(value="/emps/{empIds}",method=RequestMethod.DELETE)
	@ResponseBody
	public Msg delEmp(@PathVariable(value="empIds") String ids){
		
		if(ids.contains("-")){
			List<Integer> del_id  = new ArrayList<Integer>();
			//删除多个
			String[] id = ids.split("-");
			for (String string : id) {
				del_id.add(Integer.parseInt(string));
			}
			
			
			employeeService.delBatch(del_id);
		}else{
			//删除单个
			employeeService.delEmp(Integer.parseInt(ids));
		}
		
		return msg.success();
	}
	
	
	
	//校验邮箱是否存在
	@SuppressWarnings("static-access")
	@RequestMapping(value="/checkEmail",method=RequestMethod.POST)
	@ResponseBody
	public Msg checkEmail(String empEmail){
		Boolean b = employeeService.checkEmail(empEmail);
		if(b){
			return msg.success();
		}else{
			return msg.fail();
		}
	}
	
	
	//根据id查询员工信息
	@SuppressWarnings("static-access")
	@RequestMapping(value="/emps/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable(value="id") Integer id){
		Employee employee = employeeService.getEmpById(id);
		return msg.success().add("employee", employee);
	}
	

	/**
	 * 查询所有的员工
	 * @return
	 *//*
	@RequestMapping(value="/emps")
	public String getEmps(@RequestParam(value="cp",defaultValue="1") Integer currentPage,Model model){
		
		//使用分页插件，传入当前页数和每页要显示的数量  
		PageHelper.startPage(currentPage, 10);
		List<Employee> list = employeeService.getAll();
		
		//使用PageInfo包装查询结果 ,它里面有页面需要分页参数
		PageInfo page = new PageInfo(list,10);
		
		//将数据存入model
		model.addAttribute("page", page);
		return "list";
	}*/
}
