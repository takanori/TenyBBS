$(document).ready(function() {

	var tbThreads = $('#tb-threads');

	tbThreads.addClass('tb-threads');
	tbThreads.append(
		'<table class="table well">' +
		'<thead><tr><th class="col-md-3">title</th><th class="col-md-6">content</th><th class="col-md-2">updated_at</th><th class="col-md-1"></th></tr></thead>' +
		'<tbody class="tb-thread-list"></tbody></table>'
	);

	var tbThreadList = tbThreads.find('.tb-thread-list');
	var rawThreads = [];
	var insertForm = $('#insert-form');

	$.ajax({
		type: 'GET',
		url: '/api/thread/all',
		success: function(data) {
			if (data.threads) {
				rawThreads = data.threads;
				refreshThreads(rawThreads);
			} else {
				// debugPrint('Error searching.');
			}
		}
	});

	// insert ==========================================================

	var titleInput = insertForm.find('.title-input');
	var contentInput = insertForm.find('.content-input');
	$('#tb-insert-btn').on('click', function() {
		if (!titleInput.val())
			return;

		addNewThread(insertForm.serialize());
		titleInput.focus();
	});

	function addNewThread(threadData) {
		$.ajax({
			type: 'POST',
			url: '/api/thread/insert',
			data: threadData,
			success: function(data) {
				if (data.thread) {
					rawThreads.unshift(data.thread);
					refreshThreads(rawThreads);
					titleInput.val("");
					contentInput.val("");
				}
			},
			dataType: 'json',
		});
	}

	// update =======================================================================
	// TODO 

	// var contentBeforeEdit = '';
	// $(tbThreadList).on('dblclick', '.todo-content', function() {
	//   // debugPrint('tb-row dblclicked');

	//   var existingInput = $(tbThreadList).find('.tb-row-input');
	//   if (existingInput) {
	//     existingInput.parent().text(contentBeforeEdit);
	//     existingInput.remove();
	//   }

	//   var todoId = $(this).parent().attr('id');
	//   var contentTd = $(this);
	//   var todoContent = contentTd.text();

	//   contentBeforeEdit = todoContent;
	//   contentTd.text('');

	//   var updateTextArea = $('<textarea class="col-xs-12 tb-row-input" rows="4">' + htmlEscape(todoContent).replace(/\"/g, [>"<] '&quot;') + '</textarea>');
	//   updateTextArea.appendTo(contentTd).focus();
	
	//   var submitBtn = $('<input type="button" class="update-btn btn btn-primary btn-xs" name="submit-update" value="Submit">').on('click', function() {

	//     // Update todo
	//     var tbRowInput = $(this).siblings('.tb-row-input');
	//     var newContent = tbRowInput.val();
	//     var newDone = $(this).parent().siblings('td:first').children().prop('checked') ? 1 : 0;

	//     if (!newContent)
	//       return;

	//     $.ajax({
	//       type: 'PUT',
	//       url: '/todos/update',
	//       data: {
	//         todo_id: todoId,
	//         content: newContent,
	//         done: newDone,
	//       },
	//       success: function(data) {
	//         if (data.todo) {
	//           updateCache(data.todo);
	//           refreshThreads(rawThreads);
	//         }
	//       },
	//     });
			
	//     tbRowInput.val('');
	//     contentInput.focus();

	//     if (intro) {
	//       intro.exit();
	//     }
	//   });
	//   updateTextArea.after(submitBtn);

	//   if (intro) {
	//     intro.refresh();
	//   }
	// });

	// function updateCache(todo) {
	//   for (var i = 0; i < rawThreads.length; i++) {
	//     if (rawThreads[i].id == todo.id) {
	//       rawThreads[i] = todo;
	//       break;
	//     }
	//   }
	// }

	// update done only =======================================================================
	// TODO

	// $(tbThreadList).on('click', '.done-check', function() {

	//   var todoId = $(this).parent().parent().attr('id');
	//   var newDone = $(this).prop('checked') ? 1 : 0;

	//   $.ajax({
	//     type: 'PUT',
	//     url: '/todos/update-done-only',
	//     data: {
	//       todo_id: todoId,
	//       done: newDone,
	//     },
	//     success: function(data) {
	//       if (data.todo) {
	//         updateCache(data.todo);
	//         refreshThreads(rawThreads);
	//       }
	//     },
	//   });

	// });

	
	// delete =======================================================================
	// TODO

	// $(tbThreadList).on('click', '.delete-btn', function() {
	//   // debugPrint('delete-btn clicked');
	//   var todoId = $(this).parent().parent().attr('id');
	//   deleteTodo(todoId);

	//   if (intro) {
	//     intro.exit();
	//   }
	// });

	// function deleteTodo(todoId) {
	//   if (!todoId)
	//     return;
	//   $.ajax({
	//     type: 'DELETE',
	//     url: '/todos/delete',
	//     data: {
	//       todo_id : todoId,
	//     }, 
	//     success: function(data) {
	//       // debugPrint("success in delete: " + data.todo_id);
	//       deleteCache(data.todo_id);
	//       refreshThreads(rawThreads);
	//     },
	//   });
	// }

	// function deleteCache(todoId) {
	//   for (var i = 0; i < rawThreads.length; i++) {
	//     if (rawThreads[i].id == todoId) {
	//       rawThreads.splice(i, 1);
	//       break;
	//     }
	//   }
	// }

	// helper ========================================================================

		'<table class="table well">' +
		'<thead><tr><th class="col-md-3">title</th><th class="col-md-6">content</th><th class="col-md-2">updated_at</th><th class="col-md-1"></th></tr></thead>' +
		'<tbody class="tb-thread-list"></tbody></table>'

	function refreshThreads(threads) {
		// debugPrint('refreshThreads threads.length: ' + threads.length);
		
		tbThreadList.empty();
		for (var i = 0; i < threads.length; i++) {
			var str = '';
			str += '<tr id="' + threads[i].id + '" class="tb-row">';
			str += '<td class="thread-title"><a href="/thread/id/' + threads[i].id + '">' + htmlEscape(threads[i].title) + '</td>';
			str += '<td class="thread-content">' + htmlEscape(threads[i].content) + '</td>';
			str += '<td><small class="text-muted">' + htmlEscape(threads[i].updated_at) + '</small></td>';
			str += '<td><span class="delete-btn glyphicon glyphicon-remove"></span></td></tr>';
			// str += '<td><span class="delete-btn"><i class="icon-remove-sign"></i></span></td></tr>';

			tbThreadList.append(str);
		}
	}

	function htmlEscape(string) {
		if (!string) return;
		return string.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
	}	

	// debug ========================================================================

  function debugPrint(str) {
    var	area = $('#debug');
    if (!area) return;
    area.val(area.val() + str + '\n');
  }
  
});
