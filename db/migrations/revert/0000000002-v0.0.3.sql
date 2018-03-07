START TRANSACTION;

SET search_path = api, pg_catalog;

DROP VIEW todos;

CREATE VIEW todos AS
	SELECT data.relay_id(t.*) AS id,
    t.id AS row_id,
    t.todo,
    t.private,
    (t.owner_id = request.user_id()) AS mine,
    'test_value'::text AS test_value
   FROM data.todo t;
REVOKE ALL ON TABLE todos FROM webuser;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE todos TO webuser;

COMMIT TRANSACTION;
