$(document).ready(function() {

	var tbEntries = $('#tb-entries');

	tbEntries.addClass('tb-entries');
	tbEntries.append(
		'<table class="table well">' +
		'<thead><tr><th class="col-md-2">author</th><th class="col-md-7">content</th><th class="col-md-2">created_at</th><th class="col-md-1"></th></tr></thead>' +
		'<tbody class="tb-entry-list"></tbody></table>'
	);

	var tbEntryList = tbEntries.find('.tb-entry-list');
	var rawEntries = [];
	var insertForm = $('#insert-form');
  var threadId = insertForm.find('.thread-id').val();

	$.ajax({
		type: 'GET',
		url: '/api/entry/all',
    data: { thread_id : threadId },
		success: function(data) {
			if (data.entries) {
				rawEntries = data.entries;
				refreshEntries(rawEntries);
			} else {
				// debugPrint('Error searching.');
			}
		}
	});

	// insert ==========================================================

	var authorNameInput = insertForm.find('.author-name-input');
	var contentInput = insertForm.find('.content-input');
	$('#tb-insert-btn').on('click', function() {
		if (!contentInput.val())
			return;

		addNewEntry(insertForm.serialize());
		contentInput.focus();
	});

	function addNewEntry(entryData) {
		$.ajax({
			type: 'POST',
			url: '/api/entry/insert',
			data: entryData,
			success: function(data) {
				if (data.entry) {
					rawEntries.unshift(data.entry);
					refreshEntries(rawEntries);
					contentInput.val("");
				}
			},
			dataType: 'json',
		});
	}

	// update =======================================================================
	// TODO 

	// var contentBeforeEdit = '';
	// $(tbEntryList).on('dblclick', '.todo-content', function() {
	//   // debugPrint('tb-row dblclicked');

	//   var existingInput = $(tbEntryList).find('.tb-row-input');
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
	//           refreshEntries(rawEntries);
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
	//   for (var i = 0; i < rawEntries.length; i++) {
	//     if (rawEntries[i].id == todo.id) {
	//       rawEntries[i] = todo;
	//       break;
	//     }
	//   }
	// }

	// update done only =======================================================================
	// TODO

	// $(tbEntryList).on('click', '.done-check', function() {

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
	//         refreshEntries(rawEntries);
	//       }
	//     },
	//   });

	// });

	
	// delete =======================================================================
	// TODO

	// $(tbEntryList).on('click', '.delete-btn', function() {
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
	//       refreshEntries(rawEntries);
	//     },
	//   });
	// }

	// function deleteCache(todoId) {
	//   for (var i = 0; i < rawEntries.length; i++) {
	//     if (rawEntries[i].id == todoId) {
	//       rawEntries.splice(i, 1);
	//       break;
	//     }
	//   }
	// }

	// helper ========================================================================

	function refreshEntries(entries) {
		// debugPrint('refreshEntries entries.length: ' + entries.length);
		
		tbEntryList.empty();
		for (var i = 0; i < entries.length; i++) {
			var str = '';
			str += '<tr id="' + entries[i].id + '" class="tb-entry-row">';
			str += '<td class="entry-author-name">' + htmlEscape(entries[i].author_name) + '</td>';
			str += '<td class="entry-content">' + htmlEscape(entries[i].content) + '</td>';
			str += '<td><small class="text-muted">' + htmlEscape(entries[i].created_at) + '</small></td>';
			str += '<td><span class="delete-btn glyphicon glyphicon-remove"></span></td></tr>';

			tbEntryList.append(str);
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
