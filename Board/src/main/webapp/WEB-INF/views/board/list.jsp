<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="../include/header.jsp" %>
	<div id="page-wrapper">
		<div class="row">
		    <div class="col-lg-12">
		        <h1 class="page-header">게시판</h1>
		    </div>
		</div>
		<div class="row">
		    <div class="col-lg-12">
		        <div class="panel panel-default">
		            <div class="panel-heading">게시글 목록<button id="regBtn" type="button" class="btn btn-xs btn-default pull-right">게시글 작성하기</button></div>		            
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
                            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h4 class="modal-title" id="myModalLabel">게시물등록완료</h4>
                                        </div>
                                        <div class="modal-body">게시물이 등록되었습니다.</div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>                                            
                                        </div>
                                    </div>
                                </div>
                            </div>
		                </div>
		            </div>
		        </div>
		    </div>
		</div>
	</div>
<%@include file="../include/footer.jsp" %>
<script type="text/javascript">
	$(document).ready(function() {
		var result = '<c:out value="${result}" />';
		
		checkModal(result);
		
		function checkModal(result) {
			if(result === '') {
				return;
			}
		
			if(parseInt(result) > 0) {
				$('.modal-body').html("게시글이" + parseInt(result) + "번으로 등록되었습니다.");
			}
			$('#myModal').modal("show");
		}
		
		$("#regBtn").on("click", function () {
			self.location = "/board/register";
		});
		
	});
</script>