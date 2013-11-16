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
                console.log('Error searching.');
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

    var titleBeforeChange = '';
    var contentBeforeChange = '';
    $(tbThreadList).on('click', '.update-btn', function() {
        var threadTr = $(this).parent().parent();

        var existingTitleInput = $(tbThreadList).find('.tb-update-title');
        if (existingTitleInput) {
            var existingContentInput = existingTitleInput.parent().parent().find('.tb-update-content');
            existingTitleInput.parent().text(titleBeforeChange);
            existingTitleInput.remove();
            existingContentInput.parent().text(contentBeforeChange);
            existingContentInput.remove();
        }

        var threadId = threadTr.attr('id');
        var titleTd = threadTr.children('.thread-title');
        var contentTd = threadTr.children('.thread-content');
        titleBeforeChange = titleTd.text();
        contentBeforeChange = contentTd.text();

        titleTd.text('');
        contentTd.text('');

        var titleArea = $('<textarea class="col-xs-12 tb-update-title" rows="2">' + htmlEscape(titleBeforeChange).replace(/\"/g, '&quot;') + '</textarea>');
        var contentArea = $('<textarea class="col-xs-12 tb-update-content" rows="4">' + htmlEscape(contentBeforeChange).replace(/\"/g, '&quot;') + '</textarea>');
        titleArea.appendTo(titleTd).focus();
        contentArea.appendTo(contentTd);

        var submitBtn = $('<input type="button" class="update-submit-btn btn btn-primary btn-xs" name="update-submit" value="Submit">').on('click', function() {

            var newTitle = titleArea.val();
            var newContent = contentArea.val();

            if (!newContent) {
                return;
            }

            $.ajax({
                type: 'POST',
                url: '/api/thread/update',
                data: {
                    id: threadId,
                    title: newTitle,
                    content: newContent,
                },
                success: function(data) {
                    if (data.thread) {
                        console.log(data.thread);
                        updateCache(data.thread);
                        refreshThreads(rawThreads);
                    }
                    else {
                        console.log("Error. Could not get updated thread.");
                    }
                },
            });

            titleInput.focus();

        });
        contentArea.after(submitBtn);
    });

    function updateCache(thread) {
        var threadId = thread.id;
        for (var i = 0; i < rawThreads.length; i++) {
            if (rawThreads[i].id == threadId) {
                rawThreads[i] = thread;
                break;
            }
        }
    }

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

    $(tbThreadList).on('click', '.delete-btn', function() {
        var threadTitle = $(this).parent().siblings('.thread-title').text();
        if (window.confirm('スレッド"' + threadTitle + '"を削除しますか?')) {
            console.log('delete-btn clicked');
            var threadId = $(this).parent().parent().attr('id');
            deleteThread(threadId);
        }
    });

    function deleteThread(threadId) {
        if (!threadId)
            return;
        $.ajax({
            type: 'POST',
            url: '/api/thread/delete',
            data: {
                id : threadId,
            }, 
            success: function(data) {
                console.log("success in delete: " + data.deleted_count);
                if (data.deleted_count === '1') {
                    deleteCache(threadId);
                    refreshThreads(rawThreads);
                }
                else {
                    console.log('Error: deleted_count is ' + data.deleted_count + '. Expected 1.');
                }
            },
        });
    }

    function deleteCache(threadId) {
        for (var i = 0; i < rawThreads.length; i++) {
            if (rawThreads[i].id == threadId) {
                rawThreads.splice(i, 1);
                break;
            }
        }
    }

    // helper ========================================================================

    function refreshThreads(threads) {
        tbThreadList.empty();
        for (var i = 0; i < threads.length; i++) {
            var str = '';
            str += '<tr id="' + threads[i].id + '" class="tb-row">';
            str += '<td class="thread-title"><a href="/thread/id/' + threads[i].id + '">' + htmlEscape(threads[i].title) + '</td>';
            str += '<td class="thread-content">' + htmlEscape(threads[i].content) + '</td>';
            str += '<td><small class="text-muted">' + htmlEscape(threads[i].updated_at) + '</small></td>';
            str += '<td><span class="update-btn glyphicon glyphicon-edit"></span>';
            str += ' <span class="delete-btn glyphicon glyphicon-remove"></span></td></tr>';
            // str += '<td><span class="delete-btn"><i class="icon-remove-sign"></i></span></td></tr>';

            tbThreadList.append(str);
        }
    }

    function htmlEscape(string) {
        if (!string) return;
        return string.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
    }	

});
