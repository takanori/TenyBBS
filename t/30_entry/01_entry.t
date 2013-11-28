use strict;
use warnings;
use utf8;
use t::Util;
use Plack::Test;
use Plack::Util;
use Test::More;
use Test::WWW::Mechanize::PSGI;

plan skip_all => 'not yet';

my $app = Plack::Util::load_psgi 'script/tenybbs-server';
my $mech = Test::WWW::Mechanize::PSGI->new( app => $app );

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

        expect_res( 200, $cb, GET => '/')

        # TODO 
        # expect_res( 200, $cb, GET => 'http://localhost/thread/:GUID_FOR_TEST_THREAD/insert' );
        # expect_res( 200, $cb, GET => 'http://localhost/thread/:GUID_FOR_TEST_THREAD/search' );
        # expect_res( 200, $cb, GET => 'http://localhost/thread/:GUID_FOR_TEST_THREAD/update' );
        # expect_res( 200, $cb, GET => 'http://localhost/thread/:GUID_FOR_TEST_THREAD/delete' );
    };

done_testing;
