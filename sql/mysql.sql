CREATE TABLE IF NOT EXISTS threads (
        id       INTEGER PRIMARY KEY AUTO_INCREMENT,
        author_name VARCHAR(36),
        title    TEXT,
        content  TEXT,
        created_at DATETIME NOT NULL,
        updated_at DATETIME NOT NULL,
        INDEX updated_at(updated_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS entries (
        id          INTEGER PRIMARY KEY,
        thread_id   INTEGER NOT NULL,
        author_name VARCHAR(36),
        content     TEXT,
        created_at  DATETIME NOT NULL,
        updated_at  DATETIME NOT NULL,
        FOREIGN KEY(thread_id) REFERENCES threads(id),
        INDEX created_at(created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- GRANT ALL ON *.* TO YourUserName@"localhost"IDENTIFIED BY "YourPassword";
-- ALTER TABLE threads ADD author_name VARCHAR(36);

-- -- # dammy data
insert into threads (id, author_name, title, content, created_at, updated_at) values (1, 'エルボーバット(青森県)','【速報】アニメDVD・BVDの売り上げを見守るスレ14395', 'やあ（´・ω・｀)\nようこそ、スクリプト捕縛スレへ。\nこのチェリーコークはサービスだから、まず飲んで落ち着いて欲しい。','2013-11-23 04:01:14','2013-11-23 04:04:21');
insert into entries (id, thread_id, author_name, content, created_at, updated_at) values (1, 1, 'エルボーバット(青森県)', '>>1\n書き込む前に深呼吸でもしたら？','2013-11-23 04:02:03','2013-11-23 04:02:03');
insert into entries (id, thread_id, author_name, content, created_at, updated_at) values (2, 1, 'フルネルソンスープレックス(家)','>>1\nワロ','2013-11-23 04:03:50','2013-11-23 04:02:03');
insert into entries (id, thread_id, author_name, content, created_at, updated_at) values (3, 1, 'かかと落とし(やわらか銀行)', '>>2\nなんだお前根性なしだな','2013-11-23 04:02:55','2013-11-23 04:02:55');
insert into entries (id, thread_id, author_name, content, created_at, updated_at) values (4, 1, 'エルボーバット(青森県)', '>>3\nアフィサイトなんて「どーでもいい」って立場なんだが','2013-11-23 04:04:21','2013-11-23 04:04:21');

insert into threads (id, author_name, title, content, created_at, updated_at) values (2, 'デンジャラスバックドロップ(チベット自治区)', 'ナポリタンをおかずにご飯がうまい！', 'のり弁当×ナポリタン：ナポリタンをおかずにご飯がうまい！\nほっかほっか亭で「のりナポリタン」限定販売','2013-11-23 00:09:50','2013-11-23 00:13:22');
insert into entries (id, thread_id, author_name, content, created_at, updated_at) values (5, 2, 'トペ コンヒーロ(京都府)', 'J( ｰ`)し「今日は、ゆうすけの大好きなナポリタン丼よ、魚肉ソーセージも入れたから」','2013-11-23 00:11:22','2013-11-23 00:11:22');
insert into entries (id, thread_id, author_name, content, created_at, updated_at) values (6, 2, 'ツームストンパイルドライバー(東京都)', 'ソーセージが親善大使の役割を果たしているから\n炭水×炭水でもOK','2013-11-23 00:13:22','2013-11-23 00:13:22');
insert into entries (id, thread_id, author_name, content, created_at, updated_at) values (7, 2, '足4の字固め(WiMAX)', 'あばずれの喰い物','2013-11-23 00:14:23','2013-11-23 00:14:23');

insert into threads (id, author_name, title, content, created_at, updated_at) values (3, '膝靭帯固め(徳島県)', '日本人は韓国ブランドに興味を示さない・・・なぜ「サムスン」より「アップル」なのか？', '今年1～9月に世界で最多の9000万台近いスマートフォンを売り上げたサムスン電子だが、日本市場では4位に甘んじている。','2013-11-23 11:25:54','2013-11-23 11:28:43');
insert into entries (id, thread_id, author_name, content, created_at, updated_at) values (8, 3, 'かかと落とし(やわらか銀行)', '>>1\nワロス','2013-11-23 11:26:23','2013-11-23 11:26:23');
insert into entries (id, thread_id, author_name, content, created_at, updated_at) values (9, 3, 'ファイヤーボールスプラッシュ(庭)', '安かろう悪かろう','2013-11-23 11:28:32','2013-11-23 11:28:32');
insert into entries (id, thread_id, author_name, content, created_at, updated_at) values (10, 3, 'アンクルホールド(埼玉県)', 'サムスンがアップルを買収すれば売れるんじゃね ','2013-11-23 11:28:43','2013-11-23 11:28:43');

insert into threads (id, author_name, title, content, created_at, updated_at) values (4, 'カーフブランディング(庭)', '今、秋葉原の電気屋の前に行列出来てるんだけど、何かの発売日？', 'ソース\n秋葉原にいる俺 ','2013-11-23 08:02:52','2013-11-23 08:07:43');
insert into entries (id, thread_id, author_name, content, created_at, updated_at) values (11, 4, '稲妻レッグラリアット(愛媛県)', '知らんわｗｗｗ','2013-11-23 08:06:21','2013-11-23 08:06:21');
insert into entries (id, thread_id, author_name, content, created_at, updated_at) values (12, 4, '河津落とし(関東・東海)', 'ドラエフ3','2013-11-23 08:06:48','2013-11-23 08:06:48');
insert into entries (id, thread_id, author_name, content, created_at, updated_at) values (13, 4, '不知火(やわらか銀行)', '箱じゃね','2013-11-23 08:07:43','2013-11-23 08:07:43');



