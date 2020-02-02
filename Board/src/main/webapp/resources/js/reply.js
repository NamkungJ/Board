console.log("Reply JS Module.....");

var replyService = (function(){
	
	// 댓글 등록
	function add(reply, callback, error){
		console.log("add reply ajax.....");
		
		$.ajax({
			type : 'post',
			url : '/replies/reg',
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, err){
				if(error){
					error(err);
				}
			}
		});
	}
	
	// 댓글 목록
	function getList(param, callback, error) {
		console.log("getList reply get-ajax..... : " + param.bno + "/" + param.page);
		
		var bno = param.bno;
		var page = param.page || 1;
		
		$.getJSON("/replies/pages/"+bno+"/"+page+".json",
				function(data) {
					if (callback) {
						callback(data);
					}
				}).fail(function(xhr, status, err) {
					if(error) {
						error();
					}
				});
	}
	
	// 댓글 삭제
	function remove(rno, callback, error){
		console.log("remove reply ajax..... : " + rno);
		
		$.ajax({
			type : 'delete',
			url : '/replies/' + rno,						
			success : function(result, status, xhr){
				if(callback){					
					callback(result);
				}
			},
			error : function(xhr, status, err){
				if(error){
					error(err);
				}
			}
		});
	}
	
	// 댓글 수정
	function update(reply, callback, error){
		console.log("update reply ajax..... : " + reply.bno + "/" + reply.rno);
		
		$.ajax({
			type : 'put',
			url : '/replies/' + reply.rno,
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if(callback){
					console.log("UPDATE RESULT : " + result);
					callback(result);
				}
			},
			error : function(xhr, status, err){
				if(error){
					error(err);
				}
			}
		});
	}
	
	// 댓글 조회
	function get(rno, callback, error) {
		console.log("get reply ajax..... : " + rno);
		
		$.get("/replies/" + rno + ".json",
				function(result){
					if(callback) {
						callback(result);
				}
		}).fail(function(xhr, status, err) {
			if(error) {
				error();
			}
		});
		
	}
	
	return {
		add : add,
		getList : getList,
		remove : remove,
		update : update,
		get : get
	};	
})();