package TenyBBS::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;

any '/' => sub {
    my ($c) = @_;
    return $c->render('index.tx');
};

get '/thread' => sub {
    my ($c) = @_;
    my @threads = (
        { title => 'foo', },
        { title => 'bar', },
        { title => 'baz', },
    );
    return $c->render('thread/index.tx', { threads => \@threads });
};

post '/account/logout' => sub {
    my ($c) = @_;
    $c->session->expire();
    return $c->redirect('/');
};

1;
