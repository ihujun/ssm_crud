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
</head>
<body>

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
				<button class="btn btn-primary">
					<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
					添加
				</button>
				<button class="btn btn-danger">
					<span class="glyphicon glyphicon-minus" aria-hidden="true"></span>
					删除选中
				</button>
			</div>
		</div>

		<!-- main -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<tr>
						<th>序号</th>
						<th>编号</th>
						<th>姓名</th>
						<th>性别</th>
						<th>邮箱</th>
						<th>部门</th>
						<th>操作</th>
					</tr>

					<c:forEach items="${page.list }" var="emp" varStatus="s">
						<tr>
							<td>${s.count }</td>
							<td>${emp.empId }</td>
							<td>${emp.empName }</td>
							<td>${emp.gender=="n"?"男":"女" }</td>
							<td>${emp.email }</td>
							<td>${emp.department.depName }</td>
							<td>
								<button class="btn btn-primary btn-sm">
									<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
									编辑
								</button>
								<button class="btn btn-danger btn-sm">
									<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
									删除
								</button>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>

		<!-- page -->
		<div class="row">
			<!-- page info -->
			<div class="col-md-6">当前页数：${page.pageNum }/${page.pages }页,总记录数：${page.total }
			</div>
			<!-- page main -->
			<div class="col-md-6">
				<nav aria-label="Page navigation">
				<ul class="pagination">

					<c:if test="${page.pageNum==1 }">
						<li class="disabled"><a
							href="${pageContext.request.contextPath }/emps?cp=1">首页</a></li>
						<li class="disabled"><a
							href="${pageContext.request.contextPath }/emps?cp=${page.pageNum-1}"
							aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
						</a></li>
					</c:if>
					<c:if test="${page.pageNum!=1 }">
						<li><a href="${pageContext.request.contextPath }/emps?cp=1">首页</a></li>
						<li><a
							href="${pageContext.request.contextPath }/emps?cp=${page.pageNum-1}"
							aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
						</a></li>
					</c:if>


					<c:forEach items="${page.navigatepageNums }" var="num">
						<c:if test="${num==page.pageNum }">
							<li class="active"><a href="#">${num }</a></li>
						</c:if>
						<c:if test="${num!=page.pageNum }">
							<li><a
								href="${pageContext.request.contextPath }/emps?cp=${num}">${num }</a></li>
						</c:if>
					</c:forEach>

					<c:if test="${page.pageNum==page.pages }">
						<li class="disabled"><a href="${pageContext.request.contextPath }/emps?cp=${page.pageNum+1}" aria-label="Next"> <span
								aria-hidden="true">&raquo;</span>
						</a></li>
						<li class="disabled"><a href="${pageContext.request.contextPath }/emps?cp=${page.pages}">尾页</a></li>
					</c:if>
					<c:if test="${page.pageNum!=page.pages }">
						<li><a href="${pageContext.request.contextPath }/emps?cp=${page.pageNum+1}" aria-label="Next"> <span
								aria-hidden="true">&raquo;</span>
						</a></li>
						<li><a href="${pageContext.request.contextPath }/emps?cp=${page.pages}">尾页</a></li>
					</c:if>
				</ul>
				</nav>
			</div>
		</div>
	</div>
</body>
</html>