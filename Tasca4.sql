/* Nivell 1
Exercici 1
Realitza una subconsulta que mostri tots els usuaris amb més de 30 transaccions utilitzant almenys 2 taules. */

SELECT u.id, u.name, u.surname, u.email 
FROM geekstore.users u
WHERE u.id IN (
    SELECT t.user_id
    FROM geekstore.transactions t
    GROUP BY t.user_id
    HAVING COUNT(t.user_id) > 30
);

/* Exercici 2
Mostra la mitjana d'amount per IBAN de les targetes de crèdit a la companyia Donec Ltd, utilitza almenys 2 taules. */

SELECT AVG(t.amount) AS mediana, cc.iban
FROM transactions t
JOIN companies c
ON t.business_id = c.company_id
JOIN credit_cards cc
ON cc.id = t.card_id
WHERE c.company_name = 'Donec Ltd'
GROUP BY cc.iban;


