package com.hj.ssm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hj.ssm.bean.Department;
import com.hj.ssm.dao.DepartmentMapper;

@Service
public class DepartmentService {

	//注入DepartmentMapper
	@Autowired
	DepartmentMapper departmentMapper;
	
	/**
	 * 查询所有的部门信息
	 * @return
	 */
	public List<Department> getDeps(){
		return departmentMapper.selectByExample(null);
	}
}
