<%@page import="org.student.entity.Page"%>
<%@page import="org.student.dao.impl.StudentDaoImpl"%>
<%@page import="org.student.entity.Student"%>
<%@page import="java.util.List"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!--引入jquery-3.4.1.js  -->
<script type="text/javascript" src="js/jquery-3.4.1.js"></script>
<!-- 通过jquery实现功能 -->
<script type="text/javascript">
	$(document).ready(function() {
		<!--选中行 - 并选中其中的奇数行 - 奇数行的背景颜色设置为亮灰色-->
		$("tr:odd").css("background-color", "lightgray");
	});
</script>

<meta charset="UTF-8">
<title>学生信息列表</title>
</head>
<body>
	<%
		/*在分页显示的前提下：显示数据jsp需要哪些数据：
				当前页：currentPage
				页面大小：pageSize
				当前页的数据集合：students
				总数据：totalCount
				总页数：totalPage
		 --->新建Page类，用于封装以上5个字段
		
		*/
	%>

	<%
		String error = (String) request.getAttribute("error");

		if (error != null) {
			if (error.equals("addError")) {
				out.print("增加失败！");
			} else if (error.equals("noAddError")) {
				out.print("增加成功！");
			}
		}
		String delete = (String) request.getAttribute("delete");

		if (delete != null) {
			if (delete.equals("deleteError")) {
				out.print("删除失败！");
			} else if (delete.equals("noDeleteError")) {
				out.print("删除成功！");
			}
		}
		String update = (String) request.getAttribute("update");

		if (update != null) {
			if (update.equals("updateError")) {
				out.print("修改失败！");
			} else if (update.equals("noUpdateError")) {
				out.print("修改成功！");
			}
		}
	%>


	<table border="1px">
		<tr>
			<th>学号</th>
			<th>姓名</th>
			<th>年龄</th>
			<th>操作</th>
		</tr>

		<%
			//获取request域中的数据
			Page p = (Page) request.getAttribute("p");
		
			for (Student student : p.getStudents()) {
		%>


		<tr>
			<td><a href="QueryStudentBySnoServlet?sno=<%=student.getSno()%>"><%=student.getSno()%></a></td>
			<td><%=student.getSname()%></td>
			<td><%=student.getSage()%></td>
			<td><a href="DelectStudentServlet?sno=<%=student.getSno()%>">删除</a></td>

		</tr>
		<%
			}
		%>

	</table>
	<a href="add.jsp">新增</a><br />
		<% 
		if(p.getCurrentPage()==0){ //首页显示下一页、尾页
		%>
			<a href="QueryStudentByPage?currentPage=<%=p.getCurrentPage()+1 %> ">下一页</a>
			<a href="QueryStudentByPage?currentPage=<%=p.getTotalPage()%> ">尾页</a>
		<%
		 }
		else if(p.getCurrentPage()==p.getTotalPage()){ //尾页显示首页、上一页
		%>
			<a href="QueryStudentByPage?currentPage=1 ">首页</a>
			<a href="QueryStudentByPage?currentPage=<%=p.getCurrentPage()-1 %>">上一页</a>
		<%
		 }else{//其它
		 %>
	<a href="QueryStudentByPage?currentPage=1 ">首页</a>
	<a href="QueryStudentByPage?currentPage=<%=p.getCurrentPage()-1 %>">上一页</a>
	<a href="QueryStudentByPage?currentPage=<%=p.getCurrentPage()+1 %> ">下一页</a>
	<a href="QueryStudentByPage?currentPage=<%=p.getTotalPage()%> ">尾页</a>
	<%
		 }
	%>
	<br/>
</body>
</html>
