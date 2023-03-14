/* Comparaison de longueurs */

CREATE OR REPLACE FUNCTION calculer_longueur_max(chaine1 text, chaine2 text)
RETURNS integer AS $$
DECLARE
    longueur1 integer;
    longueur2 integer;
BEGIN
    longueur1 := length(chaine1);
    longueur2 := length(chaine2);
    RETURN GREATEST(longueur1, longueur2);
END;
$$ LANGUAGE plpgsql;

SELECT calculer_longueur_max('Hello', 'world'); -- renvoie 5



/* Fin Comparaison de longueurs Fin */

/* Nombre d'occurrences */

CREATE OR REPLACE FUNCTION nb_occurrences(caractere CHAR, chaine TEXT, debut INTEGER, fin INTEGER)
RETURNS INTEGER AS $$
DECLARE
    nb_occurrences INTEGER := 0;
    chaine_array CHAR[];
    i INTEGER;
BEGIN
    chaine_array := string_to_array(chaine, NULL);
    FOR i IN debut..fin LOOP
        IF chaine_array[i] = caractere THEN
            nb_occurrences := nb_occurrences + 1;
        END IF;
    END LOOP;
    RETURN nb_occurrences;
END;
$$ LANGUAGE plpgsql;

SELECT nb_occurrences('a', 'abracadabra', 1, 8); -- renvoie 4
SELECT nb_occurrences('b', 'abracadabra', 0, 5); -- renvoie 1
SELECT nb_occurrences('z', 'abracadabra', 0, 5); -- renvoie 0

/* Fin Nombre d'occurrences Fin */

/* Nombre de Jours */

CREATE OR REPLACE FUNCTION getNbJoursParMois (p_date DATE) RETURN NUMBER IS
    v_mois NUMBER;
    v_annee NUMBER;
    v_nb_jours NUMBER;
BEGIN
    
    v_mois := TO_NUMBER(TO_CHAR(p_date, 'MM'));
    v_annee := TO_NUMBER(TO_CHAR(p_date, 'YYYY'));

    
    IF v_mois = 2 THEN
        IF (v_annee MOD 4 = 0 AND (v_annee MOD 100 != 0 OR v_annee MOD 400 = 0)) THEN
            v_nb_jours := 29; 
        ELSE
            v_nb_jours := 28;
        END IF;
    ELSIF v_mois IN (4, 6, 9, 11) THEN
        v_nb_jours := 30;
    ELSE
        v_nb_jours := 31;
    END IF;
    
    RETURN v_nb_jours;
END;


CREATE OR REPLACE FUNCTION getNbJoursParMois (p_date DATE) RETURN NUMBER AS $$
DECLARE
  v_mois NUMBER;
  v_annee NUMBER;
  v_nb_jours NUMBER;
BEGIN
  -- Extraction du mois et de l'année de la date
  v_mois := TO_NUMBER(TO_CHAR(p_date, 'MM'));
  v_annee := TO_NUMBER(TO_CHAR(p_date, 'YYYY'));

  -- Calcul du nombre de jours dans le mois
  IF v_mois = 2 THEN
    IF (v_annee MOD 4 = 0 AND (v_annee MOD 100 != 0 OR v_annee MOD 400 = 0)) THEN
      v_nb_jours := 29; -- année bissextile
    ELSE
      v_nb_jours := 28;
    END IF;
  ELSIF v_mois IN (4, 6, 9, 11) THEN
    v_nb_jours := 30;
  ELSE
    v_nb_jours := 31;
  END IF;

  RETURN v_nb_jours;
END 
$$ LANGUAGE plpgsql;



/* Fin Nombre de Jours Fin */