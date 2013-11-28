use strict;
use warnings;
use utf8;
use t::Util;
use Test::More;
use Test::mysqld;
use DBI;

BEGIN {
    use_ok('TenyBBS::DB');
}

# TODO use fixture

{
    my $mysqld = Test::mysqld->new(
        my_cnf => {
            'skip-networking' => undef,
        },
    ) or plan skip_all => $Test::mysqld::errstr;

    my $dbh = DBI->connect(
        $mysqld->dsn(dbname => 'test'),
    );
    $dbh->{'mysql_enable_utf8'} = 1;

    my $schema = TenyBBS::DB::Schema->instance;

    my $db = TenyBBS::DB->new(
        schema => $schema,
        dbh => $dbh,
    );

    my $sql_threads = qq|
    CREATE TABLE IF NOT EXISTS threads (
        id       INTEGER PRIMARY KEY AUTO_INCREMENT,
        title    TEXT,
        content  TEXT,
        created_at DATETIME NOT NULL,
        updated_at DATETIME NOT NULL,
        INDEX updated_at(updated_at)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
    |;

    my $sql_entries = qq|
    CREATE TABLE IF NOT EXISTS entries (
        id          VARCHAR(36) PRIMARY KEY,
        thread_id   INTEGER NOT NULL,
        author_name VARCHAR(36),
        content     TEXT,
        created_at  DATETIME NOT NULL,
        updated_at  DATETIME NOT NULL,
        FOREIGN KEY(thread_id) REFERENCES threads(id) ON DELETE CASCADE,
        INDEX created_at(created_at)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
    |;

    $db->do($sql_threads);
    $db->do($sql_entries);

    my @threads = (
        { title => 'C#について',          content => 'C#について話そう' },
        { title => 'Perlについて',        content => 'Perlについて話そう' },
        { title => 'Objective-Cについて', content => 'Objective-Cについて話そう' },
    );

    my @entries = (
        { thread_id => 1, author_name => 'Alice', content => 'バージョン上がって便利になった', },
        { thread_id => 1, author_name => 'Bob',   content => 'LINQとラムダ式が便利', },
        { thread_id => 1, author_name => 'Cate',  content => 'UnityとかXamarinで使える', },
        { thread_id => 2, author_name => 'Alice', content => '日本で人気が高いらしい', },
    );

    for my $thread (@threads) {
        $db->insert_thread(
            {   title   => $thread->{title},
                content => $thread->{content},
            }
        );
    }

    for my $entry (@entries) {
        $db->insert_entry(
            {   thread_id   => $entry->{thread_id},
                author_name => $entry->{author_name},
                content     => $entry->{content},
            }
        );
    }

    subtest 'thread data' => sub {

        # Do not use is_deeply.
        # $thread_got has new keys 'created_at' and 'updated_at'
        my $all_threads = $db->all_threads;

        for my $i ( 0 .. $#threads ) {
            my $thread_expected = $threads[$i];
            my $thread_got      = $all_threads->[$i];

            for my $key ( keys $thread_expected ) {
                is( $thread_got->{$key}, $thread_expected->{$key} );
            }
        }
    };
}

done_testing;
