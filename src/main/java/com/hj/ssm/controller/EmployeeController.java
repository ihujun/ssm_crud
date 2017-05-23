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
 * EmployeeԱ����Controller��
 * @author Administrator
 *
 */

@Controller
public class EmployeeController {
	
	//ע��EmployeeService
	@Autowired
	private EmployeeService employeeService;
	
	private Msg msg = new Msg();
	
	
	/**
	 * ��ѯ���е�Ա��������json���� 
	 * @return
	 */
	@SuppressWarnings({ "static-access", "unchecked", "rawtypes" })
	@RequestMapping(value="/emps",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmpsJson(@RequestParam(value="cp",defaultValue="1") Integer currentPage,Model model){
		
		//ʹ�÷�ҳ��������뵱ǰҳ����ÿҳҪ��ʾ������  
		PageHelper.startPage(currentPage, 10);
		List<Employee> list = employeeService.getAll("emp_id");
		
		//ʹ��PageInfo��װ��ѯ��� ,��������ҳ����Ҫ��ҳ����
		PageInfo page = new PageInfo(list,10);
		
		
		return msg.success().add("page", page);
	}
	
	
	
	/**
	 * ���Ա����Ϣ
	 * @param employee
	 * @param result
	 * @return
	 */
	@SuppressWarnings("static-access")
	@RequestMapping(value="/emps",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee,BindingResult result){
		//�ж��Ƿ���У�����
		if(result.hasErrors()){
			//�У���������Ϣ����map������ʧ��
			Map<String,Object> map  = new HashMap<String,Object>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return msg.fail().add("errors", map);
		}else{
			//û�У�ִ�б��沢���سɹ�
			employeeService.saveEmp(employee);
			return msg.success();
		}
		
	}
	
	
	
	/**
	 * ����Ա����Ϣ
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
	 * ɾ����������Ա��
	 * @param id
	 * @return
	 */
	@SuppressWarnings("static-access")
	@RequestMapping(value="/emps/{empIds}",method=RequestMethod.DELETE)
	@ResponseBody
	public Msg delEmp(@PathVariable(value="empIds") String ids){
		
		if(ids.contains("-")){
			List<Integer> del_id  = new ArrayList<Integer>();
			//ɾ�����
			String[] id = ids.split("-");
			for (String string : id) {
				del_id.add(Integer.parseInt(string));
			}
			
			
			employeeService.delBatch(del_id);
		}else{
			//ɾ������
			employeeService.delEmp(Integer.parseInt(ids));
		}
		
		return msg.success();
	}
	
	
	
	//У�������Ƿ����
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
	
	
	//����id��ѯԱ����Ϣ
	@SuppressWarnings("static-access")
	@RequestMapping(value="/emps/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable(value="id") Integer id){
		Employee employee = employeeService.getEmpById(id);
		return msg.success().add("employee", employee);
	}
	

	/**
	 * ��ѯ���е�Ա��
	 * @return
	 *//*
	@RequestMapping(value="/emps")
	public String getEmps(@RequestParam(value="cp",defaultValue="1") Integer currentPage,Model model){
		
		//ʹ�÷�ҳ��������뵱ǰҳ����ÿҳҪ��ʾ������  
		PageHelper.startPage(currentPage, 10);
		List<Employee> list = employeeService.getAll();
		
		//ʹ��PageInfo��װ��ѯ��� ,��������ҳ����Ҫ��ҳ����
		PageInfo page = new PageInfo(list,10);
		
		//�����ݴ���model
		model.addAttribute("page", page);
		return "list";
	}*/
}
