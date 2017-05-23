package com.hj.ssm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hj.ssm.bean.Department;
import com.hj.ssm.dao.DepartmentMapper;

@Service
public class DepartmentService {

	//ע��DepartmentMapper
	@Autowired
	DepartmentMapper departmentMapper;
	
	/**
	 * ��ѯ���еĲ�����Ϣ
	 * @return
	 */
	public List<Department> getDeps(){
		return departmentMapper.selectByExample(null);
	}
}
