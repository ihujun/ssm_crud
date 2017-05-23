package com.hj.ssm.page;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.github.pagehelper.PageInfo;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations={"classpath:spring/applicationContext.xml","classpath:springmvc.xml"})
public class PageTest {
	
	@Autowired
	WebApplicationContext context;

	//模拟请求
	MockMvc mockMvc;
	
	@Before
	public void init(){
		mockMvc=MockMvcBuilders.webAppContextSetup(context).build();
	}
	
	@Test
	public void testPage() throws Exception{
		MvcResult  mvcResult = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("currentPage", "3")).andReturn();
		
		MockHttpServletRequest request = mvcResult.getRequest();
		PageInfo attribute = (PageInfo) request.getAttribute("page");
		System.out.println("当前页数："+attribute.getPageNum());
	}
}
