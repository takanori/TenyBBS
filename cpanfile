requires 'Amon2',                           '5.16';
requires 'DBD::SQLite',                     '1.33';
requires 'HTML::FillInForm::Lite',          '1.11';
requires 'JSON',                            '2.50';
requires 'Module::Functions',               '2';
requires 'Plack::Middleware::ReverseProxy', '0.09';
requires 'Plack::Session',                  '0.14';
requires 'Router::Boom',                    '0.06';
requires 'Starlet',                         '0.20';
requires 'Teng',                            '0.18';
requires 'Text::Xslate',                    '2.0009';
requires 'Time::Piece',                     '1.20';
requires 'perl',                            '5.010_001';

requires 'DateTime',                   '1.03';
requires 'Data::GUID::URLSafe',        '0.006';
requires 'Log::Minimal',               '0.16';
requires 'DBD::mysql',                 '4.025';
requires 'Plack::Middleware::Session', '0.21';

on configure => sub {
    requires 'Module::Build',    '1.38';
    requires 'Module::CPANfile', '0.9010';
};

on test => sub {
    requires 'Test::More',                 '0.98';
    requires 'Test::WWW::Mechanize::PSGI', '0.35';
    requires 'Test::mysqld',               '0.17';
};
