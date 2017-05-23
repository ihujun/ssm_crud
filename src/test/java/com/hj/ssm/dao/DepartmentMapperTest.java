package com.hj.ssm.dao;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.hj.ssm.bean.Employee;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring/applicationContext.xml"})
public class DepartmentMapperTest {
	
	@Autowired
	DepartmentMapper departmentMapper;
	
	@Autowired
	EmployeeMapper employeeMapper;
	
	@Autowired
	SqlSession sqlSession;

	

	@Test
	public void testInsertSelective() {
		/*Department department = new Department(null, "һ��");
		departmentMapper.insertSelective(department);*/
		//departmentMapper.deleteByPrimaryKey(1);
		
	}
	
	@Test
	public void testInsertSelectiveEmp() {
		/*Employee employee = new Employee(null, "hj", "n", "145@qq.com", 1);
		employeeMapper.insertSelective(employee);*/
		
		/*Department department = new Department(null, "������");
		Department department2 = new Department(null, "���²�");
		departmentMapper.insertSelective(department);
		departmentMapper.insertSelective(department2);
		*/
		
		EmployeeMapper employeeMapper = sqlSession.getMapper(EmployeeMapper.class);
		for(int x=0;x<100;x++){
			employeeMapper.insertSelective(new Employee(null, "����"+x+"��", "n", x+"@hj.com", 2));
		}
		System.out.println("OK");
	}


}
