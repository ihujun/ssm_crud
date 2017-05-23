<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工信息</title>
<!-- Jquery -->
<script type="text/javascript"
	src="${pageContext.request.contextPath }/source/js/jquery.min.js"></script>

<!-- Bootstrap -->
<link
	href="${pageContext.request.contextPath }/source/bootstrap/css/bootstrap.min.css"
	rel="stylesheet" />
<script type="text/javascript"
	src="${pageContext.request.contextPath }/source/bootstrap/js/bootstrap.min.js"></script>

<script type="text/javascript">
	var total,currentPage;
	$(function() {
		getPageData(1);

		
		$("#empAdd").click(function() {

			//ajax查询部门信息并显示在弹出页面
			getDeps("#deps");

			$('#empAddModal').modal({
				backdrop : 'static'
			});
		});

		//提交添加员工表单
		$("#add_emp_save").click(function() {

			//校验表单数据
			/* if(!validate_add_form()){
				return false;
			} */

			$.ajax({
				url : "${pageContext.request.contextPath }/emps",
				type : "post",
				data : $("#empAddModal form").serialize(),
				success : function(d) {
					if (d.code == 1) {
						//后台校验成功
						$('#empAddModal').modal('hide');

						getPageData(total);
					} else {
						$("#empName").parent().removeClass("has-error has-success");
						$("#empName").next("span").text("");
						$("#empEmail").parent().removeClass("has-error has-success");
						$("#empEmail").next("span").text("");
						
						//邮箱的错误信息
						if (d.info.errors.email != undefined) {
							$("#empEmail").parent().addClass("has-error");
							$("#empEmail").next("span").text("邮箱格式不正确");
						}else{
							$("#empEmail").parent().addClass("has-success");
						}
						
						//姓名的错误信息
						if (d.info.errors.empName != undefined) {
							$("#empName").parent().addClass("has-error");
							$("#empName").next("span").text("用户名2-5位中文或者6-16位英文和数字组合");
						}else{
							$("#empName").parent().addClass("has-success");
						}
						
						
					}

				}
			});
		});
		
		//校验邮箱 
		$("#empEmail").blur(function() {
			validate_add_email("#empEmail");
		});
		
		
		//编辑按钮
		$(document).on("click",".edit_emp_btn",function(){
			
			
			
			//ajax查询员工信息并显示在页面
			var id = $(this).attr("editId");
			getEmp(id);
			
			$("#emp_edit_save").attr("editId",id);
			
			//ajax查询部门信息并显示在弹出页面
			getDeps("#depsEdit");

			$('#empModalEdit').modal({
				backdrop : 'static'
			});
			
			//清空样式
			$("#empEmailEdit").parent().removeClass("has-error has-success");
			$("#empEmailEdit").next("span").text("");
		});
		
		
		//删除单个按钮
		$(document).on("click",".del_emp_btn",function(){
			var empName = $(this).parents("tr").find("td:eq(3)").text();
			if(confirm("确认删除"+empName+"吗？")){
				//发送ajax请求删除员工
				$.ajax({
					url : "${pageContext.request.contextPath }/emps/"+$(this).attr("delId"),
					type : "post",
					data: "_method=DELETE",
					success : function(d) {
						if(d.code==1){
							//$('#empModalEdit').modal('hide');
							getPageData(currentPage);
						}
					}
				});
			}
		});
		
		
		//全选/全不选
		$("#checkAll").click(function(){
			
			$(".check_item").prop("checked",$(this).prop("checked"));
		});
		
		//手动选择全部单个后全选也选中
		$(document).on("click",".check_item",function(){
			
			if($(".check_item:checked").length==$(".check_item").length){
				$("#checkAll").prop("checked",true);
			}else{
				$("#checkAll").prop("checked",false);
			}
		});
		
		
		//删除选中按钮
		$("#delCheck").click(function(){
			var empName="";
			var del_ids="";
			$.each($(".check_item:checked"),function(){
				empName+=$(this).parents("tr").find("td:eq(3)").text()+",";
				if($(".check_item:checked").length!=1){
					del_ids+=$(this).parents("tr").find("td:eq(2)").text()+"-";
				}else{
					del_ids=$(this).parents("tr").find("td:eq(2)").text();
				}
				
			});
			empName=empName.substring(0,empName.length-1);
			if($(".check_item:checked").length!=1){
				del_ids=del_ids.substring(0,del_ids.length-1);
			}
			if(confirm("确认删除("+empName+")吗？")){
				
				//发送ajax请求删除选中员工
				$.ajax({
					url : "${pageContext.request.contextPath }/emps/"+del_ids,
					type : "post",
					data: "_method=DELETE",
					success : function(d) {
						if(d.code==1){
							//$('#empModalEdit').modal('hide');
							getPageData(currentPage);
						}
					}
				});
			}
		});
		
		
		});
		
		
		//点击保存更新
		$("#emp_edit_save").click(function(){
			
				//校验邮箱信息
				var email = $("#empEmailEdit").val();
				var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
				$("#empEmailEdit").parent().removeClass("has-error has-success");
				$("#empEmailEdit").next("span").text("");
				if (!regEmail.test(email)) {

					$("#empEmailEdit").parent().addClass("has-error");
					$("#empEmailEdit").next("span").text("邮箱格式不正确");
					return false;
				} else {

					$("#empEmailEdit").parent().addClass("has-success");
					$("#empEmailEdit").next("span").text("");
					
				}
			
			//保存
			emp_update();
		});
		
		
	
	
	
	
	//ajax保存更新数据
	function emp_update(){
		$.ajax({
			url : "${pageContext.request.contextPath }/emps/"+$("#emp_edit_save").attr("editId"),
			type : "post",
			data: $("#empModalEdit form").serialize()+"&_method=PUT",
			success : function(d) {
				if(d.code==1){
					$('#empModalEdit').modal('hide');
					getPageData(currentPage);
				}
			}
		});
	}
	
	
	
	
	
	//ajax校验邮箱是否存在
	function validate_add_email(email){
		$.ajax({
			url : "${pageContext.request.contextPath }/checkEmail",
			data:"empEmail="+$(email).val(),
			type : "post",
			success : function(d) {
				$(email).parent().removeClass("has-error has-success");
				$(email).next("span").text("");
				if(d.code==1){
					$(email).parent().addClass("has-success");
					$(email).next("span").text("邮箱可用");
					return true;
				}else{
					$(email).parent().addClass("has-error");
					$(email).next("span").text("邮箱已存在");
					return false;
				}
			}
		});
		
	}
	
	
	
	

	//校验表单数据
	function validate_add_form() {
		//1、拿到要校验的数据，使用正则表达式
		var empName = $("#empName").val();
		var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
		$("#empName").parent().removeClass("has-error has-success");
		$("#empName").next("span").text("");
		if (!regName.test(empName)) {

			$("#empName").parent().addClass("has-error");
			$("#empName").next("span").text("用户名2-5位中文或者6-16位英文和数字组合");
			//show_validate_msg("#empName_add_input", "error", "用户名可以是2-5位中文或者6-16位英文和数字的组合");
			return false;
		} else {
			$("#empName").parent().addClass("has-success");
			$("#empName").next("span").text("");
		}

		//2、校验邮箱信息
		var email = $("#empEmail").val();
		var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
		$("#empEmail").parent().removeClass("has-error has-success");
		$("#empEmail").next("span").text("");
		if (!regEmail.test(email)) {

			$("#empEmail").parent().addClass("has-error");
			$("#empEmail").next("span").text("邮箱格式不正确");
			return false;
		} else {

			$("#empEmail").parent().addClass("has-success");
			$("#empEmail").next("span").text("");
		}

		return true;
	}

	//查询部门信息
	function getDeps(ele) {
		$(ele).empty();
		$.ajax({
			url : "${pageContext.request.contextPath }/deps",
			type : "get",
			success : function(d) {
				//将查询出来的部门信息添加到页面
				$.each(d.info.deps, function(index, item) {
					var op = $("<option></option>").append(item.depName)
							.val(item.depId);
					$(ele).append(op);
				});
			}
		});
	}
	
	
	//查询单个员工信息
	function getEmp(id){
		$.ajax({
			url : "${pageContext.request.contextPath }/emps/"+id,
			type : "get",
			success : function(d) {
				var emp = d.info.employee;
				$("#empName_edit").text(emp.empName);
				$("#empEmailEdit").val(emp.email);
				$("#empModalEdit input[name=gender]").val([emp.gender]);
				$("#empModalEdit select").val([emp.depId]);
			}
		});
	}

	

	//查询数据 
	function getPageData(p) {
		$.ajax({
			url : "${pageContext.request.contextPath }/emps",
			data : "cp=" + p,
			type : "get",
			success : function(d) {
				generator_table(d);
				generator_page_info(d);
				generator_page(d);
				total = d.info.page.total;
			}
		});
	}

	//生成表格主体数据 
	function generator_table(d) {
		$("#emps_table tbody").empty();

		var emps = d.info.page.list;
		$.each(emps, function(index, item) {
			var checkbox = $("<input type='checkbox' class='check_item'/>").val(
					item.empId);
			var checkboxTd = $("<td></td>").append(checkbox);
			var numTd = $("<td></td>").append(index + 1);
			var empIdTd = $("<td></td>").append(item.empId);
			var empNameTd = $("<td></td>").append(item.empName);
			var gender = item.gender == "n" ? "男" : "女";
			var empGenderTd = $("<td></td>").append(gender);
			var empEmailTd = $("<td></td>").append(item.email);
			var empDepTd = $("<td></td>").append(item.department.depName);
			var editBtnTd = $("<button></button>").addClass(
					"btn btn-primary btn-sm edit_emp_btn").append(
					$("<span></span>").addClass("glyphicon glyphicon-pencil"))
					.append("编辑");
			editBtnTd.attr("editId",item.empId);
			var delBtnTd = $("<button></button>").addClass(
					"btn btn-danger btn-sm del_emp_btn").append(
					$("<span></span>").addClass("glyphicon glyphicon-trash"))
					.append("删除");
			delBtnTd.attr("delId",item.empId);
			var btnTd = $("<td></td>").append(editBtnTd).append(" ").append(
					delBtnTd);
			$("<tr></tr>").append(checkboxTd).append(numTd).append(empIdTd)
					.append(empNameTd).append(empGenderTd).append(empEmailTd)
					.append(empDepTd).append(btnTd).appendTo(
							"#emps_table tbody");
		});
	}

	//生成分页信息
	function generator_page_info(d) {
		//清空原数据 
		$("#currentPage").empty();
		$("#totalPage").empty();
		$("#total").empty();

		$("#currentPage").text(d.info.page.pageNum);
		currentPage=d.info.page.pageNum;
		$("#totalPage").text(d.info.page.pages);
		$("#total").text(d.info.page.total);

	}

	//生成分页
	function generator_page(d) {
		//清空原数据 
		$("#page_nav").empty();

		var nav = $("<nav></nav>")
		var uL = $("<ul></ul>").addClass("pagination");
		var indexLi = $("<li></li>").append(
				$("<a></a>").append("首页").attr("href", "#"));
		var preLi = $("<li></li>").append(
				$("<a></a>").append($("<span></span>").append("&laquo;")).attr(
						"href", "#"));
		if (d.info.page.isFirstPage) {
			indexLi.addClass("disabled");
			preLi.addClass("disabled");
		} else {
			indexLi.click(function() {
				getPageData(1);
			});
			preLi.click(function() {
				getPageData(d.info.page.pageNum - 1);
			});
		}

		var nextLi = $("<li></li>").append(
				$("<a></a>").append($("<span></span>").append("&raquo;")).attr(
						"href", "#"));
		var lastLi = $("<li></li>").append(
				$("<a></a>").append("尾页").attr("href", "#"));
		if (d.info.page.isLastPage) {
			nextLi.addClass("disabled");
			lastLi.addClass("disabled");
		} else {
			lastLi.click(function() {
				getPageData(d.info.page.pages);
			});
			nextLi.click(function() {
				getPageData(d.info.page.pageNum + 1);
			});
		}

		uL.append(indexLi).append(preLi);
		$.each(d.info.page.navigatepageNums, function(index, item) {
			var numLi = $("<li></li>").append(
					$("<a></a>").append(item).attr("href", "#"));
			if (item == d.info.page.pageNum) {
				numLi.addClass("active");
			}

			numLi.click(function() {
				getPageData(item);
			});

			uL.append(numLi);
		});
		uL.append(nextLi).append(lastLi);
		nav.append(uL).appendTo("#page_nav");
	}
	
	
</script>
</head>
<body>

	<!-- 添加窗口 -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">添加员工</h4>
				</div>
				<div class="modal-body">



					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">姓名：</label>
							<div class="col-sm-7">
								<input type="text" class="form-control" name="empName"
									id="empName" placeholder="姓名"> <span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">性别：</label>
							<div class="col-sm-7">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender_n" value="n"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender_m" value="m"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">邮箱：</label>
							<div class="col-sm-7">
								<input type="email" class="form-control" name="email"
									id="empEmail" placeholder="邮箱"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">部门：</label>
							<div class="col-sm-7">
								<select class="form-control" name="depId" id="deps">
								</select>
							</div>
						</div>
					</form>



				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="add_emp_save">添加</button>
				</div>
			</div>
		</div>
	</div>
	
	
	
	<!-- 修改窗口 -->
	<div class="modal fade" id="empModalEdit" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabelEdit">修改员工</h4>
				</div>
				<div class="modal-body">

					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">姓名：</label>
							<div class="col-sm-7">
								<p class="form-control-static" name="empName" id="empName_edit"></p>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">性别：</label>
							<div class="col-sm-7">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender_n_edit" value="n"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender_m_edit" value="m"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">邮箱：</label>
							<div class="col-sm-7">
								<input type="email" class="form-control" name="email"
									id="empEmailEdit" placeholder="邮箱"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">部门：</label>
							<div class="col-sm-7">
								<select class="form-control" name="depId" id="depsEdit">
								</select>
							</div>
						</div>
					</form>



				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="emp_edit_save">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	
	
	



	<div class="container">
		<!-- title -->
		<div class="row">
			<div class="col-md-12">
				<h1 class="page-header" style="text-align: center;">SSM-员工信息</h1>
			</div>
		</div>

		<!-- button -->
		<div class="row">
			<div class="col-md-4">
				<button class="btn btn-primary" id="empAdd">
					<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
					添加
				</button>
				<button class="btn btn-danger" id="delCheck">
					<span class="glyphicon glyphicon-minus" aria-hidden="true"></span>
					删除选中
				</button>
			</div>
		</div>

		<!-- main -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th><input type="checkbox" id="checkAll" /></th>
							<th>序号</th>
							<th>编号</th>
							<th>姓名</th>
							<th>性别</th>
							<th>邮箱</th>
							<th>部门</th>
							<th>操作</th>
						</tr>
					</thead>

					<tbody>

					</tbody>

				</table>
			</div>
		</div>

		<!-- page -->
		<div class="row">
			<!-- page info -->
			<!-- <div class="col-md-6">当前页数：${page.pageNum }/${page.pages }页,总记录数：${page.total } -->
			<div class="col-md-6">
				当前页数：<span id="currentPage"></span>/<span id="totalPage"></span>页,总记录数：<span
					id="total"></span>
			</div>
			<!-- page main -->
			<div class="col-md-6" id="page_nav"></div>
		</div>
	</div>
</body>
</html>