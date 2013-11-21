use strict;
use warnings;
use utf8;
use t::Util;
use Plack::Util;
use Plack::Test;
use Test::More;
use Test::WWW::Mechanize::PSGI;

my $app = Plack::Util::load_psgi 'script/tenybbs-server';
my $mech = Test::WWW::Mechanize::PSGI->new(app => $app);

sub expect_res {
    my ( $stat, $cb, $method, $url ) = @_;
    my $req = HTTP::Request->new( $method => $url );
    my $res = $cb->($req);
    is $res->code, $stat;
    diag $res->content if $res->code != $stat;
}

subtest 'index' => sub {
    test_psgi
        app    => $app,
        client => sub {
            my $cb = shift;
            expect_res( 302, $cb, GET  => '/' );
            expect_res( 200, $cb, GET  => '/thread' );
            expect_res( 200, $cb, GET  => '/api/thread/all' );
            expect_res( 200, $cb, POST => '/api/thread/insert' );

            # expect_res( 200, $cb, GET => 'http://localhost/thread/update' );
            # expect_res( 200, $cb, GET => 'http://localhost/thread/delete' );

            # # access thread contents
            # expect_res( 200, $cb, GET => 'http://localhost/thread/:ID_FOR_TEST_THREAD' );
        };

    $mech->get_ok('/');
    $mech->title_is('TenyBBS');
    $mech->content_contains('Write your title here');
};

done_testing;
