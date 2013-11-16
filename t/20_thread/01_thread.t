use strict;
use warnings;
use utf8;
use t::Util;
use Plack::Test;
use Plack::Util;
use Test::More;
use Test::Harness;

my $app = Plack::Util::load_psgi 'script/tenybbs-server';

plan skip_all => 'not yet';

sub expect_res {
    my ( $stat, $cb, $method, $url ) = @_;
    my $req = HTTP::Request->new( $method => $url );
    my $res = $cb->($req);
    is $res->code, $stat;
    diag $res->content if $res->code != $stat;
}

test_psgi
    app    => $app,
    client => sub {
        my $cb = shift;
        expect_res( 200, $cb, GET  => 'http://localhost/thread' );
        expect_res( 200, $cb, GET  => 'http://localhost/api/thread/all' );
        expect_res( 200, $cb, POST => 'http://localhost/api/thread/insert' );

        # expect_res( 200, $cb, GET => 'http://localhost/thread/update' );
        # expect_res( 200, $cb, GET => 'http://localhost/thread/delete' );

        # # access thread contents
        # expect_res( 200, $cb, GET => 'http://localhost/thread/:GUID_FOR_TEST_THREAD' );
    };

done_testing;
