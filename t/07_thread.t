use strict;
use warnings;
use utf8;
use t::Util;
use Plack::Test;
use Plack::Util;
use Test::More;

my $app = Plack::Util::load_psgi 'script/tenybbs-server';

# スレッド一覧ページを開く

sub expect_200 {
    my ($cb, $method, $url) = @_;
    my $req = HTTP::Request->new($method => $url);
    my $res = $cb->($req);
    is $res->code, 200;
    diag $res->content if $res->code != 200;
}

test_psgi
    app => $app,
    client => sub {
        my $cb = shift;
        expect_200($cb, GET => 'http://localhost/thread');
        expect_200($cb, GET => 'http://localhost/thread/new');
    };


done_testing;
