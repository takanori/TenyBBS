package TenyBBS::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;
use Time::Piece;

any '/' => sub {
    my ($c) = @_;
    return $c->redirect('/thread');
};

get '/thread' => sub {
    my ($c) = @_;
    my @threads = $c->db->search('thread');
    return $c->render('thread/index.tx', { threads => \@threads });
};

get '/thread/new' => sub {
    my ($c) = @_;
    return $c->render('thread/new.tx');
};

post '/thread' => sub {
    my ($c) = @_;
    my $title = $c->req->param('title');
    my $content = $c->req->param('content');
    $c->db->insert(thread => {
        title => $title,
        content => $content,
        created_at => Time::Piece->new
    });
    return $c->redirect('/thread');
};

get '/thread/:id' => sub {
    my ($c, $args) = @_;
    my $id = $args->{id};
    my $thread = $c->db->single(thread => { id => $id });
    return $c->res_404 unless $thread;
    my @responses = $c->db->search(response => { thread_id => $thread->id });

    return $c->render('thread/show.tx', { thread => $thread, responses => \@responses });
};

post '/thread/:id/response' => sub {
    my ($c, $args) = @_;
    my $id = $args->{id};
    my $content = $c->req->param('content');
    $c->db->insert(response => {
        thread_id  => $id,
        content    => $content,
        created_at => Time::Piece->new
    });

    return $c->redirect("/thread/$id");
};

post '/account/logout' => sub {
    my ($c) = @_;
    $c->session->expire();
    return $c->redirect('/');
};

1;
