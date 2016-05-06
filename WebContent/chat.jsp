<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="jquery.js"></script>
<script>
	var username = '${sessionScope.username}';
	var ws;
	var target = 'ws://localhost:8090/websocket-chat/chatSocket?username=' + username;

	window.onload = function() {
		// 进入聊天室，就打开socket通道
		if ('WebSocket' in window) {
            ws = new WebSocket(target);
        } else if ('MozWebSocket' in window) {
            ws = new MozWebSocket(target);
        } else {
            alert('WebSocket is not supported by this browser.');
            return;
        }

        ws.onmessage = function(event) {
            
            var data = JSON.parse(event.data);
        	if(data.welcome) {
        		$('#content').append(data.welcome+'<br/>');
            }

            if(data.usernames) {
            	$('#userList').empty();
				$(data.usernames).each(function() {
					$('#userList').append('<input type="checkbox" value="'+ this +'">' + this + '<br/>');
				})
            }

            if(data.content) {
            	$('#content').append(data.content+'<br/>');
            }
        }
	}

	function subSend() {
		var obj = null;
		var val = $('#msg').val();

		var ss = $('#userList :checked');
		if(!ss.size()) {
			obj = {
				msg: val,
				type: 1 // 1 广播  2单聊
			};
		}else {
			var to = $('#userList :checked').val();
			obj = {
				to: to,
				msg: val,
				type: 2 // 1 广播  2单聊
			};
		}
		
		ws.send(JSON.stringify(obj));
		$('#msg').val('');
	}
</script>
</head>
<body>
	<div id="container" style="border: 1px solid black; width:400px; height:400px; float: left;">
		<div id="content" style="height: 350px;"></div>
		<div style="border-top: 1px solid black; width:400px; height: 50px;">
			<input type="text" id="msg">
			<button id="send" onclick="subSend()">send</button>
		</div>
	</div>
	<div id="userList" style="border: 1px solid black; width: 100px; height: 400px; float: left; margin-left: -1px;"></div>
</body>
</html>