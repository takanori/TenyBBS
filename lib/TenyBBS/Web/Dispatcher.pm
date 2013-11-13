package TenyBBS::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;

# Threads ===========================================================

any '/' => sub {
    my ($c) = @_;
    return $c->render('index.tx');
};

get '/thread' => sub {
    my ($c) = @_;
    return $c->render('thread/index.tx');
};

get '/thread/all' => sub {
    my ($c) = @_;
    my $threads = $c->db->all_threads;

    $c->render_json({threads => $threads})
};

post '/thread/insert' => sub {
    my ($c) = @_;
    my $title = $c->req->param('title');
    my $content => $c->req->param('content');
    my $thread = $c->db->insert_thread(
        {   title   => $title,
            content => $content,
        }
    );
    return $c->render_json( { thread => $thread } );
};

post '/thread/update' => sub {
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

post '/thread/delete' => sub {
    my ($c) = @_;
    my $id = $c->req->param('id');
    my $deleted_count = $c->db->insert_thread( { id => $id } );
    return $c->render_json( { deleted_count => $deleted_count } );
};


1;
