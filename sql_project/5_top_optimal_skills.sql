WITH most_in_demand_skills AS (
    SELECT
        skills_dim.skill_id,
        skills,
        COUNT (*) AS count_of_skills
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
        skills_dim.skill_id
),

top_paying_skills AS (
    SELECT
        skills_dim.skill_id,
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
        skills_dim.skill_id
)

SELECT
    most_in_demand_skills.skill_id,
    most_in_demand_skills.skills,
    count_of_skills,
    salary_avg
FROM
    top_paying_skills
INNER JOIN
    most_in_demand_skills ON most_in_demand_skills.skill_id = top_paying_skills.skill_id
WHERE
    count_of_skills > 10
ORDER BY
    salary_avg DESC,
    count_of_skills DESC
LIMIT 25;