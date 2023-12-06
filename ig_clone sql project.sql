use ig_clone;

/* 1.We want to reward the user who has been around the longest, Find the 5 oldest users. */

 select username,created_at
 from users
 order by created_at asc
 limit 5;
 
 
/* 2.To target inactive users in an email ad campaign, find the users who have never posted a photo. */

 select username,p.id from users u
 left join photos p
 on u.id=p.user_id
 where p.id is null;
 
 
/* 3.Suppose you are running a contest to find out who got the most likes on a photo. Find out who won? */

 select u.username,p.id,p.image_url,count(*) as total
 from users u
 join photos p
 on u.id=p.user_id
 join likes l
 on l.photo_id=p.id
 group by p.id
 order by total desc
 limit 1;
 
 
/* 4.The investors want to know how many times does the average user post. */
 
 select round ((select count(*) from photos)/ (select count(*) from users),2) as avg_user_post;


/* 5.A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags. */
 
 select t.tag_name, count(tag_name) as total from tags t
 join photo_tags pt
 on pt.tag_id=t.id
 group by tag_name
 order by total desc
 limit 5;


/* 6.To find out if there are bots, find users who have liked every single photo on the site. */
 
 select u.id, u.username, count(u.id) as total_likes_by_user from users u
 join likes l
 on u.id=l.user_id
 group by u.id
 having total_likes_by_user = (select count(*) from photos);
 
 
/* 7.Find the users who have created instagramid in may and select top 5 newest joinees from it ? */
 
 select username, created_at from users
 where month(created_at)=5
 order by created_at desc
 limit 5;
 
 
/* 8.Can you help me find the users whose name starts with c and ends with any number and have posted the photos as well as liked the photos? */
 
 select u.id, username from users u
 join photos p
 on p.user_id=u.id
 join likes l
 on l.photo_id=p.id
 group by username
 having username regexp '^C.*[0-9]';

 
 /* 9.Demonstrate the top 30 usernames to the company who have posted in the range of 3 to 5. */
 
 select username,count(*) as num_of_posts
 from users u
 join photos p
 on u.id=p.user_id
 group by p.user_id
 having count(p.user_id) between 3 and 5
 order by num_of_posts desc
 limit 30;
 
 /* 10.Created an ER diagram*/