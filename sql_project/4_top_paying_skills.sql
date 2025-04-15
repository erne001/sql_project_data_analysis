SELECT
    skills,
    ROUND(AVG(salary_year_avg)) AS salary_avg
FROM
    job_postings_fact
INNER JOIN
    skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN
    skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
    AND job_work_from_home = true
GROUP BY
    skills
ORDER BY
    salary_avg DESC
LIMIT 5;