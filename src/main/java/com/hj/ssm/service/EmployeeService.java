package com.hj.ssm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hj.ssm.bean.Employee;
import com.hj.ssm.bean.EmployeeExample;
import com.hj.ssm.dao.EmployeeMapper;

@Service
public class EmployeeService {

	
	//ע��EmployeeMapper
	@Autowired
	EmployeeMapper employeeMapper;
	
	
	/**
	 * ��ѯ���е�Ա��
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
	  * ���Ա��
	  * @param employee
	  */
	 public void saveEmp(Employee employee){
		 employeeMapper.insertSelective(employee);
	 }

	 
	 /**
	  * У�������Ƿ����
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
	 * ����id��ѯԱ����Ϣ
	 * @param id
	 */
	public Employee getEmpById(Integer id) {
		return employeeMapper.selectByPrimaryKey(id);
		
	}

	
	/**
	 * ����Ա����Ϣ
	 * @param employee
	 */
	public void updateEmp(Employee employee) {
		employeeMapper.updateByPrimaryKeySelective(employee);
	}


	/**
	 * ����idɾ��Ա��
	 * @param id
	 */
	public void delEmp(Integer id) {
		employeeMapper.deleteByPrimaryKey(id);
	}


	/**
	 * ���ݶ��idɾ�����Ա��
	 * @param id
	 */
	public void delBatch(List<Integer> id) {
		EmployeeExample example = new EmployeeExample();
		com.hj.ssm.bean.EmployeeExample.Criteria criteria = example.createCriteria();
		criteria.andEmpIdIn(id);
		employeeMapper.deleteByExample(example);
		
	}
}
