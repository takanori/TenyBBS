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

post '/account/logout' => sub {
    my ($c) = @_;
    $c->session->expire();
    return $c->redirect('/');
};

1;
