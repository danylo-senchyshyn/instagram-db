-- drop table
drop table if exists "User" cascade;
drop table if exists "Groups" cascade;
drop table if exists "Group_Members" cascade;
drop table if exists "User_Follows" cascade;
drop table if exists "Messages" cascade;
drop table if exists "Story" cascade;
drop table if exists "Post" cascade;
drop table if exists "Comments" cascade;
drop table if exists "Comment_Likes" cascade;
drop table if exists "Saved_Post" cascade;
drop table if exists "Post_Likes" cascade;

-- Create tables
create table "User"
(
    user_id           serial primary key,
    username          varchar(30)  not null,
    email             varchar(50)  not null unique check (length(email) > 5),
    password          varchar(255) not null check (length(password) >= 8),
    bio               varchar(100) default '',
    profile_photo_url text         default '',
    creation_date     timestamp    default CURRENT_timestamp
);
create table "Groups"
(
    group_id      serial primary key,
    group_name    varchar(30) not null unique,
    creator_id    int         not null,
    creation_date timestamp default CURRENT_timestamp,
    foreign key (creator_id) references "User" (user_id) on delete cascade
);
create table "Group_Members"
(
    group_id      int not null,
    user_id       int not null,
    creation_date timestamp default CURRENT_timestamp,
    primary key (group_id, user_id),
    foreign key (group_id) references "Groups" (group_id) on delete cascade,
    foreign key (user_id) references "User" (user_id) on delete cascade
);
create table "User_Follows"
(
    follower_id   int,
    following_id  int,
    creation_date timestamp default CURRENT_timestamp,
    primary key (follower_id, following_id),
    foreign key (follower_id) references "User" (user_id) on delete cascade,
    foreign key (following_id) references "User" (user_id) on delete cascade
);
create table "Messages"
(
    message_id       serial primary key,
    sender_user_id   int  not null,
    receiver_user_id int  not null,
    message_text     text not null check (length(message_text) <= 1000),
    creation_date    timestamp default CURRENT_timestamp,
    foreign key (sender_user_id) references "User" (user_id) on delete cascade,
    foreign key (receiver_user_id) references "User" (user_id) on delete cascade
);
create table "Story"
(
    story_id      serial primary key,
    image_url     text      default '',
    user_id       int not null,
    creation_date timestamp default CURRENT_timestamp,
    expiry_date   timestamp default (CURRENT_timestamp + interval '24 hours'),
    foreign key (user_id) references "User" (user_id) on delete cascade
);
create table "Post"
(
    post_id       serial primary key,
    user_id       int  not null,
    image_url     text not null,
    description   varchar(100) default '',
    creation_date timestamp    default CURRENT_timestamp,
    foreign key (user_id) references "User" (user_id) on delete cascade
);
create table "Comments"
(
    comment_id    serial primary key,
    user_id       int  not null,
    post_id       int  not null,
    text          text not null check (length(text) <= 500),
    creation_date timestamp default CURRENT_timestamp,
    foreign key (user_id) references "User" (user_id) on delete cascade,
    foreign key (post_id) references "Post" (post_id) on delete cascade
);
create table "Comment_Likes"
(
    user_id       int not null,
    comment_id    int not null,
    creation_date timestamp default CURRENT_timestamp,
    primary key (user_id, comment_id),
    foreign key (user_id) references "User" (user_id) on delete cascade,
    foreign key (comment_id) references "Comments" (comment_id) on delete cascade
);
create table "Saved_Post"
(
    user_id       int not null,
    post_id       int not null,
    creation_date timestamp default CURRENT_timestamp,
    primary key (user_id, post_id),
    foreign key (user_id) references "User" (user_id) on delete cascade,
    foreign key (post_id) references "Post" (post_id) on delete cascade
);
create table "Post_Likes"
(
    user_id       int not null,
    post_id       int not null,
    creation_date timestamp default CURRENT_timestamp,
    primary key (user_id, post_id),
    foreign key (user_id) references "User" (user_id) on delete cascade,
    foreign key (post_id) references "Post" (post_id) on delete cascade
);

-- Insert data
insert into "User" (username, email, password, bio, profile_photo_url, creation_date)
values ('alex_smith', 'alex@example.com', 'alex123password', null, 'https://example.com/alex.jpg', '2010-11-05 10:00:00'),
       ('elena_kova', 'elena@example.com', 'elena123password', 'Food lover', 'https://example.com/elena.jpg', '2012-03-15 10:30:00'),
       ('mike_jones', 'mike@example.com', 'mike9876', 'Gamer', 'https://example.com/mike.jpg', '2014-08-20 11:00:00'),
       ('anna_brown', 'anna@example.com', 'anna1234pass', null, 'https://example.com/anna.jpg', '2016-06-18 11:30:00'),
       ('john_doe', 'john@example.com', 'johnpassword56', 'Music lover', 'https://example.com/john.jpg', '2017-09-10 09:00:00'),
       ('nina_white', 'nina@example.com', 'nina987password', 'Yoga and wellness', 'https://example.com/nina.jpg', '2018-11-12 09:30:00'),
       ('robert_blake', 'robert@example.com', 'robert654password', 'Fitness enthusiast', 'https://example.com/robert.jpg', '2019-02-28 10:00:00'),
       ('laura_miller', 'laura@example.com', 'laura12345pass', 'Travel blogger', 'https://example.com/laura.jpg', '2020-07-25 10:30:00'),
       ('charlie_green', 'charlie@example.com', 'charlie98765', null, 'https://example.com/charlie.jpg', '2021-05-14 12:00:00'),
       ('victoria_black', 'victoria@example.com', 'victoriapassword12', 'Artist', 'https://example.com/victoria.jpg', '2022-01-23 12:30:00'),
       ('leo_ford', 'leo@example.com', 'leo123password', 'Tech innovator', 'https://example.com/leo.jpg', '2023-03-10 13:00:00'),
       ('olivia_white', 'olivia@example.com', 'olivia12345', 'Writer', 'https://example.com/olivia.jpg', '2023-06-20 13:30:00'),
       ('chris_martin', 'chris@example.com', 'chrispassword567', 'Chef', 'https://example.com/chris.jpg', '2023-09-15 09:00:00'),
       ('sofia_garcia', 'sofia@example.com', 'sofia9876password', null, 'https://example.com/sofia.jpg', '2023-11-18 09:30:00'),
       ('daniel_jackson', 'daniel@example.com', 'danielpassword987', 'Photographer', 'https://example.com/daniel.jpg', '2025-03-05 10:00:00');

insert into "Groups" (creator_id, group_name, creation_date)
values (1, 'Tech Innovations', '2011-01-15 10:30:00'),
       (2, 'Food Lovers Unite', '2013-02-14 11:00:00'),
       (3, 'Gaming Community', '2015-04-19 11:30:00'),
       (4, 'Travel Enthusiasts', '2018-08-25 09:30:00'),
       (5, 'Music Lovers', '2019-12-10 10:00:00'),
       (6, 'Yoga and Wellness', '2020-05-15 10:30:00'),
       (7, 'Fitness Crew', '2021-03-10 11:00:00'),
       (8, 'Photography Club', '2022-07-20 12:30:00'),
       (9, 'Art and Culture', '2023-04-18 13:00:00'),
       (10, 'Writers Hub', '2023-08-16 13:30:00'),
       (11, 'Culinary World', '2024-03-20 09:30:00'),
       (12, 'Beauty Gurus', '2024-10-25 10:00:00'),
       (13, 'Photography Enthusiasts', '2025-01-10 10:30:00'),
       (14, 'Food and Travel', '2025-02-12 11:00:00'),
       (15, 'Tech and Innovation', '2025-03-05 12:00:00');

insert into "Group_Members" (group_id, user_id, creation_date)
values (1, 1, '2011-01-15 10:45:00'),
       (2, 2, '2013-02-14 11:15:00'),
       (3, 3, '2015-04-19 11:45:00'),
       (4, 4, '2018-08-25 09:45:00'),
       (5, 5, '2019-12-10 10:15:00'),
       (6, 6, '2020-05-15 10:45:00'),
       (7, 7, '2021-03-10 11:15:00'),
       (8, 8, '2022-07-20 13:15:00'),
       (9, 9, '2023-04-18 13:45:00'),
       (10, 10, '2023-08-16 14:15:00'),
       (11, 11, '2024-03-20 10:15:00'),
       (12, 12, '2024-10-25 10:45:00'),
       (13, 13, '2025-01-10 11:15:00'),
       (14, 14, '2025-02-12 11:45:00'),
       (15, 15, '2025-03-05 12:15:00');

insert into "User_Follows" (follower_id, following_id, creation_date)
values (1, 6, '2010-10-06 08:30:00'),
       (2, 7, '2011-01-15 14:45:00'),
       (3, 8, '2012-03-20 09:15:00'),
       (4, 9, '2013-07-25 19:20:00'),
       (5, 10, '2015-02-13 10:50:00'),
       (6, 11, '2016-06-05 21:05:00'),
       (7, 12, '2017-10-11 18:25:00'),
       (8, 13, '2019-01-30 11:40:00'),
       (9, 14, '2021-03-15 23:10:00'),
       (10, 15, '2023-07-20 13:35:00'),
       (11, 1, '2023-09-01 15:00:00'),
       (12, 2, '2023-12-19 09:25:00'),
       (13, 3, '2024-05-11 10:50:00'),
       (14, 4, '2024-08-22 17:30:00'),
       (15, 5, '2025-03-26 16:10:00');

insert into "Messages" (sender_user_id, receiver_user_id, message_text, creation_date)
values (1, 6, 'How do you stay fit?', '2010-10-06 08:25:00'),
       (2, 7, 'What’s your favorite dish to cook?', '2011-01-15 14:40:00'),
       (3, 8, 'Got any gaming tips?', '2012-03-20 09:10:00'),
       (4, 9, 'Have you been to Europe?', '2013-07-25 19:15:00'),
       (5, 10, 'What music are you into these days?', '2015-02-13 10:45:00'),
       (6, 11, 'How do you take such great pictures?', '2016-06-05 21:00:00'),
       (7, 12, 'Any new fitness trends?', '2017-10-11 18:20:00'),
       (8, 13, 'Tell me about your latest trip!', '2019-01-30 11:35:00'),
       (9, 14, 'When you travel, do you prefer trying new foods from different cultures, or do you stick to familiar dishes?', '2021-03-15 23:05:00'),
       (10, 15, 'There are so many new tech gadgets coming out lately! What is the most exciting one you have seen or want to try?', '2023-07-20 13:30:00'),
       (11, 1, 'Do you write poetry?', '2023-09-01 14:55:00'),
       (12, 2, 'Makeup trends change so fast! Do you prefer a natural look, or do you like experimenting with bold and colorful styles?', '2023-12-19 09:20:00'),
       (13, 3, 'What camera do you use?', '2024-05-11 10:45:00'),
       (14, 4, 'What’s your favorite dish to cook?', '2024-08-22 17:25:00'),
       (15, 5, 'Do you have any tech recommendations?', '2025-03-26 16:05:00');

insert into "Story" (user_id, image_url, creation_date, expiry_date)
values (1, 'https://example.com/story6.jpg', '2010-10-06 08:35:00', '2010-10-07 08:35:00'),
       (2, 'https://example.com/story7.jpg', '2011-01-15 14:50:00', '2011-01-16 14:50:00'),
       (3, 'https://example.com/story8.jpg', '2012-03-20 09:20:00', '2012-03-21 09:20:00'),
       (4, 'https://example.com/story9.jpg', '2013-07-25 19:25:00', '2013-07-26 19:25:00'),
       (5, 'https://example.com/story10.jpg', '2015-02-13 11:00:00', '2015-02-14 11:00:00'),
       (6, 'https://example.com/story11.jpg', '2016-06-05 21:10:00', '2016-06-06 21:10:00'),
       (7, 'https://example.com/story12.jpg', '2017-10-11 18:30:00', '2017-10-12 18:30:00'),
       (8, 'https://example.com/story13.jpg', '2019-01-30 11:50:00', '2019-01-31 11:50:00'),
       (9, 'https://example.com/story14.jpg', '2021-03-15 23:15:00', '2021-03-16 23:15:00'),
       (10, 'https://example.com/story15.jpg', '2023-07-20 13:40:00', '2023-07-21 13:40:00'),
       (11, 'https://example.com/story16.jpg', '2023-09-01 15:10:00', '2023-09-02 15:10:00'),
       (12, 'https://example.com/story17.jpg', '2023-12-19 09:30:00', '2023-12-20 09:30:00'),
       (13, 'https://example.com/story18.jpg', '2024-05-11 10:55:00', '2024-05-12 10:55:00'),
       (14, 'https://example.com/story19.jpg', '2024-08-22 17:35:00', '2024-08-23 17:35:00'),
       (15, 'https://example.com/story20.jpg', '2025-03-26 16:15:00', '2025-03-27 16:15:00');


insert into "Post" (user_id, image_url, description, creation_date)
values (1, 'https://example.com/post6.jpg', 'Morning hike', '2010-10-06 12:30:00'),
       (2, 'https://example.com/post7.jpg', 'Delicious dessert', '2012-03-15 13:00:00'),
       (3, 'https://example.com/post8.jpg', 'Adventure awaits', '2014-08-23 13:30:00'),
       (4, 'https://example.com/post9.jpg', null, '2016-05-10 10:30:00'),
       (5, 'https://example.com/post10.jpg', 'Relaxing with music', '2017-11-18 11:00:00'),
       (5, 'https://example.com/post11.jpg', 'Morning yoga session', '2018-06-25 11:30:00'),
       (7, 'https://example.com/post12.jpg', 'Fitness progress', '2019-02-14 12:00:00'),
       (7, 'https://example.com/post13.jpg', 'Cityscape', '2020-09-30 12:30:00'),
       (9, 'https://example.com/post14.jpg', null, '2021-05-22 13:00:00'),
       (10, 'https://example.com/post15.jpg', 'Exploring new tech', '2022-01-15 13:30:00'),
       (10, 'https://example.com/post16.jpg', 'Photography gear', '2023-03-10 10:30:00'),
       (12, 'https://example.com/post17.jpg', 'Makeup transformation', '2023-06-12 11:00:00'),
       (13, 'https://example.com/post18.jpg', 'Night sky photography', '2023-09-08 11:30:00'),
       (13, 'https://example.com/post19.jpg', null, '2023-11-22 12:00:00'),
       (13, 'https://example.com/post20.jpg', 'Tech gadget review', '2024-02-14 12:30:00');

insert into "Comments" (user_id, post_id, text, creation_date)
values (1, 15, 'Great tech review!', '2010-10-06 12:45:00'),
       (2, 1, 'Stunning view!', '2012-03-15 13:15:00'),
       (3, 2, 'Looks amazing!', '2014-08-23 13:45:00'),
       (4, 3, 'Where was this taken?', '2016-05-10 10:45:00'),
       (5, 4, 'This is beautiful!', '2017-11-18 11:15:00'),
       (6, 5, 'Love the vibe!', '2018-06-25 11:45:00'),
       (7, 6, 'Great session!', '2019-02-14 12:15:00'),
       (8, 7, 'Great progress!', '2020-09-30 12:45:00'),
       (9, 8, 'Amazing cityscape!', '2021-05-22 13:15:00'),
       (10, 9, 'Food looks so good!', '2022-01-15 13:45:00'),
       (11, 10, 'Tech looks impressive!', '2023-03-10 10:45:00'),
       (12, 11, 'Cool equipment!', '2023-06-12 11:15:00'),
       (13, 12, 'Amazing transformation!', '2023-09-08 11:45:00'),
       (14, 13, 'Such a beautiful shot!', '2023-11-22 12:15:00'),
       (15, 14, 'Healthy meals look great!', '2024-02-14 12:45:00');

insert into "Comment_Likes" (user_id, comment_id, creation_date)
values (1, 1, '2010-10-06 13:00:00'),
       (2, 2, '2012-03-15 13:30:00'),
       (3, 3, '2014-08-23 14:00:00'),
       (4, 4, '2016-05-10 11:00:00'),
       (5, 5, '2017-11-18 11:30:00'),
       (6, 5, '2018-06-25 12:00:00'),
       (7, 5, '2019-02-14 12:30:00'),
       (8, 8, '2020-09-30 13:00:00'),
       (9, 9, '2021-05-22 13:30:00'),
       (10, 10, '2022-01-15 14:00:00'),
       (11, 11, '2023-03-10 11:00:00'),
       (12, 12, '2023-06-12 11:30:00'),
       (13, 12, '2023-09-08 12:00:00'),
       (14, 14, '2023-11-22 12:30:00'),
       (15, 15, '2024-02-14 13:00:00');

insert into "Saved_Post" (user_id, post_id, creation_date)
values (1, 1, '2010-10-06 13:10:00'),
       (2, 2, '2012-03-15 13:40:00'),
       (3, 3, '2014-08-23 14:10:00'),
       (4, 4, '2016-05-10 11:10:00'),
       (5, 5, '2017-11-18 11:40:00'),
       (6, 6, '2018-06-25 12:10:00'),
       (7, 7, '2019-02-14 12:40:00'),
       (8, 8, '2020-09-30 13:10:00'),
       (9, 9, '2021-05-22 13:40:00'),
       (10, 10, '2022-01-15 14:10:00'),
       (11, 11, '2023-03-10 11:10:00'),
       (12, 12, '2023-06-12 11:40:00'),
       (13, 13, '2023-09-08 12:10:00'),
       (14, 14, '2023-11-22 12:40:00'),
       (15, 15, '2024-02-14 13:10:00');

insert into "Post_Likes" (user_id, post_id, creation_date)
values (1, 1, '2010-10-06 13:10:00'),
       (2, 2, '2012-03-15 13:40:00'),
       (3, 3, '2014-08-23 14:10:00'),
       (4, 4, '2016-05-10 11:10:00'),
       (5, 5, '2017-11-18 11:40:00'),
       (6, 6, '2018-06-25 12:10:00'),
       (7, 7, '2019-02-14 12:40:00'),
       (8, 8, '2020-09-30 13:10:00'),
       (9, 9, '2021-05-22 13:40:00'),
       (10, 10, '2022-01-15 14:10:00'),
       (11, 10, '2023-03-10 11:10:00'),
       (12, 10, '2023-06-12 11:40:00'),
       (13, 13, '2023-09-08 12:10:00'),
       (14, 13, '2023-11-22 12:40:00'),
       (15, 15, '2024-02-14 13:10:00');

-- Views
-- Nájdite všetkých používateľov, ktorí majú vyplnený svoj životopis (bio).
drop view if exists users_with_bio;
create view users_with_bio as
select
    user_id,
    username,
    bio
from "User"
where bio <> '';

-- Nájdite všetky správy, ktoré majú viac ako 100 znakov.
drop view if exists long_messages;
create view long_messages as
select  message_text,
        message_id,
        sender_user_id,
        receiver_user_id,
        length(message_text) as message_length,
        to_char(creation_date, 'dd.mm.yyyy hh24:mi:ss') as creation_date
from "Messages"
where length(message_text) > 100
order by message_length desc;

-- Zobrazte zoznam komentárov spolu s menami používateľov, ktorí ich napísali.
drop view if exists comments_with_authors;
create view comments_with_authors as
select c.comment_id,
       u.username,
       c.text,
       to_char(c.creation_date, 'dd.mm.yyyy hh24:mi:ss') as creation_date
from "Comments" c
         join "User" u on c.user_id = u.user_id
order by c.creation_date;

-- Zobrazte lajky na príspevky spolu s informáciami o príspevkoch a používateľoch.
drop view if exists post_likes_details;
create view post_likes_details as
select pl.user_id as liker_id,
       u.username as liker_name,
       pl.post_id,
       p.image_url,
       p.description,
       to_char(pl.creation_date, 'dd.mm.yyyy hh24:mi:ss') as like_date
from "Post_Likes" pl
         join "User" u on pl.user_id = u.user_id
         join "Post" p on pl.post_id = p.post_id
order by pl.creation_date desc;

-- Zobrazte všetkých používateľov a ich sledovateľov. Ak používateľ nemá sledovateľov, stále sa zobrazí v zozname.
drop view if exists users_with_followers;
create view users_with_followers as
select
    u.user_id,
    u.username,
    uf.follower_id,
    follower.username as follower_name,
    to_char(uf.creation_date, 'dd.mm.yyyy hh24:mi:ss') as follow_date
from "User" u
         join "User_Follows" uf on u.user_id = uf.following_id
         left join "User" follower on uf.follower_id = follower.user_id;

-- Spočítajte počet príspevkov pre každého používateľa.
drop view if exists user_post_count;
create view user_post_count as
select u.user_id,
       u.username,
       count(p.post_id) as post_count
from "User" u
         left join "Post" p on u.user_id = p.user_id
group by u.user_id, u.username
order by post_count desc;

-- Nájdite top 5 používateľov s najväčším počtom lajkov na príspevkoch.
drop view if exists top_liked_users;
create view top_liked_users as
select u.user_id,
       u.username,
       count(pl.post_id) as total_likes
from "User" u
         join "Post" p on u.user_id = p.user_id
         join "Post_Likes" pl on p.post_id = pl.post_id
group by u.user_id, u.username
order by total_likes desc
    limit 5;