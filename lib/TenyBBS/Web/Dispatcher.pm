package TenyBBS::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;

any '/' => sub {
    my ($c) = @_;
    my @thread_list = $c->db->fetch_threads;
    my @entry_list = $c->db->fetch_entries;
    return $c->render('index.tx', { thread_list => \@thread_list, entry_list => \@entry_list});
};


post '/thread/insert' => sub {
    my ($c) = @_;
    my $title = $c->req->param('title');
    my $content = $c->req->param('content');
    my $author_name = $c->req->param('author_name');
    $c->db->create_thread($title, $content, $author_name);
    return $c->redirect('/');
};


1;
