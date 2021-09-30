
-- -----------------------------------------------------
-- Insercion en la tabla roles
-- -----------------------------------------------------
INSERT INTO `db_ganadero`.`tbl_rol`
(`rol`,`creation_date`)
VALUES
('Admin Finca',CURDATE()),
('Admin Systema',CURDATE());
-- -----------------------------------------------------
-- insercion tabla user
-- -----------------------------------------------------
INSERT INTO `db_ganadero`.`tbl_user`
(
`user_name`, `document_type`,`document`,`gender`,`email`,`user_password`,
`phone_number`,`creation_date`,`rol_id`
)
VALUES
(
'Pedro','C.C','90852147','Masculino','pedro_ad_fin_@gmail.com','finca123',
'320865478',CURDATE(),1
),
(
'Juan','C.C','50652137','Masculino','juan_ad_fin_@gmail.com','12548',
'310875465',CURDATE(),1
),
(
'Maria','C.C','1015698745','Femenino','maria_admin_@gmail.com','admin12365',
'3208165478',CURDATE(),2
);
-- -----------------------------------------------------
-- insercion tabla farm
-- -----------------------------------------------------
INSERT INTO `db_ganadero`.`tbl_farm`
(
`farm_name`,`nit`,`address`,`owner_farm`,`creation_date`,`id_user`,`rol_id`
)
VALUES
('La palma', '900271860-2','Vereda los pozos','Fernando Marin', CURDATE(),1,1),
('La esperanza', '900265860-5','Vereda Villa Rica','Fernando Marin', CURDATE(),2,1);

-- -----------------------------------------------------
-- insercion tabla iron_mark
-- -----------------------------------------------------
INSERT INTO `db_ganadero`.`tbl_iron_mark`
(`name_own_iron`,`document_own_iron`,`iron_image`,`creation_date`)
VALUES
('Jacinto vesga','50289632','iron_mark1.png',CURDATE()),
('Pedro Vera','325698741','iron_mark2.png',CURDATE()),
('Pablo Bosco','28963258','iron_mark3.png',CURDATE());

-- -----------------------------------------------------
-- insercion tabla purpose
-- -----------------------------------------------------
INSERT INTO `db_ganadero`.`tbl_purpose`
(`type`,`creation_date`)
VALUES
('lechero',CURDATE()),
('carne',CURDATE()),
('doble',CURDATE());
-- -----------------------------------------------------
-- insercion tabla type_won
-- -----------------------------------------------------
INSERT INTO `db_ganadero`.`tbl_type_won`
(`class_won`,`creation_date`)
VALUES
('levante',CURDATE()),
('novillos',CURDATE()),
('terneros',CURDATE()),
('toro',CURDATE()),
('vaca',CURDATE());
-- -----------------------------------------------------
-- insercion tabla incidents
-- -----------------------------------------------------
INSERT INTO `db_ganadero`.`tbl_incidents`
(`incident`,`incident_status`,`creation_date`)
VALUES
('perdida','notas del incidente',CURDATE()),
('traslado','notas del incidente',CURDATE()),
('muerte','notas del incidente',CURDATE()),
('venta','notas del incidente',CURDATE());
-- -----------------------------------------------------
-- insercion tabla won
-- -----------------------------------------------------
INSERT INTO `db_ganadero`.`tbl_won`
(`sex`,`bred`,`age`,`weight`,`photo`,`creation_date`,
`farm_id`,`id_type_won`,`id_purpose`,`id_incident`,
`Iid_mark`
)
VALUES
('toro','Angus',2,500,'angus1.png',CURDATE(),1,2,2,2,1),
('toro','Holstein',1,300,'holstein.png',CURDATE(),2,2,2,4,1),
('vaca','Boran',1,270,'boran.png',CURDATE(),2,3,1,4,3),
('vaca','Cebu',1,270,'cebu.png',CURDATE(),1,1,1,1,3),
('vaca','Chianina',2,400,'cianina.png',CURDATE(),2,1,3,3,2);

-- -----------------------------------------------------
-- Consultas sobre las tablas
-- -----------------------------------------------------

#::::::::::::consultas a una sola tabla::::::::::::::::::::::::

#Consulart todos los registros tabla rol
SELECT * FROM db_ganadero.tbl_rol;

#Consulart todos los registros tabla farm
SELECT * FROM db_ganadero.tbl_farm;

#Consulart todos los registros tabla user
SELECT * FROM db_ganadero.tbl_user;

#Consulart todos los registros tabla iron_mark
SELECT * FROM db_ganadero.tbl_iron_mark;

#Consulart todos los registros tabla purpose
SELECT * FROM db_ganadero.tbl_purpose;

#Consulart todos los registros tabla type_won
SELECT * FROM db_ganadero.tbl_type_won;

#Consulart todos los registros tabla incidents
SELECT * FROM db_ganadero.tbl_incidents;

#Consulart todos los registros tabla won
SELECT * FROM db_ganadero.tbl_won;

#::::::::::::consultas multi tabla::::::::::::::::::::::::
    
#mostrar el administrador del sistema

SELECT 
    tbl_user.user_name, tbl_rol.rol
FROM
    tbl_user
        INNER JOIN
    tbl_rol ON tbl_user.rol_id = tbl_rol.id_rol
WHERE
    tbl_user.rol_id = 2;   
    

#mostrar los administrasdores de las fincas

SELECT 
    tbl_user.user_name, tbl_rol.rol
FROM
    tbl_user
        INNER JOIN
    tbl_rol ON tbl_user.rol_id = tbl_rol.id_rol
WHERE
    tbl_user.rol_id = 1; 


#mostrar el administrador de una finca en particular

SELECT 
    tbl_farm.farm_name, tbl_user.user_name, tbl_rol.rol
FROM
    tbl_farm
        INNER JOIN
    tbl_user ON tbl_farm.id_user = tbl_user.id_user
        INNER JOIN
    tbl_rol ON tbl_user.rol_id = tbl_rol.id_rol
WHERE
    tbl_farm.farm_name = 'La palma';   

    
#mostrar todos los novillos

SELECT 
    tbl_won.id_cow, tbl_type_won.class_won
FROM
    tbl_won
        INNER JOIN
    tbl_type_won ON tbl_won.id_type_won = tbl_type_won.id_type_won
WHERE
    tbl_type_won.id_type_won = 2; 

#Novillos de levante que se encuentren en una finca en particular

SELECT 
    tbl_won.id_cow, tbl_farm.farm_name, tbl_type_won.class_won
FROM
    tbl_won
        INNER JOIN
    tbl_type_won ON tbl_won.id_type_won = tbl_type_won.id_type_won
        INNER JOIN
    tbl_farm ON tbl_won.farm_id = tbl_farm.id_farm
WHERE
    (tbl_farm.farm_name = 'La esperanza'
        AND tbl_won.id_type_won = 1);


#Ganado marcado con un hierro en particular

SELECT 
    tbl_won.id_cow, tbl_iron_mark.iron_image, tbl_iron_mark.name_own_iron
FROM
    tbl_won
        INNER JOIN
    tbl_iron_mark ON tbl_won.Iid_mark = tbl_iron_mark.id_mark
WHERE
    tbl_iron_mark.id_mark = 1;
    
#nombre de la finca, hierro, tipo, ordenados alfabeticamnete por nombre de la finca     

SELECT 
    tbl_won.id_cow,
    tbl_farm.farm_name,
    tbl_type_won.class_won,
    tbl_iron_mark.iron_image,
    tbl_iron_mark.name_own_iron
FROM
    tbl_won
        INNER JOIN
    tbl_type_won ON tbl_won.id_type_won = tbl_type_won.id_type_won
        INNER JOIN
    tbl_farm ON tbl_won.farm_id = tbl_farm.id_farm
        INNER JOIN
    tbl_iron_mark ON tbl_won.Iid_mark = tbl_iron_mark.id_mark
WHERE
    (tbl_farm.farm_name = 'La esperanza'
        AND tbl_won.id_type_won = 3)
ORDER BY tbl_farm.farm_name;       
  
#consultar el ganado de sexo masculino y cierta raza
SELECT sex, bred FROM tbl_won WHERE (sex = 'macho' AND bred = 'Angus');


#consulatar las fincas que administren dos trabajadores Juan o Pedro
SELECT 
    tbl_user.user_name, tbl_rol.rol
FROM
    tbl_user
        INNER JOIN
    tbl_rol ON tbl_user.rol_id = tbl_rol.id_rol
WHERE
    (tbl_user.user_name = 'Pedro'
        OR tbl_user.user_name = 'Juan');

        
#listar administradores de finas cuyos nombres contengan la silaba 'Ju'    
SELECT user_name FROM tbl_user WHERE user_name LIKE "%ju%";  


#actualizar un animal de novillo, toro o vaca
UPDATE tbl_won SET id_type_won=4  WHERE id_cow = 4; 


#actualizar la contraseña de un usuario del sistema
UPDATE tbl_user SET user_password='act 123' WHERE id_user = 1;


#eliminar un animal
DELETE FROM tbl_won WHERE id_cow =5;


#eliminar un usuario del sistema
DELETE FROM tbl_user WHERE id_user =2;


#eliminar un hierro
DELETE FROM tbl_iron_mark WHERE id_mark = 3;



  






















