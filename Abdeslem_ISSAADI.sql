-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le :  sam. 02 mai 2026 à 13:31
-- Version du serveur :  5.7.17
-- Version de PHP :  7.1.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `evmi`
--

DELIMITER $$
--
-- Procédures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `aff_cl` ()  NO SQL
BEGIN
SELECT * FROM clients;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `aff_cm` ()  NO SQL
BEGIN
SELECT * FROM commandes;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `aff_fc` ()  NO SQL
BEGIN
SELECT * FROM factures;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `aff_fr` ()  NO SQL
BEGIN
SELECT * FROM fournisseurs;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `aff_list_produit` ()  NO SQL
BEGIN
SELECT * FROM produits;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `aft_com_ins` (IN `ref` VARCHAR(15), IN `qnt` INT)  NO SQL
BEGIN
UPDATE `produits` SET `Qso_pr`= `Qso_pr`-qnt WHERE `Ref_pr`=ref;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Ajout_client` (IN `Cod_cl` VARCHAR(15), IN `Nom_cl` VARCHAR(15), IN `Pre_cl` VARCHAR(15), IN `Adr_cl` TEXT, IN `Nte_cl` VARCHAR(15), IN `Nfa_cl` VARCHAR(15), IN `Mal_cl` VARCHAR(20))  NO SQL
BEGIN INSERT INTO `clients`(`Cod_cl`,`Nom_cl`,`Pre_cl`,`Adr_cl`,`Nte_cl`,`Nfa_cl`,`Mal_cl`) VALUES (Cod_cl,Nom_cl,Pre_cl,Adr_cl,Nte_cl,Nfa_cl,Mal_cl);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Ajout_comande` (IN `num` VARCHAR(15), IN `date` DATE, IN `cod` VARCHAR(15))  NO SQL
BEGIN
INSERT INTO `commandes`(`Num_cm`, `Dat_cm`, `Cod_cl`) VALUES (num,date,cod) ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Ajout_facture` (IN `num` VARCHAR(15), IN `date` DATE, IN `code` VARCHAR(15), IN `numc` VARCHAR(15))  NO SQL
BEGIN
INSERT INTO `factures`(`Num_fc`, `Dat_fc`, `Cod_cl`, `Num_cm`) VALUES (num,date,code,numc);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Ajout_fournis` (IN `codef` VARCHAR(15), IN `nomf` VARCHAR(15), IN `pren` VARCHAR(15), IN `adrf` TEXT, IN `ntf` VARCHAR(15), IN `ntff` VARCHAR(15))  NO SQL
BEGIN
INSERT INTO `fournisseurs`(`Cod_fs`, `Nom_fs`, `Pre_fs`, `Adr_fs`, `Nte_fs`, `Nfa_fs`) VALUES (codef,nomf,pren,adrf,ntf,ntff);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Ajout_produit` (IN `Refp` VARCHAR(15), IN `desp` VARCHAR(15), IN `punp` INT, IN `tva` INT, IN `pacp` INT, IN `Qso_pr` INT)  NO SQL
BEGIN 
INSERT INTO `produits`(`Ref_pr`, `Des_pr`, `Pun_pr`, `Tva_pr`, `Pac_pr`, `Qso_pr`) VALUES (Refp,desp,punp,tva,pacp,Qso_pr) ;



END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ajt_pr_coman` (IN `numf` VARCHAR(15), IN `refp` VARCHAR(15), IN `qntl` INT)  NO SQL
BEGIN
INSERT INTO `concerner`(`Ref_pr`,`Num_cm`,`Qan_cm`) VALUES (numf,refp,qntl);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ajt_pr_fc` (IN `num` VARCHAR(15), IN `ref` VARCHAR(15), IN `qnt` INT)  NO SQL
BEGIN
INSERT INTO `comporter`(`Ref_pr`,`Num_fc`, `Qan_lv`) VALUES (num,ref,qnt);
CALL`aft_com_ins`(ref,qnt);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ajt_pr_fr` (IN `cod` VARCHAR(15), IN `ref` VARCHAR(15), IN `pri` INT)  NO SQL
BEGIN
INSERT INTO `fournir`(`Cod_fs`,`Ref_pr`,`Pac_pr`) VALUES (cod,ref,pri);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ajt_qnts` (IN `qnt` INT, IN `ref` VARCHAR(15))  NO SQL
BEGIN
UPDATE `produits` SET `Qso_pr`= `Qso_pr`+qnt WHERE `Ref_pr`=ref;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cherch_client` (IN `cod` VARCHAR(15))  NO SQL
BEGIN
SELECT * FROM `clients` WHERE `Cod_cl`=cod;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cherch_cm` (IN `num` VARCHAR(15))  NO SQL
BEGIN
SELECT * FROM `commandes` WHERE `Num_cm`=num;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cherch_fc` (IN `cod` VARCHAR(15))  NO SQL
BEGIN
SELECT * FROM `factures` WHERE `Num_fc`=cod;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cherch_fr` (IN `cod` VARCHAR(15))  NO SQL
BEGIN
SELECT * FROM `fournisseurs` WHERE `Cod_fs`=cod;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cherch_produit` (IN `cod` VARCHAR(15))  NO SQL
BEGIN
SELECT * FROM `produits` WHERE `Ref_pr`=cod;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cl_cm` (IN `num` VARCHAR(15))  NO SQL
BEGIN
SELECT * FROM commandes WHERE Cod_cl=num;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cl_fc` (IN `num` VARCHAR(15))  NO SQL
BEGIN
SELECT * FROM `factures`,`total` WHERE `Cod_cl`=num;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cl_pr` (IN `ref` VARCHAR(15))  NO SQL
BEGIN
SELECT * FROM clients WHERE Cod_cl IN (SELECT Cod_cl FROM factures WHERE Num_fc IN (SELECT Num_fc FROM comporter WHERE Ref_pr=ref));
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cm_cl` (IN `num` VARCHAR(15))  NO SQL
BEGIN
SELECT * FROM clients WHERE Cod_cl=(SELECT `Cod_cl` FROM commandes WHERE Num_cm=num);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cm_pr` (IN `num` VARCHAR(15))  NO SQL
BEGIN
SELECT Ref_pr FROM concerner WHERE Num_cm=num;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `commende_de_produit` (IN `num` VARCHAR(15))  NO SQL
BEGIN
SELECT Num_cm FROM concerner WHERE Ref_pr=num;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `commende_fc` (IN `num` VARCHAR(15))  NO SQL
BEGIN
SELECT Num_cm FROM lesfactures WHERE Num_fc=num;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `conecter_emp` (IN `log` VARCHAR(15), IN `mdp` VARCHAR(15))  NO SQL
BEGIN
SELECT * FROM `emplyer` WHERE (`Log_emp`=log) AND(`Mdp_emp`=mdp);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `facture_commende` (IN `num` VARCHAR(15))  NO SQL
BEGIN
SELECT * FROM factures WHERE Num_cm=num;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `fc_cl` (IN `num` VARCHAR(15))  NO SQL
BEGIN
SELECT `Cod_cl`  FROM `factures` WHERE `Num_fc`=num;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lesfournisseurdeproduit` (IN `ref` VARCHAR(15))  NO SQL
BEGIN
SELECT * FROM `fournisseurs` WHERE `Cod_fs`IN (SELECT `Cod_fs` FROM `fournir` WHERE `Ref_pr`=ref);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `les_facture_de_produit` (IN `num` VARCHAR(15))  NO SQL
BEGIN
SELECT Num_fc FROM comporter WHERE Ref_pr=num;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `modifier_client` (IN `cod` VARCHAR(15), IN `nom` VARCHAR(15), IN `pre` VARCHAR(15), IN `adr` TEXT, IN `nt` VARCHAR(15), IN `nf` VARCHAR(15), IN `mal` VARCHAR(15))  NO SQL
BEGIN
UPDATE `clients` SET `Nom_cl`=nom,`Pre_cl`=pre,`Adr_cl`=adr,`Nte_cl`=nt,`Nfa_cl`=nf,`Mal_cl`=mal WHERE `Cod_cl`=cod;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `modifier_cm` (IN `cod` VARCHAR(15), IN `date` VARCHAR(15), IN `num` VARCHAR(15))  NO SQL
UPDATE `commandes` SET `Num_cm`=cod,`Dat_cm`=date,`Cod_cl`=num WHERE `Num_cm`=cod$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `modifier_fr` (IN `cod` VARCHAR(15), IN `nom` VARCHAR(15), IN `pre` VARCHAR(15), IN `adr` TEXT, IN `ntf` VARCHAR(15), IN `nf` VARCHAR(15))  NO SQL
BEGIN
UPDATE `fournisseurs` SET `Nom_fs`=nom,`Pre_fs`=pre,`Adr_fs`=adr,`Nte_fs`=ntf,`Nfa_fs`=nf WHERE `Cod_fs`=cod;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `modifier_produit` (IN `cod` VARCHAR(15), IN `des` VARCHAR(15), IN `pr` INT, IN `tva` INT, IN `tpa` INT, IN `qs` INT)  NO SQL
UPDATE `produits` SET `Des_pr`=des,`Pun_pr`=pr,`Tva_pr`=tva,`Pac_pr`=tpa,`Qso_pr`=qs WHERE `Ref_pr`=cod$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Net_pay` (IN `num` VARCHAR(15), OUT `NP` INT)  NO SQL
BEGIN
SELECT total INTO NP FROM total WHERE Num_fc=num;
IF (NP>10000) THEN 
SET NP=NP-NP*0.1;
END IF;
SELECT NP AS `net a payer`;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `produit_facture` (IN `num` VARCHAR(15))  NO SQL
BEGIN
SELECT `Ref_pr` FROM `comporter` WHERE `Num_fc`=num;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pr_fournisseur` (IN `cod` VARCHAR(15))  NO SQL
BEGIN
SELECT * FROM `produits` WHERE `Ref_pr`IN (SELECT `Ref_pr` FROM `fournir` WHERE `Cod_fs`=cod);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Sup_client` (IN `Code` VARCHAR(15))  NO SQL
BEGIN
DELETE FROM `clients` WHERE `Cod_cl`=`Code`;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Sup_comande` (IN `num` VARCHAR(15))  NO SQL
BEGIN
DELETE FROM `commandes` WHERE `Num_cm`=`num`;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Sup_facture` (IN `num` VARCHAR(15))  NO SQL
BEGIN
DELETE FROM `factures` WHERE Num_fc=num;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Sup_fournis` (IN `cod` VARCHAR(15))  NO SQL
BEGIN
DELETE FROM `fournisseurs` WHERE Cod_fs=cod;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Sup_produit` (IN `Refp` VARCHAR(15))  NO SQL
BEGIN

DELETE FROM `produits` WHERE Ref_pr=Refp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `thtdunefc` (IN `num` VARCHAR(15))  NO SQL
BEGIN
SELECT tht FROM tht WHERE Num_fc=num;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `total` (IN `cod` VARCHAR(15))  NO SQL
BEGIN
SELECT total FROM total WHERE Num_fc=cod;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ttcdunefc` (IN `num` VARCHAR(15))  NO SQL
BEGIN
SELECT TTC FROM ttc WHERE Num_fc=num;
END$$

--
-- Fonctions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `calcul_np` (`num` VARCHAR(15)) RETURNS DECIMAL(10,0) NO SQL
BEGIN
SELECT total INTO @NP FROM total WHERE Num_fc=num;
IF (@NP>10000) THEN 
SET @NP=@NP-@NP*0.1;
 END IF;
    RETURN @NP;
    END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `nbr_cl` () RETURNS INT(10) NO SQL
BEGIN
SELECT COUNT(Cod_cl) INTO @nc FROM clients;
RETURN @nc;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `nbr_cm` () RETURNS INT(10) NO SQL
BEGIN
SELECT COUNT(Num_cm) INTO @cm FROM commandes;
RETURN @cm;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `nbr_cm_cl` (`cod` VARCHAR(15)) RETURNS INT(10) NO SQL
BEGIN
SELECT COUNT(Num_cm) INTO @ncc FROM commandes WHERE Cod_cl=cod ;
RETURN @ncc;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `nbr_cm_fc` (`num` VARCHAR(15)) RETURNS INT(10) NO SQL
BEGIN
SELECT Num_cm INTO @nfc FROM factures WHERE Num_fc=num;
RETURN @nfc;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `nbr_fac` () RETURNS INT(11) NO SQL
BEGIN
SELECT COUNT(Num_fc) INTO @nf FROM factures;
RETURN @nf;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `nbr_fc_cl` (`cod` VARCHAR(15)) RETURNS INT(11) NO SQL
BEGIN
SELECT COUNT(Num_fc) INTO @nfc FROM factures WHERE Cod_cl=cod ;
RETURN @nfc;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `nbr_fc_cm` (`num` VARCHAR(15)) RETURNS INT(11) NO SQL
BEGIN
SELECT COUNT(Num_fc) INTO @nfc FROM factures WHERE Num_cm=num;
RETURN @nfc;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `nbr_four` () RETURNS INT(11) NO SQL
BEGIN
SELECT COUNT(Cod_fs) INTO @fr FROM fournisseurs;
RETURN @fr;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `nbr_pr` () RETURNS INT(11) NO SQL
BEGIN
SELECT COUNT(Ref_pr) INTO @np FROM produits;
RETURN @np;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `nbr_pr_cm` (`num` VARCHAR(15)) RETURNS INT(10) NO SQL
BEGIN
SELECT COUNT(Ref_pr) INTO @np FROM concerner WHERE Num_cm=num;
RETURN @np;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `nbr_pr_fc` (`num` VARCHAR(15)) RETURNS INT(10) NO SQL
BEGIN
SELECT COUNT(Ref_pr) INTO @npf FROM comporter WHERE Num_fc=num;
RETURN @npf;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `recette` () RETURNS DECIMAL(10,0) NO SQL
BEGIN
SELECT SUM(`net a payer`) INTO @rec FROM nap ;
RETURN  @rec;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `achet`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `achet` (
`Cod_fs` varchar(15)
,`Ref_pr` varchar(15)
,`Pac_pr` int(11)
);

-- --------------------------------------------------------

--
-- Structure de la table `administrateur`
--

CREATE TABLE `administrateur` (
  `Id_Adm` varchar(15) NOT NULL,
  `Nom_Adm` varchar(15) NOT NULL,
  `Pre_Adm` varchar(15) NOT NULL,
  `Log_Adm` varchar(15) NOT NULL,
  `Mdp_Adm` varchar(15) NOT NULL,
  `Cod_sys` varchar(15) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `administrateur`
--

INSERT INTO `administrateur` (`Id_Adm`, `Nom_Adm`, `Pre_Adm`, `Log_Adm`, `Mdp_Adm`, `Cod_sys`) VALUES
('C1', 'ahmed', 'anis', 'ahmed_anis', 'ahmed123', 'S1'),
('C2', 'salah', 'issaadi', 'salah_issaadi', 'salah123', 'S2'),
('C3', 'djamel', 'dine', 'djamel_dine', 'djamel123', 'S3'),
('C4', 'karim', 'abas', 'karim_abas', 'karim123', 'S4'),
('C5', 'bousal', 'hamid', 'bousal_hamid', 'bousal123', 'S5');

-- --------------------------------------------------------

--
-- Structure de la table `archiffe`
--

CREATE TABLE `archiffe` (
  `Ref_pr` varchar(15) NOT NULL,
  `Des_pr` varchar(15) NOT NULL,
  `Pun_pr` int(11) NOT NULL,
  `Tva_pr` int(11) NOT NULL,
  `Pac_pr` int(11) NOT NULL,
  `Qso_pr` int(11) NOT NULL,
  `Nom_Fam` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `archiffe`
--

INSERT INTO `archiffe` (`Ref_pr`, `Des_pr`, `Pun_pr`, `Tva_pr`, `Pac_pr`, `Qso_pr`, `Nom_Fam`) VALUES
('R003', 'a5', 6577, 4, 10, 2, 'ibiza'),
('123', 'a5', 6577, 4, 10, 2, 'flash disk');

-- --------------------------------------------------------

--
-- Structure de la table `clients`
--

CREATE TABLE `clients` (
  `Cod_cl` varchar(15) NOT NULL,
  `Nom_cl` varchar(15) NOT NULL,
  `Pre_cl` varchar(15) NOT NULL,
  `Adr_cl` text NOT NULL,
  `Nte_cl` varchar(15) NOT NULL,
  `Nfa_cl` varchar(15) NOT NULL,
  `Mal_cl` varchar(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `clients`
--

INSERT INTO `clients` (`Cod_cl`, `Nom_cl`, `Pre_cl`, `Adr_cl`, `Nte_cl`, `Nfa_cl`, `Mal_cl`) VALUES
('C001', 'boussaha', 'mouhamed', 'alger,1600', '0727898445', '036989078', 'boussaha@yahoo.fr'),
('C002', 'issaadi', 'djhf', 'fihf', '09895', '238009652', 'sl7528660@gmail.com'),
('C003', 'khaloufi', 'raouf', 'b.b.a,34000', '067179401', '025122454', 'khaloufi@yahoo.fr'),
('C006\r\n         ', 'ahmed', 'aniss', 'setif', '075000120', '032191156', 'ahmed@yahoo.fr'),
('C007', 'laba', 'ali', 'oran', '055641258', '04902341', 'laba@yahoo.fr'),
('191935058471', 'issaadi', 'abdeslem', 'setif', '0665847140', '022896314', 'sl7528660@gmail.com'),
('123', 'ilyess', 'ana', 'paris', '00335897463', '00235879', 'ab@gmail.com'),
('191935045158', 'ahmed', 'anis', 'oran', '0557', '444', 'sl7528660@gmail.com');

--
-- Déclencheurs `clients`
--
DELIMITER $$
CREATE TRIGGER `aft_cli_del` AFTER DELETE ON `clients` FOR EACH ROW BEGIN
DELETE FROM commandes WHERE Cod_cl=old.Cod_cl;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `commandes`
--

CREATE TABLE `commandes` (
  `Num_cm` varchar(15) NOT NULL,
  `Dat_cm` date NOT NULL,
  `Cod_cl` varchar(15) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `commandes`
--

INSERT INTO `commandes` (`Num_cm`, `Dat_cm`, `Cod_cl`) VALUES
('004', '2010-10-10', 'C002'),
('010', '2014-11-14', 'C001'),
('005', '2021-09-11', 'C005'),
('006', '2021-01-14', 'C006'),
('008', '2021-01-14', 'C006'),
('009', '2021-07-14', 'C007'),
('007', '2021-07-17', 'C001'),
('789', '2011-11-11', 'C002'),
('0099', '2012-12-12', 'C002');

--
-- Déclencheurs `commandes`
--
DELIMITER $$
CREATE TRIGGER `aft_com_del` AFTER DELETE ON `commandes` FOR EACH ROW BEGIN
DELETE FROM factures WHERE Num_cm=old.Num_cm;
DELETE FROM concerner WHERE Num_cm=old.Num_cm;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `comporter`
--

CREATE TABLE `comporter` (
  `Ref_pr` varchar(15) NOT NULL,
  `Num_fc` varchar(15) NOT NULL,
  `Qan_lv` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `comporter`
--

INSERT INTO `comporter` (`Ref_pr`, `Num_fc`, `Qan_lv`) VALUES
('R003', '1865', 87),
('R001', '1200', 159),
('', 'R011', 78),
('R006', '1865', 1),
('R007', '1200', 12),
('R008', '1200', 178),
('R009', '1865', 15),
('R011', '1200', 230),
('006', '1865', 15256489),
('R001', '1865', 10),
('R002', '1865', 10),
('1865', 'R003', 10),
('R004', '1865', 1),
('R005', '1865', 1),
('', 'R005', 150),
('1000', 'R001', 14),
('R006', '1200', 5),
('R001', '2000', 18888),
('R004', '2021', 11);

--
-- Déclencheurs `comporter`
--
DELIMITER $$
CREATE TRIGGER `aft_comport_ins` AFTER INSERT ON `comporter` FOR EACH ROW BEGIN
UPDATE `produits` SET `Qso_pr`=`Qso_pr`- new.`Qan_lv` WHERE `Ref_pr`=new.`Ref_pr`;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `concerner`
--

CREATE TABLE `concerner` (
  `Ref_pr` varchar(15) NOT NULL,
  `Num_cm` int(15) NOT NULL,
  `Qan_cm` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `concerner`
--

INSERT INTO `concerner` (`Ref_pr`, `Num_cm`, `Qan_cm`) VALUES
('R010', 6, 11),
('R003', 9, 14),
('R002', 99, 7777),
('R002', 789, 159),
('R008', 6, 21),
('R006', 789, 15),
('R003', 5, 45),
('R006', 4, 78),
('R001', 4, 15);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `datecommende`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `datecommende` (
`Dat_cm` date
);

-- --------------------------------------------------------

--
-- Structure de la table `factures`
--

CREATE TABLE `factures` (
  `Num_fc` varchar(15) NOT NULL,
  `Dat_fc` date NOT NULL,
  `Cod_cl` varchar(15) NOT NULL,
  `Num_cm` varchar(15) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `factures`
--

INSERT INTO `factures` (`Num_fc`, `Dat_fc`, `Cod_cl`, `Num_cm`) VALUES
('1865', '2021-04-08', 'C001', '004'),
('145', '2029-12-19', '7777', 'aze147'),
('1200', '2021-06-26', 'C001', '1452'),
('1888', '2021-07-11', '1475', '007'),
('11111', '2015-11-14', 'C005', '005'),
('99', '2017-12-17', 'C003', '001'),
('2000', '2020-12-20', 'C001', '006'),
('85', '2020-12-10', 'C005', '003'),
('44', '2021-12-14', 'C002', '003'),
('1000000', '2001-12-12', 'C001', '004'),
('999999999', '2022-02-22', 'C001', '004'),
('2021', '2000-12-14', 'C003', '001');

--
-- Déclencheurs `factures`
--
DELIMITER $$
CREATE TRIGGER `aft_fac_del` AFTER DELETE ON `factures` FOR EACH ROW BEGIN
DELETE FROM comporter WHERE Num_fc=old.Num_fc;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `famille`
--

CREATE TABLE `famille` (
  `ID_Fam` varchar(15) NOT NULL,
  `Nom_Fam` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `famille`
--

INSERT INTO `famille` (`ID_Fam`, `Nom_Fam`) VALUES
('001', 'ecran'),
('002', 'flash disk'),
('003', 'fr'),
('2022', 'ibiza');

-- --------------------------------------------------------

--
-- Structure de la table `fournir`
--

CREATE TABLE `fournir` (
  `Cod_fs` varchar(15) NOT NULL,
  `Ref_pr` varchar(15) NOT NULL,
  `Pac_pr` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `fournir`
--

INSERT INTO `fournir` (`Cod_fs`, `Ref_pr`, `Pac_pr`) VALUES
('F001', 'R011', 156),
('F003', 'R003', 10),
('F004', 'R004', 100),
('F005', 'R004', 200),
('F001', 'R001', 152),
('F004', 'R007', 12),
('F003', 'R009', 32);

-- --------------------------------------------------------

--
-- Structure de la table `fournisseurs`
--

CREATE TABLE `fournisseurs` (
  `Cod_fs` varchar(15) NOT NULL,
  `Nom_fs` varchar(15) NOT NULL,
  `Pre_fs` varchar(15) NOT NULL,
  `Adr_fs` text NOT NULL,
  `Nte_fs` varchar(15) NOT NULL,
  `Nfa_fs` varchar(15) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `fournisseurs`
--

INSERT INTO `fournisseurs` (`Cod_fs`, `Nom_fs`, `Pre_fs`, `Adr_fs`, `Nte_fs`, `Nfa_fs`) VALUES
('F003', 'halitim', 'yacine', 'alger,16000', '078459615', '035599312'),
('F004', 'hadjab', 'siham', 'batna,05000', '079547689', '034568990'),
('F005', 'tali', 'karim', 'setif,1900', '0563214587', '036989012'),
('F001', 'brarma', 'linda', 'constantine ,2500', '076450930', '029769032'),
('F006', 'sifo', 'kouccem', 'oran', '05548784', '0336589');

--
-- Déclencheurs `fournisseurs`
--
DELIMITER $$
CREATE TRIGGER `aft_fourniseur_del` AFTER DELETE ON `fournisseurs` FOR EACH ROW BEGIN
DELETE FROM fournir WHERE Cod_fs=old.Cod_fs;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `informationclient`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `informationclient` (
`Cod_cl` varchar(15)
,`Nom_cl` varchar(15)
,`Pre_cl` varchar(15)
,`Adr_cl` text
,`Nte_cl` varchar(15)
,`Nfa_cl` varchar(15)
,`Mal_cl` varchar(20)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `lesfactures`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `lesfactures` (
`Num_fc` varchar(15)
,`Dat_fc` date
,`Cod_cl` varchar(15)
,`Num_cm` varchar(15)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `listecommande`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `listecommande` (
`Num_cm` varchar(15)
,`Dat_cm` date
,`Cod_cl` varchar(15)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `listefournisseur`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `listefournisseur` (
`Cod_fs` varchar(15)
,`Nom_fs` varchar(15)
,`Prenom_fs` varchar(15)
,`Adr_fs` text
,`Nte_fs` varchar(15)
,`Nfa_fs` varchar(15)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `listeproduits`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `listeproduits` (
`Ref_pr` varchar(15)
,`Des_pr` varchar(15)
,`Pun_pr` int(11)
,`Tva_pr` int(11)
,`Pac_pr` int(11)
,`Nom_fam` varchar(15)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `nap`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `nap` (
`Num_fc` varchar(15)
,`net a payer` decimal(10,0)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `prixminimals`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `prixminimals` (
`Cod_fs` varchar(15)
,`Ref_pr` varchar(15)
,`MIN(``Pac_pr``)` int(11)
);

-- --------------------------------------------------------

--
-- Structure de la table `produits`
--

CREATE TABLE `produits` (
  `Ref_pr` varchar(15) NOT NULL,
  `Des_pr` varchar(15) NOT NULL,
  `Pun_pr` int(11) NOT NULL,
  `Tva_pr` int(11) NOT NULL,
  `Pac_pr` int(11) NOT NULL,
  `Qso_pr` int(11) NOT NULL,
  `Nom_Fam` varchar(15) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `produits`
--

INSERT INTO `produits` (`Ref_pr`, `Des_pr`, `Pun_pr`, `Tva_pr`, `Pac_pr`, `Qso_pr`, `Nom_Fam`) VALUES
('R003', 'a5', 6577, 4, 10, 2, 'ibiza'),
('R011', 'a5', 6577, 4, 10, 100, 'flash disk'),
('1000', 'b', 1, 5, 5, 10, 'fr'),
('R002', 'lecture dvd', 21, 26, 1877, 7, 'flash disk'),
('R004', 'disk', 1, 100, 32, 10, 'fr');

--
-- Déclencheurs `produits`
--
DELIMITER $$
CREATE TRIGGER `after_produit_delat` AFTER DELETE ON `produits` FOR EACH ROW BEGIN

INSERT INTO       `archiffe`(`Ref_pr`,`Des_pr`,`Pun_pr`,`Tva_pr`,`Pac_pr`,`Qso_pr`,`Nom_Fam`) SELECT `Ref_pr`, `Des_pr`, `Pun_pr`,`Tva_pr`,`Pac_pr`,`Qso_pr`,`Nom_Fam` FROM `produits` WHERE Ref_pr=Ref_pr;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `quantiteapro`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `quantiteapro` (
`Ref_pr` varchar(15)
,`Des_pr` varchar(15)
,`Qso_pr` int(11)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `quantitestoque`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `quantitestoque` (
`Ref_pr` varchar(15)
,`Des_pr` varchar(15)
,`Qso_pr` int(11)
);

-- --------------------------------------------------------

--
-- Structure de la table `systeme`
--

CREATE TABLE `systeme` (
  `Cod_sys` varchar(15) NOT NULL,
  `Nom_sys` varchar(15) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `systeme`
--

INSERT INTO `systeme` (`Cod_sys`, `Nom_sys`) VALUES
('S1', 'client'),
('S2', 'commande'),
('S3', 'facturation'),
('S4', 'produit'),
('S5', 'fournissement'),
('H', 'bbb');

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `tht`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `tht` (
`Num_fc` varchar(15)
,`Ref_pr` varchar(15)
,`Des_pr` varchar(15)
,`Pun_pr` int(11)
,`Tva_pr` int(11)
,`Qso_pr` int(11)
,`Qan_lv` int(11)
,`tht` bigint(21)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `total`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `total` (
`Num_fc` varchar(15)
,`total` decimal(47,4)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `ttc`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `ttc` (
`Num_fc` varchar(15)
,`Ref_pr` varchar(15)
,`Des_pr` varchar(15)
,`Pun_pr` int(11)
,`Tva_pr` int(11)
,`Qso_pr` int(11)
,`Qan_lv` int(11)
,`TTc` decimal(25,4)
);

-- --------------------------------------------------------

--
-- Structure de la vue `achet`
--
DROP TABLE IF EXISTS `achet`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `achet`  AS  (select `fournir`.`Cod_fs` AS `Cod_fs`,`fournir`.`Ref_pr` AS `Ref_pr`,`fournir`.`Pac_pr` AS `Pac_pr` from `fournir` where `fournir`.`Ref_pr` in (select `quantiteapro`.`Ref_pr` from `quantiteapro`)) ;

-- --------------------------------------------------------

--
-- Structure de la vue `datecommende`
--
DROP TABLE IF EXISTS `datecommende`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `datecommende`  AS  (select `commandes`.`Dat_cm` AS `Dat_cm` from `commandes` where (`commandes`.`Cod_cl` = 'C002')) ;

-- --------------------------------------------------------

--
-- Structure de la vue `informationclient`
--
DROP TABLE IF EXISTS `informationclient`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `informationclient`  AS  (select `clients`.`Cod_cl` AS `Cod_cl`,`clients`.`Nom_cl` AS `Nom_cl`,`clients`.`Pre_cl` AS `Pre_cl`,`clients`.`Adr_cl` AS `Adr_cl`,`clients`.`Nte_cl` AS `Nte_cl`,`clients`.`Nfa_cl` AS `Nfa_cl`,`clients`.`Mal_cl` AS `Mal_cl` from `clients`) ;

-- --------------------------------------------------------

--
-- Structure de la vue `lesfactures`
--
DROP TABLE IF EXISTS `lesfactures`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `lesfactures`  AS  (select `factures`.`Num_fc` AS `Num_fc`,`factures`.`Dat_fc` AS `Dat_fc`,`factures`.`Cod_cl` AS `Cod_cl`,`factures`.`Num_cm` AS `Num_cm` from `factures`) ;

-- --------------------------------------------------------

--
-- Structure de la vue `listecommande`
--
DROP TABLE IF EXISTS `listecommande`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `listecommande`  AS  (select `num_cm``dat_cm``cod_cl`.`Num_cm` AS `Num_cm`,`num_cm``dat_cm``cod_cl`.`Dat_cm` AS `Dat_cm`,`num_cm``dat_cm``cod_cl`.`Cod_cl` AS `Cod_cl` from `commandes` `num_cm``dat_cm``cod_cl`) ;

-- --------------------------------------------------------

--
-- Structure de la vue `listefournisseur`
--
DROP TABLE IF EXISTS `listefournisseur`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `listefournisseur`  AS  (select `fournisseurs`.`Cod_fs` AS `Cod_fs`,`fournisseurs`.`Nom_fs` AS `Nom_fs`,`fournisseurs`.`Pre_fs` AS `Prenom_fs`,`fournisseurs`.`Adr_fs` AS `Adr_fs`,`fournisseurs`.`Nte_fs` AS `Nte_fs`,`fournisseurs`.`Nfa_fs` AS `Nfa_fs` from `fournisseurs`) ;

-- --------------------------------------------------------

--
-- Structure de la vue `listeproduits`
--
DROP TABLE IF EXISTS `listeproduits`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `listeproduits`  AS  (select `produits`.`Ref_pr` AS `Ref_pr`,`produits`.`Des_pr` AS `Des_pr`,`produits`.`Pun_pr` AS `Pun_pr`,`produits`.`Tva_pr` AS `Tva_pr`,`produits`.`Pac_pr` AS `Pac_pr`,`produits`.`Nom_Fam` AS `Nom_fam` from `produits`) ;

-- --------------------------------------------------------

--
-- Structure de la vue `nap`
--
DROP TABLE IF EXISTS `nap`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `nap`  AS  select `total`.`Num_fc` AS `Num_fc`,`calcul_np`(`total`.`Num_fc`) AS `net a payer` from `total` ;

-- --------------------------------------------------------

--
-- Structure de la vue `prixminimals`
--
DROP TABLE IF EXISTS `prixminimals`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `prixminimals`  AS  (select `achet`.`Cod_fs` AS `Cod_fs`,`achet`.`Ref_pr` AS `Ref_pr`,min(`achet`.`Pac_pr`) AS `MIN(``Pac_pr``)` from `achet`) ;

-- --------------------------------------------------------

--
-- Structure de la vue `quantiteapro`
--
DROP TABLE IF EXISTS `quantiteapro`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `quantiteapro`  AS  (select `quantitestoque`.`Ref_pr` AS `Ref_pr`,`quantitestoque`.`Des_pr` AS `Des_pr`,`quantitestoque`.`Qso_pr` AS `Qso_pr` from `quantitestoque` where (`quantitestoque`.`Qso_pr` < 10)) ;

-- --------------------------------------------------------

--
-- Structure de la vue `quantitestoque`
--
DROP TABLE IF EXISTS `quantitestoque`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `quantitestoque`  AS  (select `produits`.`Ref_pr` AS `Ref_pr`,`produits`.`Des_pr` AS `Des_pr`,`produits`.`Qso_pr` AS `Qso_pr` from `produits`) ;

-- --------------------------------------------------------

--
-- Structure de la vue `tht`
--
DROP TABLE IF EXISTS `tht`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `tht`  AS  (select `comporter`.`Num_fc` AS `Num_fc`,`produits`.`Ref_pr` AS `Ref_pr`,`produits`.`Des_pr` AS `Des_pr`,`produits`.`Pun_pr` AS `Pun_pr`,`produits`.`Tva_pr` AS `Tva_pr`,`produits`.`Qso_pr` AS `Qso_pr`,`comporter`.`Qan_lv` AS `Qan_lv`,(`comporter`.`Qan_lv` * `produits`.`Pun_pr`) AS `tht` from (`produits` join `comporter`) where (`comporter`.`Ref_pr` = `produits`.`Ref_pr`)) ;

-- --------------------------------------------------------

--
-- Structure de la vue `total`
--
DROP TABLE IF EXISTS `total`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `total`  AS  (select `ttc`.`Num_fc` AS `Num_fc`,sum(`ttc`.`TTc`) AS `total` from `ttc` group by `ttc`.`Num_fc`) ;

-- --------------------------------------------------------

--
-- Structure de la vue `ttc`
--
DROP TABLE IF EXISTS `ttc`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `ttc`  AS  (select `comporter`.`Num_fc` AS `Num_fc`,`produits`.`Ref_pr` AS `Ref_pr`,`produits`.`Des_pr` AS `Des_pr`,`produits`.`Pun_pr` AS `Pun_pr`,`produits`.`Tva_pr` AS `Tva_pr`,`produits`.`Qso_pr` AS `Qso_pr`,`comporter`.`Qan_lv` AS `Qan_lv`,(`produits`.`Pun_pr` + ((`produits`.`Pun_pr` * `produits`.`Tva_pr`) / 100)) AS `TTc` from (`produits` join `comporter`) where (`comporter`.`Ref_pr` = `produits`.`Ref_pr`)) ;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `administrateur`
--
ALTER TABLE `administrateur`
  ADD PRIMARY KEY (`Id_Adm`);

--
-- Index pour la table `archiffe`
--
ALTER TABLE `archiffe`
  ADD PRIMARY KEY (`Ref_pr`);

--
-- Index pour la table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`Cod_cl`);

--
-- Index pour la table `commandes`
--
ALTER TABLE `commandes`
  ADD PRIMARY KEY (`Num_cm`);

--
-- Index pour la table `comporter`
--
ALTER TABLE `comporter`
  ADD PRIMARY KEY (`Ref_pr`,`Num_fc`);

--
-- Index pour la table `concerner`
--
ALTER TABLE `concerner`
  ADD PRIMARY KEY (`Ref_pr`,`Num_cm`);

--
-- Index pour la table `factures`
--
ALTER TABLE `factures`
  ADD PRIMARY KEY (`Num_fc`);

--
-- Index pour la table `famille`
--
ALTER TABLE `famille`
  ADD PRIMARY KEY (`Nom_Fam`);

--
-- Index pour la table `fournir`
--
ALTER TABLE `fournir`
  ADD PRIMARY KEY (`Cod_fs`,`Ref_pr`);

--
-- Index pour la table `fournisseurs`
--
ALTER TABLE `fournisseurs`
  ADD PRIMARY KEY (`Cod_fs`);

--
-- Index pour la table `produits`
--
ALTER TABLE `produits`
  ADD PRIMARY KEY (`Ref_pr`);

--
-- Index pour la table `systeme`
--
ALTER TABLE `systeme`
  ADD PRIMARY KEY (`Cod_sys`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
