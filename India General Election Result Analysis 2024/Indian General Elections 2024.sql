CREATE database INDIA_ELECTION_RESULTS_2024;
use india_election_results_2024;
SELECT * FROM constituencywise_details;
SELECT * FROM constituencywise_results;
SELECT * FROM partywise_results;
SELECT * FROM states;
SELECT * FROM statewise_results;

#TOTAL SEATS
SELECT 
DISTINCT COUNT(Parliament_Constituency) AS Total_Seats 
FROM constituencywise_results;

#TOTAL NO OF SEATS FOR EACH STATE
SELECT 
s.state AS State,
COUNT(cr.Parliament_Constituency) AS Total_Seats
FROM constituencywise_results cr
INNER JOIN statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
INNER JOIN states s ON sr.state_id = s.state_id
GROUP BY s.state;

#TOTAL SEATS WON BY NDA ALLIANCE
SELECT
SUM(CASE
WHEN party IN (
'Bharatiya Janata Party - BJP',
'Telugu Desam - TDP',
'Janata Dal  (Secular) - JD(S)',
'Janata Dal  (United) - JD(U)',
'Shiv Sena - SHS',
'AJSU Party - AJSUP',
'Apna Dal (Soneylal) - ADAL',
'Asom Gana Parishad - AGP',
'Hindustani Awam Morcha (Secular) - HAMS',
'Janasena Party - JnP',
'Lok Janshakti Party(Ram Vilas) - LJPRV',
'Rashtriya Lok Dal - RLD',
'Sikkim Krantikari Morcha - SKM',
'Nationalist Congress Party - NCP'
) THEN Won
ELSE 0
END) AS Total_Seats_Won_By_NDA
FROM partywise_results;

#SEATS WON BY NDA ALLIANCE PARTIES
SELECT
Party,
Won as Seats_Won
FROM partywise_results
WHERE party IN (
'Bharatiya Janata Party - BJP',
'Telugu Desam - TDP',
'Janata Dal  (Secular) - JD(S)',
'Janata Dal  (United) - JD(U)',
'Shiv Sena - SHS',
'AJSU Party - AJSUP',
'Apna Dal (Soneylal) - ADAL',
'Asom Gana Parishad - AGP',
'Hindustani Awam Morcha (Secular) - HAMS',
'Janasena Party - JnP',
'Lok Janshakti Party(Ram Vilas) - LJPRV',
'Rashtriya Lok Dal - RLD',
'Sikkim Krantikari Morcha - SKM',
'Nationalist Congress Party - NCP'
)
ORDER BY Seats_Won DESC, Party;

#TOTAL SEATS WON BY Indian National Developmental Inclusive Alliance (I.N.D.I.A)
SELECT 
SUM(
CASE WHEN party in (
	'Indian National Congress - INC',
	'Aam Aadmi Party - AAAP',
	'All India Trinamool Congress - AITC',
	'Bharat Adivasi Party - BHRTADVSIP',
	'Communist Party of India  (Marxist) - CPI(M)',
	'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
	'Communist Party of India - CPI',
	'Dravida Munnetra Kazhagam - DMK',
	'Indian Union Muslim League - IUML',
	'Nat`Jammu & Kashmir National Conference - JKN',
	'Jharkhand Mukti Morcha - JMM',
	'Jammu & Kashmir National Conference - JKN',
	'Kerala Congress - KEC',
	'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
	'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
	'Rashtriya Janata Dal - RJD',
	'Rashtriya Loktantrik Party - RLTP',
	'Revolutionary Socialist Party - RSP',
	'Samajwadi Party - SP',
	'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
	'Viduthalai Chiruthaigal Katchi - VCK'
) THEN Won
ELSE 0
END) as Seats_Won_By_INDIAlliance
FROM partywise_results;

#TOTAL SEATS WON BY Indian National Developmental Inclusive Alliance (I.N.D.I.A) Parties
SELECT 
Party,
Won as Seats_Won
FROM partywise_results
WHERE party in (
	'Indian National Congress - INC',
	'Aam Aadmi Party - AAAP',
	'All India Trinamool Congress - AITC',
	'Bharat Adivasi Party - BHRTADVSIP',
	'Communist Party of India  (Marxist) - CPI(M)',
	'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
	'Communist Party of India - CPI',
	'Dravida Munnetra Kazhagam - DMK',
	'Indian Union Muslim League - IUML',
	'Nat`Jammu & Kashmir National Conference - JKN',
	'Jharkhand Mukti Morcha - JMM',
	'Jammu & Kashmir National Conference - JKN',
	'Kerala Congress - KEC',
	'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
	'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
	'Rashtriya Janata Dal - RJD',
	'Rashtriya Loktantrik Party - RLTP',
	'Revolutionary Socialist Party - RSP',
	'Samajwadi Party - SP',
	'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
	'Viduthalai Chiruthaigal Katchi - VCK'
)
ORDER BY Seats_Won Desc, Party;

#ADD A COLUMN FOR PARTY ALLIANCE IN PARTYWISE_RESULTS TABLE
ALTER TABLE partywise_results ADD Party_Alliance VARCHAR(50);

UPDATE partywise_results SET Party_Alliance = "I.N.D.I.A"
WHERE party IN ('Indian National Congress - INC',
	'Aam Aadmi Party - AAAP',
	'All India Trinamool Congress - AITC',
	'Bharat Adivasi Party - BHRTADVSIP',
	'Communist Party of India  (Marxist) - CPI(M)',
	'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
	'Communist Party of India - CPI',
	'Dravida Munnetra Kazhagam - DMK',
	'Indian Union Muslim League - IUML',
	'Nat`Jammu & Kashmir National Conference - JKN',
	'Jharkhand Mukti Morcha - JMM',
	'Jammu & Kashmir National Conference - JKN',
	'Kerala Congress - KEC',
	'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
	'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
	'Rashtriya Janata Dal - RJD',
	'Rashtriya Loktantrik Party - RLTP',
	'Revolutionary Socialist Party - RSP',
	'Samajwadi Party - SP',
	'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
	'Viduthalai Chiruthaigal Katchi - VCK'
);

UPDATE partywise_results SET Party_Alliance = "NDA"
WHERE party IN (
'Bharatiya Janata Party - BJP',
'Telugu Desam - TDP',
'Janata Dal  (Secular) - JD(S)',
'Janata Dal  (United) - JD(U)',
'Shiv Sena - SHS',
'AJSU Party - AJSUP',
'Apna Dal (Soneylal) - ADAL',
'Asom Gana Parishad - AGP',
'Hindustani Awam Morcha (Secular) - HAMS',
'Janasena Party - JnP',
'Lok Janshakti Party(Ram Vilas) - LJPRV',
'Rashtriya Lok Dal - RLD',
'Sikkim Krantikari Morcha - SKM',
'Nationalist Congress Party - NCP'
);

UPDATE partywise_results SET Party_Alliance = "OTHER"
WHERE Party_Alliance IS NULL;

SELECT * FROM partywise_results;
#WHICH PARTY ALLIANCE WON THE MOST NO OF SEATS ACROSS ALL THE STATES
SELECT Party_Alliance, SUM(Won) AS Seats_Won FROM partywise_results GROUP BY Party_Alliance ORDER BY sum(WON) DESC LIMIT 1;

SELECT PARTY, WON FROM PARTYWISE_RESULTS WHERE PARTY_ALLIANCE = 'NDA' ORDER BY WON DESC;

#WINNING CANDIDATE'S NAME, THEIR PARTY NAME, TOTAL VOTES, MARGIN OF VICTORY FOR A SPECIFIC STATE AND CONSTITUENCY
SELECT CR.WINNING_CANDIDATE, PR.PARTY, PR.PARTY_ALLIANCE, CR.TOTAL_VOTES, CR.MARGIN, S.STATE, CR.CONSTITUENCY_NAME
FROM CONSTITUENCYWISE_RESULTS CR 
INNER JOIN PARTYWISE_RESULTS PR ON CR.PARTY_ID = PR.PARTY_ID
INNER JOIN STATEWISE_RESULTS SR ON CR.PARLIAMENT_CONSTITUENCY = SR.PARLIAMENT_CONSTITUENCY
INNER JOIN STATES S ON SR.STATE_ID = S.STATE_ID
WHERE CR.CONSTITUENCY_NAME = "ANAKAPALLE";

#WHAT IS THE DISTRIBUTION OF EVM VOTES VERSUS POSTAL VOTES FOR CANDIDATES IN A SPECIFIC CONSTITUENCY
SELECT 
CD.CANDIDATE, CD.EVM_VOTES, CD.POSTAL_VOTES, CD.TOTAL_VOTES, CR.CONSTITUENCY_NAME
FROM CONSTITUENCYWISE_DETAILS CD
JOIN CONSTITUENCYWISE_RESULTS CR ON CR.CONSTITUENCY_ID = CD.CONSTITUENCY_ID
WHERE CR.CONSTITUENCY_NAME = "ANAKAPALLE";

#WHICH PARTY WON THE MOST NUMBER OF SEATS IN A STATE AND HOW MANY SEATS DID EACH PARTY WIN
SELECT PR.PARTY, COUNT(CR.CONSTITUENCY_ID) AS SEATS_WON
FROM PARTYWISE_RESULTS PR
INNER JOIN CONSTITUENCYWISE_RESULTS CR ON PR.PARTY_ID = CR.PARTY_ID
INNER JOIN STATEWISE_RESULTS SR ON CR.PARLIAMENT_CONSTITUENCY = SR.PARLIAMENT_CONSTITUENCY
INNER JOIN STATES S ON SR.STATE_ID = S.STATE_ID
WHERE S.STATE = 'ANDHRA PRADESH'
GROUP BY PR.PARTY
ORDER BY SEATS_WON DESC;

#total no of seats won by each party alliance in each state for Indian Elections 2024
SELECT S.STATE, 
SUM(CASE WHEN PR.PARTY_ALLIANCE = 'NDA' THEN 1 ELSE 0 END) AS NDA_SEATS_WON,
SUM(CASE WHEN PR.PARTY_ALLIANCE = 'I.N.D.I.A' THEN 1 ELSE 0 END) AS INDIA_SEATS_WON,
SUM(CASE WHEN PR.PARTY_ALLIANCE = 'OTHER' THEN 1 ELSE 0 END) AS OTHER_SEATS_WON
FROM PARTYWISE_RESULTS PR
INNER JOIN CONSTITUENCYWISE_RESULTS CR ON PR.PARTY_ID = CR.PARTY_ID
INNER JOIN STATEWISE_RESULTS SR ON CR.PARLIAMENT_CONSTITUENCY = SR.PARLIAMENT_CONSTITUENCY
INNER JOIN STATES S ON SR.STATE_ID = S.STATE_ID
GROUP BY S.STATE;

#WHICH CANDIDATE RECEIVED THE HIGHEST NUMBER OF EVM VOTES IN EACH CONSTITUENCY (TOP 10)
SELECT 
CD.CANDIDATE, CD.CONSTITUENCY_ID, CR.CONSTITUENCY_NAME, CD.EVM_VOTES
FROM CONSTITUENCYWISE_DETAILS CD 
JOIN CONSTITUENCYWISE_RESULTS CR ON CD.CONSTITUENCY_ID = CR.CONSTITUENCY_ID
WHERE 
CD.EVM_VOTES = (SELECT MAX(CD1.EVM_VOTES) 
FROM CONSTITUENCYWISE_DETAILS CD1 
WHERE CD.CONSTITUENCY_ID = CD1.CONSTITUENCY_ID)
ORDER BY CD.EVM_VOTES DESC LIMIT 10;

#WHICH CANDIDATE WON AND WHICH CANDIDATE WAS A RUNNER UP IN EACH CONSTITUENCY OF STATE
WITH RANKED_CANDIDATES AS 
(SELECT 
CD.CONSTITUENCY_ID, CD.CANDIDATE, CD.PARTY, CD.EVM_VOTES, CD.POSTAL_VOTES, CD.TOTAL_VOTES,
ROW_NUMBER() OVER (PARTITION BY CD.CONSTITUENCY_ID ORDER BY CD.TOTAL_VOTES DESC) AS VOTE_RANK
FROM CONSTITUENCYWISE_DETAILS CD
JOIN CONSTITUENCYWISE_RESULTS CR ON CD.CONSTITUENCY_ID = CR.CONSTITUENCY_ID
JOIN STATEWISE_RESULTS SR ON CR.PARLIAMENT_CONSTITUENCY = SR.PARLIAMENT_CONSTITUENCY
JOIN STATES S ON SR.STATE_ID = S.STATE_ID
WHERE S.STATE = 'ANDHRA PRADESH')
SELECT 
CR.CONSTITUENCY_NAME, MAX(CASE WHEN RC.VOTE_RANK = 1 THEN RC.CANDIDATE END) AS WINNING_CANDIDATE,
MAX(CASE WHEN RC.VOTE_RANK = 2 THEN RC.CANDIDATE END) AS RUNNING_CANDIDATE
FROM RANKED_CANDIDATES RC
JOIN CONSTITUENCYWISE_RESULTS CR ON RC.CONSTITUENCY_ID = CR.CONSTITUENCY_ID
GROUP BY CR.CONSTITUENCY_NAME
ORDER BY CR.CONSTITUENCY_NAME;

#FOR THE STATE OF ANDHRA PRADESH, WHAT ARE THE TOTAL NO OF SEATS, TOTAL NO OF CANDIDATES, TOTAL NO OF PARTIES, 
#TOTAL VOTES (INCLUDING EVM AND POSTAL) AND THE BREAKDOWN OF EVM AND POSTAL.
	SELECT 
	COUNT(DISTINCT CD.CONSTITUENCY_ID) AS TOTAL_SEATS,
	COUNT(DISTINCT CD.CANDIDATE) AS TOTAL_CANDIDATES,
	COUNT(DISTINCT CD.PARTY) AS TOTAL_PARTIES,
	SUM(CD.EVM_VOTES) AS EVM_VOTES,
	SUM(CD.POSTAL_VOTES) AS POSTAL_VOTES,
	SUM(CD.TOTAL_VOTES) AS TOTAL_VOTES
	FROM CONSTITUENCYWISE_DETAILS CD
	JOIN CONSTITUENCYWISE_RESULTS CR ON CD.CONSTITUENCY_ID = CR.CONSTITUENCY_ID
	JOIN STATEWISE_RESULTS SR ON CR.PARLIAMENT_CONSTITUENCY = SR.PARLIAMENT_CONSTITUENCY
	JOIN STATES S ON SR.STATE_ID = S.STATE_ID
	WHERE S.STATE = "ANDHRA PRADESH";