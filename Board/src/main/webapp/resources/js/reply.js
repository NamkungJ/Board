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
			error : function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	return {
		add : add
	};	
})();