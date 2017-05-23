package com.hj.ssm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hj.ssm.bean.Employee;
import com.hj.ssm.bean.EmployeeExample;
import com.hj.ssm.dao.EmployeeMapper;

@Service
public class EmployeeService {

	
	//注入EmployeeMapper
	@Autowired
	EmployeeMapper employeeMapper;
	
	
	/**
	 * 查询所有的员工
	 * @return
	 */
	 public List<Employee> getAll(String orderBy){
		 EmployeeExample employeeExample = new EmployeeExample();
		 if(orderBy!=null){
			 employeeExample.setOrderByClause(orderBy);
		 }
		 
		 return employeeMapper.selectByExampleWithDep(employeeExample);
	 }
	 
	 
	 /**
	  * 添加员工
	  * @param employee
	  */
	 public void saveEmp(Employee employee){
		 employeeMapper.insertSelective(employee);
	 }

	 
	 /**
	  * 校验邮箱是否存在
	  * @param empEmail
	  */
	public Boolean checkEmail(String empEmail) {
		EmployeeExample example = new EmployeeExample();
		com.hj.ssm.bean.EmployeeExample.Criteria c= example.createCriteria();
		c.andEmailEqualTo(empEmail);
		long count = employeeMapper.countByExample(example);
		return count==0;
	}

	
	/**
	 * 根据id查询员工信息
	 * @param id
	 */
	public Employee getEmpById(Integer id) {
		return employeeMapper.selectByPrimaryKey(id);
		
	}

	
	/**
	 * 更新员工信息
	 * @param employee
	 */
	public void updateEmp(Employee employee) {
		employeeMapper.updateByPrimaryKeySelective(employee);
	}


	/**
	 * 根据id删除员工
	 * @param id
	 */
	public void delEmp(Integer id) {
		employeeMapper.deleteByPrimaryKey(id);
	}


	/**
	 * 根据多个id删除多个员工
	 * @param id
	 */
	public void delBatch(List<Integer> id) {
		EmployeeExample example = new EmployeeExample();
		com.hj.ssm.bean.EmployeeExample.Criteria criteria = example.createCriteria();
		criteria.andEmpIdIn(id);
		employeeMapper.deleteByExample(example);
		
	}
}
