-- Questão 1. Gere uma lista de todos os instrutores, mostrando sua ID, nome e número de seções que eles ministraram. Não se esqueça de mostrar o número de seções como 0 para os instrutores que não ministraram qualquer seção. Sua consulta deverá utilizar outer join e não deverá utilizar subconsultas escalares. --
SELECT i.ID, i.name, COUNT(t.sec_id) AS "Number of sections" FROM instructor i LEFT OUTER JOIN teaches t ON i.ID = t.ID GROUP BY i.ID, i.name;

-- Questão 2. Escreva a mesma consulta do item anterior, mas usando uma subconsulta escalar, sem outer join. --
SELECT instructor.ID, instructor.name, (SELECT COUNT(teaches.sec_id) FROM teaches WHERE teaches.ID = instructor.ID) AS "Number of sections" FROM instructor GROUP BY instructor.ID, instructor.name;

-- Questão 3. Gere a lista de todas as seções de curso oferecidas na primavera de 2010, junto com o nome dos instrutores ministrando a seção. Se uma seção tiver mais de 1 instrutor, ela deverá aparecer uma vez no resultado para cada instrutor. Se não tiver instrutor algum, ela ainda deverá aparecer no resultado, com o nome do instrutor definido como “-”. --
SELECT t.course_id, t.sec_id, i.ID AS "ID", t.semester, t.year, CASE WHEN i.name IS NULL THEN '-' ELSE i.name END AS "name" FROM instructor i RIGHT OUTER JOIN teaches t ON i.ID = t.ID WHERE t.year = 2010 AND t.semester = 'Spring' GROUP BY t.course_id, t.sec_id, i.ID, t.semester, t.year, i.name;

-- Questão 4. Suponha que você tenha recebido uma relação grade_points (grade, points), que oferece uma conversão de conceitos (letras) na relação takes para notas numéricas; por exemplo, uma nota “A+” poderia ser especificada para corresponder a 4 pontos, um “A” para 3,7 pontos, e “A-” para 3,4, e “B+” para 3,1 pontos, e assim por diante. 
--Os Pontos totais obtidos por um aluno para uma oferta de curso (section) são definidos como o número de créditos para o curso multiplicado pelos pontos numéricos para a nota que o aluno recebeu. --
--Dada essa relação e o nosso esquema university, escreva: --
--Ache os pontos totais recebidos por aluno, para todos os cursos realizados por ele. --
SELECT student.ID, student.name, course.title, department.dept_name, grade_points.grade, grade_points.points, grade_points.points * course.credits as "Pontos totais" FROM student
INNER JOIN takes ON student.ID = takes.ID
INNER JOIN course ON takes.course_id = course.course_id
INNER JOIN department ON course.dept_name = department.dept_name
INNER JOIN grade_points ON takes.grade = grade_points.grade;

-- Questão 5. Crie uma view a partir do resultado da Questão 4 com o nome “coeficiente_rendimento”. --
CREATE VIEW coeficiente_rendimento AS (SELECT student.ID, student.name, course.title, department.dept_name, grade_points.grade, grade_points.points, grade_points.points * course.credits as "Pontos totais" FROM student
INNER JOIN takes ON student.ID = takes.ID
INNER JOIN course ON takes.course_id = course.course_id
INNER JOIN department ON course.dept_name = department.dept_name
INNER JOIN grade_points ON takes.grade = grade_points.grade);
