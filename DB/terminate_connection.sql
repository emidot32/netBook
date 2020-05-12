-- SELECT pg_terminate_backend(pid)  
-- FROM   pg_stat_activity
-- WHERE  usename = 'uftbtbusfgdqit' and client_addr != '195.162.88.160';
select * from pg_stat_activity 
WHERE  usename = 'uftbtbusfgdqit'; 