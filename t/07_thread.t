use strict;
use warnings;
use utf8;
use t::Util;
use Plack::Test;
use Plack::Util;
use Test::More;

my $app = Plack::Util::load_psgi 'script/tenybbs-server';

sub expect_res {
    my ($stat, $cb, $method, $url) = @_;
    my $req = HTTP::Request->new($method => $url);
    my $res = $cb->($req);
    is $res->code, $stat;
    diag $res->content if $res->code != $stat;
}

test_psgi
    app => $app,
    client => sub {
        my $cb = shift;
        expect_res(200, $cb, GET => 'http://localhost/thread');
        expect_res(200, $cb, GET => 'http://localhost/thread/new');
        expect_res(200, $cb, GET => 'http://localhost/thread/1');
        expect_res(404, $cb, GET => 'http://localhost/thread/4');
    };


done_testing;
