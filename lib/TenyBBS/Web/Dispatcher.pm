package TenyBBS::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;
use Time::Piece;

any '/' => sub {
    my ($c) = @_;
    return $c->render('index.tx');
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
    $c->db->insert(thread => {
        title => $title,
        created_at => Time::Piece->new
    });
    return $c->redirect('/thread');
};

get '/thread/:id' => sub {
    my ($c, $args) = @_;
    my $id = $args->{id};
    my $thread = $c->db->single(thread => { id => $id });
    return $c->res_404 unless $thread;
    return $c->render('thread/show.tx', { thread => $thread });
};

post '/account/logout' => sub {
    my ($c) = @_;
    $c->session->expire();
    return $c->redirect('/');
};

1;
