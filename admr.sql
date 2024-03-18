-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mar. 20 fév. 2024 à 11:46
-- Version du serveur : 10.4.27-MariaDB
-- Version de PHP : 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `admr`
--

-- --------------------------------------------------------

--
-- Structure de la table `formulaire`
--

CREATE TABLE `formulaire` (
  `formulaireId` int(11) NOT NULL,
  `titre` varchar(255) DEFAULT NULL,
  `dateCreation` date DEFAULT NULL,
  `typeFormulaireId` int(11) DEFAULT NULL,
  `sectionId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `question`
--

CREATE TABLE `question` (
  `questionId` int(11) NOT NULL,
  `titre` varchar(255) DEFAULT NULL,
  `reponseId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `reponse`
--

CREATE TABLE `reponse` (
  `reponseId` int(11) NOT NULL,
  `titre` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `section`
--

CREATE TABLE `section` (
  `sectionId` int(11) NOT NULL,
  `titre` varchar(255) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `section_question`
--

CREATE TABLE `section_question` (
  `sectionId` int(11) NOT NULL,
  `questionId` int(11) NOT NULL,
  `obligatoire` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `type_formulaire`
--

CREATE TABLE `type_formulaire` (
  `typeFormulaireId` int(11) NOT NULL,
  `typeFormulaire` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `utilisateurId` int(11) NOT NULL,
  `mail` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` int(11) DEFAULT NULL,
  `dateCreation` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déclencheurs `utilisateur`
--
DELIMITER $$
CREATE TRIGGER `CheckEmailDomainBeforeInsert` BEFORE INSERT ON `utilisateur` FOR EACH ROW BEGIN
    IF NOT NEW.mail LIKE '%@fede02.admr.org' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'L''insertion a été rejetée car le domaine de l''email n''est pas @fede02.admr.org';
    END IF;
END
$$
DELIMITER ;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `formulaire`
--
ALTER TABLE `formulaire`
  ADD PRIMARY KEY (`formulaireId`),
  ADD KEY `typeFormulaireId` (`typeFormulaireId`),
  ADD KEY `sectionId` (`sectionId`);

--
-- Index pour la table `question`
--
ALTER TABLE `question`
  ADD PRIMARY KEY (`questionId`),
  ADD KEY `reponseId` (`reponseId`);

--
-- Index pour la table `reponse`
--
ALTER TABLE `reponse`
  ADD PRIMARY KEY (`reponseId`);

--
-- Index pour la table `section`
--
ALTER TABLE `section`
  ADD PRIMARY KEY (`sectionId`);

--
-- Index pour la table `section_question`
--
ALTER TABLE `section_question`
  ADD PRIMARY KEY (`sectionId`,`questionId`),
  ADD KEY `questionId` (`questionId`);

--
-- Index pour la table `type_formulaire`
--
ALTER TABLE `type_formulaire`
  ADD PRIMARY KEY (`typeFormulaireId`);

--
-- Index pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`utilisateurId`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `formulaire`
--
ALTER TABLE `formulaire`
  MODIFY `formulaireId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `question`
--
ALTER TABLE `question`
  MODIFY `questionId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `reponse`
--
ALTER TABLE `reponse`
  MODIFY `reponseId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `section`
--
ALTER TABLE `section`
  MODIFY `sectionId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `type_formulaire`
--
ALTER TABLE `type_formulaire`
  MODIFY `typeFormulaireId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  MODIFY `utilisateurId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `formulaire`
--
ALTER TABLE `formulaire`
  ADD CONSTRAINT `formulaire_ibfk_1` FOREIGN KEY (`typeFormulaireId`) REFERENCES `type_formulaire` (`typeFormulaireId`) ON DELETE CASCADE,
  ADD CONSTRAINT `formulaire_ibfk_2` FOREIGN KEY (`sectionId`) REFERENCES `section` (`sectionId`) ON DELETE CASCADE;

--
-- Contraintes pour la table `question`
--
ALTER TABLE `question`
  ADD CONSTRAINT `question_ibfk_1` FOREIGN KEY (`reponseId`) REFERENCES `reponse` (`reponseId`) ON DELETE CASCADE;

--
-- Contraintes pour la table `section_question`
--
ALTER TABLE `section_question`
  ADD CONSTRAINT `section_question_ibfk_1` FOREIGN KEY (`sectionId`) REFERENCES `section` (`sectionId`) ON DELETE CASCADE,
  ADD CONSTRAINT `section_question_ibfk_2` FOREIGN KEY (`questionId`) REFERENCES `question` (`questionId`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
