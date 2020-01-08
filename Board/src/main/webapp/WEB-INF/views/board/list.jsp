<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="../include/header.jsp" %>
	<div id="page-wrapper">
		<div class="row">
		    <div class="col-lg-12">
		        <h1 class="page-header">Tables</h1>
		    </div>
		    <!-- /.col-lg-12 -->
		</div>
		<!-- /.row -->
		<div class="row">
		    <div class="col-lg-12">
		        <div class="panel panel-default">
		            <div class="panel-heading">
		                DataTables Advanced Tables
		            </div>
		            <!-- /.panel-heading -->
		            <div class="panel-body">
		                <div class="table-responsive">
		                    <table class="table table-striped table-bordered table-hover" id="dataTables-example">
		                        <thead>
		                            <tr>
		                                <th>번호</th>
		                                <th>제목</th>
		                                <th>작성자</th>
		                                <th>작성일</th>
		                                <th>수정일</th>
		                            </tr>
		                        </thead>
		                        <tbody>
		                        	<c:forEach items="${list}" var="board">
		                        		<tr class="odd gradeX">
			                                <td><c:out value="${board.bno}"></c:out></td>
			                                <td><c:out value="${board.title}"></c:out></td>
			                                <td><c:out value="${board.writer}"></c:out></td>
			                                <td class="center"><fmt:formatDate value="${board.regdate}" pattern="yyyy-MM-dd"/></td>
			                                <td class="center"><fmt:formatDate value="${board.updatedate}" pattern="yyyy-MM-dd"/></td>
		                            	</tr>	
		                        	</c:forEach>		                        		                       
								</tbody>
		                    </table>
		                </div>
		                <!-- /.table-responsive -->		
		            </div>
		            <!-- /.panel-body -->
		        </div>
		        <!-- /.panel -->
		    </div>
		    <!-- /.col-lg-12 -->
		</div>
		<!-- /.row -->			
	</div>
	<!-- /#page-wrapper -->
<%@include file="../include/footer.jsp" %>        