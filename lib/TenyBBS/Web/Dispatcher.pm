package TenyBBS::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;

use Log::Minimal;

# Index =============================================================

any '/' => sub {
    my ($c) = @_;
    return $c->redirect('/thread');    # TODO
};

# Threads ===========================================================

get '/thread' => sub {
    my ($c) = @_;
    return $c->render('thread/index.tx');
};

get '/api/thread/all' => sub {
    my ($c) = @_;
    my $threads = $c->db->all_threads;

    $c->render_json( { threads => $threads } );
};

post '/api/thread/insert' => sub {
    my ($c)     = @_;
    my $title   = $c->req->param('title');
    my $content = $c->req->param('content');
    my $thread  = $c->db->insert_thread(
        {   title   => $title,
            content => $content,
        }
    );
    return $c->render_json( { thread => $thread } );
};

post '/api/thread/update' => sub {
    my ($c)   = @_;
    my $id    = $c->req->param('id');
    my $title = $c->req->param('title');
    my $content => $c->req->param('content');
    my $thread = $c->db->insert_thread(
        {   id      => $id,
            title   => $title,
            content => $content,
        }
    );
    return $c->render_json( { thread => $thread } );
};

post '/api/thread/delete' => sub {
    my ($c) = @_;
    my $id = $c->req->param('id');
    my $deleted_count = $c->db->delete_thread( { id => $id } );
    return $c->render_json( { deleted_count => $deleted_count } );
};

# Entries  ===========================================================

get '/thread/id/:id' => sub {
    my ( $c, $args ) = @_;
    return $c->render( 'thread/show.tx', { thread_id => $args->{id} } );
};

get '/api/entry/all' => sub {
    my ($c) = @_;
    my $thread_id = $c->req->param('thread_id');
    my $entries = $c->db->all_entries( { thread_id => $thread_id } );

    $c->render_json( { entries => $entries } );
};

post '/api/entry/insert' => sub {
    my ($c)         = @_;
    my $thread_id   = $c->req->param('thread_id');
    my $author_name = $c->req->param('author_name');
    my $content     = $c->req->param('content');
    my $entry       = $c->db->insert_entry(
        {   thread_id   => $thread_id,
            author_name => $author_name,
            content     => $content,
        }
    );
    return $c->render_json( { entry => $entry } );
};

post '/api/entry/update' => sub {
    my ($c)         = @_;
    my $id          = $c->req->param('id');
    my $author_name = $c->req->param('author_name');
    my $content     = $c->req->param('content');
    my $entry       = $c->db->update_entry(
        {   id          => $id,
            author_name => $author_name,
            content     => $content,
        }
    );
    return $c->render_json( { entry => $entry } );
};

post '/api/entry/delete' => sub {
    my ($c) = @_;
    my $id = $c->req->param('id');
    my $deleted_count = $c->db->delete_entry( { id => $id } );
    warnf ($deleted_count);
    return $c->render_json( { deleted_count => $deleted_count } );
};

1;
